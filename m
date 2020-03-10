Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08786C10F25
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 02:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08B52146E
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 02:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVX8DLwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgCJCT1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Mar 2020 22:19:27 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40374 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgCJCT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Mar 2020 22:19:27 -0400
Received: by mail-qk1-f195.google.com with SMTP id m2so11348326qka.7
        for <git@vger.kernel.org>; Mon, 09 Mar 2020 19:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rPRNcsRljC2emdL9+y8hjw/VbA1dsWzBRdwB61UlDgw=;
        b=bVX8DLwIS8+pCOCzN0W0Fso3YmnnYJba0d+bMky84pv1WV5erEp5pPE3NUxGffmxS9
         7eJ6Qh2dDxSkJ/6LIIaPhEre17D2q88H0rWzaNC05t/0ET+JDQBxzOmXZghFciw7RlNE
         9QaV1PGiQMkp7bDh80dD5zFPQmrlfeaS622NVxOM62j0y7wbaVx7pxR2jA/5HWU0yCLz
         klAXq61nXlAGPfCoUORrgg34f8GjR/SUb9bd77GTMX53yLU/kskfglbgK4KSrbW2WNKs
         alxekQ/WuwHoZ+inGKm/9h2u8LBTjAywqFfjQHCk+wi8Pe/BAq32NXiWRb57Z1Wr7wy1
         FO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rPRNcsRljC2emdL9+y8hjw/VbA1dsWzBRdwB61UlDgw=;
        b=aou6R3GIinha31rtUA2uRLyqGYHuQMK9UTQWnf08WunGjy8r8MgzqTbMVv4QADYp8i
         xT3MLEprgyeTTV8cMSgHtn2XOpVcnoPlTP/AlUnMpH+0yQOvkhivShbBUifUrhr0ndM0
         z7k0WK3ZSkScQ15R30NBN/IpVu5etOZyDOIRaast8dFP7usNAiJf9adt5TX47gITx6cG
         WRvjfxQzy/L/ywiFMs85bsjxwtfc7zOYAGgwTCXN614XLaOHol7E+jDbN3sr0MGKQ/qq
         zqls/MonSxtun8+DX1P7gDN7tUC9YMQ7ZWqYeVxfWSiv04CUzkAvdzfu5NIySmkFWQ7O
         NPKw==
X-Gm-Message-State: ANhLgQ3EatBIIzyEQhsiyd9XoKDecZHQK10TRd5uc9126GWyuqERQr0j
        W93sC5laUC1bUWcMIAo/hSqkDsC/0sA=
X-Google-Smtp-Source: ADFU+vv8GFehblAe9+vHL/BleanXkfSTwatrXCZ1KlOj8OY5QcYQ+h4sdpFbHi1kPYnRxpybNHV63w==
X-Received: by 2002:a05:620a:14b9:: with SMTP id x25mr5606635qkj.386.1583806764902;
        Mon, 09 Mar 2020 19:19:24 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id e2sm23354705qkb.112.2020.03.09.19.19.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Mar 2020 19:19:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 0/3] Teach ref-filter API to correctly handle CRLF in messages
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqqimjd1rx2.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 9 Mar 2020 22:19:20 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>, Alex Henrie <alexhenrie24@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <63755050-10A5-4A46-9BB3-8207E055692C@gmail.com>
References: <pull.576.git.1583692184.gitgitgadget@gmail.com> <xmqqimjd1rx2.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> Le 9 mars 2020 =C3=A0 11:14, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> The ref-filter API does not correctly handle commit or tag messages =
that use
>> CRLF as the line terminator. Such messages can be created with =
the--verbatim=20
>> option of git commit and git tag, or by using git commit-tree =
directly.
>>=20
>> This impacts the output of git branch -v, and git branch, git tag and =
git
>> for-each-ref when used with a --format argument containing the atoms=20=

>> %(contents:subject) or %(contents:body).
>=20
> What is missing from the above is the definition of "correct".
> Without saying what you consider in the current behaviour is
> "incorrect" and why, the first sentence does not give the right
> information to readers.

You are right, I'll send a v2 shortly with an updated cover letter and =
commit message.

> Let me speculate why "such messages" are created by end users using
> the --verbatim option.  They probably have unusual message that
> needs to have whitespaces and characters that are stripped without
> the option at the end of the lines in the message, and they
> explicitly ask Git not to lose them with the option.  Perhaps CR may
> be among those that they want to retain.

That's possible. In my case what made me discover the bug is our old =
version of GitLab at work,
in which messages for merge commit created using the web UI contain CRLF =
[1].

[1] https://gitlab.com/gitlab-org/gitlab-foss/-/issues/31671


