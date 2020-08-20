Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF3AC433DF
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 02:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6696208B3
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 02:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgwZ/Hcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgHTCHD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 22:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgHTCHC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 22:07:02 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2F4C061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 19:07:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a79so274641pfa.8
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 19:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6BtB0TeiuX8FSQBd9k67+kYYkkaR6zSPvPi7npo59mg=;
        b=JgwZ/Hcm63TjYfCaKBE3QpzJPJONszJVf3E/QIDBbREe6es2DP3D5qkI621HM8q+jT
         XyBVIwjITnSt5AoTGPe9fyy+Bnq2sBdHCVVCBZwaJ7zPT3S0SsuvZIs1Q8TpL9MZ/3jh
         Xk40dz5LHxAeGSkCzfrN/18ZXqcaI4+NryuEEMYaXXwxGTcO7qXrmQzIER+fgM359S4Y
         Mxt2/u3BRfGs26wGq+vHZ37vt/W1JGlVo9bjRNhWkXAKYSXYtgKfmRDPeoPT3+41LEwu
         SwGlNHvvqP2BQe5Y6+uZBGTPvZsnegULGJvPNgKS0O2UD1lY8Db/cZJE8eoLMcAz9Brk
         9OpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6BtB0TeiuX8FSQBd9k67+kYYkkaR6zSPvPi7npo59mg=;
        b=YRVxZFr+xLGqQGR9bmytmPbFwkomMYU8PAYzxqdV+N029yv5pIMfjppfF0AvGRorNe
         tYvSOzUFUG0QvGIiijpb0f1KN4Z2OLBnNWq0WzRRTprtwYQ2vwAOVfSt3Ls4nbugMBAG
         0+iFCPdT1k7NkMYAyDlG7D0TlDJ0oYkVCCkRro37KBx9QDiFWi9GnT5v4tkQEnDgnsFu
         iM0IXdAzp/gtDygdw6dl9mN+ZECQeaqUEi0mNtAxVyOpsUJRcuHiNkLAavbM5YPF9AQb
         x0ytyJR9HJkoDqoQwonVqDTMaCWUVPbF+XAl45nGcWd/xWdmZRjN1ffC5XCNbzjIN10Z
         Or6g==
X-Gm-Message-State: AOAM533jyTjQk+7ZU/ism7tFvwACs4R2KmY+qdICOgQ7ZhblOQbPDkb+
        EfW4XWd41s6EBgO7SkXZuv0=
X-Google-Smtp-Source: ABdhPJzPDgQNBopUX92qyODvimCMsgRfnheehgtA2sDqC2ZuTdT/NjK6FUTzxdokTV/dxpZMX7qVzQ==
X-Received: by 2002:a63:4c11:: with SMTP id z17mr890538pga.152.1597889221609;
        Wed, 19 Aug 2020 19:07:01 -0700 (PDT)
Received: from localhost ([2402:800:63a8:cb7a:1eb1:40a4:f50c:706e])
        by smtp.gmail.com with ESMTPSA id mh14sm281773pjb.23.2020.08.19.19.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 19:07:00 -0700 (PDT)
Date:   Thu, 20 Aug 2020 09:06:58 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/7] maintenance: optionally skip --auto process
Message-ID: <20200820020658.GA31084@danh.dev>
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
 <90de25d1287595fdedc9dcd194a2e0ac120d4aad.1597857409.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90de25d1287595fdedc9dcd194a2e0ac120d4aad.1597857409.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-08-19 17:16:42+0000, Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> @@ -1868,8 +1869,15 @@ int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
>  
>  int run_auto_maintenance(int quiet)
>  {
> +	int enabled;
>  	struct child_process maint = CHILD_PROCESS_INIT;
>  
> +	if (!git_config_get_bool("maintenance.auto", &enabled) &&
> +	    !enabled) {
> +		    fprintf(stderr, "enabled: %d\n", enabled);
> +		return 0;
> +	    }

Nit: This block of code is mis-indented (mixed space and tab).

If we're running into inner block, "enabled" will always be "0"
We can just write:

	fprintf(stderr, "enabled: 0\n");

instead. Writing like that, we have one less thing to worry about
(whether "enabled" is initialised in git_config_get_bool or not).


-- 
Danh
