Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC79C433E0
	for <git@archiver.kernel.org>; Sun, 17 May 2020 09:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475AB2065F
	for <git@archiver.kernel.org>; Sun, 17 May 2020 09:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vf0xO/ss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgEQJqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 05:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgEQJqn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 05:46:43 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79534C061A0C
        for <git@vger.kernel.org>; Sun, 17 May 2020 02:46:42 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s69so3354525pjb.4
        for <git@vger.kernel.org>; Sun, 17 May 2020 02:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=PQKTFQ69erRB6+t3wCQSKnYE/bHK689Gd7spzgFye2I=;
        b=vf0xO/ssFq22mb/p2cjluCCK12ToJVC2tGaCI4UYd0wFujXai5vTv2kyNvyNGE0MRq
         Hrh9hu+InKQUb4eH+5SKVWub83+e5O8anIMcsFTjhYSLz6UmcaJAgJLN5BKyWo48lbE6
         /P7nKHD9e+B3mTh+e/vAlRg58MOW9vkMCrgD5EaqwawmHjHyfEawatR3uMEbcvwOaWoc
         ISR8LAKWLAB5phyTHp5cYvMTT27vV37izhSriPQdoXYsIDy14mhPVOmlsi4LT/M+cnIC
         g7T39hOwwS2LkFbIz7nv4g/tynLY5bCTOay+O1on1pOtoY/VqyS7+1MAlF35XU0Pbt0A
         i26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=PQKTFQ69erRB6+t3wCQSKnYE/bHK689Gd7spzgFye2I=;
        b=Q2OhzBEYQBBa5eEcqShvHFvzV+fZdm9bLSfJZyLsmhwVaPArhUpsHXmHTGxRwo26Vg
         SIqwMzWTO5sjUZin1BITw2CqupxJkmF5JsxhYb7tPaLNNVv6j1jSCl8fWkXK2NIlQqva
         QABEOflLGjMhYcIF42OqZMNxOsD7IQeTuAedG2LihZgn7zEHPZPeVfISn/+i72E8+vXK
         S4Dcbr9oi+2pX8dVBOCnGlC4tBz7UAuVvfDtLCJ2poly753OyG7dZ7koUSk9FPIsxiJm
         hPqiozGJv9kWqHRKehPxheN5V5qZ7sbQ/WNzGS6kf7d3GVSnA2658QRpGSTTgMPEl0ab
         e2jw==
X-Gm-Message-State: AOAM533Uj0bRs9yXt8GFPVKPnNWGMANIag+76lO8hpVkPDCyxUxzOqUW
        mPOA3nmdTp9/CP+Y9lf3HgKGzobaFJM=
X-Google-Smtp-Source: ABdhPJwQlN1X6k3cm2cMyuvzU/yCaoN2rtg/wc2Ss6y+dJmMAmXD1z3yEDwu4ygOg7otTJ4GLL2ZhQ==
X-Received: by 2002:a17:90a:26a7:: with SMTP id m36mr13046387pje.28.1589708801732;
        Sun, 17 May 2020 02:46:41 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:1c:9c42:c40:e2b6:f2aa:f55d])
        by smtp.gmail.com with ESMTPSA id x193sm6211160pfd.54.2020.05.17.02.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 02:46:41 -0700 (PDT)
Date:   Sun, 17 May 2020 15:15:13 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Kenneth Lorber <keni@hers.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] Add namespace collision avoidance guidelines file
Message-ID: <20200517094513.GA947@Abhishek-Arch>
Reply-To: 1589681624-36969-4-git-send-email-keni@hers.com
References: <1589681624-36969-1-git-send-email-keni@hers.com>
 <1589681624-36969-4-git-send-email-keni@hers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589681624-36969-4-git-send-email-keni@hers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Kenneth,

On Sat, May 16, 2020 at 10:13:41PM -0400, Kenneth Lorber wrote:
> From: Kenneth Lorber <keni@his.com>
> 
> Add a file of guidelines to prevent the namespace collisions
> mentioned in git help config without any guidance.
> 
> Signed-off-by: Kenneth Lorber <keni@his.com>
> ---

Since most users (including me) have never faced a namespace collision
with Git before, you might have to make a stronger case for why this
adding namespace collisions to documentation is important.

I honestly don't have enough knowledge of Git internals to talk about
any changes to the guidelines itself.

