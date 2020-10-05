Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA4BC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 23:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 562A92075A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 23:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNepwfZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgJEXmm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 19:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgJEXmm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 19:42:42 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F122C0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 16:42:40 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bb1so301662plb.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 16:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YULWb//7H+AN1PeK7+8LMJfHh/GeHUjV04JbSrEctxw=;
        b=CNepwfZb7C/rp7HB+5V11eh4cYgc/Qoc9FbcaReck3HrdvLuytOyeTIIw9NiXCtbYz
         ald/iEiMz1K6yJjXg2TOq7B30KOB3L1460XV/BEgVGzbFvDWeS6Dcq1fw1ErAZHkYlWE
         2PwAW4syCGyXIyiveNeL5oobpYYH24fCF8B0JGb6rIqBq3sl1k96/aTvXt0RBBBcj+DF
         skvgojBJpKNITjTYQ+2sH+1ut3Yn+AxFIYVlS4SYu3GSkxi9CAw2BHRwfljb9CIsLkes
         fsSgI3NXeA4mr+eDQfV3PPnepllNpCC7z0EIE0DBAft0uAt8/5BhlqWuQAatebR1NItF
         G5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YULWb//7H+AN1PeK7+8LMJfHh/GeHUjV04JbSrEctxw=;
        b=GvjRTgsaSE2yzMRio5gE+PyBeq4wx7ucf0q3RdTEvtVHyv9055fFcsEeKlB3I+4/0U
         HHthh8LcnEAlzMWKAkKb3NNDMxcWq8qZCuXHl7lhAv7W39Cn52dtzRkZFYAwgy00YXJR
         BDdTEVHTn3WtGxmdzALjCAQsa57/Uau3oMW8JoP9z//XQqnoGukjSx02BPIxn6MVEosr
         IMqTkvA7/DRta+CB1yoiyc5IvCSRdRAvGwH2ghZFITC3bpmsjIbE2lXCO53a1WOBhoS9
         EQspgWn5BfFbX1274MWDfBwAxXMWERRxeXGByeAXqiDKkjnXot44RhvXYhKUnYJ4pIh+
         QCRw==
X-Gm-Message-State: AOAM533i2TnwVD9KxA5rGrcuUgJ5YQh5xKtccDUjAMI+pnUIRxOqpbsk
        gmo1bIG9YJLMmhIEMVCya3o=
X-Google-Smtp-Source: ABdhPJx5z7IIvWB15Rotae8HIzg4yN7WEI9K7Qzi7+9Yym7aoIpkiaGQDceYNmUyzJI+ykyDRDsSXw==
X-Received: by 2002:a17:90a:b287:: with SMTP id c7mr1729480pjr.141.1601941360180;
        Mon, 05 Oct 2020 16:42:40 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id q6sm1157389pfn.10.2020.10.05.16.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 16:42:39 -0700 (PDT)
Date:   Mon, 5 Oct 2020 16:42:37 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 7/9] hook: replace run-command.h:find_hook
Message-ID: <20201005234237.GE1393696@google.com>
References: <20200909004939.1942347-1-emilyshaffer@google.com>
 <20200909004939.1942347-8-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909004939.1942347-8-emilyshaffer@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer wrote:

> Subject: hook: replace run-command.h:find_hook

tiny nit: This doesn't remove find_hook, so this may want to be
described as "add replacement for" instead of "replace".

[...]
> --- a/hook.c
> +++ b/hook.c
> @@ -111,6 +111,15 @@ struct list_head* hook_list(const struct strbuf* hookname)
>  	return &hook_head;
>  }
>  
> +int hook_exists(const char *hookname)
> +{
> +	const char *value = NULL;
> +	struct strbuf hook_key = STRBUF_INIT;
> +	strbuf_addf(&hook_key, "hook.%s.command", hookname);
> +
> +	return (!git_config_get_value(hook_key.buf, &value)) || !!find_hook(hookname);
> +}

This feels a bit fragile, since it can go out of sync with run_hooks.
I think I'd prefer if they shared code and this function either
returned a parsed structure that could be used later to run hooks or
cached the result keyed by hookname.

Thanks,
Jonathan
