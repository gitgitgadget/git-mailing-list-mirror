From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/7] push: document --lockref
Date: Tue,  9 Jul 2013 12:53:30 -0700
Message-ID: <1373399610-8588-8-git-send-email-gitster@pobox.com>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
 <1373399610-8588-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 09 21:54:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwdz3-00068J-Bs
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 21:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154Ab3GITxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 15:53:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39579 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752660Ab3GITxr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 15:53:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD85D2F3E0
	for <git@vger.kernel.org>; Tue,  9 Jul 2013 19:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=CTTk
	rYpMQbgqB6UC/xXnUVrYxKY=; b=g7ghApdQ6I6trjDkPiZOe1/ScPlJZzx8UvBK
	UYHLksSP3MyxR5dPUjV5FuVZLLaCitvdILolOUTCgFAINFtkcmq7JKLtHApDFPTD
	etd9hsI8W+Y0WQce+XlqkDnSMyOPjGJ7PLyGstwSnSBYoOCyDjzJlvV+CgmhQB74
	k80NFq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Okq2Ge
	tGyXdYu7bR7Kb2VpZYBWXf00AnxArmj4GP6e4XzKZpvwtWNbnZE+x3lYpkEyS5GJ
	3aRHl4XkldL71V874mcg7S9B1ifP8oTvA5sP6YFHlZgiW885KzopTAPdmYvPC+iZ
	CwRvpF0OADlR1jsovu4lTPtgW9hF+5CRsw5JA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B24162F3DF
	for <git@vger.kernel.org>; Tue,  9 Jul 2013 19:53:46 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 370A62F3DD
	for <git@vger.kernel.org>; Tue,  9 Jul 2013 19:53:46 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-875-g76c723c
In-Reply-To: <1373399610-8588-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 441167A4-E8D1-11E2-8FFE-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229993>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-push.txt | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index f7dfe48..e7c8bd6 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git push' [--all | --mirror | --tags] [--follow-tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose] [-u | --set-upstream]
+	   [--lockref[=<refname>[:[<expect>]]]]
 	   [--no-verify] [<repository> [<refspec>...]]
 
 DESCRIPTION
@@ -146,6 +147,31 @@ already exists on the remote side.
 	to the `master`	branch). See the `<refspec>...` section above
 	for details.
 
+--lockref::
+--lockref=<refname>::
+--lockref=<refname>:<expect>::
+	When updating <refname> at the remote, make sure that the
+	ref currently points at <expect> (an object name), and else
+	fail the push, even if `--force` is specified.  If only
+	<refname> is given, the expected value is taken from the
+	remote-tracking branch that holds the last-observed value of
+	the <refname>.  <expect> given as an empty string means the
+	<refname> should not exist and this push must be creating
+	it.  If `--lockref` (without any value) is given, make sure
+	each ref this push is going to update points at the object
+	our remote-tracking branch for it points at.
++
+This is meant to make `--force` safer to use.  Imagine that you have
+to rebase what you have already published.  You will have to
+`--force` the push to replace the history you originally published
+with the rebased history.  If somebody else built on top of your
+original history while you are rebasing, the tip of the branch at
+the remote may advance with her commit, and blindly pushing with
+`--force` will lose her work.  By using this option to specify that
+you expect the history you are updating is what you rebased and want
+to replace, you can make sure other people's work will not be losed
+by a forced push. in such a case.
+
 --repo=<repository>::
 	This option is only relevant if no <repository> argument is
 	passed in the invocation. In this case, 'git push' derives the
-- 
1.8.3.2-875-g76c723c