>  Documentation/gitrepository-layout.txt        |  1 +
>  .../technical/namespace-collisions.txt        | 86 +++++++++++++++++++
>  2 files changed, 87 insertions(+)
>  create mode 100644 Documentation/technical/namespace-collisions.txt
> 
> diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
> index 1a2ef4c150..a84a4df513 100644
> --- a/Documentation/gitrepository-layout.txt
> +++ b/Documentation/gitrepository-layout.txt
> @@ -290,6 +290,7 @@ worktrees/<id>/locked::
>  worktrees/<id>/config.worktree::
>  	Working directory specific configuration file.
>  
> +include::technical/namespace-collisions.txt[]
>  include::technical/repository-version.txt[]
>  
>  SEE ALSO
> diff --git a/Documentation/technical/namespace-collisions.txt b/Documentation/technical/namespace-collisions.txt
> new file mode 100644
> index 0000000000..fb79c82a73
> --- /dev/null
> +++ b/Documentation/technical/namespace-collisions.txt
> @@ -0,0 +1,86 @@
> +gitattributes
> +
> +
> +NAMESPACE COLLISIONS
> +--------------------

A convention I have noticed is that "========" is for the document
header and "--------" is for section headers.

> +Git uses identifiers in a number of different namespaces:
> +
> +* environment variables
> +* files in $GIT_DIR
> +* files in the working trees
> +* config sections
> +* hooks
> +* attributes
> +
> +In order to reduce the chance of collisions between names Git uses
> +and those used by other entities (users, groups, and extension authors),
> +the following are recommended best practices.
> +
> +Names reserved to Git:
> +
> +* file or directory names ending with `.lock`
> +* file or directory names starting with `.git`
> +* filenames in $GIT_DIR
> +* directory names in $GIT_DIR unless allowed by a rule below
> +* environment variables starting with `GIT_`
> +* configuration file sections unless allowed by a rule below
> +* file or directory names in `$GIT_DIR/hooks` unless allowed by a rule below
> +* attributes unless allowed by a rule below
> +
> +
> +Names reserved for individual users:
> +
> +* The directory `$GIT_DIR/my`
> +* Environment variables starting with `GIT_MY_`
> +* Configuration section `my`
> +* Files or directories in `$GIT_DIR/hooks` starting with `my_`
> +* Attributes starting with `my_`
> +
> +Names reserved for individual repos:
> +
> +* The directory `$GIT_DIR/this`
> +* Environment variables starting with `GIT_THIS_`
> +* Configuration section `this`
> +* Files or directories in `$GIT_DIR/hooks` starting with `this_`
> +* Attributes starting with `this_`
> +
> +Names reserved for the lowest level group of people:
> +
> +* The directory `$GIT_DIR/our`
> +* Environment variables starting with `GIT_OUR_`
> +* Configuration section `our`
> +* Files or directories in `$GIT_DIR/hooks` starting with `our_`
> +* Attributes starting with `our_`
> +
> +Names reserved for larger groups of people, for companies,
> +or for extensions that are distributed outside of the originating group:
> +
> +$ID is defined as a reverse DNS-style name, with dots replaced by
> +underscores (preferably) or by hyphens (if necessary).  The $ID
> +can have as many sections as possible, thus `com.example.sitename.projectid`
> +is perfectly reasonable.  Use of a name based on a domain you control is
> +highly recommended; if you do not control a domain, constructing the base of $ID
> +from your email address is a reasonable alternative, but use double delimiters
> +in place of the @ sign; for example: `com.example--root.project`
> +
> +* The directory $GIT_DIR/$ID
> +* Environment variables starting with `GIT__$ID_` (note two underscores)
> +* Configuration section `GIT--$ID`
> +* Files or directories in `$GIT_DIR/hooks` starting with $ID
> +* Attributes starting with `git__` (note two underscores)
> +
> +Aliases
> +~~~~~~~
> +Aliases are a special case.  Users need to type them so they should be
> +short, but there is no way to prevent such short names from colliding.
> +So the documentation or installer should construct something like:
> +
> +  [alias]
> +     test = !git my-test
> +     my-test = !echo made it
> +
> +while detecting collisions for the short name.  Then users or local
> +policy can deal with collisions on the short name.
> +
> +This is not meant to cover every possible use case - a policy that
> +detailed would be ignored and thus of no use.  Please play nicely.
> -- 
> 2.17.1
> 

Regards
Abhishek
