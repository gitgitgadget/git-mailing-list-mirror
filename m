Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A2BC43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 07:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A0C21835
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 07:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="bT0qQtqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfLGH3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 02:29:37 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35713 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfLGH3h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 02:29:37 -0500
Received: by mail-lj1-f193.google.com with SMTP id j6so10111812lja.2
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 23:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65d63Ku8ifDNMXTZkbBrspuW/sG4/fa3uvoH5pySM2c=;
        b=bT0qQtqe8nph46vXiIcoliDC2R0c3Uv7js1vT2zp2aL1bccylXlmKwsfD+2YOKojS2
         nkm8ty2ukVDJUs8j15ByS059AaLx8Tdq1o+AsjRr7atM8v7noyGmR0KKDJIBPjbXZeAy
         MzMi9KRmq0BwYJPiOkc59Ii1EWdc/ImICulKdIxKHuz2S2QlKB4oX+M6SPMy5nb47/BW
         qOyJhuGoOP5Y8MY2t9ku38aRu2g5202M4MTzTNj3id2LRTPGmeT9E048b0ZyykQfkE7i
         Sj9vrvp8lmy72UedHN19nkaInZOrH8JijDrJEg1JGK4cOi9XHtLrkuLUL5hV+sy4YZCc
         RMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65d63Ku8ifDNMXTZkbBrspuW/sG4/fa3uvoH5pySM2c=;
        b=tm9CLvhkBBQDEEEKX7e9b8e/v8o2STMY8vZGCne43gzsHPIgKzV5E6k+HK+N8X+WJc
         T0oytA/kzSLhm9NF0oZGlV3xJwHKNP2Xt0tt/HQcGlehTJMIK0YEJwOVpzrwgOBhqb/V
         2nzxYuo9wNh+EmOEmfvqvNcYYD+yCiMX19HbAj3oGURL1P7WEvh9gZwhMBLAwvWPEV80
         YaxcUlxBD4FVvRJS1m4fcxaQhJK3g7zljedaz5b5GoJoZJ9TgdGax58rk/40jaBnsWK5
         q/ffRhI+ofWduTuyRoRplx3zRYTbhAQa4FWzXtX8M1wIgy0+nr+3gFd+sHjcpPmbCDSz
         6piw==
X-Gm-Message-State: APjAAAXOvsHAHahyyTQmLzcdSFtTxTQGAew/9AOCt5pSDy9qdRoXx5Ye
        IQUrrh2Oli+RTC4dcFzsyyv67vyL+746wIujOFVgHg==
X-Google-Smtp-Source: APXvYqzJlNVm1RNqRS53goVWR3FSXjxfgVXI17gGE8y/XwVfZYplt7acpkIi08d2Sl9FX5+YlwRIqtBrX4JRvYvKGUQ=
X-Received: by 2002:a2e:7816:: with SMTP id t22mr10825332ljc.161.1575703775132;
 Fri, 06 Dec 2019 23:29:35 -0800 (PST)
MIME-Version: 1.0
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com> <20191207010938.GA75094@generichostname>
In-Reply-To: <20191207010938.GA75094@generichostname>
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
Date:   Fri, 6 Dec 2019 23:29:20 -0800
Message-ID: <CABvFv3+viMXJO0z5HAQbCya7MU9tWd7P_LxUhu66T74XGN99yA@mail.gmail.com>
Subject: Re: [PATCH 00/13] git-p4: python3 compatibility
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 6, 2019 at 5:09 PM Denton Liu <liu.denton@gmail.com> wrote:
> On Fri, Dec 06, 2019 at 04:33:18PM -0800, Yang Zhao wrote:
> > This patchset adds python3 compatibility to git-p4.
> > ...
>
> Currently, there's a competing effort to do the same thing[1] by Ben
> Keene (CC'd). Like the last time[2] two competing topics arose at the
> same time, I'm going to make the same suggestion.
>
> Would it be possible for both of you to join forces?

Yes, I do believe we are aware of each other's efforts. I had submitted
an RFC patch set around the time Ben was preparing his own patchset.

I have not reviewed Ben's first patchset as I did not feel that I understood
the systems well enough at the time. I've briefly skimmed through Ben's latest
iteration and it would appear the general approach is very similar, but there's
more added abstractions and just general code change in his version.

Regardless, I'm open to working together.

Ideally, I would prefer we land something minimal and working in mainline soon,
then further collaborate on changes that clean up code and enable more features.

My end-game is to have P4 Streams working in git-p4, and maybe LFS-like support
that uses p4 as the backend. It would be great to not be the only one
spending effort
in that direction.

Yang
