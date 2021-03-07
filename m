Return-Path: <SRS0=HVLo=IF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEEFC433E0
	for <git@archiver.kernel.org>; Sun,  7 Mar 2021 16:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A48F365012
	for <git@archiver.kernel.org>; Sun,  7 Mar 2021 16:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhCGQrS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Mar 2021 11:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhCGQqw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Mar 2021 11:46:52 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FB4C06174A
        for <git@vger.kernel.org>; Sun,  7 Mar 2021 08:46:51 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id a188so5642266pfb.4
        for <git@vger.kernel.org>; Sun, 07 Mar 2021 08:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oQVYFikkSwzpsQ2m1/RChO/Zu1ajrtQr14ujvbF24e0=;
        b=SP2Isg7I1HdVzumgthadyTJUJjLx6+pUUu2fWyPM2x2YQWyIFYuhIr2Ls+HZDNLJmW
         owZOAvOIKMgR5zFuLzu+Y/jOswq34wAwgUyIKs6VsM21a0u5gz+9xPwbd3ADG+vHEnvE
         e3RmbTw08VthPOhRenyl6RzPDtGyq9mcGQDRePlf5xfx9JyjPFRTiq495WOoDPYt6Ir5
         d29xxtJcAelvmcZ/6RFui2FZfI9b8dRvTsPGOCzauwLDC+xA/f8+n9hecps3TgwyafFR
         inbCbSfabJzlzEtx+hEYdSsd3S0tzh72R3pSaQVrsoja9s66yGnGF0KH6mcur1VxogsZ
         POAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oQVYFikkSwzpsQ2m1/RChO/Zu1ajrtQr14ujvbF24e0=;
        b=V0erQPEXcDcjHgSPIFRSP7q21EZ1PAjG7VnSI4i7iYr5vDPACgPJ2e1eNIAwkMAtqG
         29eAKcgcm75DS7PYSvdJKLxtfoDuyCVivHP0H1LHNK/YtZOokMFEqxEb5bUshBuKEzX2
         Reup+NB17TyOm5V5yDpS2tiFuP7ETn1mfumxydBiw6JA3N00x4UmEZ4oYGQ8azjFDPI6
         3q08zuzLCHIsFITtNAIUKDxU4rPHq3lb2H2eVnAABHt7ZK7RD8cMMk0mjFamh/uoetwr
         ACagv52xYEsfHeIkYYN6OE5tz+8Domb+HfzgOdWIY1hKnMXLZwd52TVTIEuWH77PFWtH
         +gjA==
X-Gm-Message-State: AOAM530prkEc+YLp2XKWSgBof2+jJyFY+7QhNiHXpeRwn84n4li5FdTh
        prUM9dVgh+N7DNnUzojtmjI=
X-Google-Smtp-Source: ABdhPJxvcIUwf3NIPabxoCm52qlC37GcJyKeqCSAFkUnqmTMX+NIQvPhC/cUIFVHhhG+2YtA8jpuNQ==
X-Received: by 2002:a63:6642:: with SMTP id a63mr16936803pgc.333.1615135610696;
        Sun, 07 Mar 2021 08:46:50 -0800 (PST)
Received: from konoha ([14.139.233.131])
        by smtp.gmail.com with ESMTPSA id c21sm8043368pgh.0.2021.03.07.08.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 08:46:50 -0800 (PST)
Date:   Sun, 7 Mar 2021 22:16:44 +0530
From:   Shourya Shukla <periperidip@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        levraiphilippeblain@gmail.com
Subject: Re: [PATCH v2 1/1] rm: stage submodule removal from '.gitmodules'
 when using '--cached'
Message-ID: <20210307164644.GA8702@konoha>
References: <20210218184931.83613-1-periperidip@gmail.com>
 <20210222172623.69313-1-periperidip@gmail.com>
 <20210222172623.69313-2-periperidip@gmail.com>
 <xmqqo8gb7vf9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo8gb7vf9.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/02 11:29, Junio C Hamano wrote:
> Shourya Shukla <periperidip@gmail.com> writes:
> 
> > +	if (git_config_rename_section_in_file(index_only ? GITMODULES_INDEX :
> > +					      GITMODULES_FILE, sect.buf, NULL) < 0) {
> 
> Also, is it really sufficient to pass GITMODULES_INDEX as the first
> argument to this function to tweak what is in the index?
> 
> git_config_copy_or_rename_section_in_file() which is the
> implementation of that helper seems to always want to work with a
> file that is on disk, by making unconditional calls to
> hold_lock_file_for_update(), fopen(), fstat(), chmod(), etc.
> 
> So I suspect that there are much more work needed.  

I am not able to comprehend _why_ we need so much more work. To me it
seems to work fine.

The flow now is something like:

1. If !index_only i.e., '--cached' is not passed then remove the entry
of the SM from the working tree copy of '.gitmodules' i.e.,
GITMODULES_FILE. If there are any unstaged mods in '.gitmodules', we do
not proceed with 'git rm'.

2. Now, delete the entry of the above SM from the index copy of the
'.gitmodules' i.e., GITMODULES_INDEX (irrespective of the value of
'index_only'). If there are any unstaged mods in '.gitmodules', we do
not proceed with 'git rm'.

3. Finally, after the deletion of the SM entry, we stage the changes
using 'stage_updated_gitmodules()'.

Also, before any of the above thing happens, we check if it is OK to
write the '.gitmodules' using 'is_staging_gitmodules_ok()'. All the
above behaviour is in line with the current behaviour of 'git rm'.

What exactly do we need to change then?

> It seems to me that the config editing API is one of the older and
> hackier parts of the system and requires quite a lot of work to
> teach it to work with anything but a on-disk file.  In the longer
> term, it may be a good thing to clean it up, but I suspect that it
> is way too much work for too little benefit to do so as a part of
> this topic, so an easier way out for now would be to:
> 
>  - write out the .gitmodules in the index to a temporary file (learn
>    how to correctly call entry.c::checkout_entry() by studying how
>    builtin/checkout-index.c::checkout_file() calls it, especially to
>    a temporary file with the --temp option).
> 
>  - use git_config_rename_section_in_file() on that temporary file to
>    remove the section about the submodule.
> 
>  - read that temporary file back into memory and write it out as a
>    blob object by calling sha1-file.c::write_object_file().
> 
>  - add that back to the index as .gitmodules (studying how
>    builtin/update-index.c::add_cacheinfo() calls add_cache_entry()
>    would be a good way to learn how to do this).
> 
> The working tree side can stay as is, but as I said in the earlier
> message, I think you need to update the .gitmodules in the working
> tree and .gitmodules in the index separately (and without doing any
> equivalent of "git add .gitmodules").

But 'git rm' itself used to stage the changes i.e., 'git add'-ing them.

Regards,
Shourya Shukla

