Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81CAC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 18:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiBUS1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 13:27:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbiBUS0H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 13:26:07 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A1E1DA56
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:21:14 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id c18so14532688ioc.6
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9K9uVttJpDDO1MJ/J4Pn9x59j0c8maAqM6MXmE+v3oM=;
        b=bEHz4GxP/gBdQuCw15ktpW/27LU5dqF0IyFLVrOvrcYS8hn20TSgj7lPUVFea6W0LT
         WGtoaq65hagIurChvoOZjGIegHAjNIbQ4Fj7iMeNF5TiAaDcZIK31Wfq4F6pJyooo2ld
         /oPFI1Mqjom50OkDuD3d9tHtxXYPx63nrjZfsnkdTLfySuBH9k/iKoXJUKTdbQ9DU5Xo
         +T3DYPc25S8gpL0nxQJN9Wv+Yiwd+NZp/U3wDm0a2gXqhiM98d7t6b54KJWkaIzUYRVO
         CYYCT1uEhSe36whGrYAFoSGHSYUQFRC/Tlybjf+nKTxsMtk24DmebsCAhuhFXFTwroWx
         txMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9K9uVttJpDDO1MJ/J4Pn9x59j0c8maAqM6MXmE+v3oM=;
        b=HgiU4TzZKa9onPUUaYhrT15NoFGeKM9mHNybOVwhYs0dQMBXYepwkj0mNeugQMpxlp
         xiJN5PbtqD0OZHEGTo4dlVxUc8STPgf3LTWF3ynbHStUnd2wQB8vtwL0QWYkPEvijBU+
         hTxyC4Qa2DJwgXL4Agnqr14IfnPnqilV3lZSXuzMYkOdUfzlyR5TMMP3S9PexgHZiXh4
         j9Kw8ogQiPuNhtO+xyNxNLMe8ghFMOUSSRlaDjRcAfNVl2ozZ9V7MXhIeBQ7TXQBWTi1
         tfZpbf51kI5Uti070wUJj4CiA7vH1kGZ8uLYhiFSgPx5yylRXCRjq7No+lgGds4TNrYJ
         xpeA==
X-Gm-Message-State: AOAM530YJ2El7awJ2eJv8BAsxA+0bqrTusHdLPm7a7o7N+LlYLSMJ8pv
        GGnjJ1FI88tcH1yHqQG3RVDBww==
X-Google-Smtp-Source: ABdhPJwfQXh+hLyayVOOp8U+GOy+Pm3fkvEvp0/bdbcvJa7CIEwvAPr4gJ6SLr7mMUwUXwYasy59Qg==
X-Received: by 2002:a05:6638:304d:b0:307:1acf:2eca with SMTP id u13-20020a056638304d00b003071acf2ecamr15816377jak.101.1645467673907;
        Mon, 21 Feb 2022 10:21:13 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e5sm8283459ilq.9.2022.02.21.10.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 10:21:13 -0800 (PST)
Date:   Mon, 21 Feb 2022 13:21:12 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] usage.[ch] API users: use report_fn, not hardcoded
 prototype
Message-ID: <YhPYGDfzdMElklX7@nand.local>
References: <patch-1.1-7551daf131b-20220221T160719Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-7551daf131b-20220221T160719Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 21, 2022 at 05:09:18PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Change a couple of users of "report_fn" that hardcoded a definition of
> it to use the definition of report_fn instead.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>
> I'll eventually want to depend on this for a larger topic I plan to
> re-roll[1], but in the meantime this trivial fix can hopefully cook &
> graduate.

This looks good to me, thanks.

> diff --git a/run-command.c b/run-command.c
> index a8501e38ceb..3d854c498aa 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -362,10 +362,9 @@ static void NORETURN child_die_fn(const char *err, va_list params)
>  /* this runs in the parent process */
>  static void child_err_spew(struct child_process *cmd, struct child_err *cerr)
>  {
> -	static void (*old_errfn)(const char *err, va_list params);
> +	report_fn old_errfn = get_error_routine();
>  	report_fn die_message_routine = get_die_message_routine();

Perhaps as part of the larger series you alluded to earlier, but we
could get rid of the die_message_routine variable here altogether. It
only exists to pass as the argument to set_error_routine(), and isn't
used anywhere else in the function.

So you could do something like this on top:

--- >8 ---
diff --git a/run-command.c b/run-command.c
index 3d854c498a..4afa01db9a 100644
--- a/run-command.c
+++ b/run-command.c
@@ -363,9 +363,8 @@ static void NORETURN child_die_fn(const char *err, va_list params)
 static void child_err_spew(struct child_process *cmd, struct child_err *cerr)
 {
 	report_fn old_errfn = get_error_routine();
-	report_fn die_message_routine = get_die_message_routine();

-	set_error_routine(die_message_routine);
+	set_error_routine(get_die_message_routine());
 	errno = cerr->syserr;

 	switch (cerr->err) {
--- 8< ---

But it doesn't need to happen here, just an idle thought I had while
reading.

Thanks,
Taylor
