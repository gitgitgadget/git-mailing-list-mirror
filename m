Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFB4C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 23:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiKVXND (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 18:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbiKVXMx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 18:12:53 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A5E4B9B7
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 15:12:51 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z20so21195613edc.13
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 15:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gd60W5rNyCxNO/7AIadeMnQ1QxsXnwGvrHsUFa47jaE=;
        b=UO+jVPUGVE3J9A3MCVx0apOjZAnyUjCKBGPjbPcOCBoQMv6sjJiIx5VWxyGBZSnUl1
         zkJm6KBnnTZNSJIW1XWHyLN4CedBVHswxIhoYcZV8qy7uB8M2Bhpdn+1633FDC9ZndvK
         ZskBB6UKHjHNatGHaJPEuwqOH+OpqQfp7M1iWqWg1K/jmoZIgnKQqyP/VBX25LwP+zhf
         JSSjer2nChG4DUQCyAmTcbhDJlpd+tkfvviPPn+qa+GNMT4tRtGQCsRexqhylujsQLAA
         OqRDqeoCv8BtAUPb7dLk4fVMqY6Wo+pBx5ny95pq5J43CH7VQlGLrbamx0cd85wt2X42
         TVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gd60W5rNyCxNO/7AIadeMnQ1QxsXnwGvrHsUFa47jaE=;
        b=EW7dh8WJObC62j4TRtUtE3aMqpPE7/26uAiF9WKX/din8nVwCwA0vmZushEWu1yszI
         69FooSLR6Tq908kAAYzLgxwFPJPbppQPRE+RwDR4WO85tOM47ey1Fau5CLi0DTBClZIw
         60JoNdZevzb/zjZVkIupL7kCs7wW3qdM86w6X22FAtEmoz4YUfiJ/0vGcTcPSdyxmMbI
         KJy94BXL7l5G56XdUReZe/z+nL2/FXSq8c+q2BqzLb/swB5tyFuBb17k1JbVDrBeVtdO
         /HWP187TCu6Bb7g53ZLCjJU16L3Xb67QqZwNqKPVIcKE25jeJp4wdGmfTGxtVAmCFBYM
         R8xw==
X-Gm-Message-State: ANoB5pkGm+9jQ7uZezHzI/U8RqdzmBs9zXJfTP7bxUe9tUckl4dP1xe8
        rWnvDM6Pp6SzFUVnJNHiDgI=
X-Google-Smtp-Source: AA0mqf44jQBlvy6dPv+MOfZ4hJJtyGrbEDZWQ8Kz2vA/C6GOKaQH/oUMcBu07TMG6ctY7zX/h5LbRQ==
X-Received: by 2002:aa7:c941:0:b0:469:172:4f46 with SMTP id h1-20020aa7c941000000b0046901724f46mr20468536edt.130.1669158770008;
        Tue, 22 Nov 2022 15:12:50 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id o7-20020aa7c7c7000000b00463c475684csm6850021eds.73.2022.11.22.15.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 15:12:49 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oxcRd-000pn9-0h;
        Wed, 23 Nov 2022 00:12:49 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: ab/remove--super-prefix & ab/submodule-no-abspath (was: What's
 cooking in git.git (Nov 2022, #05; Tue, 22))
Date:   Wed, 23 Nov 2022 00:06:09 +0100
References: <xmqqfseargo4.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqfseargo4.fsf@gitster.g>
Message-ID: <221123.86edtua8i6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 23 2022, Junio C Hamano wrote:

> * ab/remove--super-prefix (2022-11-21) 11 commits
>  - fetch: rename "--submodule-prefix" to "--super-prefix"
>  - read-tree: add "--super-prefix" option, eliminate global
>  - submodule--helper: convert "{update,clone}" to their own "--super-prefix"
>  - submodule--helper: convert "status" to its own "--super-prefix"
>  - submodule--helper: convert "sync" to its own "--super-prefix"
>  - submodule--helper: convert "foreach" to its own "--super-prefix"
>  - submodule--helper: don't use global --super-prefix in "absorbgitdirs"
>  - submodule.c & submodule--helper: pass along "super_prefix" param
>  - read-tree + fetch tests: test failing "--super-prefix" interaction
>  - Merge branch 'ab/submodule-no-abspath' into ab/remove--super-prefix
>  - Merge branch 'ab/submodule-helper-prep-only' into ab/remove--super-prefix
>  (this branch uses ab/submodule-helper-prep-only and ab/submodule-no-abspath.)
>
>  Remove the top-level `--super-prefix` option.
>  source: <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>
>
>
> * ab/submodule-no-abspath (2022-11-09) 1 commit
>   (merged to 'next' on 2022-11-18 at 34d0accc7b)
>  + submodule--helper absorbgitdirs: no abspaths in "Migrating git..."
>  (this branch is used by ab/remove--super-prefix.)
>
>  Remove an absolute path in the "Migrating git directory" message.
>
>  Will merge to 'master'.
>  source: <patch-1.1-34b54fdd9bb-20221109T020347Z-avarab@gmail.com>

Glen pointed out an issue in ab/submodule-no-abspath which I just
submitted a fix-on-top for in [1].

There will be a merge conflict with ab/remove--super-prefix, but one
which I tried to make easy to resolve when crafting [1]. The resolution
is:
	
	diff --git a/submodule.c b/submodule.c
	remerge CONFLICT (content): Merge conflict in submodule.c
	index ab2e61617d8..08366045ffe 100644
	--- a/submodule.c
	+++ b/submodule.c
	@@ -2267,7 +2267,6 @@ static void relocate_single_git_dir_into_superproject(const char *path,
	 	const char *rel_new_git_dir;
	 	struct strbuf new_gitdir = STRBUF_INIT;
	 	const struct submodule *sub;
	-	const char *super_prefix = get_super_prefix();
	 	const char *sp = super_prefix ? super_prefix : "";
	 
	 	if (submodule_uses_worktrees(path))
	@@ -2298,12 +2297,7 @@ static void relocate_single_git_dir_into_superproject(const char *path,
	 					&new_gitdir);
	 
	 	fprintf(stderr, _("Migrating git directory of '%s%s' from '%s' to '%s'\n"),
	-<<<<<<< 065be1da895 (submodule absorbgitdirs: use relative <from> and <to> paths)
	 		sp, path, rel_old_git_dir, rel_new_git_dir);
	-=======
	-		super_prefix ? super_prefix : "", path,
	-		real_old_git_dir + off, real_new_git_dir + off);
	->>>>>>> 1aa4019527a (fetch: rename "--submodule-prefix" to "--super-prefix")
	 
	 	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);

Now, I expect that neither topic will make this upcoming release, and
"ab/remove--super-prefix" will have at least one more re-roll per Glen's
outstanding feedback.

Would you like to have such a re-roll sooner than later, and to have
"ab/remove--super-prefix" built on "master" the existing
"ab/submodule-no-abspath", or rebased for this fix-on-top? Or I could
just wait until after the release when the dust settles and
"ab/submodule-no-abspath" + this fix on top in [1] graduate to submit a
v4.
	
1. https://lore.kernel.org/git/patch-1.1-065be1da895-20221122T224306Z-avarab@gmail.com/
