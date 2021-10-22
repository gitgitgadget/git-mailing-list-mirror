Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CCEC433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 04:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C1D610CF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 04:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhJVEaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 00:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhJVEaR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 00:30:17 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB54FC061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 21:28:00 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id l7so2928789iln.8
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 21:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y3RMp/+Eprf1PiMfeD7W3znDphjlyAQAfa3r+fj+W0g=;
        b=lb/UaXaq3LYy2o8V8/IoclmVPANrImIS8vCRist8/ZOKvOY3IKAaK9VXyZBcg71smY
         3TI3pWYWEaGanmkWN2+DItYqxGsw65nE0w2iS2wOforcp/xSdLtQOgycoLe7u+aeD1Hv
         Q4XaGcjLNmC+VAo6jA6yifE3xejtwkLYyx0IGwbAfGYScWZWVvDkKavrfOQPI877HV61
         bR1Ot5VMwqUoStMDAK0lfJMUvGCOXNIjhYuM3H9/oLEB+gBg1Wd3MN6jq7OcHBk0a7IS
         nAeBROs/jiyoa4Rb1t4E/A9y5B7n83SZ75Mw51aenaz/jIdzsIXwur4I4SSgiAlgPX6K
         bU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y3RMp/+Eprf1PiMfeD7W3znDphjlyAQAfa3r+fj+W0g=;
        b=qP/cI/2UMU7dOztkYH+BVv+Yfg8i4oCr4IcGmRQGTxDbqPbimFRieMoFsMJpazTTmo
         7ZpoQYAmEWqeJhjNzaN9N4aDhQC2pRW3jv92n65SUOgmVMkrgdPhALpHv5JetOBWWPRN
         1iTOxYfXQ3qJfe+S1uFcsjYAwX41q9VfM74GDSisb3ZrvsMYEv5VkwKO5C69454Zni9M
         Xx3Qq/Ae9JvPmO3IQEtJnzJZduGhJ8XuWElSfTVbfyna7yQeyoG61BRa+isgTjymgKy1
         wyDFJcl5QG4QnUSjF19d7vODkeWy12mk4RpOS09nwisH86EJ/wOQKK5MnBR4KbhUNMhp
         xpgg==
X-Gm-Message-State: AOAM532oHsFucQ8RU6q/tdt/fvent8r2ceR8hPO0EMhBLRbG+oxYSSBe
        Z3Lu/c0xW281NNyEKxCSwmSzMg==
X-Google-Smtp-Source: ABdhPJw8kYIU5tN/jEQCx+UlO+LpTYPKZSIWCfu8nv5ciQcHiBM6Q02Sx8wSYVcYNpXrmfhNuIS4rg==
X-Received: by 2002:a92:ca0c:: with SMTP id j12mr6915017ils.50.1634876880293;
        Thu, 21 Oct 2021 21:28:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l22sm3333843ion.53.2021.10.21.21.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 21:27:59 -0700 (PDT)
Date:   Fri, 22 Oct 2021 00:27:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        peff@peff.net
Subject: Re: [PATCH 07/11] pack-bitmap.c: avoid leaking via
 midx_bitmap_filename()
Message-ID: <YXI9zssVEupYAeWQ@nand.local>
References: <cover.1634787555.git.me@ttaylorr.com>
 <f3897c3afc0e47933289025c269a4d5f248241ef.1634787555.git.me@ttaylorr.com>
 <xmqqcznymi7k.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcznymi7k.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 21, 2021 at 09:54:39AM -0700, Junio C Hamano wrote:
> But after reading all the users of get_midx_filename(), especially
> given that it is mostly internal implementation detail inside
> midx.c, I think rewriting
>
> 	f() {
> 	char *midx = get_midx_filename(...);
>
> 	... use midx ...
>
> 	cleanup:
> 	free(midx);
> 	}
>
> into
>
> 	f() {
> 	struct strbuf midx;
>
> 	get_midx_filename(&midx, ...);
>
> 	... use midx.buf ...
>
> 	cleanup:
> 	strbuf_release(&midx);
> 	}
>
> is not too bad a fix for this.

I was initially worried that this was too heavy-handed an approach. But
I hadn't actually tried it, and updating the half-dozen callers of
get_midx_filename() took only a couple of minutes.

But just because something is easy doesn't necessarily mean that it is a
good idea to do ;). Luckily, this approach ended up being clean, and
allows us to implement midx_bitmap_filename() without copying,
open-coding, or leaking.

Thanks for the nice suggestion.

Taylor
