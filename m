Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C4AC433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 11:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9831C610E5
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 11:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhDHLWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 07:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhDHLWy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 07:22:54 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAC9C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 04:22:43 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id nh5so946055pjb.5
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 04:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+ExPF9zEUwW8pMjZNhLWIQEmPq+v9vI3wip59bWvxXA=;
        b=SKRKqS7AqanOpHCy7UzsUTSAhrqxdydjWXSQxMJnGI8sh+u5eA/f6OoxOBXz9EVltR
         7vggaRjtT202JQOLyLAvS/gBgf5RcoenRQRfnYYs8Z6bzLS/0CE9Bc/a78MUMStdvB1b
         n2DcaL5QHTfGdpWYWOBCm2DCwdnTrH3R05bolxCv6eUaj7z2DycCdRHY3GaKIx+D9NQl
         DYt+u/ekJAcK0uB/rUG7wWGtMd0z6X71eml7nKkp+ZEBOXIN0C2VTc+0DMHwWfEpXcMy
         erQLR6wNyfkg6MkT+ifxcZpOzkiiqSDvh5uxsLlHQ8yVrZM7+ZCNBaqxyKzCG2RmrDAf
         5HEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+ExPF9zEUwW8pMjZNhLWIQEmPq+v9vI3wip59bWvxXA=;
        b=Bmyb89+i2UdQhw0oX0McZ8xRQtksxOiGV724DsuXL3VPZEUOcbIObQH85MTgUUSFr5
         nZCc20cA444F6XordQBTe0a8qo0jQn4WSKxKQaQseVnC9e70mme0m3iajxF6dGPXl/6m
         2v5lz6bFFz9WYvM2ulGFjxo56Z+tlCuZQyRUEdpUQloKHmPZ8TXLE/y85hp9rejCWrtk
         OXT9IWYqae6yP9kdBjuWy8NVBcE45cXwNiQajx9CJJe/nFEmwRpDyMo2g6KbFrCnYo73
         WxOUgXO4ckiQ8h9ia5nZ5kZ/ye+05mNgY90YKUfFEQG8S8HzFG3ba1J1YxsHItHUVMDF
         nVmQ==
X-Gm-Message-State: AOAM532+R4BPIcRER5F+J4Rosf0RCGAh/8pFM9fiziU05hEyekhsMxOK
        km1rKrr7Ocrda1zjhpY1HYiJDMkhMXo=
X-Google-Smtp-Source: ABdhPJyKoKqNLctxU7h3m8XAGVR+oN/JHuQXq+jUJzPGe2iovVT17PBsjiPVHguIkhZFsHVCLsiYzw==
X-Received: by 2002:a17:90b:4a8a:: with SMTP id lp10mr7140782pjb.27.1617880962819;
        Thu, 08 Apr 2021 04:22:42 -0700 (PDT)
Received: from localhost ([113.185.86.148])
        by smtp.gmail.com with ESMTPSA id s22sm23680540pfe.150.2021.04.08.04.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 04:22:42 -0700 (PDT)
Date:   Thu, 8 Apr 2021 18:22:39 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v2 1/4] run-command: make `exists_in_PATH()` non-static
Message-ID: <YG7naB1xepTSoeVk@danh.dev>
References: <20210407173334.68222-1-mirucam@gmail.com>
 <20210407173334.68222-2-mirucam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407173334.68222-2-mirucam@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-04-07 19:33:30+0200, Miriam Rubio <mirucam@gmail.com> wrote:
> From: Pranit Bauva <pranit.bauva@gmail.com>
> 
> Removes the `static` keyword from `exists_in_PATH()` function
> and declares the function in `run-command.h` file.
> The function will be used in bisect_visualize() in a later
> commit.
> 
> `exists_in_PATH()` and `locate_in_PATH()` functions don't
> depend on file-local variables.

Isn't this implementation detail? I think we shouldn't include them in
the commit message.

> 
> Mentored by: Christian Couder <chriscool@tuxfamily.org>
> Mentored by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  run-command.c |  2 +-
>  run-command.h | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/run-command.c b/run-command.c
> index be6bc128cd..210b8858f7 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -211,7 +211,7 @@ static char *locate_in_PATH(const char *file)
>  	return NULL;
>  }
>  
> -static int exists_in_PATH(const char *file)
> +int exists_in_PATH(const char *file)
>  {
>  	char *r = locate_in_PATH(file);
>  	int found = r != NULL;
> diff --git a/run-command.h b/run-command.h
> index d08414a92e..a520ad1342 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -179,6 +179,16 @@ void child_process_clear(struct child_process *);
>  
>  int is_executable(const char *name);
>  
> +/**
> + * Returns if a $PATH given by parameter is found or not (it is NULL). This
> + * function uses locate_in_PATH() function that emulates the path search that
> + * execvp would perform. Memory used to store the resultant path is freed by
> + * the function.

I think this documentation focused too much in implementation detail,
locate_in_PATH is still an internal linkage symbol at this stage.
I think its mention here doesn't improve anything.

Further more, "a $PATH given by parameter" is not what this function
does, the function check if a given "file" is found in "$PATH" or not.

I would copy 2 first paragraphs of locate_in_PATH's documentation, and
append the documentation for return values instead:

-- 
Danh
