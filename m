From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] run-command.c: retire unused run_hook_with_custom_index()
Date: Mon, 01 Dec 2014 08:43:37 -0800
Message-ID: <xmqq61dvqq12.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 17:43:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvU4e-00029V-Kl
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 17:43:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936AbaLAQnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 11:43:40 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51421 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752892AbaLAQnj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 11:43:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 286FB1F2BB;
	Mon,  1 Dec 2014 11:43:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=7
	EffwOKCALb+eLjK966KxIqjtuQ=; b=jp7QRKMlawYlVrT6l3xW9dG0JLXYewPLi
	JypZXhuFFEaMlvm4ENSYgVxFCSlE6WHXs2VNNd2K9rmkgmEGsYJyo4KWwaRIsLj+
	hb3mVPPK4KY81UN8f9TTytGaWKsLa4ocPuHXxwjkwyxUKzlJAtfX5bHI7Q1U1t/D
	AAqFuRouE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=aR2
	Pp/H0ZpyFYF15ta3d3I/JiABkQsQ1D5uHJ7i2kXESpiXiL6jfbaGLiH4YHKTq36h
	QaLeBl5eTQUF8n9TjbnaTmZmFH/9T8aQ4qNOuEI92KRvlBegJzLKzu9QfJladKHr
	7iQMSpVApfIqEPVN2EG3amb104FHG7gxBIJ/gweg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F4791F2BA;
	Mon,  1 Dec 2014 11:43:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A51C21F2B7;
	Mon,  1 Dec 2014 11:43:38 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3350478E-7979-11E4-A6A7-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260494>

This was originally meant to be used to rewrite run_commit_hook()
that only special cases the GIT_INDEX_FILE environment, but the
run_hook_ve() refactoring done earlier made the implementation of
run_commit_hook() thin and clean enough.

Nobody uses this, so retire it as an unfinished clean-up made
unnecessary.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 run-command.c | 17 -----------------
 run-command.h |  4 ----
 2 files changed, 21 deletions(-)

diff --git a/run-command.c b/run-command.c
index 35a3ebf..ae36852 100644
--- a/run-command.c
+++ b/run-command.c
@@ -792,20 +792,3 @@ int run_hook_le(const char *const *env, const char *name, ...)
 
 	return ret;
 }
-
-int run_hook_with_custom_index(const char *index_file, const char *name, ...)
-{
-	const char *hook_env[3] =  { NULL };
-	char index[PATH_MAX];
-	va_list args;
-	int ret;
-
-	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
-	hook_env[0] = index;
-
-	va_start(args, name);
-	ret = run_hook_ve(hook_env, name, args);
-	va_end(args);
-
-	return ret;
-}
diff --git a/run-command.h b/run-command.h
index ea73de3..9e8cd9c 100644
--- a/run-command.h
+++ b/run-command.h
@@ -53,10 +53,6 @@ LAST_ARG_MUST_BE_NULL
 extern int run_hook_le(const char *const *env, const char *name, ...);
 extern int run_hook_ve(const char *const *env, const char *name, va_list args);
 
-LAST_ARG_MUST_BE_NULL
-__attribute__((deprecated))
-extern int run_hook_with_custom_index(const char *index_file, const char *name, ...);
-
 #define RUN_COMMAND_NO_STDIN 1
 #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
 #define RUN_COMMAND_STDOUT_TO_STDERR 4
-- 
2.2.0-133-g5229807
