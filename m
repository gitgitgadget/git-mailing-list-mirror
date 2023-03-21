Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EDBC6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 20:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCUUrg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 16:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCUUrf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 16:47:35 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D200754C8C
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 13:47:10 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id z19so6945531plo.2
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 13:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clumio.com; s=google; t=1679431628;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUpkwmcM9BLJBWc5XJyAt8Wx4E/TWpLtIiJviFtnlbo=;
        b=aNSO8glZclPAKGHm4+6usMJL2gy13sSWmymtaoW9VQMnyaEHbIJPo3qmDH0VTPINaw
         Se3SLSQfFSviN6wMh2PxjithD8hc7q1oKb0Jq6IVmYcTP+I7k3IyyNnZdEc9nz1r79Pt
         s8rUYrxM5sa+HdodLWuYROEwZpZ9BSML+HtftJdX1G0nCbSsn6pdUa0RGsgLPt9nE8HJ
         rdh8tAXzZbvQQ0CeNegD3ugwXpirhGpqlobTszMjS2/JR9I8Lu0vWyGYggqKjiLXuFC+
         VUK/8G4LWUZAhYmKzfR7E6gg+Ey5oHANGuKqCu8k7Rr1SK+mYynR5e6qEqy63gUkvWkw
         sjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679431628;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUpkwmcM9BLJBWc5XJyAt8Wx4E/TWpLtIiJviFtnlbo=;
        b=MMYvZsrkL7UafcMMJknK01bNNxzqRYyyNuoAabEBRRWYPw76O9mdE5O2WrnaiXThkh
         ejQ4/btYSnQn6VIDsXhHwllhuyIHDDDcP+nu+77Ozl2EksYd48WPuyiBCEu5hTI2r+fT
         T7zgJDDSOPrxAWMYrYZq+QCe5gvlsZilF0ua30iim8pA26VLWXn3mKQPsZFxCpGGvSXo
         WX3tloEP8HoH5rhsaTY7GMGHW/81rKibkcJ8t7n4u21M/OqzYCyKSVqByxkZUNmH4+rD
         0gCQ3GxhjEsaP5G0kxcAowupVvbZa3FNbsWYC9ffkl5EAUpQ8Z9dagcu32mRvZ1DldGp
         hbYA==
X-Gm-Message-State: AO0yUKXHZeMTb0DeW7+LU1bUIk2CZjYz8C7wo3dyFC6xPsf1IL5GsC4/
        Oj7K+PDW5AMWfbMRglfVpemYkA==
X-Google-Smtp-Source: AK7set8m38JyWqCHgVJRNOplTnonJMtTKYD+9ucLpE5MAJzPUcJH1mLOw0Xh3szYqCehmnSgzM49Bw==
X-Received: by 2002:a17:902:ce82:b0:1a1:97b5:c63e with SMTP id f2-20020a170902ce8200b001a197b5c63emr488263plg.38.1679431627980;
        Tue, 21 Mar 2023 13:47:07 -0700 (PDT)
Received: from smtpclient.apple (107-194-200-191.lightspeed.sntcca.sbcglobal.net. [107.194.200.191])
        by smtp.gmail.com with ESMTPSA id s24-20020a170902b19800b0019e5fc21663sm8938044plr.218.2023.03.21.13.47.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Mar 2023 13:47:07 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [EXTERNAL SENDER] Suspected git grep regression in git 2.40.0
From:   Stephane Odul <stephane@clumio.com>
In-Reply-To: <b0f4b588-9871-8e59-e5a2-3f8745a7c4cd@grsecurity.net>
Date:   Tue, 21 Mar 2023 13:46:55 -0700
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <51078D7E-C325-4F57-96C1-601B4E102DD9@clumio.com>
References: <7E83DAA1-F9A9-4151-8D07-D80EA6D59EEA@clumio.com>
 <xmqqttyejc7y.fsf@gitster.g>
 <b0f4b588-9871-8e59-e5a2-3f8745a7c4cd@grsecurity.net>
To:     Mathias Krause <minipli@grsecurity.net>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for looking into this so quickly.

I=E2=80=99m unable to reproduce locally reliably but I created a custom =
pipeline to reproduce more quickly.

Here are the things I found out.

* With the NO_JIT flag and limited to only python files (in our case we =
only want to grep on py files anyways):
  - git grep -c -P '(*NO_JIT)^[[:alnum:]_]+ =3D json.load' -- '*.py=E2=80=99=

  This is snappy and works, no more error.

* Without the flag and the *.py restriction:
  - git grep -c -P '^[^ #][^#]+sys[.]argv=E2=80=99
    This did not fail but took almost 3m, big performance regression.
  - git grep -c -P '^[[:alnum:]_]+ =3D json.load=E2=80=99
    Crashed and returned -11. Stderr was empty so I have no idea on what =
file it failed.

 * With NO_JIT on all the files:
  - git grep -c -P '(*NO_JIT)^[[:alnum:]_]+ =3D json.load=E2=80=99
   This worked, that pattern is snappy but other patterns are very slow:
  - git grep -c -P '(*NO_JIT)^[^ #][^#]+sys[.]argv=E2=80=99
    Took 8m to complete.

 * Without the flag but only *.py.
    - git grep -c -P '^[[:alnum:]_]+ =3D json.load' -- '*.py=E2=80=99
     All the patterns run fast (under 1s), and no errors.


Note that I was trying -E and replaced \w with [[:alnum:]_] =E2=80=A6 =
I=E2=80=99ll need to revert that, but I don=E2=80=99t thing \w is the =
issue.

Overall I would say that the issue is likely because the patterns are =
run against a non ASCII file somewhere in the repo.
Our repo is fairly large with files in various formats, including =
potentially some binaries that would definitely not be proper UTF-8.

For now I have a good workaround which is to only check for *.py files, =
which we should have done in the first place. The NO_JIT flag slows down =
things significantly so we will not use it here.

Do you have any recommendation on how to identify which file(s) is =
causing the crash considering there is nothing in stderr?

Thanks!=
