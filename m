Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05625C77B61
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 15:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjDGPz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 11:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDGPz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 11:55:57 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEFB659E
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 08:55:56 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n14so24446803plc.8
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 08:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680882956; x=1683474956;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NN19a4IbdDTEVg+CUuXTyU9pCh+hU9wrdC/7cRYiHeE=;
        b=USHC1v1Y2KNGE16Suj4VRjbfyGwaPwfzW12oZfJJIUSQBv6z8L6Saewhf5DPQ91Vu1
         XdLfNtxpv48Da6vHDN1phTkFrEuVBJGUBbaY8igycZiDE3K3iCP9SLC5VDf8CcAcTvhh
         me5XSEGoJqYjoGYqYBB3FFpIBmf69tvUCf/501jTus8LtJ/nQasWkbVBjyJ9HdzHE/jp
         dxgrOdPQsoAIf9YFQrMJ6j8ZLoXx1Hmzqa5chWTA9SrcWpRLqkySI5m5bnD0TiP7eQVA
         6GgkygG4LkvY9C9VOJ9iJeCDBUU/avtGMXmhcxgzYo4bGeo/iSx0C7aWRNwaX+rHnspx
         EGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680882956; x=1683474956;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NN19a4IbdDTEVg+CUuXTyU9pCh+hU9wrdC/7cRYiHeE=;
        b=yqezJPy0mtnzu56KVVz/hoQfc6H0F1fqdohO8ugcBKauOG/QH8nIWBkCLFlQsYxbBv
         uIEUZn+n00IAwvaDDW1e3+Q9Pz3/+skgy9sv6UnhemcBAIbJSK05axB3C0HNihyHZvRT
         O4xyvvjyNZURozxekvXJMx+2od4cHDtP1ZWhFkcQNvykida52qwC41ixzzt+epPLwvqb
         CY/hyj/EuggLcixvtuTGn/c8EA4Sb1ulhEeRmeqFX1DBgJ2bSgdhGU19aThcr0jFlXnF
         ojzoO33jvubmThKY6Vpag31hNjnu9u16LirBWJJhCR6mwwCCLGH2ebJ5N2OvXdtCyEaG
         Wyvg==
X-Gm-Message-State: AAQBX9dVSrFxeBawXCZHqYHLMYL5s8tIAI8TmuaKSf5J2PQbv07ZblWJ
        NIfLwdi/A9ZtuL0NybSf3c93vA8FUhc=
X-Google-Smtp-Source: AKy350YPLTgVPqZoNDZjgMbg7FJ1EL0MDWQ8NnmFTBEPWqhXRGoF43sVG3goFgxIQdZDzUeE65KPuA==
X-Received: by 2002:a05:6a20:791e:b0:d8:cb1a:f4e5 with SMTP id b30-20020a056a20791e00b000d8cb1af4e5mr2535490pzg.23.1680882955871;
        Fri, 07 Apr 2023 08:55:55 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id d16-20020aa78690000000b005a7c892b435sm3243784pfo.25.2023.04.07.08.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 08:55:54 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] coccinelle: add and apply branch_get() rules
References: <4cb4b69c-bd14-dfbd-6d06-59a7cd7e8c94@gmail.com>
Date:   Fri, 07 Apr 2023 08:55:53 -0700
In-Reply-To: <4cb4b69c-bd14-dfbd-6d06-59a7cd7e8c94@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Thu, 6 Apr 2023 22:34:56 +0200")
Message-ID: <xmqqjzynlm9i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> There are three supported ways to obtain a "struct branch *" for the
> currently checked out branch, in the current worktree, using the API
> branch_get(): branch_get(NULL), branch_get("") and branch_get("HEAD").
>
> The first one is the recommended [1][2] and optimal usage.  Let's add
> two coccinelle rules to convert the latter two into the first one.
>
>   1. f019d08ea6 (API documentation for remote.h, 2008-02-19)
>
>   2. d27eb356bf (remote: move doc to remote.h and refspec.h, 2019-11-17)

Citing commits in the past is not an optimal way to justify a
recommendation, though.  It does not show that these recommendations
made earlier are still current.  Phrasing it this way

    Among them, the comment in remote.h for "struct branch"
    recommends branch_get(NULL) for HEAD.

might be a way to say that it comes from the current source, and
when future readers of "git log" stumbles on this commit, they will
also understand why the change was made.

> diff --git a/contrib/coccinelle/branch_get.cocci b/contrib/coccinelle/branch_get.cocci
> new file mode 100644
> index 0000000000..3ec5b59723
> --- /dev/null
> +++ b/contrib/coccinelle/branch_get.cocci
> @@ -0,0 +1,10 @@
> +@@
> +@@
> +- branch_get("HEAD")
> ++ branch_get(NULL)
> +@@
> +@@
> +- branch_get("")
> ++ branch_get(NULL)
> +

I am not sure about these rules.  Noybody is passing "" to ask for
HEAD in the current code.  Neither

    $ git log -S'branch_get("")'

shows anything.  The first one does modify existing calls, but there
are many calls to branch_get() that pass a computed value in a
strbuf or a variable.  Do we know they are not passing "HEAD" or ""?

Stepping back a bit.  What is the ultimate goal for this change?

Are we going to insist that the currently checked out branch MUST be
asked for by passing NULL and not "" or "HEAD" to branch_get()?  If
that is the goal, then it almost makes me wonder if we should just
do the attached patch, plus your changes to the callers, without
adding any new Coccinelle rules, and finding and fixing the fallouts
by inspecting all the call graph that leads to branch_get().

If that is not the goal, and we will keep acepting NULL, "", and "HEAD"
as equivalents, the value of updating callers with literal "HEAD" to
pass NULL is rather dubious.

To be fair, I do not think we would not see if "branch_get(NULL)
must be the only way to ask for the current branch" is a good goal,
until we at least try a little.  Maybe during such a conversion that
starts by erroring when the function is called with "HEAD" or ""
(attached below), we might find that we need to change an existing
caller (or many of them) to do something silly like this:

 return_type a_caller(const char *branch_name, ...)
 {
-	struct branch *branch = branch_get(branch_name);
+	struct branch *branch;
+
+	if (branch_name &&
+	    (!strcmp(branch_name, "HEAD") || !*branch_name))
+		branch = branch_get(NULL);
+	else
+		branch = branch_get(branch_name);
	... use branch_name ...
	... use branch ...

in which case we may start doubtint the goal to always use NULL for
"HEAD".

So, I dunno.  The patch does not make anything worse (other than
adding two extra Coccinelle rules), but to me, the ultimate goal
("where does it want to take us") is unclear.

 remote.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git i/remote.c w/remote.c
index 3a831cb530..3788dd3fa0 100644
--- i/remote.c
+++ w/remote.c
@@ -1829,8 +1829,10 @@ struct branch *branch_get(const char *name)
 	struct branch *ret;
 
 	read_config(the_repository);
-	if (!name || !*name || !strcmp(name, "HEAD"))
+	if (!name)
 		ret = the_repository->remote_state->current_branch;
+	else if (!*name || !strcmp(name, "HEAD"))
+		BUG("use NULL for HEAD to call branch_get()");
 	else
 		ret = make_branch(the_repository->remote_state, name,
 				  strlen(name));
