Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCC6C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 14:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D9C61106
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 14:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhKJOnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 09:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbhKJOnM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 09:43:12 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AE4C061767
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 06:40:24 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z21so11464782edb.5
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 06:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=u/tPgF8Yef3Kj349DN6QmUHzvrefm0xhH2WpL/J0tXc=;
        b=jWVwFQ03azTIsIiHAZAMrahxie6XWb3GGuIFii+fwLpuqT9gYklWKLoxI4r3DTSuF+
         djXCtgqk13zf5qaK0Hlrqqh15ekv7KXrbKjnbT0NkB4Q/Y9MKylRg0w8oRfXjf1mydN8
         6e7ZGcm7QLGNPRv1Ox78M9aafndEEHjVF/HI/oVa5cYUtHENVU18876GmwZnw5xe9zjW
         /lrpT8g4ybyS3AsI/IrU6exWpGSh/SFVgdUzhdlTdI9acQJiMEKtWuXkf7bJGn18CR0X
         vBqM1n8mn77sfQtK3puT0hKrbe4fH7HbOLu+TTJdrnjodkgembMKCqflGzJrwjZMsebA
         eVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=u/tPgF8Yef3Kj349DN6QmUHzvrefm0xhH2WpL/J0tXc=;
        b=1y/tbhjiiD7HA2R8PJx0At7pu71CVbuAT1jI3NLbn8wTCWnAmrdwFymmUlMj2VLQJJ
         CqSUaxXue6I2ytAfLibZk+vpMk//i2g6ubgybKLzr6O8+tIOkAbtlYFMV2DkhSHjo/0S
         y1lRDVhxX5uw2nXQiA65zO45X0CZYpi/HaRc69sdfhfM1m4TRdWN6nJPHQ/j99ZtRBMz
         HB6vaH15lnGr5/hMXTvDqIjmCveDc2jZ0luZbb8OtH+Wcwd4tp8MTH4JxInGJnWsMAVO
         5V7xRqHhzOM4mybLwKberJpG9I/avwRAq0Px/IFJGfkZt+4zFvUzkAA2ePhX+lgc8hID
         X9qA==
X-Gm-Message-State: AOAM530vy0btR04fl4ynKsAg/gPvspux+IJb9KBgmlqr/JV4zDrrN277
        sxmh3og9Pwnm47elOBzKAnI=
X-Google-Smtp-Source: ABdhPJyqi+o79PS4oKI3LDrofa6JfXvN0DuzZ1/njoZTMmqBE02IcHGIn/Mz0scXk82NjjySoYIbNQ==
X-Received: by 2002:a17:906:15d0:: with SMTP id l16mr108979ejd.462.1636555222764;
        Wed, 10 Nov 2021 06:40:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hd15sm11926454ejc.69.2021.11.10.06.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 06:40:22 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkolx-001105-Sb;
        Wed, 10 Nov 2021 15:40:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 1/3] wrapper: handle EINTR in `git_fsync()`
Date:   Wed, 10 Nov 2021 15:39:31 +0100
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <cover.1636544377.git.ps@pks.im>
 <0c8e98295e91b656a89e1db53bfe02e7c7fc8432.1636544377.git.ps@pks.im>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <0c8e98295e91b656a89e1db53bfe02e7c7fc8432.1636544377.git.ps@pks.im>
Message-ID: <211110.864k8khy5m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 10 2021, Patrick Steinhardt wrote:

> [[PGP Signed Part:Undecided]]
> While we already have a wrapper around `git_fsync()`, this wrapper
> doesn't handle looping around `EINTR`. Convert it to do so such that
> callers don't have to remember doing this everywhere.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  wrapper.c      | 9 ++++++++-
>  write-or-die.c | 6 ++----
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/wrapper.c b/wrapper.c
> index ece3d2ca10..e20df4f3a6 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -546,7 +546,7 @@ int xmkstemp_mode(char *filename_template, int mode)
>  	return fd;
>  }
>  
> -int git_fsync(int fd, enum fsync_action action)
> +static int git_fsync_once(int fd, enum fsync_action action)
>  {
>  	switch (action) {
>  	case FSYNC_WRITEOUT_ONLY:
> @@ -591,7 +591,14 @@ int git_fsync(int fd, enum fsync_action action)
>  	default:
>  		BUG("unexpected git_fsync(%d) call", action);
>  	}
> +}
>  
> +int git_fsync(int fd, enum fsync_action action)
> +{
> +	while (git_fsync_once(fd, action) < 0)
> +		if (errno != EINTR)
> +			return -1;
> +	return 0;
>  }
>  
>  static int warn_if_unremovable(const char *op, const char *file, int rc)
> diff --git a/write-or-die.c b/write-or-die.c
> index cc8291d979..e61220aa2d 100644
> --- a/write-or-die.c
> +++ b/write-or-die.c
> @@ -57,10 +57,8 @@ void fprintf_or_die(FILE *f, const char *fmt, ...)
>  
>  void fsync_or_die(int fd, const char *msg)
>  {
> -	while (git_fsync(fd, FSYNC_HARDWARE_FLUSH) < 0) {
> -		if (errno != EINTR)
> -			die_errno("fsync error on '%s'", msg);
> -	}
> +	if (git_fsync(fd, FSYNC_HARDWARE_FLUSH) < 0)
> +		die_errno("fsync error on '%s'", msg);

Nit: While at it maybe change it to: "fsync() error syncing file '%s'"

Maybe having a xgit_fsync() convenience wrapper would make subsequent
steps easier?
