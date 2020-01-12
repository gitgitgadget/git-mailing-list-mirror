Return-Path: <SRS0=w3fS=3B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7A0C33CA9
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 10:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A32222D9
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 10:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLXmx3bB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732573AbgALKRt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jan 2020 05:17:49 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40248 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732569AbgALKRt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jan 2020 05:17:49 -0500
Received: by mail-yw1-f67.google.com with SMTP id i126so3672652ywe.7
        for <git@vger.kernel.org>; Sun, 12 Jan 2020 02:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dlc2cxCP2i+fY3L7T09hNz/TK5xkRNg0HuDH+61Y+dI=;
        b=PLXmx3bBQUFmP102AfqZXNyPXE0/2pmoS+RlHEKTI+Vuv+hkcbcNi5TBlwl2oJvHPB
         cf8JwQ+EQEa4yUBBmdIGEtF0n93+arsGYjB9EKAAMQc0jQGRHqW9m5hR/h7XNyU7SQ6B
         ntm37K1C9NO9L3N2v6TA4Hvf4D19Gk9egygRaA6XJlXLT95vUhqRR5eM2EWUFNaWS0nV
         ok/m6nJLAu0F62DdfjEndPLIj5Ug2T5KnIrXVBBY3l+LgRhlSONmcjU3yB0n55sffgFC
         qGu7S/IoFZNTTVWUBu4Ycxq0PYE4QYgekBmyo0OnQbuwgHEZnGfiSCVQmeqoX3ZQXI0v
         Ofaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=dlc2cxCP2i+fY3L7T09hNz/TK5xkRNg0HuDH+61Y+dI=;
        b=U+EgaG3SC4yA9+OJwk/vCu2PWJTodo3VQ7JC4woWD1FuQPRLj2W1b0oHH7lIHlWYu4
         oKhBkQGIQnyZCySf9g2OzHHYKGXYa7ztSMfOC1oafa+06vCbZMcekCRcshrjp3gAwD0C
         ZqVwyj01awUwEwjrV60mecnraHCfUmLJvHRw5rGBdnf0JiTD83aIDH9z6bt8DTEvRWt+
         uaqDeWNb8zq9yj/BAiNjwaUdGVU8KfOdXzt8Mds/KWjk+pBQXGP8C3n1CsGd7iVYnnDL
         48rxfuhmQVtawyj9tF1ELifEAhsxVRxVmtW0pEIP5VpF2Ib7r5nQPbrXOIzOuDFgUDo5
         ewhA==
X-Gm-Message-State: APjAAAUsCcAlLz8VsOjo8IvOmhzTIMK+HiV05AVKb6IMRmPl4Bss2/3f
        VOZYS14bX2on3kHyWGHzsio=
X-Google-Smtp-Source: APXvYqw8elztjkV6oyVwRgSqH2hHWejU1jUqUcrEuN2WpqV5IQ+P5VVSSWa7NJJnBxNBcQ2xaB728g==
X-Received: by 2002:a25:e744:: with SMTP id e65mr8938577ybh.174.1578824267795;
        Sun, 12 Jan 2020 02:17:47 -0800 (PST)
