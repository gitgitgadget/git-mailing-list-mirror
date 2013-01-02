From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] format-patch: document and test --reroll-count
Date: Wed,  2 Jan 2013 14:42:04 -0800
Message-ID: <1357166525-12188-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 02 23:42:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqX16-0000Yn-7a
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 23:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774Ab3ABWmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 17:42:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59523 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752753Ab3ABWmL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 17:42:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2188BA33A
	for <git@vger.kernel.org>; Wed,  2 Jan 2013 17:42:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=bzEAyV3Bi74PDwkj0Y7w5pL3qfU
	=; b=TDE8t6GHRjhUBXhgSemFtky7TUZnUZTEQmI0+ji3bsgsoVJIc5HFXFMVNCA
	bxpMhut3gV7UqeAGZ7+BW4OCISuxTRchq0rbgQPp+1oBOsGSsFzCBYIUitqjqVY6
	ziypWqObNWVTRzEWKLFCg4qGzLBfezddkcmvfewvieYPDEzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=Y/xSmRC50IlDiN2KKq8MrEjKO4I87
	huYzGN2pg1VgDmlz7VoJgAb2pFZNldDeaEM2O3NTmhOpRxTU+wnIKVufrYgZWltb
	1ZgnGXl4bBj2PZ27wKC7ysoj8LlmvBYfKHb3YFdx/R+GikSSfJgQomLtiLe0fKbG
	Mia6Ym/vJOuZpE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 131B4A339
	for <git@vger.kernel.org>; Wed,  2 Jan 2013 17:42:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 70C2BA336 for
 <git@vger.kernel.org>; Wed,  2 Jan 2013 17:42:06 -0500 (EST)
X-Mailer: git-send-email 1.8.1.203.gc241474
X-Pobox-Relay-ID: A3368ECC-552D-11E2-A08F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212549>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This comes on top of the 7 patches that have been cooking on 'pu'
   (http://thread.gmane.org/gmane.comp.version-control.git/212036),
   and I am planning to squash this to 7/7 that adds --reroll-count
   option to the code.  This is sent as a separate patch to keep
   reviewing easier.

 Documentation/git-format-patch.txt | 10 +++++++++-
 t/t4014-format-patch.sh            |  8 ++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 6d43f56..736d8bf 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 		   [--start-number <n>] [--numbered-files]
 		   [--in-reply-to=Message-Id] [--suffix=.<sfx>]
 		   [--ignore-if-in-upstream]
-		   [--subject-prefix=Subject-Prefix]
+		   [--subject-prefix=Subject-Prefix] [--reroll-count <n>]
 		   [--to=<email>] [--cc=<email>]
 		   [--cover-letter] [--quiet]
 		   [<common diff options>]
@@ -166,6 +166,14 @@ will want to ensure that threading is disabled for `git send-email`.
 	allows for useful naming of a patch series, and can be
 	combined with the `--numbered` option.
 
+--reroll-count=<n>::
+	Mark the series as the <n>-th iteration of the topic. The
+	output filenames have `v<n>` pretended to them, and the
+	subject prefix ("PATCH" by default, but configurable via the
+	`--subject-prefix` option) has ` v<n>` appended to it.  E.g.
+	`--reroll-count=4` may produce `v4-0001-add-makefile.patch`
+	file that has "Subject: [PATCH v4 1/20] Add makefile" in it.
+
 --to=<email>::
 	Add a `To:` header to the email headers. This is in addition
 	to any configured headers, and may be used multiple times.
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 959aa26..0ff9958 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -237,6 +237,14 @@ test_expect_success 'multiple files' '
 	ls patches/0001-Side-changes-1.patch patches/0002-Side-changes-2.patch patches/0003-Side-changes-3-with-n-backslash-n-in-it.patch
 '
 
+test_expect_success 'reroll count' '
+	rm -fr patches &&
+	git format-patch -o patches --cover-letter --reroll-count 4 master..side >list &&
+	! grep -v "^patches/v4-000[0-3]-" list &&
+	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
+	! grep -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
+'
+
 check_threading () {
 	expect="$1" &&
 	shift &&
-- 
1.8.0.9.g5e84801
