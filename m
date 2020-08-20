Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B3DC433E3
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 14:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C1F6207DE
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 14:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkpRtBZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgHTOvl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgHTOvb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 10:51:31 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED0AC061386
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 07:51:31 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id z23so992990plo.8
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 07:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dVZHedtm7ejbx0BIolGi3RnR/E5F6B21O1m287py5uU=;
        b=rkpRtBZJJNNNpjivHKXDqighk51Vvqdx10uPsJUqWFacNKScBoe5tVR/mJxX1RTFza
         WxcKsDta0xwFnOE0qZENW7Ap/Y2Ln/u5YzAb6ouJi93+mCS8ymaVshakj54Va1cBwWLK
         IK0D2odfzY7i4jFTY/TdIpFgevBS2bW6l3zpsW5X+yT16CvcFap04eU0vbKofOX95/Cg
         AYQY70F4uid2c2cuxAYYboSHLmv92woCoPr+PiS5b+X7yFLiBUEHUjQo3Ga7QxAS3bRL
         vq+ApqwfDvTES4FwT6htyeqBswgsjHONnEehVbb1RLKS87fHj1VNMbOU4n9LRscEqa9K
         z1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dVZHedtm7ejbx0BIolGi3RnR/E5F6B21O1m287py5uU=;
        b=ch9+vuh6yhbVCXdgpKdJaAaqEivr1axIOmf5+89to4r2oe8uKfcSNb9JJdgn7001ff
         cy7MGtjklHZEM0+zudzPWZcgc1b/FkL5ejX7/Cz7U/a7K9imMHTr2EnwcgjcVVheiaCI
         H5iPLJ7b75bhxHlXWtrG4kmcrR1wG1ZPVqu5r8QszZZtJSCw/PMxwnTMst6TlZxthJVT
         DG5713BfiDmeXdYB/TasoPkpTXlmFrz5fh2A3PkX3JR/OYYuv8S0KnVWVd+z6UdQ3cly
         PCbOZyIDzRAONbdZ/yWJcMr/1s9swY7cMWyWJ0r9pHUCUs3oAZ2f+bwwuvhrcfunSvV+
         +ciQ==
X-Gm-Message-State: AOAM532KVXsweCeS/HU4xIs3EQpX2L0DESEuUYdg7u509z21scPmhq+x
        Ku1DAL8TqOVh92/YGSTgMjOF/g/i8FiWpA==
X-Google-Smtp-Source: ABdhPJzB+6W9TBr97N2qIVS6IiMrTxI4SDQ2QgX3ZSfJEDFcDVrmOcmKNX4Mk/a3nC0CP8Cf2ppPNw==
X-Received: by 2002:a17:90a:1384:: with SMTP id i4mr2870566pja.157.1597935090565;
        Thu, 20 Aug 2020 07:51:30 -0700 (PDT)
Received: from localhost ([2402:800:63a8:cb7a:1eb1:40a4:f50c:706e])
        by smtp.gmail.com with ESMTPSA id p9sm2905338pjm.1.2020.08.20.07.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 07:51:29 -0700 (PDT)
Date:   Thu, 20 Aug 2020 21:51:27 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/7] maintenance: add --scheduled option and config
Message-ID: <20200820145127.GC31084@danh.dev>
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
 <4473c93b118a0e0cdb205d1758aaaa2d8bf5139a.1597857412.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4473c93b118a0e0cdb205d1758aaaa2d8bf5139a.1597857412.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-08-19 17:16:44+0000, Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com> wrote:
> +static void fill_schedule_info(struct maintenance_task *task,
> +			       const char *config_name,
> +			       timestamp_t schedule_delay)
> +{
> +	timestamp_t now = approxidate("now");

I see this pattern in both previous patch and this patch,
should we create a helper (if not exist) to get current timestamp
instead, parsing "now" every now and then is not a good idea, in my
very opinionated opinion.

> +	char *value = NULL;
> +	struct strbuf last_run = STRBUF_INIT;
> +	int64_t previous_run;
> +
> +	strbuf_addf(&last_run, "maintenance.%s.lastrun", task->name);
> +
> +	if (git_config_get_string(last_run.buf, &value))
> +		task->scheduled = 1;
> +	else {
> +		previous_run = git_config_int64(last_run.buf, value);
> +		if (now >= previous_run + schedule_delay)
> +			task->scheduled = 1;
> +	}
> +
> +	free(value);
> +	strbuf_release(&last_run);
> +}
> +
>  static void initialize_task_config(void)
>  {
>  	int i;
> @@ -1359,6 +1387,7 @@ static void initialize_task_config(void)
>  
>  	for (i = 0; i < TASK__COUNT; i++) {
>  		int config_value;
> +		char *config_str;
>  
>  		strbuf_setlen(&config_name, 0);
>  		strbuf_addf(&config_name, "maintenance.%s.enabled",
> @@ -1366,6 +1395,20 @@ static void initialize_task_config(void)
>  
>  		if (!git_config_get_bool(config_name.buf, &config_value))
>  			tasks[i].enabled = config_value;
> +
> +		strbuf_setlen(&config_name, 0);

It looks like we have a simple and better named alias for this:

	strbuf_reset(&config_name)

_reset has 400+ occurences in this code base, compare to 20 of _setlen


-- 
Danh
