Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FDCC2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 13:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7160820CC7
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 13:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4nFbapN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgA3N2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 08:28:06 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38506 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbgA3N2G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 08:28:06 -0500
Received: by mail-qt1-f193.google.com with SMTP id c24so2418171qtp.5
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 05:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gnv0T1ayu5QjUCfjcg1DN2uA6IqE80bILOlYyKwob3E=;
        b=R4nFbapNyz0mh0mgeX4WlWgnqmeog7rjLZyIPD7jZdAV0XloKp/TqKgGjD7PB6hImF
         att8B/lcnJmJ4SF+PJnpTvCMhTae7qthGTSToSXWqOdo+DuCG0/+Obwdfe3ORYNJtdoR
         TDpZeZZT7pJKQGiJLnSe845HjIDOBs4l9fC4k5mkwPLJJt/eSKKronBh5mZOefAmaLaH
         hI2Q08YWsANbl63Gi+FE0ky7S8JK/bCCs9ZCcCvQA0kxa9xa0WhqoLKpe8I2WXQHHtp0
         03aTLznWuoYNb1sFtmy/89FOsa7GoaVRB43lWoqEad1ZXry279qK/WulW3E3G3kE61xO
         d4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gnv0T1ayu5QjUCfjcg1DN2uA6IqE80bILOlYyKwob3E=;
        b=pdJcheHxG8y9IYpQtOXlFuPCU+9B2DHs7Gcq3fGkKyBdXL/lXOyJlLApewKLDMOJlh
         UqcqykIGJhOHAPi+J0VAogNzDOQ0fSQ+f5aFYttswe6HUa5EjWR+dyyqVAlbUkvQ8oQn
         MYAw5SH4fOlZXy8bjjHu6lcwNLfxcqFLGH43Ad66LU6fYo2fih52Rnuwl45k9BLo9W3W
         WWiBJxi+5rAfPmHASJLrg7LoLUYnlKony8qjze4tzII5rk9DJ2EuNzu19Ln2Eu01G/cj
         TNqQ8+5sLTx1sHvc5ZkwYoEZTg5HTUE5DBWScIrorftLQ6hbLn9N61oCewA9VmA5d4li
         Vn5g==
X-Gm-Message-State: APjAAAWRg8DTsBeS04E0m0Y0LXwhlT6lL9+KfKzxYBAdqzrEZBKampk6
        BlIA8b6wqVGn26KTLvrTihk=
X-Google-Smtp-Source: APXvYqzUiB3tDZyYSzOK0F+gn/2raU0K2yQ/LNwJhII3pljWvb8pc1h6GAETIVotGu+6Zovxnx5f4A==
X-Received: by 2002:ac8:740c:: with SMTP id p12mr4640520qtq.286.1580390885302;
        Thu, 30 Jan 2020 05:28:05 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id f7sm2977702qtp.86.2020.01.30.05.28.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Jan 2020 05:28:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 08/12] grep: allow submodule functions to run in parallel
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <CAHd-oW590ZnNnCdD5LLiBQB73LRUVEf41wv7FLJvGMwd2kLYww@mail.gmail.com>
Date:   Thu, 30 Jan 2020 08:28:01 -0500
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>,
        =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7DA86BCF-8A20-4B06-BDC0-82EEDFCC0AE5@gmail.com>
References: <cover.1579141989.git.matheus.bernardino@usp.br> <af8ad95d413aa3d763769eb3ae9544e25ccbe2d1.1579141989.git.matheus.bernardino@usp.br> <20200129112613.GE10482@szeder.dev> <xmqqy2tqdr9t.fsf@gitster-ct.c.googlers.com> <CAHd-oW590ZnNnCdD5LLiBQB73LRUVEf41wv7FLJvGMwd2kLYww@mail.gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,
>>=20
>> @@ -958,6 +946,8 @@ int cmd_grep(int argc, const char **argv, const =
char *prefix)
>>                        /* die the same way as if we did it at the =
beginning */
>>                        setup_git_directory();
>>        }
>> +       if (!use_index)
>> +               recurse_submodules =3D 0; /* ignore */
>>=20
>>        /*
>>         * skip a -- separator; we know it cannot be
>=20
> Yeah, this seems more meaningful, IMHO, as we can easily see that the
> recurse_submodules option was dropped in favor of using --no-index.
>=20
I agree. I=E2=80=99ll send a v2 of my patch with this added.

Philippe.

