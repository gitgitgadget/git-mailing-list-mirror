Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073A3C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 09:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbhLJJ2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 04:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239221AbhLJJ2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 04:28:25 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72343C061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 01:24:50 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z5so28417284edd.3
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 01:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=rDzz0BpDLVXiEWJdZc/ZnL9fubDVPfTgdzGhIjacxq0=;
        b=D80X/krSU8Vd04CzLWf5A0Kl79FQofsPMdWNIQJNyv+4iB+JnFnH2FPdNDf9Qy/tyE
         t6KflUQinavkx3ousBihW7IBKitY1x2FXMVKJRCA91yPn+C0wyR0u2f/M2buTTGhp25B
         WRmK7ruzFnQSw1O0t3cbqWf4M9jQjC0soWf8z8KsBA0su0B8BR0eJHuBjkjsi1Ow76LI
         ME7794i3LQJofF4hPrrPeYMe1euMLI4pAhhHpR07pHYitEyx/rC2+rORo+v/Ek/Q9jo7
         Z+pOybL5fMWLiqt3n74LM30qW1KnvQEBI2PnkT4iS/S2hT2NQ4CEoqJF8rIIELOeo6dD
         ifpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=rDzz0BpDLVXiEWJdZc/ZnL9fubDVPfTgdzGhIjacxq0=;
        b=2GWouA2voExwVi5ryyxPbzdo6LnAyK6DVdLd6wW2j90jJQy3XbilGrGdndGTh3cGs0
         qlqx0WMqSS2jtsJAkvhaTIdJIYDTYGLeB8gCQiMzCQDX8vq58v4TvDFktzVrTh4Gmj94
         Z9wh0qcFA01UTS7BueM1N8NY/oEiLS11XB0a+vHPXFC6QfcA5a5E8bF7tAitylzMQqjZ
         371HBqr5+E/A0CVATiyhxv1wGYd4/CbXFVXbLd76te7KylR5wZg+ZM+ITcRwcaF7XJhs
         yJt/fztUiSG6K7P2RYSNJ00UD/U7hNOmrar6pheATyrm6DZdTeDpI9gH2Z5/GppmklTd
         ynWQ==
X-Gm-Message-State: AOAM532pA6R4XgfpmyvMlzoIGAwqHTucEtq2nXOgR/sr8rJAs0vzvfIN
        fzjFrdGstVIEf077XtGj6U4OqeRJ2s9TtA==
X-Google-Smtp-Source: ABdhPJy//zkhIzUlsB2JGCU43vkH5ozL6RDpv9Yra8SkNPr1GXiSgs1hrBrYyt2MnjCMh/OoLj38lQ==
X-Received: by 2002:a17:907:3daa:: with SMTP id he42mr23007436ejc.160.1639128288726;
        Fri, 10 Dec 2021 01:24:48 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id yd13sm1140482ejb.39.2021.12.10.01.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 01:24:47 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mvc91-000Ev6-A3;
        Fri, 10 Dec 2021 10:24:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 2/2] checkout: introduce "--to-branch" option
Date:   Fri, 10 Dec 2021 09:59:43 +0100
References: <pull.1095.git.1639117329.gitgitgadget@gmail.com>
 <254b352e31029d8151eb6a974fdf8c127340cf79.1639117329.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <254b352e31029d8151eb6a974fdf8c127340cf79.1639117329.git.gitgitgadget@gmail.com>
Message-ID: <211210.86y24sdd7k.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 10 2021, ZheNing Hu via GitGitGadget wrote:

> From: ZheNing Hu <adlternative@gmail.com>
>
> When we want checkout to a branch (e.g. dev1) which reference
> to a commit, but sometimes we only remember the tag (e.g. v1.1)
> on it, we will use `git checkout v1.1` to find the commit first,
> git will be in the state of deatching HEAD, so we have to search the
> branches on the commit and checkout the branch we perfer. This will
> be a bit cumbersome.
>
> Introduce "--to-branch" option, `git checkout --to-branch <tag>`
> and `git checkout --to-branch <commit>` will search all branches
> and find a unique branch reference to the commit (or the commit which
> the tag reference to) and checkout to it. If the commit have more
> than one branches, it will report error "here are more than one
> branch on commit".
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  Documentation/git-checkout.txt |  8 +++-
>  builtin/checkout.c             | 33 +++++++++++++
>  t/t2018-checkout-branch.sh     | 85 ++++++++++++++++++++++++++++++++++
>  t/t9902-completion.sh          |  1 +
>  4 files changed, 126 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index d473c9bf387..2a240699fd9 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  [verse]
>  'git checkout' [-q] [-f] [-m] [<branch>]
>  'git checkout' [-q] [-f] [-m] --detach [<branch>]
> -'git checkout' [-q] [-f] [-m] [--detach] <commit>
> +'git checkout' [-q] [-f] [-m] [--detach] [-w|--to-branch] <commit>
>  'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
>  'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...
>  'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]
> @@ -210,6 +210,12 @@ variable.
>  	`<commit>` is not a branch name.  See the "DETACHED HEAD" section
>  	below for details.
>  
> +-w::
> +--to-branch::
> +	Rather than checking out a commit to work on it, checkout out
> +	to the unique branch on it. If there are multiple branches on
> +	the commit, the checkout will fail.
> +

So basically what this option implements is something that could be done
as a shellscript of:
	
	git_checkout_branch_from_oid () {
		rev=$1
		git for-each-ref --format='%(refname:strip=2)' --points-at $rev >/tmp/found
		if test $(wc -l </tmp/found) -ne 1
	        then
			echo "Goldilocks error in finding $rev: $(cat /tmp/found)"
	                return 1
		fi
	        git checkout $found
	}

Which is not to say that it isn't useful, but that I think adding this
to "git checkout" specifically is adding this to the wrong level. Isn't
this useful to most things that parse revisions? I.e. wouldn't a better
interface be via the peel syntax?

    oid=$(git rev-parse HEAD)
    git checkout $oid^{tobranch}

Doing it that way would allow any arbitrary command that takes revisions
now access to that, and we could have e.g. "^{tobranches}" too, so you
could do:

    git for-each-ref --format='%(refname:strip=2)' $oid^{tobranches}

Or:

    git log $oid^{tobranches}

I think implementing that is a bit harder. It's peel_onion() in
object-name.c. I think parse_branchname_arg() via get_oid_mb() is now
only capable of filling in an OID for a given name, and then checking
out that name comes as a separate step, and you can't just return
e.g. "master".

But I don't think anything stops us from adjusting those functions a bit
so that get_oid_with_context(() and friends could pass down say an
optional "struct string_list *", and the "peel" could then be expanded
to that.

Similar to how we have "git chekout -", and the "-" is understood by
some commands, but not all (via some opt-in whose location I forget...).
