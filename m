From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] add: make "add -u/-A" update full tree without pathspec
 (step 3)
Date: Tue, 22 Mar 2011 22:19:18 -0700
Message-ID: <7v1v1yifc9.fsf_-_@alter.siamese.dyndns.org>
References: <7vy649vah1.fsf@alter.siamese.dyndns.org>
 <7vtyexv6wl.fsf@alter.siamese.dyndns.org>
 <7vpqplv65o.fsf@alter.siamese.dyndns.org> <vpqlj09a303.fsf@bauges.imag.fr>
 <7vhbaxuyk7.fsf@alter.siamese.dyndns.org>
 <20110321111643.GE16334@sigill.intra.peff.net>
 <7vtyeuiu07.fsf@alter.siamese.dyndns.org>
 <7v7hbqifej.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 06:19:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2GTm-0003tr-Rk
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 06:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524Ab1CWFTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 01:19:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40228 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755368Ab1CWFT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 01:19:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DC7A7211C;
	Wed, 23 Mar 2011 01:21:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nRNAaj0htB3+q1O1s46N4JHJbYE=; b=EDsiTC
	BNRPu3Dm9eQCfa1wONEku5HQLugOrYdkTsLTVK5qQD0zJnW2ZUN9gQ2A+KfKn/2k
	tfWixkZlp59KyNoN0n7n1A2/eeQIsXe3qj7M4za3evqR806J6za/ywXO0bDeQfSi
	hUeHwEIrswPp29S6EXjddG871fp34VTFn8CHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bcE6fI0Kc66D7ewM7h3LMpnxbFLuYBug
	6Agi4e/SvbrnmblYlOQ6OsbRb5Bdxv0+IddTp93SJq2IfltmHRPdRtufZ7zqwc3I
	fdBYf7AP7m+7bBuyFnLin9dl8rjdjcNpSnzidRcXROcf0EQdJ5ZVN6BpJqkfe41Z
	D6WQ+iTBmp4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A8EFF211B;
	Wed, 23 Mar 2011 01:21:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 510C7211A; Wed, 23 Mar 2011
 01:21:00 -0400 (EDT)
In-Reply-To: <7v7hbqifej.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 22 Mar 2011 22:17:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5986469A-550D-11E0-85D9-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169798>

Now long after 1.8.0 happened, people should have got used to the
new default behaviour and it is no longer necessary to give the
migration advice anymore.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * And this concludes the two-year long series from the future ;-)

 builtin/add.c         |   23 +----------------------
 t/t2200-add-update.sh |    3 +--
 2 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 1d76d55..71f3aa5 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -364,27 +364,6 @@ static int add_files(struct dir_struct *dir, int flags)
 	return exit_status;
 }
 
-static const char *warn_add_uA_180_migration_msg[] = {
-	"Since release 1.8.0, running 'git add -u' (or 'git add -A')",
-	"from a subdirectory without giving any pathspec takes effect",
-	"on the whole working tree, not just the part under the current",
-	"directory. If you want to limit the operation to the current",
-	"directory, please add '.' at the end of the command, like",
-	"'git add -u .'",
-	"Alternatively, you can set add.treewideupdate configuration",
-	"variable to 'false' to keep using the old behaviour.",
-	"This warning will be issued until you set the variable",
-	"to either 'true' or 'false'."
-};
-
-static int warn_180_migration(void)
-{
-	int i;
-	for (i = 0; i < ARRAY_SIZE(warn_add_uA_180_migration_msg); i++)
-		warning("%s", warn_add_uA_180_migration_msg[i]);
-	return 1; /* default to "true" (tree-wide, i.e. not local) */
-}
-
 int cmd_add(int argc, const char **argv, const char *prefix)
 {
 	int exit_status = 0;
@@ -419,7 +398,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		whole_tree_add = 1;
 		if (prefix) {
 			if (default_tree_wide_update < 0)
-				default_tree_wide_update = warn_180_migration();
+				default_tree_wide_update = 1;
 			if (!default_tree_wide_update)
 				whole_tree_add = 0;
 		}
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 97478cd..8479ff2 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -81,7 +81,6 @@ test_expect_success 'change gets noticed' '
 '
 
 test_expect_success 'update from a subdirectory without pathspec (no config)' '
-	# This test needs to be adjusted when warning message is removed
 	test_might_fail git config --remove add.treewideupdate &&
 	test_might_fail git reset check dir1 &&
 	echo changed >check &&
@@ -93,7 +92,7 @@ test_expect_success 'update from a subdirectory without pathspec (no config)' '
 	git diff-files --name-only dir1 check >actual &&
 	: >expect &&
 	test_cmp expect actual &&
-	grep warning expect.warning
+	! grep warning expect.warning
 '
 
 test_expect_success 'update from a subdirectory without pathspec (local)' '
-- 
1.7.4.1.586.g183369
