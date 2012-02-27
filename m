From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] builtin/symbolic-ref.c: add option to output
 shortened ref
Date: Mon, 27 Feb 2012 15:54:49 -0800
Message-ID: <7vlinn4yt2.fsf@alter.siamese.dyndns.org>
References: <1330380638-9738-1-git-send-email-jk@jk.gs>
 <7vwr7752s8.fsf@alter.siamese.dyndns.org> <4F4C07AD.3050404@jk.gs>
 <7vpqcz514d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Tue Feb 28 00:55:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2APD-0000cy-Fl
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 00:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107Ab2B0Xyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 18:54:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36630 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932068Ab2B0Xyx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 18:54:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A85E73D0;
	Mon, 27 Feb 2012 18:54:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/gkZSQVFHcJPXNmI8poUCBD86PM=; b=ZZucDL
	/9L3hi7u8BSjiq7w237DKxRSlGTrl19q+dkq/YOlHF29LJgoQp2RQZrfQ53Zq9HM
	SPcMaET+mJxYd+K3FY9SmGZGvso5qcIsl9C2ZjMb57e9kWQqQ3sHwpkOx3Q3gQ0B
	HT0b0T8uRxXxQWv5GVo+6dbCUhB8kIpfVHJUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZlxLju7Yvi4ikZlup0OnjCSNjOd48HXE
	ccC3TLqErBir71xQyu7vFBSU0mb4XT8SXfwnXhu161OmRA8ZsnNfdC0hNH1KOixW
	iMgLGcI7YPECNd+q711HplcgIlJcQldPLYXmDJXjKFvyUcdrA6txKF5QzpM/j4au
	fs1msIBpo+o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0192E73CF;
	Mon, 27 Feb 2012 18:54:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BF6673CD; Mon, 27 Feb 2012
 18:54:51 -0500 (EST)
In-Reply-To: <7vpqcz514d.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 27 Feb 2012 15:04:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 702D55C0-619E-11E1-91B9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191691>

Junio C Hamano <gitster@pobox.com> writes:

> ... I do not think this change deserves to be taken hostage to it.

So here is a trivial rebase of the patch.

The --short option should apply only when querying (-q also shares this, I
think), so I split the synopsis into two.

I was the guity one who named the variable refs_heads_master, hoping that
it would be easier to name it after representative value it would contain
(so that it would be clear for other code that may want to strip the
leading component what to expect), but now it has happened with your
patch, the variable name looks silly.

OPT_BOOLEAN() is deprecated; OPT_BOOL() has a much saner semantics for
most callers' needs and we should consider using it when adding new
options.

Perhaps we would also want some tests?

 Documentation/git-symbolic-ref.txt |    7 ++++++-
 builtin/symbolic-ref.c             |   11 ++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.txt
index a45d4c4..89e7707 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -8,7 +8,8 @@ git-symbolic-ref - Read and modify symbolic refs
 SYNOPSIS
 --------
 [verse]
-'git symbolic-ref' [-q] [-m <reason>] <name> [<ref>]
+'git symbolic-ref' [-m <reason>] <name> <ref>
+'git symbolic-ref' [-q] [--short] <name>
 
 DESCRIPTION
 -----------
@@ -33,6 +34,10 @@ OPTIONS
 	symbolic ref but a detached HEAD; instead exit with
 	non-zero status silently.
 
+--short::
+	When showing the value of <name> as a symbolic ref, try to shorten the
+	value, e.g. from `refs/heads/master` to `master`.
+
 -m::
 	Update the reflog for <name> with <reason>.  This is valid only
 	when creating or updating a symbolic ref.
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 2ef5962..801d62e 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -8,13 +8,15 @@ static const char * const git_symbolic_ref_usage[] = {
 	NULL
 };
 
+static int shorten;
+
 static void check_symref(const char *HEAD, int quiet)
 {
 	unsigned char sha1[20];
 	int flag;
-	const char *refs_heads_master = resolve_ref_unsafe(HEAD, sha1, 0, &flag);
+	const char *refname = resolve_ref_unsafe(HEAD, sha1, 0, &flag);
 
-	if (!refs_heads_master)
+	if (!refname)
 		die("No such ref: %s", HEAD);
 	else if (!(flag & REF_ISSYMREF)) {
 		if (!quiet)
@@ -22,7 +24,9 @@ static void check_symref(const char *HEAD, int quiet)
 		else
 			exit(1);
 	}
-	puts(refs_heads_master);
+	if (shorten)
+		refname = shorten_unambiguous_ref(refname, 0);
+	puts(refname);
 }
 
 int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
@@ -32,6 +36,7 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT__QUIET(&quiet,
 			"suppress error message for non-symbolic (detached) refs"),
+		OPT_BOOL(0, "short", &shorten, "shorten ref output"),
 		OPT_STRING('m', NULL, &msg, "reason", "reason of the update"),
 		OPT_END(),
 	};
