Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBB1C636CC
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 08:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjBHIZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 03:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjBHIZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 03:25:09 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F08822016
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 00:25:07 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id fi26so19339004edb.7
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 00:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nrz2UhNcg+cyavh0JTS6+k7A7iyjyPU2nzPwZtm2f2g=;
        b=moOFmNRUXLdJ6G+9kRbURa77cSQO0PkMx4EfQ7ayTT3EBmdOK4qjyL2W3zSASvYkyZ
         87kVUblHzqUXmyGD+5h2A5Bad34l9J2RP0rE+6Tp8zDRQTZb7VSyD7RjWGTpyUxNZ30Q
         Muc98D/xNNq3oDgN3xZGdGUNwVhm/ClKolbjROS+Tjdob8g+KG0XV4PdKpqE6fkV2WhG
         45HIlOA//loDG9ntx55iX93MeEU3jpHau3sQLen9U1Qq8NqkMX4UntEhEMbhvjC5zM/U
         +dioEgVAqm8cKow/hTEUtg2vWcYqKv6RA/lG+XE9u2AdzPPRBKW4vLGSEeWLxOuRngHW
         HdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nrz2UhNcg+cyavh0JTS6+k7A7iyjyPU2nzPwZtm2f2g=;
        b=GXu7sXxrI+rbokT6vx1CK4llmSLFAy4zBC3lCBSl2YaQ5ya4dnk+twXaOkhHBtkZvg
         ta/WV0x/xX1K7EB/r8758Ty1RPoDcLP1+s4Me1FjL9Fgvu74uCi5aJvUnljmJMQ793Yu
         YZuQOQeDIfWqGLmXpAYSUdJwZccKEpmFV5Fw34uB/M+uYzqNiTa5boeYfVLlsu5GPCRQ
         6iU3ZTQLzcleEWjxMtuKb/gpeikfCT7RZ5nT0ecl97K5BytPgU2bdy6HpD7yM2r5uuxt
         uoqLAWO0fXg/evNwki6fW/q2I1RcNima4yCAPjP5epy7m2AeE//Op0gZt4qNLdskUM42
         iV/w==
X-Gm-Message-State: AO0yUKV+I4mMpQTSZbB/i/VnAonL7wqC7OJbLEZWAfcBytdCg/oQP0oY
        hBgOi/DZ5Omt63PNZTkKtT+1n3R+n4vmaiJb
X-Google-Smtp-Source: AK7set9PXeX8akcxjg2V1dn7go2PAAGbIXkoIqfzqgEbDF6wSc7YcGZo6KBWOpl9r4kMEnYkQ1EFSQ==
X-Received: by 2002:a05:6402:3894:b0:4aa:b225:39a1 with SMTP id fd20-20020a056402389400b004aab22539a1mr2111432edb.20.1675844705549;
        Wed, 08 Feb 2023 00:25:05 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id r6-20020a056402018600b0049f29a7c0d6sm7532536edv.34.2023.02.08.00.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 00:25:04 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPflH-001BuR-1n;
        Wed, 08 Feb 2023 09:25:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, newren@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v7 6/7] diff-lib: refactor match_stat_with_submodule
Date:   Wed, 08 Feb 2023 09:18:54 +0100
References: <20230117193041.708692-1-calvinwan@google.com>
 <20230207181706.363453-7-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230207181706.363453-7-calvinwan@google.com>
Message-ID: <230208.861qn01s4g.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 07 2023, Calvin Wan wrote:

