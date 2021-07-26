Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1876C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 22:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F92603E9
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 22:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhGZWKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 18:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhGZWKO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 18:10:14 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF67C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 15:50:41 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id o13so10533999qkk.9
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 15:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4zOjimpHUrYL4s9h6Kus6nmizoEetc9zuXKstMhtB4c=;
        b=pwXurcM7PNh/vNF1bGgLX8MaEqmquFkIJuPr4utMb19fifv4T+p7E8vO3GodoiFNI6
         910ttzRCrTGmLlRsbqplnJWGtdrgKbFp0SIA+l3DC0L1BWB9OqIRag5QGuhmb7XW+M5W
         wmfEcQrB+Apfl49NFzWXisEcdFGLDyrybbtQ31zKW7GJqU4lCuk0f5+epOQ+AMeaU2u1
         +JUnz63Pt/Wv1fxnHl7Wbbp+Zo2+sZpGG7MCYK3o9miX3oQ+Ddh94ru6VyuKXJjm7ewd
         a7/l1d4Xe604jE00StbJUuVOM3tdqQp4Z2KUh1AD4Qnhf9xMLO/B5HUcqFzkaoKJgEVn
         htLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4zOjimpHUrYL4s9h6Kus6nmizoEetc9zuXKstMhtB4c=;
        b=E3T+mXPTXcnC0WiBix/N0nytOmc2/BzIFzNnjfTXMJVb+3zk+NPTY1wMziiP6eP/rj
         EsGdebDPl5ruQEruE+lSHMR24yGbyr1LZsSWEFUlB8an0wXYi7+bkWufbgbZlDelZua/
         tJVf/22HRdIZseleA4FA5jNrGEZMts8ZqBVxGrHWY7dyxwEyYIxIe7CkoNcSHfVosq29
         /GKPq1HzXOYwbMc7cb2/akCLhOOSDdvmbrYo+ihM2/qY1VmUr4czoQes7Zo039Dm2Dcs
         bJLmOQ39yuBMxGO5JbUt45WRbxwXjDgQQS+rkMZcJtousZg999o/mNoLnm5qYB/VQw6G
         aYEA==
X-Gm-Message-State: AOAM533Ly64F2kOGkzOoLWrnPb64bLayVafrIGlqekFRD6fbD6KqZsdM
        CxCq4yXN68QJQxYG4u5fAIw=
X-Google-Smtp-Source: ABdhPJwRSFW3a+bcrEGWc/oDlgNo5FLV7M/vmjz75CaybU5hFtB1CbhLkeKiAYMKSFTVia6ZMTS0JQ==
X-Received: by 2002:a37:a1cf:: with SMTP id k198mr19907215qke.259.1627339840886;
        Mon, 26 Jul 2021 15:50:40 -0700 (PDT)
Received: from smtpclient.apple (host-68-169-160-88.MIDOLT1.epbfi.com. [68.169.160.88])
        by smtp.gmail.com with ESMTPSA id d19sm766356qkn.94.2021.07.26.15.50.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jul 2021 15:50:40 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: Exit code 255 after large clone (32-bit PowerPC)
From:   Evan Miller <emmiller@gmail.com>
In-Reply-To: <YP8ykvsZie4mPE5o@camp.crustytoothpaste.net>
Date:   Mon, 26 Jul 2021 18:50:39 -0400
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E5CF61E9-8817-4FB9-B604-C97BF3DFE8B4@gmail.com>
References: <D3C1583B-8CC8-434B-8AF5-B9827A7FD037@gmail.com>
 <YP8ykvsZie4mPE5o@camp.crustytoothpaste.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On Jul 26, 2021, at 18:09, brian m. carlson =
<sandals@crustytoothpaste.net> wrote:
>=20
> On 2021-07-26 at 17:54:07, Evan Miller wrote:
>> What did you do before the bug happened? (Steps to reproduce your =
issue)
>>=20
>> $ git clone -v git@github.com:macports/macports-ports.git
>> Cloning into 'macports-ports'...
>> remote: Enumerating objects: 1223319, done.
>> remote: Counting objects: 100% (685/685), done.
>> remote: Compressing objects: 100% (341/341), done.
>> remote: Total 1223319 (delta 289), reused 608 (delta 252), =
pack-reused 1222634
>> Receiving objects: 100% (1223319/1223319), 244.46 MiB | 1.09 MiB/s, =
done.
>> Connection to github.com closed by remote host.
>=20
> This message is the relevant detail here.  This means that the
> connection was reset, which could be due to the remote host (GitHub),
> but is more likely due to a network issue of some sort.  You'll have =
to
> do normal network troubleshooting to see why that might be.
>=20
> It could very well be related to the fact that you're running a nearly
> 14-year old operating system, but I just can't say for certain.  It's
> not a bug in Git, however.
>=20
> Even if the data is otherwise transferred successfully, Git will exit
> unsuccessfully if this happens, and that will result in your data not
> being checked out.

Thanks. The issue happens repeatedly on this machine, which is connected =
via Ethernet to residential fiber. I am doubtful of a generic network =
issue, but I will try an updated SSH client. (The issue does not happen =
over HTTPS.)

In any event, it would be good to have a more informative error message =
in this kind of situation. It is surprising that the data transfer is =
successful, and the Deltas are computed, but the overall checkout fails.

Evan


> --=20
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA

