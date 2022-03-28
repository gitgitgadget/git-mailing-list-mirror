Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FBAC433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 15:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240577AbiC1QAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 12:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236994AbiC1QAC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 12:00:02 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D17F221
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 08:58:19 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id p25so11729268qkj.10
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 08:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lMIKFybE/V507bHKvnJn47AdCBULfBqGh0FUSo7zfgc=;
        b=h7oGMwDF76xC8lwehvHzfxJno+TpmD6kPOpoAJJMAaBr+w3hY1rw1foF01a6egEbXN
         mxBDCSs7yrBY+/d9KNPq/x7yiF0acorHMJp60BWSWet3WrvkPasYaLJnyrrhPEL3uDMN
         708iSBXRJeLJQQ80UUe8XiCEy5sNImSQe2VbQ81tvVCyqfRGL3GVdJz9DRB/DI2szL1N
         9LGyyY+cDlmOeeHncmpM3GlXrM/b3b1Y9Hu/4zq4so8DXS8KefS3EgNYxXR/fXbzBdCw
         cwi/cgS06Ai63xxyEtRDqPehjjsCNhbiDduP6KLDspx9pAHh7PskOJzSGiY/4rsUGEHn
         4r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lMIKFybE/V507bHKvnJn47AdCBULfBqGh0FUSo7zfgc=;
        b=BaUrSJKdztXJwrSepcCx0RWA2Yz2/1p/RtxOA0w9znw5X6k9tHtXVXNB/pLGHb9ZN7
         xSbhPEbjfDg5KEDOheD8rJvc9pFA5fEcY4cvGf/czDRG0FmlHosOfxI19tXDB8eO6/na
         Quds69Lz/WmWSMNiGiUAYWTSo3XHDHG0lmrOLKoE+lKnHOjA9OfTGOEqKt4CULXUhba1
         Ev4tm0fIvgLpUOFBWofkIFqt6ca/iHYEvWq/7n/hfIvi0dvNuTG6nUVClpX6ft7jCaGN
         DwjWHL+SFg0v/YYWz6hPyBJyhPjRzodWhLWUTewjEIURe+fQ90+JewFHaceVWKCJV229
         VZ+A==
X-Gm-Message-State: AOAM532Q8CKhVwtl8gxukFjWm3735FBY1wluR08znUwUZr7kmOiPB4be
        gx/jGSw6G0k9/OhjlHBLRoZR0A+xIL21
X-Google-Smtp-Source: ABdhPJyeFsLl0iKITNk7QrXqTCJc7/MOddtUwWn+HhZTtUGkzqH0hyNt8WhqBIrYiORfl8YFvVc5gg==
X-Received: by 2002:a05:620a:d96:b0:67a:ee04:d947 with SMTP id q22-20020a05620a0d9600b0067aee04d947mr17122990qkl.237.1648483098563;
        Mon, 28 Mar 2022 08:58:18 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id k1-20020ac85fc1000000b002e1c6420790sm13660770qta.40.2022.03.28.08.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 08:58:18 -0700 (PDT)
Message-ID: <4781bae6-4ac6-1217-b018-aef286cdca7c@github.com>
Date:   Mon, 28 Mar 2022 11:58:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] pack-objects: lazily set up "struct rev_info", don't
 leak
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <patch-1.1-193534b0f07-20220325T121715Z-avarab@gmail.com>
 <patch-v2-1.1-9951d92176e-20220328T154049Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-v2-1.1-9951d92176e-20220328T154049Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/28/2022 11:43 AM, Ævar Arnfjörð Bjarmason wrote:
> An earlier version of this commit[3] went behind
> opt_parse_list_objects_filter()'s back by faking up a "struct option"
> before calling it. Let's avoid that and instead create a blessed API
> for this pattern.

...

> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> index f02d8df1422..4b25287886d 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -285,6 +285,10 @@ int opt_parse_list_objects_filter(const struct option *opt,
>  				  const char *arg, int unset)
>  {
>  	struct list_objects_filter_options *filter_options = opt->value;
> +	opt_lof_init init = (opt_lof_init)opt->defval;
> +
> +	if (init)
> +		filter_options = init(opt->value);
>  
>  	if (unset || !arg)
>  		list_objects_filter_set_no_filter(filter_options);
> diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
> index 90e4bc96252..ffc02d77e76 100644
> --- a/list-objects-filter-options.h
> +++ b/list-objects-filter-options.h
> @@ -104,13 +104,31 @@ void parse_list_objects_filter(
>  	struct list_objects_filter_options *filter_options,
>  	const char *arg);
>  
> +/**
> + * The opt->value to opt_parse_list_objects_filter() is either a
> + * "struct list_objects_filter_option *" when using
> + * OPT_PARSE_LIST_OBJECTS_FILTER().
> + *
> + * Or, if using no "struct option" field is used by the callback,
> + * except the "defval" which is expected to be an "opt_lof_init"
> + * function, which is called with the "opt->value" and must return a
> + * pointer to the ""struct list_objects_filter_option *" to be used.
> + *
> + * The OPT_PARSE_LIST_OBJECTS_FILTER_INIT() can be used e.g. the
> + * "struct list_objects_filter_option" is embedded in a "struct
> + * rev_info", which the "defval" could be tasked with lazily
> + * initializing. See cmd_pack_objects() for an example.
> + */
>  int opt_parse_list_objects_filter(const struct option *opt,
>  				  const char *arg, int unset);
> +typedef struct list_objects_filter_options *(*opt_lof_init)(void *);
> +#define OPT_PARSE_LIST_OBJECTS_FILTER_INIT(fo, init) \
> +	{ OPTION_CALLBACK, 0, "filter", (fo), N_("args"), \
> +	  N_("object filtering"), 0, opt_parse_list_objects_filter, \
> +	  (intptr_t)(init) }
>  
>  #define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
> -	OPT_CALLBACK(0, "filter", fo, N_("args"), \
> -	  N_("object filtering"), \
> -	  opt_parse_list_objects_filter)
> +	OPT_PARSE_LIST_OBJECTS_FILTER_INIT((fo), NULL)

I like this way of combining the macros into one implementation
(guarded with a NULL check).

This version looks good to me.

Thanks,
-Stolee
