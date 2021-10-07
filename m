Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C40AC433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 18:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E81DF6103C
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 18:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243676AbhJGSgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 14:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhJGSgu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 14:36:50 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834C4C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 11:34:56 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id y1so4448660plk.10
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 11:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=pe6WbQyW9sphZQc3Z2RUhSKcCtLKjAfVXPcQepYXKx8=;
        b=rf3eCcqB+6nn2PjEiO9kPOWtbmxn+jy4lUHN/cElS+QJlX4mR7a0IoHwpuyRH5T6qY
         YflMLIPEkrrjOsDQxVaBkJHMbklQ+FdApxyTF99W8OGw4FWqzGQFxSazdLfolfiUtSVj
         2ySfW8ZyViUiG739AJ5T/rX4ir30x+kQSA1zigQ+KSra8u3SF8dSs7pFM4km7Whderys
         IRkPDOVkkUQps4hRXdQ14mlYPyKfXRvHEJbjJJbFyB5SJOz4ssPQFZhiISqmA6ZT1JwV
         0+9EDcb/fzzSa+lssmTQHhqPiL7LHu/6nbKfXef0rbwDOSYIpBuAjJ6+mW0w2rnJJtZ/
         7A8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=pe6WbQyW9sphZQc3Z2RUhSKcCtLKjAfVXPcQepYXKx8=;
        b=gpYAFing2guM8NQYUj84X2X0bGvDldDsiGjFQNnWlNu7KmaPiP1Cz1toW+J0dN8rHX
         MK2z+tTrMvJJ9ofH9lyYDUck02QYX/zLDyKvoH5D0BSlfSSg2Xz66ORXPQLXkiABbBjG
         iGJqtR+HdDWTqJ5ONM8FPDGQkcrcA58po6ekUpNOv736WZD4zgrqQfpOSKL2HFnBKFwj
         +ZWTZC7Q4KwcBpwqw031r0TcWH6arVr5z4HIDqeOm9h/bU9hxNZViCgIdwoRgPx04RZq
         E2Qp1ypIayk5vGapbxQVYAI0BhbgNQ6vGATbmp174lAiOBQMPvgYrPRY/O7rh5MpotI5
         DbbA==
X-Gm-Message-State: AOAM532IEQcDQf9X8BLju5L7W+teY9/uF40q0ATFiXilMScP+DZ6/NyR
        hFhlkyJlz/rSAuCXPPe0WI8GR1gZKQ3tlg==
X-Google-Smtp-Source: ABdhPJzZYwhId9VIq/OtQiTWeNoXi7UWCy9TeU/1CiW2cYPWFkBSNhbO5k8tG9GS41W5c2Sy03z6Ww==
X-Received: by 2002:a17:902:7613:b0:13d:c6f0:1ecf with SMTP id k19-20020a170902761300b0013dc6f01ecfmr5223789pll.16.1633631695789;
        Thu, 07 Oct 2021 11:34:55 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf7:7c1c:a2ca:e52a])
        by smtp.gmail.com with ESMTPSA id o2sm9062613pja.7.2021.10.07.11.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 11:34:55 -0700 (PDT)
Date:   Thu, 7 Oct 2021 11:34:49 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 7/7] submodule: trace adding submodule ODB as alternate
Message-ID: <YV89ybxIomWjSkFG@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1632242495.git.jonathantanmy@google.com>
 <cover.1632956589.git.jonathantanmy@google.com>
 <e4b6ee218656bb7c296475ae70562472ddd45682.1632956589.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4b6ee218656bb7c296475ae70562472ddd45682.1632956589.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.09.29 16:06, Jonathan Tan wrote:
> Submodule ODBs are never added as alternates during the execution of the
> test suite, but there may be a rare interaction that the test suite does
> not have coverage of. Add a trace message when this happens, so that
> users who trace their commands can notice such occurrences.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  submodule.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/submodule.c b/submodule.c
> index 4bf552b0e5..61575e5a56 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -201,6 +201,8 @@ int register_all_submodule_odb_as_alternates(void)
>  		add_to_alternates_memory(added_submodule_odb_paths.items[i].string);
>  	if (ret) {
>  		string_list_clear(&added_submodule_odb_paths, 0);
> +		trace2_data_intmax("submodule", the_repository,
> +				   "register_all_submodule_odb_as_alternates/registered", ret);
>  		if (git_env_bool("GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB", 0))
>  			BUG("register_all_submodule_odb_as_alternates() called");
>  	}
> -- 
> 2.33.0.685.g46640cef36-goog
> 

Can you also update the GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB note in
t/README about tracing in this case?
