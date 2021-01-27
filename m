Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A44C433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 03:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA206206B5
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 03:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbhA0D7E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbhA0DCm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 22:02:42 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D5AC061A2D
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 18:50:01 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id d15so444012qtw.12
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 18:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L0hcjLLr4pYVXjKZ47Di1GmD7IuV0gvgjSFPO1WC7tU=;
        b=c6cVxlMyCK6WgO38eKxYV9YXApcKMmAXc657EFq9nJTFZ7NGkeSbeZvxG5sHfi9vSr
         /ULBIGISpsDaXvAPRAUmxvid+oQqBpi65g5xXN0viholMHYaLToX/Fzv8LHN/ZSkCtLP
         QL5WymqnlT4ohY8V1SytTtdrYBO/AhcG9MDOdWYJEKk0v7/nDw1RDv4jVjc54TCwd1oo
         DJTNSweY2/qoc6yBBck/wZilt8FjtYnOSc5VMop7QJj+jvsSOrKAE3+/TNp9Lkhi1Xpt
         cGJpqESFHVN4xfDAPlB7HZjXWX6lD7Txq+qBknPQLtgMnNsMZd0fK4KFAZwrl1zG9+wg
         CjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L0hcjLLr4pYVXjKZ47Di1GmD7IuV0gvgjSFPO1WC7tU=;
        b=hWin2H5z4yD51ufe+Uj5x0IPR9OTpM+qUElgYYGZeAVhPbeaFlDOhmG0Bn4tKfzIio
         xE8cm4G0owCWPdOUBjlZD4/5pnOzY+U72268hxIrtdTFucy4fDSWfd6f5ZK9U8tTlEjw
         7eMf3KTfzrwLyy7FRelCWjjzwhdLrnE0R72EyktK57IUfrakajs9/AcXBD/NkamQOz5a
         Y1LiZZyMEv4I4L/fAB6+37JnXs/cpI/wLn7plx4b3w/By+BSzQ3Q+6ffcK0YFpHkC4hp
         H/YA6vDoe40gfm8hu2jN/gotW6RdsmSKv4t27wycqH6387vH668/Yb1vlMkKkQC/j33X
         BBqA==
X-Gm-Message-State: AOAM532mUM8Lfo/ZD3HZE6wA9xpnaMq0CIwo0pHjZnZZehekS1HZsRG2
        gTSO2DuB7+bbnnHHEQZglpRyIA==
X-Google-Smtp-Source: ABdhPJxvXcTPLHdnwQ08cIsPHCdroE4GWjcAXSA68w2ebf2+DVWEVQ5XdbJTvcyXIdNvK/8MKFLswQ==
X-Received: by 2002:ac8:4e8b:: with SMTP id 11mr7949615qtp.292.1611715800941;
        Tue, 26 Jan 2021 18:50:00 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5cad:8534:72d4:8c70])
        by smtp.gmail.com with ESMTPSA id y68sm341706qkb.132.2021.01.26.18.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 18:50:00 -0800 (PST)
Date:   Tue, 26 Jan 2021 21:49:58 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        l.s.r@web.de, szeder.dev@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 04/17] midx: rename pack_info to write_midx_context
Message-ID: <YBDU1i6+wEyGL0TQ@nand.local>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
 <9fe5ee8611c3a18daaa9701bb5eefc8c408a7e76.1611676886.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9fe5ee8611c3a18daaa9701bb5eefc8c408a7e76.1611676886.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 26, 2021 at 04:01:13PM +0000, Derrick Stolee via GitGitGadget wrote:
> This change only renames "struct pack_info" to "struct
> write_midx_context" and the names of instances from "packs" to "ctx". In
> future changes, we will expand the data inside "struct
> write_midx_context" and align our chunk-writing method with the
> chunk-format API.

Thanks for saying that; that makes clear what is (and isn't) going on
here.

> @@ -463,37 +463,37 @@ struct pack_list {
>  static void add_pack_to_midx(const char *full_path, size_t full_path_len,
>  			     const char *file_name, void *data)
>  {
> -	struct pack_list *packs = (struct pack_list *)data;
> +	struct write_midx_context *ctx = (struct write_midx_context *)data;

Same comments as earlier about the unnecessary cast on the right-hand
side of this (and the below) assignment.

Otherwise this patch looks obviously fine to me.


Thanks,
Taylor
