Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EDBC433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 18:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJKSPQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 14:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJKSPO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 14:15:14 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FE41ADB2
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 11:15:10 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id k2so33261296ejr.2
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 11:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ckqIr9sQnUgzz/v7DHFmRNxv4u+2BHbidKmehYitUAo=;
        b=Ay9tB3MNSJLB74E5WUQHlEf2XJSw8vDWe39cun3wOeU2TzJVYvwdx/VKWiWYvJ06gk
         e0RAk9QyUbSGNgBUyHV5NSCPZe4YVUPqeNuKYhfSh/h0ID0I9217k/fO5hZJ60Wbfoyr
         /d0X4P93I7DuY6UdfdyzUYa4DuARfNvjogpABGy/kwx8HrDz43+5yUT8zIJ1/ngrrAj/
         ehLEWcm+neUI6+5CpmytF4ENBXnnL16z3kgfDTye5F6XEgqLvV1mU75pZMonUMgHsWVE
         hm9nWctDMR40vh/b1x9fkJbjXyjwPYEw3H0lNXNlIei1CJFicxO4yx26y0tDpSfj1zyG
         ek9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckqIr9sQnUgzz/v7DHFmRNxv4u+2BHbidKmehYitUAo=;
        b=n1cqzcTFe72f0AsxuYyERUIMUWBoq1g4oEkjkDHCZ3eMxnTF8Lm/EX0yuJoR6LSMxJ
         5z1GDAVhUf8qBfp3HKQRu71n87Bi4ABdAW4bVxMa8H48PbGkQQtRA/v7Uqkl2yUovZ3E
         ugXOWO0Ph+RkMziFQKKc6qx7qSvBHpv656bAT/2hFyxOf9WXWxIGcmavfoolCulC3ISa
         MkdxgNAjkqqrgeJIXHybdYcVsRQoG0JzLRq+G19xx7y+DMqrsAiiTFYnuDdSu84i/7/0
         vkQfkYsfiLIdXM1tjiJIEcpxvucuOa82WA+nI57tQG5fBjWtSB/zl5y6yzLXVphzBHzs
         J1ug==
X-Gm-Message-State: ACrzQf0JtHTxNsCnxJJ5N5YF5dTMFC5TocpO6spHIRzzmW4Skle+Gl2J
        0b+FxiD0Z/8tNHkel08duUE=
X-Google-Smtp-Source: AMsMyM66jbGj9/KSXs0S6EvJqVKKkLYpajFJ3O5JFAHMpaL1QdL25PPOvwEwtu3Xkf5ZrHtWwxo+Cg==
X-Received: by 2002:a17:906:5dcc:b0:78d:e77d:e66f with SMTP id p12-20020a1709065dcc00b0078de77de66fmr2460144ejv.102.1665512109050;
        Tue, 11 Oct 2022 11:15:09 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id z22-20020a05640235d600b0045393e56488sm9813970edc.58.2022.10.11.11.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:15:07 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oiJmU-0044Z7-1B;
        Tue, 11 Oct 2022 20:15:06 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] bisect--helper: plug strvec leak
Date:   Tue, 11 Oct 2022 20:13:20 +0200
References: <5c6a4c30-d454-51b6-ec57-9af036b9c4e0@web.de>
 <221005.8635c2u3k5.gmgdl@evledraar.gmail.com> <xmqqy1tunjgp.fsf@gitster.g>
 <221006.86a668r5mf.gmgdl@evledraar.gmail.com> <xmqqk05cipq8.fsf@gitster.g>
 <1965b54b-122a-c965-f886-1a7dd6afbfb4@web.de>
 <Y0TXTl0gSBOFQa9B@coredump.intra.peff.net> <xmqq35buykz1.fsf@gitster.g>
 <Y0VtkmNwjKcXcemP@coredump.intra.peff.net> <xmqqpmeyuvxt.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqpmeyuvxt.fsf@gitster.g>
