Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093B0CD6E77
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 14:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbjJKOpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 10:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbjJKOpr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 10:45:47 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2849694
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 07:45:46 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7740729ae12so454683485a.1
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 07:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697035545; x=1697640345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wO3dk2Gp3UTGjtHM7Fz6g3+PljkZDM+VuUNRy5WQPUk=;
        b=lLp9bqDsZ+mHZRCpRPFH85GT9lTYVxhz+YPbFZF1G1AOkKtSkRHkZLWJog98lD63+0
         pty+17d6ZR2DiORtFw/lYRwDVWaN4Dba+22xHvyS3YaaCdSC2FOmcxcVoYe8IgiJeYW7
         nR7xMvqpbOBDK8VHhY+Ll1lwNBENij04mpUCCN5ILu3aLScDxKRoH/vxuVUoEbl0qbha
         rAKqBgkjoRyjYuLAniTU+uuIiHkUTq2ZpQpWa6c404XIsaX4+ZoD4MUMmm+s5Y51tA9u
         LsKNsMDTgRKWR8p7HBicveFn/gpYk4zg2UnJHdq0vZusRcl7XwQeeLtzbM3ZemZiVx/0
         ql/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697035545; x=1697640345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wO3dk2Gp3UTGjtHM7Fz6g3+PljkZDM+VuUNRy5WQPUk=;
        b=W2ZMnadncLjhBxiMWdJSO7oXhdJ1covhUWjLXeO+jEafZLrWmJt5yQOmFqy+pGnrMy
         R2Jy3CujKhe0eS5rzh0wIu3M89emCahYczuT+Qx4xZPlEC3wqDVqss1xxgP2utooZkdT
         Y3FyLfYL0dY9ssJ6dljA7FGw3+rt3GjRP0rXzOxoDnwKZgG143QltysURthA6c4RrsiU
         fx52XpNGAiMMcwjLVLw1jYdDZp/X0x2Mm5tk+JOuIPRDiVchaIXeDL+VVN8sSmuPjWAb
         jR5eGjEApQKyjBV8JBOeBTGmbpEj/2DI6ev4r5NA+0+YWCPAWOGdF1Yo2zP91q6XmiCS
         P/lw==
X-Gm-Message-State: AOJu0YwTJ3HxtTttGftfWQxkt90pcbk9D/+kQgZg5Jw2tW5yXPV3JsGe
        r+0/GfTSlsXODH1q2UK0DRw+Xe51PxAxgJNGH/o70A==
X-Google-Smtp-Source: AGHT+IFgFT4KLx6fHW2tEqUmUikZEdx73/V0Qm/sW0cPv4rk+5UD7e5neJKqJbf3IY9Dw0qe1wngMA==
X-Received: by 2002:a05:620a:3887:b0:76c:8998:1866 with SMTP id qp7-20020a05620a388700b0076c89981866mr19847854qkn.40.1697035545114;
        Wed, 11 Oct 2023 07:45:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g21-20020a05620a109500b0076c701c3e71sm5259449qkk.121.2023.10.11.07.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 07:45:44 -0700 (PDT)
Date:   Wed, 11 Oct 2023 10:45:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 06/20] commit-graph: check consistency of fanout table
Message-ID: <ZSa1F//QwawkTxvm@nand.local>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009210458.GF3282181@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009210458.GF3282181@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 05:04:58PM -0400, Jeff King wrote:
> We use bsearch_hash() to look up items in the oid index of a
> commit-graph. It also has a fanout table to reduce the initial range in
> which we'll search. But since the fanout comes from the on-disk file, a
> corrupted or malicious file can cause us to look outside of the
> allocated index memory.

This is all very well written and explained. The patch LGTM.

> ---
> So I actually implemented the bsearch_hash() bounds checks and wrote
> tests for midx and idx files before realizing how they handle this. ;)
> Which makes sense, because the usual outcome for a corrupted idx file is
> for it to say "non-monotonic index", which I have seen lead to user
> confusion. Arguably we should have it say something about "hey, your idx
> file seems to be corrupted, because...". But that can be its own topic.

Yeah, I definitely agree that that is out of scope here, and can be left
as #leftoverbits.

Thanks,
Taylor
