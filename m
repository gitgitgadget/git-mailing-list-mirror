Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65B3C433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 12:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9CFE23B04
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 12:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbhAWMHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 07:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbhAWMHe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 07:07:34 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B5FC06174A
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 04:06:53 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id z21so5694403pgj.4
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 04:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=puztHNcb9FDqXEmg6pgmA3EYd1FDAR5vNDzPK4FzZ60=;
        b=AgW6wCp+yXikY69NeYuhi7O2Srpk7YWTSQA1y0cspzZwjEJ1rhTnPn7bhMbSjOOOJl
         H+F72/YgfAcgoRrKg/Qk30djO8oA7N8TORWSCVAhBRbaMxqIIfwn5Va0gql8Rnk4rcUT
         6PAqjNptVRSQsYRdkNO2Lvuqt8gtqASXVjmPKsLkRIW1s0dJxQAmc3dwIOPoCWyJmEOc
         gFONKekrNw7fQq1ABaS0yYq6iFsGKPy8IcC+lO5WXYgzcc/SnwF7qiiGnV7szc5bMZ1w
         husfkUdTraP2U+VnBWrXbKLtqQJYAdeQt+3HxKpWjGA9MY5USAg5jrDj2kq5D3jQik9b
         xRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=puztHNcb9FDqXEmg6pgmA3EYd1FDAR5vNDzPK4FzZ60=;
        b=k0PuuvO3ytsb/gCbQ0kPdmVLWytoC+81oytSwhj13etV8uNp+vV9jH5+RaAhWm+xAJ
         iU7QtEeZwF/9FhcTBWRJc+V4RkB3eyD9Yo4UwEqE5cRniFQdfh2QZIcVV8jMhWUVwLHp
         OpvKVGSKD0EskmAdqMLJYWPoblnUhE1sidCMyhh5xWi5jl8MTNed9RhJljgiCKPludfD
         KzyLjrl0KtRB8WR+oMFnYbDsD/mSUgM9uwTCaWJCtDHmmaPxIqQ74dB8L65ENDDZ8mM7
         bDXB7X2GzgPfxVa+A8WOMjY7zM+ATqHVnV5xvtpYm9ucYwF7h1EYwMoL65aTA4ABl7Cn
         t9rg==
X-Gm-Message-State: AOAM531rh0Pba9JAo+LH9S3//jqWXSLFMdCI4KKOTOP5l5kPkkwggBun
        lF0dCP35ejDWaZkxFOfNQ3s=
X-Google-Smtp-Source: ABdhPJzF1fRhWFymMTpflNoIGZyJnnjcKFsSd70IT/VX4rxp4Ffy/05KDBW5SDBPs4JuC0cK7pH0gA==
X-Received: by 2002:a65:628a:: with SMTP id f10mr1104044pgv.380.1611403613345;
        Sat, 23 Jan 2021 04:06:53 -0800 (PST)
Received: from Abhishek-Arch ([2409:4064:69a:b5d0:11ae:5c4d:1150:139d])
        by smtp.gmail.com with ESMTPSA id v15sm11492984pfn.217.2021.01.23.04.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 04:06:52 -0800 (PST)
Date:   Sat, 23 Jan 2021 17:37:10 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, jnareb@gmail.com, me@ttaylor.com
Subject: Re: [PATCH v6 00/11] [GSoC] Implement Corrected Commit Date
Message-ID: <YAwRbsfdErIlTP6v@Abhishek-Arch>
Reply-To: 2437ba7c-f9d9-34bd-5e08-eff96cadcf91@gmail.com
References: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
 <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
 <2437ba7c-f9d9-34bd-5e08-eff96cadcf91@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2437ba7c-f9d9-34bd-5e08-eff96cadcf91@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 18, 2021 at 04:04:14PM -0500, Derrick Stolee wrote:
> On 1/16/2021 1:11 PM, Abhishek Kumar via GitGitGadget wrote:
> > This patch series implements the corrected commit date offsets as generation
> > number v2, along with other pre-requisites.
> ...
> > Changes in version 6:
> > 
> >  * Fixed typos in commit message for "commit-graph: implement corrected
> >    commit date".
> >  * Removed an unnecessary else-block in "commit-graph: implement corrected
> >    commit date".
> >  * Validate mixed generation chain correctly while writing in "commit-graph:
> >    use generation v2 only if the entire chain does".
> >  * Die if the GDAT chunk indicates data has overflown but there are is no
> >    generation data overflow chunk.
> 
> I checked the range-diff and looked once more through the patch
> series. This version is good to go by my standards.
> 
> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
> 
> Thanks, Abhishek!
> 

Thanks a lot for the review and continued guidance through out the
patch series!

- Abhishek
