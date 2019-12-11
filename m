Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84347C2D0C5
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 11:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5A522B48
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 11:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwVVOMmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfLKL2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 06:28:12 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40778 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbfLKL2M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 06:28:12 -0500
Received: by mail-pj1-f66.google.com with SMTP id s35so8823679pjb.7
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 03:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xOH3PvU7/5XYjSTnsR4l4IgGZhp40v7pg2mgdtnCrSU=;
        b=NwVVOMmnDXFUphOo3VZQonfEHOWgJOYq1lbhM0iUMCuEMydfC009i4NUcqFkbE1TFr
         RlV0/SlfkcpA1DUBJGmhoJCSp+jRiLVdx/fD6VjE/xzgaGw2rlxxEoMB7hoFH6RKvafx
         ZF4G7x//qWNUk07QaRIadPmzPkfDlmrCqDVaRUHSglnXEwUMBchIESzjwEQpSDQPQsB9
         +fnDGUQ7BR6zmhSyzWFNHJaRaycM1EtkPRYJ5irSKJprgNqU9/49FWxOFHQWVqVNSPtl
         8WrYwqFUJ1sOgrItfzXi7ApaqnSx45tJbCAd2yOe2KCr0KocuMlAOwgkJOoXUFe4G/Vk
         JiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xOH3PvU7/5XYjSTnsR4l4IgGZhp40v7pg2mgdtnCrSU=;
        b=ObFdsqUV52xnDY4JJXJjuIZjRZIrIz4KNfcKoA2g93hmAxRUSe4lY9QR76h9YOseaN
         +xGJel/p0UDiXVzeujz4KJw3Ec88jYqviPeQIq3tFexiP5owfPvC/7228SWdydv4FN2G
         gQAa7EbYcrJY4abKQgIC/A4PJNAPBP8MgRmfs3agbhewPeHikADyygArL2/Cfdjor6+u
         XRDqtXBrRZi00Sh/0gjmfNHpAIfGlGtXL/eiE8OV482b2IzmYjyGgniuMFF0E3qtFVq8
         i1jsH5kw5kU3nXJW2HfjbKpsDiosUE/jM9PvLj1AyGJdm8xUSLD3WVLdlpEE+K+pfXNI
         20rw==
X-Gm-Message-State: APjAAAWeN6bE2mtTlJiJHOmc76aEj7DBoyWH10SyX3b5yJYSTzT2XNcy
        l4zeli3IDAT84l6nEOcC9tE=
X-Google-Smtp-Source: APXvYqxFh3IdfCJcLp5DSkjS1gJZozVqp4TGx5GzV9rJxjQvaoEx3dbYY5Rj4gWXVwBaPJztlzLOfw==
X-Received: by 2002:a17:902:9348:: with SMTP id g8mr2751048plp.323.1576063691433;
        Wed, 11 Dec 2019 03:28:11 -0800 (PST)
Received: from generichostname (c-73-15-240-142.hsd1.ca.comcast.net. [73.15.240.142])
        by smtp.gmail.com with ESMTPSA id p16sm2583129pgi.50.2019.12.11.03.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 03:28:10 -0800 (PST)
Date:   Wed, 11 Dec 2019 03:29:08 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] git-p4: failure because of RCS keywords should
 show help
Message-ID: <20191211112908.GA41678@generichostname>
References: <pull.675.git.git.1575901009.gitgitgadget@gmail.com>
 <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
 <50e9a175c3323074ceec848c0d4054edd240e862.1575991375.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50e9a175c3323074ceec848c0d4054edd240e862.1575991375.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 10, 2019 at 03:22:54PM +0000, Ben Keene via GitGitGadget wrote:
> From: Ben Keene <seraphire@gmail.com>
> 
> When applying a commit fails because of RCS keywords, Git
> will fail the P4 submit. It would help the user if Git suggested that
> the user set git-p4.attemptRCSCleanup to true.
> 
> Change the applyCommit() method that when applying a commit fails
> becasue of the P4 RCS Keywords, the user should consider setting
> git-p4.attemptRCSCleanup to true.
> 
> Signed-off-by: Ben Keene <seraphire@gmail.com>
> ---
>  git-p4.py | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/git-p4.py b/git-p4.py
> index 174200bb6c..cb594baeef 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1959,6 +1959,14 @@ def applyCommit(self, id):
>                          for f in editedFiles:
>                              p4_revert(f)
>                          raise
> +            else:
> +                # They do not have attemptRCSCleanup set, this might be the fail point
> +                # Check to see if the file has RCS keywords and suggest setting the property.
> +                for file in editedFiles | filesToDelete:
> +                    if p4_keywords_regexp_for_file(file) != None:

small nit: we should use `is not None` here.

> +                        print("At least one file in this commit has RCS Keywords that may be causing problems. ")
> +                        print("Consider:\ngit config git-p4.attemptRCSCleanup true")
> +                        break
>  
>              if fixed_rcs_keywords:
>                  print("Retrying the patch with RCS keywords cleaned up")
> -- 
> gitgitgadget
