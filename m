From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2011, #02; Sun, 20)
Date: Sun, 20 Mar 2011 14:22:27 -0700
Message-ID: <7vpqplv65o.fsf@alter.siamese.dyndns.org>
References: <7vy649vah1.fsf@alter.siamese.dyndns.org>
 <7vtyexv6wl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 22:22:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1Q5C-0006aJ-Jb
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 22:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135Ab1CTVWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 17:22:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39199 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab1CTVWg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 17:22:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AB1F74B02;
	Sun, 20 Mar 2011 17:24:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PZ7QuvPcdlpM7dE3kZ7qh2sN28s=; b=DrwES4
	G3Lkjg2zZL7EFjXVTE7m4g8fNX9VyUisZwindRylxSMu146PbZEocolc3O5QAt+A
	WsGbF1tEemXbmmy6mygtWr2gWa7Am/mMj+bgG095uJhSTRXdc7ZkaYMn7GkuIKjO
	/5iSJgscMSjIAeG6MVzkWYFZnmBOUSq05fjTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wmtUkvKk1ZltCdjbmXWBT612+rMZYTUF
	BsoAUauj0H947wHhUni5jZ8ngKdsnBTfMY0yXeNxAJT9w/0CAzr0T9gzg4WAFTxc
	aGeNl+zKXOMezDkUlAKbaWq9YQddMt4P26ITN99WoGIwM/RTsnWUDB6t5qTDz5s4
	G0zyDaay5Dc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 88A034B01;
	Sun, 20 Mar 2011 17:24:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 546664B00; Sun, 20 Mar 2011
 17:24:06 -0400 (EDT)
In-Reply-To: <7vtyexv6wl.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 20 Mar 2011 14:06:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 64BF2062-5338-11E0-B8C5-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169528>

Junio C Hamano <gitster@pobox.com> writes:

>> * nd/rfc-add-u-full-tree (2011-02-07) 1 commit
>>  - add: make "add -u" update full tree without pathspec
>>
>> A three-phase migration that:
>>
>>  (1) first only warns when we would deviate from traditional behaviour and
>>      suggest adding "." if the user wants to limit it to cwd, but doesn't
>>      actually add full-tree, in the next release;
>>
>>  (2) warn that we have changed the behaviour and suggest adding "." if the
>>      user wants to limit it to cwd, and actually do full-tree, in 1.8.0;
>>
>>  (3) remove the warning, in 1.8.X (for X at least 2 or more).
>>
>> would be a good way forward.
>
> ... and here is how the first step would look like.

... and here is the second step meant for 1.8.0 release.

The third step for 1.8.2 or later should be trivially obvious, so I
wouldn't bother sending it out.

-- >8 --
Subject: [PATCH] add -u: tree-wide without pathspec

The warning still remains in this version, but has to stay here
to help people who skipped late 1.7.X releases.  Unfortunately
we do not have a good way to let people who have already heard
about the transition to squelch it yet. That has to wait until
we have a magic ":/" pathspec that would mean to match from the
top of the working tree no matter where $cwd is.  At that point,
people can say "git add -u :/" to squelch the warning.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/add.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 443d3bb..0ece4b1 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -360,11 +360,11 @@ static int add_files(struct dir_struct *dir, int flags)
 }
 
 static const char *warn_add_u_without_pathspec_msg[] = {
-	"In release 1.8.0, running 'git add -u' from a subdirectory",
-	"without giving any pathspec WILL take effect on the whole",
-	"working tree, not just the part under the current directory.",
-	"Please make it a habit to say 'git add -u .' when you mean",
-	"to only add paths under the current directory."
+	"Since release 1.8.0, running 'git add -u' from a subdirectory",
+	"without giving any pathspec takes effect on the whole working",
+	"tree, not just the part under the current directory.",
+	"Please say 'git add -u .' if you want to only add paths under",
+	"the current directory."
 };
 
 static void warn_add_u_without_pathspec(void)
@@ -403,11 +403,13 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		die("-A and -u are mutually incompatible");
 	if (!show_only && ignore_missing)
 		die("Option --ignore-missing can only be used together with --dry-run");
-	if ((addremove || take_worktree_changes) && !argc) {
+
+	if (take_worktree_changes && !argc && prefix)
+		warn_add_u_without_pathspec();
+
+	if (addremove && !argc) {
 		static const char *here[2] = { ".", NULL };
 
-		if (take_worktree_changes && prefix)
-			warn_add_u_without_pathspec();
 		argc = 1;
 		argv = here;
 	}
-- 
1.7.4.1.514.ga171c