Received: from flurp.local (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id c66sm3706367ywf.96.2020.01.12.02.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 02:17:46 -0800 (PST)
Date:   Sun, 12 Jan 2020 05:17:35 -0500
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     marcandre.lureau@redhat.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com
Subject: Re: [PATCH v4] branch: let '--edit-description' default to
 rebased/bisected branch
Message-ID: <20200112101735.GA19676@flurp.local>
References: <20200112064706.2030292-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200112064706.2030292-1-marcandre.lureau@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 12, 2020 at 10:47:06AM +0400, marcandre.lureau@redhat.com wrote:
> diff --git a/builtin/branch.c b/builtin/branch.c
> @@ -745,33 +745,52 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		string_list_clear(&output, 0);
>  		return 0;
>  	} else if (edit_description) {
> -		const char *branch_name;
> +		char *branch_name = NULL;

Do you need to assign NULL here? Doesn't 'branch_name' get assigned in
all cases in which the code doesn't otherwise die()?

>  		if (!argc) {
> -			if (filter.detached)
> -				die(_("Cannot give description to detached HEAD"));
> -			branch_name = head;
> +			if (!filter.detached)
> +				branch_name = xstrdup(head);
> +			else {
> +				struct wt_status_state state;
> +
> +				memset(&state, 0, sizeof(state));
> +				wt_status_get_state(the_repository, &state, 0);
> +				branch_name = state.branch;
> +				if (!branch_name)
> +					die(_("Cannot give description to detached HEAD"));
> +				free(state.onto);
> +				free(state.detached_from);

I was wondering if it would make sense to attempt this branch name
lookup much earlier in the function when it assigns 'head' (if 'head'
is detached), with the idea that perhaps other git-branch modes might
benefit from it rather than doing it only for this one special-case.
However, it looks like other code (such as branch copy and branch
rename) would actively be hurt by such a change.

At any rate, it might make the 'edit_description' case easier to read
if this special-case branch lookup code was factored out into its own
function. Not itself worth a re-roll, but something to consider if you
do re-roll.

> +			}
>  		} else if (argc == 1)
> -			branch_name = argv[0];
> +			branch_name = xstrdup(argv[0]);
>  		else
>  			die(_("cannot edit description of more than one branch"));
>  
>  		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
>  		if (!ref_exists(branch_ref.buf)) {
> -			strbuf_release(&branch_ref);
> +			int ret;
>  
>  			if (!argc)
> -				return error(_("No commit on branch '%s' yet."),
> -					     branch_name);
> +				ret = error(_("No commit on branch '%s' yet."),
> +					    branch_name);
>  			else
> -				return error(_("No branch named '%s'."),
> -					     branch_name);
> +				ret = error(_("No branch named '%s'."),
> +					    branch_name);
> +
> +			strbuf_release(&branch_ref);
> +			free(branch_name);
> +			return ret;
> +
>  		}

Unnecessary blank line after 'return'.

A couple observations...

The extra cleanup needed to handle 'branch_name' makes this code quite
a bit more verbose. I was wondering if it would be possible to
consolidate the cleanup in a "failure path" as the target of a 'goto'
(which is a common way to perform cleanup in the Git code-base).
However, doing it that way doesn't really make the code much nicer,
which leads to the next observation...

Those `return error(...)` invocations are anomalies in this function.
Every other case of error in cmd_branch() simply die()s -- without
bothering to clean up. There is no apparent reason why this code
instead uses error(). Changing these two cases to die() would simplify
cleanup since you wouldn't have to do any, which would make the code
clearer, shorter, and more consistent with the rest of cmd_branch().
(Such a change probably ought to be done first in a preparatory patch,
making this a two-patch series.)

>  		strbuf_release(&branch_ref);
>  
> -		if (edit_branch_description(branch_name))
> +		if (edit_branch_description(branch_name)) {
> +			free(branch_name);
>  			return 1;
> +		}
> +
> +		free(branch_name);

Taking the above comments and observations into account, perhaps
something like this would be cleaner:

--- >8 ---
diff --git a/builtin/branch.c b/builtin/branch.c
index d8297f80ff..0eb519561e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -601,6 +601,22 @@ static int edit_branch_description(const char *branch_name)
 	return 0;
 }
 
+/*
+ * Return branch name of current worktree -- even if HEAD is detached -- or
+ * NULL if no branch is associated with worktree. Caller is responsible for
+ * freeing result.
+ */
+static char *get_worktree_branch()
+{
+	struct wt_status_state state;
+
+	memset(&state, 0, sizeof(state));
+	wt_status_get_state(the_repository, &state, 0);
+	free(state.onto);
+	free(state.detached_from);
+	return state.branch;
+}
+
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, copy = 0, force = 0, list = 0;
@@ -745,13 +761,16 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		string_list_clear(&output, 0);
 		return 0;
 	} else if (edit_description) {
+		int ret;
 		const char *branch_name;
+		char *to_free = NULL;
 		struct strbuf branch_ref = STRBUF_INIT;
 
 		if (!argc) {
-			if (filter.detached)
+			if (!filter.detached)
+				branch_name = head;
+			else if (!(branch_name = to_free = get_worktree_branch()))
 				die(_("Cannot give description to detached HEAD"));
-			branch_name = head;
 		} else if (argc == 1)
 			branch_name = argv[0];
 		else
@@ -759,19 +778,16 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
 		if (!ref_exists(branch_ref.buf)) {
-			strbuf_release(&branch_ref);
-
 			if (!argc)
-				return error(_("No commit on branch '%s' yet."),
-					     branch_name);
+				die(_("No commit on branch '%s' yet."), branch_name);
 			else
-				return error(_("No branch named '%s'."),
-					     branch_name);
+				die(_("No branch named '%s'."), branch_name);
 		}
 		strbuf_release(&branch_ref);
 
-		if (edit_branch_description(branch_name))
-			return 1;
+		ret = edit_branch_description(branch_name);
+		free(to_free);
+		return ret;
 	} else if (copy) {
 		if (!argc)
 			die(_("branch name required"));
--- >8 ---
