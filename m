Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA95AC433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 04:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239515AbiBDEs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 23:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiBDEsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 23:48:25 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3A9C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 20:48:25 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id r59so4402196pjg.4
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 20:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=5emvHxVRKXZHLyFsjPoxykT9afBlD+uoau00pEAxjWg=;
        b=m4edI8F7cSGwEFBkd5FabJKGa6y/9uWvL3lzlOT193h0cS5FyUYiyU3TQ/xbJspDoh
         IH0hqlDcvkQU8VUVgN12Ew7IExDbEj/ZbOv89mBIuIYRmb3IuzJ+JgPvCuqaO+Mjyew0
         K9Rav+z/08I3wvNDhlfEeDnafCzDJdG2FnAz4Jix8oWk6XOPexrpzF62xyPIjDiC77Hc
         bkTNS4bT0zDPdoaa97Qgv+RJdY40FYMoOCud5M5kMHWKqIGZXIivtz1Zvcr+dC1Uf+/+
         SBe5ymIcWtxKt6WJmOfip5mQwntvA4/nOwC9+tHGg7c1SSh6uPqU7HLFPV3v3w0cUSuk
         8q7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=5emvHxVRKXZHLyFsjPoxykT9afBlD+uoau00pEAxjWg=;
        b=OSKs7RSb8ohPe/z0XTsKx2FiygIZN3DUt6+cUvLyGhEwRXh89qKwp6BGGR4+SF8svE
         VGWREQfU/VKh23TJXCzzuMXC0+25kGHX86BeKkIIkbJCyV879rQGGmtFHmOJmXwQEX16
         ko5hnqGD+v/DwzVMgzjECBa4Fk2eGdPz8Tk3GPRzhpammUB3Bg8dzf+7MjrfGfHpFflr
         4PkRoJlMQdYA7WH1RmDoFOjFlDUmHJtL/cz1Iwz9WfsvX84z0TADG89JKTzFeh0gNhkP
         RX8U6QCdbV9miAOLh7x5/an4/JUUG2X53fVSS7jwKX6cyG1WKJs0c+pVbfjWN1Frjkqq
         AugA==
X-Gm-Message-State: AOAM531GStZEL1YFMrqYEvgLGfMK29lv9MDEXPDZB3Kc1Zw3uQMGqol8
        T+FHEdDOKaX2/3je1AvfiL6sVg==
X-Google-Smtp-Source: ABdhPJxaxJNaJLOupnWFp8Exw4pJZeONjRpT0RtXZpaI4yR+qIxvo+JBslQYWMrICScYdMLq1oBE0Q==
X-Received: by 2002:a17:90b:1bc7:: with SMTP id oa7mr1167702pjb.149.1643950104721;
        Thu, 03 Feb 2022 20:48:24 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:4b3b:8fca:713d:76d4])
        by smtp.gmail.com with ESMTPSA id p4sm646639pfw.133.2022.02.03.20.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 20:48:23 -0800 (PST)
Date:   Thu, 3 Feb 2022 20:48:16 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 04/15] merge-tree: implement real merges
Message-ID: <YfywEBIIJWLPM2kr@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
 <02c29f920d0d5fde6d85f7b86a69be92e3f0f34d.1643787281.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02c29f920d0d5fde6d85f7b86a69be92e3f0f34d.1643787281.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.02.02 07:34, Elijah Newren via GitGitGadget wrote:
> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
> index 58731c19422..569485815a0 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -3,26 +3,73 @@ git-merge-tree(1)
>  
>  NAME
>  ----
> -git-merge-tree - Show three-way merge without touching index
> +git-merge-tree - Perform merge without touching index or working tree
>  
>  
>  SYNOPSIS
>  --------
>  [verse]
> -'git merge-tree' <base-tree> <branch1> <branch2>
> +'git merge-tree' [--write-tree] <branch1> <branch2>
> +'git merge-tree' [--trivial-merge] <base-tree> <branch1> <branch2> (deprecated)
>  
>  DESCRIPTION
>  -----------
> -Reads three tree-ish, and output trivial merge results and
> -conflicting stages to the standard output.  This is similar to
> -what three-way 'git read-tree -m' does, but instead of storing the
> -results in the index, the command outputs the entries to the
> -standard output.
> -
> -This is meant to be used by higher level scripts to compute
> -merge results outside of the index, and stuff the results back into the
> -index.  For this reason, the output from the command omits
> -entries that match the <branch1> tree.
> +
> +Performs a merge, but does not make any new commits and does not read
> +from or write to either the working tree or index.
> +
> +The second form is deprecated and supported only for backward
> +compatibility.  It will likely be removed in the future, and will not
> +be discussed further in this manual.
> +
> +The first form will merge the two branches, doing a real merge.  A real
> +merge is distinguished from a trivial merge in that it includes:
> +
> +  * three way content merges of individual files
> +  * rename detection
> +  * proper directory/file conflict handling
> +  * recursive ancestor consolidation (i.e. when there is more than one
> +    merge base, creating a virtual merge base by merging the merge bases)
> +  * etc.
> +
> +After the merge completes, it will create a new toplevel tree object.
> +See `OUTPUT` below for details.
> +
> +OUTPUT
> +------
> +
> +For either a successful or conflicted merge, the output from
> +git-merge-tree is simply one line:
> +
> +	<OID of toplevel tree>
> +
> +The printed tree object corresponds to what would be checked out in
> +the working tree at the end of `git merge`, and thus may have files
> +with conflict markers in them.
> +
> +EXIT STATUS
> +-----------
> +
> +For a successful, non-conflicted merge, the exit status is 0.  When the
> +merge has conflicts, the exit status is 1.  If the merge is not able to
> +complete (or start) due to some kind of error, the exit status is
> +something other than 0 or 1.
> +
> +USAGE NOTES
> +-----------
> +
> +git-merge-tree was written to be low-level plumbing, similar to
> +hash-object, mktree, commit-tree, update-ref, and mktag.  Thus, it could
> +be used as a part of a series of steps such as
> +
> +       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
> +       test $? -eq 0 || die "There were conflicts..."
> +       NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
> +       git update-ref $BRANCH1 $NEWCOMMIT
> +
> +However, it does not quite fit into the same category of low-level
> +plumbing commands since the possibility of merge conflicts give it a
> +much higher chance of the command not succeeding.

I found this final paragraph confusing. It seems to be hinting at some
conclusion it expects readers to make, but I haven't been able to figure
out what. Could this be made more explicit, or perhaps dropped
altogether?
