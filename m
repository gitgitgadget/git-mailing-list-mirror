Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1019D168C4
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 22:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706999594; cv=none; b=TissK+vOdWTmSwI8bl3ChsLqbD518McwxMccfQOJJgk1otZTwhi+Hbx4CiHP1CnFJxUDz0xsxC0xfHkK8bMZT7+IprIYZVDcQ5DY6cXdcdUaI0SDliQzrOztnqLnrmaL797bmQ8ZxGCFv2VcGaZHwiklCBpHD7YAOL7QUst1iPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706999594; c=relaxed/simple;
	bh=zr9iuNJG6aWPeZ1yyXk+ZraWCpETbEwCLPxxgmuVEQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mDR5q4xdKbHXdwDsHjZJZ511oqjqls4si0zRHa1LG6pmFneYpRlA5ij2mw+6h6rKJCHTbLZ5ycm+nXMokwIwp9xC5uD5gkBOo4myRWrnVWM8/Bc6rFOWRPPnL0esb64f+1FGj2JhpHa+qw/xwOoBLE9eZvPmEiG6KlJFpv4YouI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q2j9F7ob; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q2j9F7ob"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 303ED2703A;
	Sat,  3 Feb 2024 17:33:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zr9iuNJG6aWPeZ1yyXk+ZraWCpETbEwCLPxxgm
	uVEQA=; b=Q2j9F7obKaa9WzcBbgUPm9v7CK13WEbgLa6alLojijoTJ5lnVPD/Kf
	mbHxiYyJjX52+VPn/kXImP18aEhUr8oY5AdDtUd6XBqhiu0TXZTT28EHIk8BezF0
	xvoo0IekKwYMOc5bBae4RW+/n8+uSltlal9e1oUYVDJ9a2K5jujbk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2925B27039;
	Sat,  3 Feb 2024 17:33:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8065B27038;
	Sat,  3 Feb 2024 17:33:08 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v3 2/2] add-patch: classify '@' as a synonym for 'HEAD'
In-Reply-To: <20240203112619.979239-6-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Sat, 3 Feb 2024 16:55:50 +0530")
References: <20240202150434.11256-1-shyamthakkar001@gmail.com>
	<20240203112619.979239-6-shyamthakkar001@gmail.com>
Date: Sat, 03 Feb 2024 14:33:06 -0800
Message-ID: <xmqq34u9qiu5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3492930E-C2E4-11EE-BB21-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> Therefore, make a new function user_meant_head() which takes the
> revision string and compares it to 'HEAD' as well as '@'. However, in
> builtin/checkout.c, there is a logic to convert all command line input
> rev to the raw object name for underlying machinery (e.g., diff-index)
> that does not recognize the <a>...<b> notation, but we'd need to leave
> 'HEAD' intact.  Now we need to teach that '@' is a synonym to 'HEAD'
>  to that code and leave '@' intact, too.

I am not sure what that "However" wants to say.

 - Now we have a helper function to see what the end-user said, and
   tell if the end-user meant the state that is currently checked
   out (aka "HEAD" but some folks like a synonym "@"[*]), or if the
   end-user meant some other "concrete" branch.

 - In builtin/checkout.c, there is a logic to convert unless what
   the end-user meant is the state that is currently checked out.

Isn't the natural conclusion that follows these two stentences
"therefore, the latter is a very good place to use that helper
function, too"?

	Side note: the "@" is already problematic not just because
	"git branch @" would not refuse to create "refs/heads/@",
	but there is no ref "@" (like $GIT_DIR/refs/@ or $GIT_DIR/@)
	when it is used as a synonym for "HEAD".  There is a check
	in builtin/checkout.c:update_refs_for_switch() that runs
	strcmp() on a token given by the end-user from the command
	line with "HEAD" to notice the no-op case "git checkout
	HEAD" but the code does not trigger when "@" is given, and
	it happens to work by accident.  I really wish we didn't add
	that oddball synonym, but that is water under the bridge by
	now.