Message-ID: <221011.86czayns5x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 11 2022, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> The bug I'm worried about it is in a human writing the list of strings
>> and forgetting the NULL, so there we are losing the (admittedly minor)
>> protection.
>
> I expect that this story will repeat itself, especially given that
> we asserted that it is OK to initialize such an array with variable
> reference recently in this thread.
>
> Here are a couple that I found with a quick eyeballing of the output
> of "git grep -e 'run_command_v_opt([^,]*\.v,' \*.c" command.
>
>
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index ed8d44bb6a..c93345bc75 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -651,9 +651,8 @@ static void update_head(const struct ref *our, const struct ref *remote,
>  
>  static int git_sparse_checkout_init(const char *repo)
>  {
> -	struct strvec argv = STRVEC_INIT;
>  	int result = 0;
> -	strvec_pushl(&argv, "-C", repo, "sparse-checkout", "set", NULL);
> +	const char *argv[] = { "-C", repo, "sparse-checkout", "set", NULL };
>  
>  	/*
>  	 * We must apply the setting in the current process
> @@ -661,12 +660,11 @@ static int git_sparse_checkout_init(const char *repo)
>  	 */
>  	core_apply_sparse_checkout = 1;
>  
> -	if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
> +	if (run_command_v_opt(argv, RUN_GIT_CMD)) {
>  		error(_("failed to initialize sparse-checkout"));
>  		result = 1;
>  	}
>  
> -	strvec_clear(&argv);
>  	return result;
>  }
>  
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 0a0ca8b7c4..d261bc652f 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -384,24 +384,20 @@ static void reset_hard(const struct object_id *oid, int verbose)
>  static void restore_state(const struct object_id *head,
>  			  const struct object_id *stash)
>  {
> -	struct strvec args = STRVEC_INIT;
> -
>  	reset_hard(head, 1);
>  
> -	if (is_null_oid(stash))
> -		goto refresh_cache;
> -
> -	strvec_pushl(&args, "stash", "apply", "--index", "--quiet", NULL);
> -	strvec_push(&args, oid_to_hex(stash));
> +	if (!is_null_oid(stash)) {
> +		const char *argv[] = {
> +			"stash", "apply", "--index", "--quiet", oid_to_hex(stash), NULL
> +		};
>  
> -	/*
> -	 * It is OK to ignore error here, for example when there was
> -	 * nothing to restore.
> -	 */
> -	run_command_v_opt(args.v, RUN_GIT_CMD);
> -	strvec_clear(&args);
> +		/*
> +		 * It is OK to ignore error here, for example when there was
> +		 * nothing to restore.
> +		 */
> +		run_command_v_opt(argv, RUN_GIT_CMD);
> +	}
>  
> -refresh_cache:
>  	if (discard_cache() < 0 || read_cache() < 0)
>  		die(_("could not read index"));
>  }

I was experimenting with implementing a run_command_opt_l() earlier
which would give us the safety Jeff notes. The relevant end-state for
these two files is (there's more conversions, and I manually edited the
diff to remove an unrelated change):

diff --git a/builtin/clone.c b/builtin/clone.c
index ed8d44bb6ab..8dc986b5196 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -651,23 +651,18 @@ static void update_head(const struct ref *our, const struct ref *remote,
 
 static int git_sparse_checkout_init(const char *repo)
 {
-	struct strvec argv = STRVEC_INIT;
-	int result = 0;
-	strvec_pushl(&argv, "-C", repo, "sparse-checkout", "set", NULL);
-
 	/*
 	 * We must apply the setting in the current process
 	 * for the later checkout to use the sparse-checkout file.
 	 */
 	core_apply_sparse_checkout = 1;
 
-	if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
+	if (run_command_opt_l(RUN_GIT_CMD, "-C", repo, "sparse-checkout",
+			      "set", NULL)) {
 		error(_("failed to initialize sparse-checkout"));
-		result = 1;
+		return 1;
 	}
-
-	strvec_clear(&argv);
-	return result;
+	return 0;
 }
 
@@ -862,11 +856,11 @@ static void write_refspec_config(const char *src_ref_prefix,
 
 static void dissociate_from_references(void)
 {
-	static const char* argv[] = { "repack", "-a", "-d", NULL };
 	char *alternates = git_pathdup("objects/info/alternates");
 
 	if (!access(alternates, F_OK)) {
-		if (run_command_v_opt(argv, RUN_GIT_CMD|RUN_COMMAND_NO_STDIN))
+		if (run_command_opt_l(RUN_GIT_CMD|RUN_COMMAND_NO_STDIN,
+				      "repack",  "-a", "-d", NULL))
 			die(_("cannot repack to clean up"));
 		if (unlink(alternates) && errno != ENOENT)
 			die_errno(_("cannot unlink temporary alternates file"));
diff --git a/builtin/merge.c b/builtin/merge.c
index 5900b81729d..9c08de57113 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -345,60 +345,34 @@ static int save_state(struct object_id *stash)
 	return rc;
 }
 
-static void read_empty(const struct object_id *oid, int verbose)
+static void read_empty(const struct object_id *oid)
 {
-	int i = 0;
-	const char *args[7];
-
-	args[i++] = "read-tree";
-	if (verbose)
-		args[i++] = "-v";
-	args[i++] = "-m";
-	args[i++] = "-u";
-	args[i++] = empty_tree_oid_hex();
-	args[i++] = oid_to_hex(oid);
-	args[i] = NULL;
-
-	if (run_command_v_opt(args, RUN_GIT_CMD))
+	if (run_command_opt_l(RUN_GIT_CMD, "read-tree", "-m", "-u",
+			      empty_tree_oid_hex(), oid_to_hex(oid), NULL))
 		die(_("read-tree failed"));
 }
 
-static void reset_hard(const struct object_id *oid, int verbose)
+static void reset_hard(const struct object_id *oid)
 {
-	int i = 0;
-	const char *args[6];
-
-	args[i++] = "read-tree";
-	if (verbose)
-		args[i++] = "-v";
-	args[i++] = "--reset";
-	args[i++] = "-u";
-	args[i++] = oid_to_hex(oid);
-	args[i] = NULL;
-
-	if (run_command_v_opt(args, RUN_GIT_CMD))
+	if (run_command_opt_l(RUN_GIT_CMD, "read-tree", "-v", "--reset", "-u",
+			      oid_to_hex(oid), NULL))
 		die(_("read-tree failed"));
 }
 
 static void restore_state(const struct object_id *head,
 			  const struct object_id *stash)
 {
-	struct strvec args = STRVEC_INIT;
-
-	reset_hard(head, 1);
+	reset_hard(head);
 
 	if (is_null_oid(stash))
 		goto refresh_cache;
 
-	strvec_pushl(&args, "stash", "apply", "--index", "--quiet", NULL);
-	strvec_push(&args, oid_to_hex(stash));
-
 	/*
 	 * It is OK to ignore error here, for example when there was
 	 * nothing to restore.
 	 */
-	run_command_v_opt(args.v, RUN_GIT_CMD);
-	strvec_clear(&args);
+	run_command_opt_l(RUN_GIT_CMD, "stash", "apply", "--index", "--quiet",
+			  oid_to_hex(stash), NULL);
 
 refresh_cache:
 	if (discard_cache() < 0 || read_cache() < 0)
@@ -1470,7 +1444,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 					       check_trust_level);
 
 		remote_head_oid = &remoteheads->item->object.oid;
-		read_empty(remote_head_oid, 0);
+		read_empty(remote_head_oid);
 		update_ref("initial pull", "HEAD", remote_head_oid, NULL, 0,
 			   UPDATE_REFS_DIE_ON_ERR);
 		goto done;
