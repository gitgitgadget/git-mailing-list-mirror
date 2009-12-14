From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help.autocorrect: do not run a command if the command
 given is junk
Date: Mon, 14 Dec 2009 12:08:09 -0800
Message-ID: <7v7hspjp3q.fsf@alter.siamese.dyndns.org>
References: <4B263797.5070808@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 14 21:08:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKHDx-0000eK-1G
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 21:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758007AbZLNUI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 15:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757949AbZLNUI2
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 15:08:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39614 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757915AbZLNUI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 15:08:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 32A0CA6925;
	Mon, 14 Dec 2009 15:08:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q7yN5WELYOSOtvWikVRXi0KxALE=; b=gzVoV/
	W/Gn8et0pUUb8a5GhXhX+EZNvfax62iaSL71QeSSAV4IJGy351fEWKSwN9v5kG0Y
	9CRCrMhPk8fUmzmkj7Q9CQQXy/h9BwfBCQJzr39sxcD9vfk9bzkcXTEA8yW+Mw76
	2dk65aNLrAnxVVCrUS53OIVD7vXEQ0otLyqSs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k18HYiYeGz7c2LqQMFyvHTKrpostVm2o
	du7byqm0QcYc9qXtXmqfnvswztB5XFsBcslpm5Ys5SPr5KVW1Au3PyodBlTHmnLk
	EGpWSo8Itm4YAj38POV0IGFt5gdV56xUC/5io6koCyBMCxmPRJ9FB/TkJPFAkqRk
	vGp0pEfLKjU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E9AA6A6924;
	Mon, 14 Dec 2009 15:08:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 41623A6923; Mon, 14 Dec 2009
 15:08:10 -0500 (EST)
In-Reply-To: <4B263797.5070808@viscovery.net> (Johannes Sixt's message of
 "Mon\, 14 Dec 2009 14\:03\:19 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6AC86DEA-E8EC-11DE-BF42-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135231>

Johannes Sixt <j.sixt@viscovery.net> writes:

> From: Johannes Sixt <j6t@kdbg.org>
>
> If a given command is not found, then help.c tries to guess which one the
> user could have meant. If help.autocorrect is 0 or unset, then a list of
> suggestions is given as long as the dissimilarity between the given command
> and the candidates is not excessively high. But if help.autocorrect was
> non-zero (i.e., a delay after which the command is run automatically), the
> latter restriction on dissimilarity was not obeyed.
>
> In my case, this happened:
>
>  $ git ..daab02
>  WARNING: You called a Git command named '..daab02', which does not exist.
>  Continuing under the assumption that you meant 'read-tree'
>  in 4.0 seconds automatically...
>
> The similarity limit that this patch introduces is already used a few lines
> later where the list of suggested commands is printed.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  help.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Thanks.  Will apply to 'maint'.

But I am curious about and would prefer to see the story behind '6'
someday.

This is not entirely a new problem that you are introducing, as the same
comparison-with-six appears in a later part of the code, but this patch
duplicates the magic number whose two instances need to match, so in that
sense it makes it more necessary than before to document the choice of
magic number somewhere in a comment in the code.

Did 8af84da (git wrapper: DWIM mistyped commands, 2008-08-31) made up just
a random number out of thin-air?  What bad things would happen if we used
'600' (or '1') instead of '6'?  What kind of correlation does the cut-off
value we use here should have with some intrinsic numbers your git
installation has (e.g. perhaps "must be at least 80% of average length of
available commands" or something like that)?

In the meantime, I think squashing the following in would help us keep the
two magic numbers in sync.

diff --git a/help.c b/help.c
index db888cf..fbf80d9 100644
--- a/help.c
+++ b/help.c
@@ -297,6 +297,9 @@ static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 	old->names = NULL;
 }
 
+/* how did we decide this is a good cutoff??? */
+#define SIMILAR_ENOUGH(x) ((x) < 6)
+
 const char *help_unknown_cmd(const char *cmd)
 {
 	int i, n, best_similarity = 0;
@@ -331,7 +334,7 @@ const char *help_unknown_cmd(const char *cmd)
 	n = 1;
 	while (n < main_cmds.cnt && best_similarity == main_cmds.names[n]->len)
 		++n;
-	if (autocorrect && n == 1 && best_similarity < 6) {
+	if (autocorrect && n == 1 && SIMILAR_ENOUGH(best_similarity)) {
 		const char *assumed = main_cmds.names[0]->name;
 		main_cmds.names[0] = NULL;
 		clean_cmdnames(&main_cmds);
@@ -349,7 +352,7 @@ const char *help_unknown_cmd(const char *cmd)
 
 	fprintf(stderr, "git: '%s' is not a git-command. See 'git --help'.\n", cmd);
 
-	if (best_similarity < 6) {
+	if (SIMILAR_ENOUGH(best_similarity)) {
 		fprintf(stderr, "\nDid you mean %s?\n",
 			n < 2 ? "this": "one of these");
 