In any case, I think we'd find more places that currently treats the
token "HEAD" given directly by the end-user specially and may want
to teach at least some of them to also accept "@" the same way, and
the helper function you are introducing may become useful in the
future, at which time we may move it to a more public header.  If it
needs to be shared already between add-patch.c and builtin/checkout.c
(I am guessing what you meant with "However" as an excuse for open
coding it instead of sharing the code), perhaps we should do so without
waiting for that future, though.  I dunno.

If we choose to do so, for now, a squashable patch may look like the
attached, but we'd need to update the log message while squashing it
in.

 add-interactive.h  | 14 ++++++++++++++
 add-patch.c        | 11 +++--------
 builtin/checkout.c |  3 +--
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git c/add-interactive.h w/add-interactive.h
index 693f125e8e..ca7326336d 100644
--- c/add-interactive.h
+++ w/add-interactive.h
@@ -38,4 +38,18 @@ enum add_p_mode {
 int run_add_p(struct repository *r, enum add_p_mode mode,
 	      const char *revision, const struct pathspec *ps);
 
+/*
+ * When the user gives these tokens from the command line, they mean
+ * the state that the currently checked out state came from.  This
+ * single bit of information affects the direction in which the patch
+ * is presented to the end-user: are we showing a patch to go back to
+ * the currently committed state, or are we showing a patch to move
+ * forward to the given commit that may be different from the
+ * committed state we started with?
+ */
+static inline int the_user_meant_head(const char *rev)
+{
+	return !strcmp(rev, "HEAD") || !strcmp(rev, "@");
+}
+
 #endif
diff --git c/add-patch.c w/add-patch.c
index 7d565dcb33..5502acebb8 100644
--- c/add-patch.c
+++ w/add-patch.c
@@ -378,11 +378,6 @@ static int parse_hunk_header(struct add_p_state *s, struct hunk *hunk)
 	return 0;
 }
 
-static inline int user_meant_head(const char *rev)
-{
-	return !strcmp(rev, "HEAD") || !strcmp(rev, "@");
-}
-
 static int is_octal(const char *p, size_t len)
 {
 	if (!len)
@@ -1734,21 +1729,21 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	if (mode == ADD_P_STASH)
 		s.mode = &patch_mode_stash;
 	else if (mode == ADD_P_RESET) {
-		if (!revision || user_meant_head(revision))
+		if (!revision || the_user_meant_head(revision))
 			s.mode = &patch_mode_reset_head;
 		else
 			s.mode = &patch_mode_reset_nothead;
 	} else if (mode == ADD_P_CHECKOUT) {
 		if (!revision)
 			s.mode = &patch_mode_checkout_index;
-		else if (user_meant_head(revision))
+		else if (the_user_meant_head(revision))
 			s.mode = &patch_mode_checkout_head;
 		else
 			s.mode = &patch_mode_checkout_nothead;
 	} else if (mode == ADD_P_WORKTREE) {
 		if (!revision)
 			s.mode = &patch_mode_checkout_index;
-		else if (user_meant_head(revision))
+		else if (the_user_meant_head(revision))
 			s.mode = &patch_mode_worktree_head;
 		else
 			s.mode = &patch_mode_worktree_nothead;
diff --git c/builtin/checkout.c w/builtin/checkout.c
index 79e208ee6d..63c669b157 100644
--- c/builtin/checkout.c
+++ w/builtin/checkout.c
@@ -544,8 +544,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 		 * given a tree-object, new_branch_info->commit would be NULL,
 		 * but we do not have to do any replacement, either.
 		 */
-		if (rev && new_branch_info->commit && strcmp(rev, "HEAD") &&
-		    strcmp(rev, "@"))
+		if (rev && new_branch_info->commit && !the_user_meant_head(rev))
 			rev = oid_to_hex_r(rev_oid, &new_branch_info->commit->object.oid);
 
 		if (opts->checkout_index && opts->checkout_worktree)
