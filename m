Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889A1C433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 17:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6552720734
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 17:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t3NjK8l0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgFRR6R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgFRR6R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 13:58:17 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15567C06174E
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 10:58:16 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f18so6464606qkh.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 10:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Udu+8hjym+ADwkC3pp95PnAfHDN+CWDGXGhlqk9Mvik=;
        b=t3NjK8l0JIQFe4cr8FmZwyavnSSGUmjdUEVOcBx2MPwFIwEsa2HCVDZwNRoumv0tbZ
         3YffV6iAgFOeGiX2MUfb9ALGrnpgEWK/OTXJe6tHB5Yjr7GTN0t83uNTl24g47vEZbfY
         aKoVAt3VBhXTZ08IFSySRwIoCkQ75F/DXP7WM9ciiN2MWW6XFgi7qyl0FrVZvNLkmMJz
         01BDIGzAus0eDW0Q/YSC4y/IxZwSeANQ0EjLJb6R5mi6KGVmTymmWIt9INctb2vYIgHn
         +ipXUmVvzoffnB8IrLbC5kCQ+fxfTZEn07RCa0pgQMbtEbfsB6/U3wPPCJHz+zy2bQFn
         1iCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Udu+8hjym+ADwkC3pp95PnAfHDN+CWDGXGhlqk9Mvik=;
        b=SAW3zP8JGRE4GYHfoyJnEtZGmJ7ixDcpe3j4ObfCDF6U0plGOVEcZzO0inQFsyjt3U
         i7Q0fRocDqj6DFQ/PU/MmTSuO32CgOrYIPgtaaoEKcHz/kIQ0590q2Dzjt4cfDmpqGZk
         Gurs3dYCjYOfKWgdA0vC2ejDCrLtCHDxTKL8vfVnt/CRYmLFUyGi7zvRjG2OF4Ig7AAK
         MYvcVwpzJA1GlVyxQ+dWr8tdhcFON0Z94SL9ePEgfUfeqSixGh4JNq6PL9SeNe760OWp
         9gzq/Aq+gvqFMDwWE/oVqenB3dIsCgVqgHAoWrGf999vMwJYx7aQ5TTVMJnY2JUZunGf
         JMmw==
X-Gm-Message-State: AOAM530WfQPxH46AKVHz4rfNouhU6LISk3EEZCG2pyBYaYFGhCRbcwM6
        IV7TCyWOSygf0V01qTV6BjpmngG2y5o=
X-Google-Smtp-Source: ABdhPJz1CVJfcxLO7EIfrYjxfwW42Clq2o0+vb2fO31p4ctJjy07E+sIGJ0KRe5c2X0+nPmm+3r+nA==
X-Received: by 2002:a05:620a:538:: with SMTP id h24mr19558qkh.13.1592503095214;
        Thu, 18 Jun 2020 10:58:15 -0700 (PDT)
Received: from mail.clickyotomy.dev ([49.206.10.129])
        by smtp.gmail.com with ESMTPSA id u205sm3601864qka.81.2020.06.18.10.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 10:58:14 -0700 (PDT)
Date:   Thu, 18 Jun 2020 23:28:08 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff-files: treat "i-t-a" files as "not-in-index"
Message-ID: <20200618175808.GA36733@mail.clickyotomy.dev>
References: <20200611161640.52156-1-shrinidhi.kaushik@gmail.com>
 <xmqq4krhjql1.fsf@gitster.c.googlers.com>
 <20200611232851.GA55419@death-star>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611232851.GA55419@death-star>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
Is there any update on this patch?
Please let me know if I missed anything.

Thanks!

On 06/12/2020 04:58, Srinidhi Kaushik wrote:
> Thanks for replying!
> 
> On Thu, Jun 11, 2020 at 01:27:22PM -0700, Junio C Hamano wrote:
> > Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:
> > 
> > > The `diff-files' command and related commands which call `cmd_diff_files()',
> > > consider the "intent-to-add" files as a part of the index when comparing the
> > > work-tree against it. This was previously addressed in [1] and [2] by turning
> > > the option `--ita-invisible-in-index' (introduced in [3]) on by default.
> > >
> > > For `diff-files' (and `add -p' as a consequence) to show the i-t-a files as
> > > as new, `ita_invisible_in_index' will be enabled by default here as well.
> > >
> > > [1] 0231ae71d3 (diff: turn --ita-invisible-in-index on by default, 2018-05-26)
> > > [2] 425a28e0a4 (diff-lib: allow ita entries treated as "not yet exist in
> > >                 index", 2016-10-24)
> > > [3] b42b451919 (diff: add --ita-[in]visible-in-index, 2016-10-24)
> > 
> > Is there any place where we still run the internal diff machinery to
> > compare the index and the working tree without setting the
> > ita_invisible_in_index bit on with this patch applied, and if so,
> > why?  Does the justification why that other place needs to leave
> > the bit off apply to this codepath as well?
> 
> Yes, I believe that there exist some use cases for `ita_invisible_in_index'
> to be unset. For instance, `index_differs_from' which is used in a quite a
> few places -- like "commit", "revert", and "rebase" -- which require a
> "no change" to be returned.
> 
> This commit: [1] addressed the issue where the cache-tree was producing
> the same tree as the current commit when it involved "intent-to-add"
> entries, instead of aborting.
> 
> [1] 018ec3c820 (commit: fix empty commit creation when there's no changes
>                 but ita entries, 2016-10-24) 
> 
> > What I am trying to get at is if this is helping only one usecase
> > for "diff-files" while breaking other usecases.
> 
> Currently, `run_add_p' (for "add"; which this patch addresses
> the fix), and `push_to_deploy' (in "receive-pack"; where this
> is the intended behavior), call "diff-files" as a subprocess,
> in which case the `ita_invisible_in_index' bit is explicitly
> set. For all other cases, calls are made directly
> to `run_diff_files' and will be unaffected by this change.
>  
> > On the other hand, if there is no longer anybody who wants
> > ita_invisible_in_index off, perhaps we can get rid of the bit and
> > lose many conditionals.