> diff --git a/diff-lib.c b/diff-lib.c
> index 7101cfda3f..e18c886a80 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -73,18 +73,24 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
>  				     unsigned *dirty_submodule)
>  {
>  	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
> -	if (S_ISGITLINK(ce->ce_mode)) {
> -		struct diff_flags orig_flags = diffopt->flags;
> -		if (!diffopt->flags.override_submodule_config)
> -			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
> -		if (diffopt->flags.ignore_submodules)
> -			changed = 0;
> -		else if (!diffopt->flags.ignore_dirty_submodules &&
> -			 (!changed || diffopt->flags.dirty_submodules))
> -			*dirty_submodule = is_submodule_modified(ce->name,
> -								 diffopt->flags.ignore_untracked_in_submodules);
> -		diffopt->flags = orig_flags;
> +	struct diff_flags orig_flags;
> +
> +	if (!S_ISGITLINK(ce->ce_mode))
> +		return changed;
> +
> +	orig_flags = diffopt->flags;
> +	if (!diffopt->flags.override_submodule_config)
> +		set_diffopt_flags_from_submodule_config(diffopt, ce->name);
> +	if (diffopt->flags.ignore_submodules) {
> +		changed = 0;
> +		goto cleanup;
>  	}
> +	if (!diffopt->flags.ignore_dirty_submodules &&
> +	    (!changed || diffopt->flags.dirty_submodules))
> +		*dirty_submodule = is_submodule_modified(ce->name,
> +					 diffopt->flags.ignore_untracked_in_submodules);
> +cleanup:
> +	diffopt->flags = orig_flags;
>  	return changed;
>  }

Parallel to reviewing your topic I started wondering if we couldn't get
rid of this "orig_flags" flip-flopping, i.e. can't we just set the
specific flags we want in output parameters.

Anyway, having looked at this closely I think this patch should be
dropped entirely. I don't understand how this refactoring is meant to
make the end result easier to read, reason about, or how it helps the
subsequent patch.

In addition to the above diff in 7/7 you do (and that's the change this
is meant to help):
	
	 static int match_stat_with_submodule(struct diff_options *diffopt,
	 				     const struct cache_entry *ce,
	 				     struct stat *st, unsigned ce_option,
	-				     unsigned *dirty_submodule)
	+				     unsigned *dirty_submodule, int *defer_submodule_status,
	+				     unsigned *ignore_untracked)
	 {
	 	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
	 	struct diff_flags orig_flags;
	+	int defer = 0;
	 
	 	if (!S_ISGITLINK(ce->ce_mode))
	-		return changed;
	+		goto ret;
	 
	 	orig_flags = diffopt->flags;
	 	if (!diffopt->flags.override_submodule_config)
	@@ -86,11 +92,20 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
	 		goto cleanup;
	 	}
	 	if (!diffopt->flags.ignore_dirty_submodules &&
	-	    (!changed || diffopt->flags.dirty_submodules))
	-		*dirty_submodule = is_submodule_modified(ce->name,
	+	    (!changed || diffopt->flags.dirty_submodules)) {
	+		if (defer_submodule_status && *defer_submodule_status) {
	+			defer = 1;
	+			*ignore_untracked = diffopt->flags.ignore_untracked_in_submodules;
	+		} else {
	+			*dirty_submodule = is_submodule_modified(ce->name,
	 					 diffopt->flags.ignore_untracked_in_submodules);
	+		}
	+	}
	 cleanup:
	 	diffopt->flags = orig_flags;
	+ret:
	+	if (defer_submodule_status)
	+		*defer_submodule_status = defer;
	 	return changed;
	 }

But if I rebase out this 6/7 patch and solve the conflict for 7/7 it
becomes:
	
	@@ -65,14 +66,20 @@ static int check_removed(const struct index_state *istate, const struct cache_en
	  * Return 1 when changes are detected, 0 otherwise. If the DIRTY_SUBMODULES
	  * option is set, the caller does not only want to know if a submodule is
	  * modified at all but wants to know all the conditions that are met (new
	- * commits, untracked content and/or modified content).
	+ * commits, untracked content and/or modified content). If
	+ * defer_submodule_status bit is set, dirty_submodule will be left to the
	+ * caller to set. defer_submodule_status can also be set to 0 in this
	+ * function if there is no need to check if the submodule is modified.
	  */
	 static int match_stat_with_submodule(struct diff_options *diffopt,
	 				     const struct cache_entry *ce,
	 				     struct stat *st, unsigned ce_option,
	-				     unsigned *dirty_submodule)
	+				     unsigned *dirty_submodule, int *defer_submodule_status,
	+				     unsigned *ignore_untracked)
	 {
	 	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
	+	int defer = 0;
	+
	 	if (S_ISGITLINK(ce->ce_mode)) {
	 		struct diff_flags orig_flags = diffopt->flags;
	 		if (!diffopt->flags.override_submodule_config)
	@@ -80,11 +87,20 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
	 		if (diffopt->flags.ignore_submodules)
	 			changed = 0;
	 		else if (!diffopt->flags.ignore_dirty_submodules &&
	-			 (!changed || diffopt->flags.dirty_submodules))
	-			*dirty_submodule = is_submodule_modified(ce->name,
	-								 diffopt->flags.ignore_untracked_in_submodules);
	+			 (!changed || diffopt->flags.dirty_submodules)) {
	+			if (defer_submodule_status && *defer_submodule_status) {
	+				defer = 1;
	+				*ignore_untracked = diffopt->flags.ignore_untracked_in_submodules;
	+			} else {
	+				*dirty_submodule = is_submodule_modified(ce->name,
	+									 diffopt->flags.ignore_untracked_in_submodules);
	+			}
	+		}
	 		diffopt->flags = orig_flags;
	 	}
	+
	+	if (defer_submodule_status)
	+		*defer_submodule_status = defer;
	 	return changed;
	 }
	 

I can see how there's some room for *a* refactoring to reduce the
subsequent diff, but not by mutch.

But this commit didn't help at all. This whole "goto ret", and "goto
cleanup" is just working around the fact that you pulled "orig_flags"
out of the "if" scope. Normally the de-indentation would be worth it,
but here it's not. The control flow becomes more complex to reason about
as a result.

