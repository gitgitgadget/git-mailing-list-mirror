Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93DEC4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 00:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiKHAbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 19:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbiKHAbL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 19:31:11 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB83F1DDE4
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 16:31:10 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id l6so6755913ilq.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 16:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JUsvIrmNlIgJg9WT3AFhpjLuEccsSRhD91Jg2/tBTIY=;
        b=pq9h9W/QcPSP8OoL3dm5CTcqHf0MyWpVbhNc2IT07CgK+PTsjngwkv5H5Ld9ot1XmB
         9qqdApC4ZGhbM8Z3Nda0WVWMHZsDNM9qk2aBAOi5Kx4xi0wS2yBNnogFUQNXnDzDrFr2
         cr0ttbQv9/0M0+1HGhBm6JJGUXse6d5GcshJCd4tkTjJrHoujNR+kY/wP/9I6dgU9lI7
         x6pFohf8nCJTDXGFZj0SFiwzTyWTGIZyMyH+OBRRWC8HQCsKQAJGQBVJ/34R/0UC+cyG
         l4pBXCUoqZbVxlHo1UaQKhp/w+0aJ/pibkLPsEtDUGYoRpEbCXX4ERW/3U++8jnNoXaj
         2Vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUsvIrmNlIgJg9WT3AFhpjLuEccsSRhD91Jg2/tBTIY=;
        b=rgMdmgQtp4EMk+ZidIDbCZDxpGknCnJH8MyY6uL/5/Abl9FPH6fNLXoo7ko37Cu+Ec
         UMo9dfzwvoYrrA/v+Z1QVcjoPAVrPabsvc41CmqLeFoFcpYntfDHcrGOf5a16veTrsNw
         OIntntLAjBF9MkY+/ADTutHlHDVTlyMXdedUCgU1WeOvSSlbdC9Jvo5ztGZQMcHsYq/x
         KOrKeXVKTMv/wxbHwyJzr5WWHWsibBSypmEat8KAA23ydxyL2lffLp3nhdq83GUBBh24
         X4f7iu+Y3fW8iMja5RLh5xZ6ZT9DvNlOuHlXOblRDvWuTGsz+kLH55rcQaT/93mkhR8C
         5e6g==
X-Gm-Message-State: ACrzQf0F2GxWGttJgj0RBRdHVlOxK7i273CsNPCjTC4s7O5WEnvIeSQC
        Vd8fCYGjzXCSOXl4nRTc7NLMObAYuua9Gk+s
X-Google-Smtp-Source: AMsMyM4gBk5Zqgc8jq3UBkDkWQhXIZnvo9kkbzbbpgE4vq7jyZfyHl1Ca0YBGH6tLM7XjlirMn8PLw==
X-Received: by 2002:a92:b704:0:b0:300:9ad3:a7b2 with SMTP id k4-20020a92b704000000b003009ad3a7b2mr28964310ili.65.1667867470042;
        Mon, 07 Nov 2022 16:31:10 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p10-20020a92d28a000000b00300f4e0d41bsm3286162ilp.57.2022.11.07.16.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 16:31:09 -0800 (PST)
Date:   Mon, 7 Nov 2022 19:31:08 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] submodule: explicitly specify on-demand upon push
Message-ID: <Y2mjTGvBUYpIicFl@nand.local>
References: <20221108002553.3836987-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221108002553.3836987-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 04:25:52PM -0800, Jonathan Tan wrote:
> This now means that any push.recurseSubmodules configuration in any
> submodule is no longer respected: only the configuration (or CLI
> argument to override it) of the superproject is used. Update the
> documentation accordingly.

Hmm. Is that a desired outcome or an unfortunate side-effect of the
implementation below?

Not having thought about this a lot, the behavior I might expect is
something along the lines of recursively pushing throughout the
submodule tree, stopping the recursion as soon as we get to a nested
submodule which says "don't push any of my children".

On the other hand, I could sympathize with a compelling argument that
the superproject alone should be in charge of determining what gets
pushed.

Though TBH, it seems like the former is more convincing. If I depend on
an external repository through a submodule, and that repository itself
has submodules, it would be nice to configure (once) that I don't want
to even try and push any of that repository's children.

Thanks,
Taylor
