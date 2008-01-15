From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] git-submodule: rename shell functions for consistency
Date: Tue, 15 Jan 2008 03:18:39 -0800
Message-ID: <7vy7are3qo.fsf_-_@gitster.siamese.dyndns.org>
References: <1200280956-19920-1-git-send-email-imyousuf@gmail.com>
	<7vzlv7flb5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: imyousuf@gmail.com
X-From: git-owner@vger.kernel.org Tue Jan 15 12:19:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEjpD-0005Tc-7L
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 12:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbYAOLSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 06:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbYAOLSx
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 06:18:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58586 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbYAOLSw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 06:18:52 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CB4121801;
	Tue, 15 Jan 2008 06:18:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EDC2F1800;
	Tue, 15 Jan 2008 06:18:45 -0500 (EST)
In-Reply-To: <7vzlv7flb5.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 15 Jan 2008 02:13:50 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70512>

This renames the shell functions used in git-submodule that
implement top-level subcommands.  The rule is that the
subcommand $foo is implemented by cmd_$foo function.

A noteworthy change is that modules_list() is now known as
cmd_status().  There is no "submodule list" command.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * We could probably do something like this.  This first part is
   about making the command dispatcher maintainable.

   Note that I haven't seriously tested this series.  This and
   the next one are primarily to illustrate what I think the fix
   you are trying should look like.

 git-submodule.sh |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ad9fe62..3c104e3 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -86,9 +86,9 @@ module_name()
 #
 # Clone a submodule
 #
-# Prior to calling, modules_update checks that a possibly existing
+# Prior to calling, cmd_update checks that a possibly existing
 # path is not a git repository.
-# Likewise, module_add checks that path does not exist at all,
+# Likewise, cmd_add checks that path does not exist at all,
 # since it is the location of a new submodule.
 #
 module_clone()
@@ -121,7 +121,7 @@ module_clone()
 #
 # optional branch is stored in global branch variable
 #
-module_add()
+cmd_add()
 {
 	repo=$1
 	path=$2
@@ -174,7 +174,7 @@ module_add()
 #
 # $@ = requested paths (default to all)
 #
-modules_init()
+cmd_init()
 {
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
 	while read mode sha1 stage path
@@ -207,7 +207,7 @@ modules_init()
 #
 # $@ = requested paths (default to all)
 #
-modules_update()
+cmd_update()
 {
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
 	while read mode sha1 stage path
@@ -266,7 +266,7 @@ set_name_rev () {
 #
 # $@ = requested paths (default to all)
 #
-modules_list()
+cmd_status()
 {
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
 	while read mode sha1 stage path
@@ -347,16 +347,16 @@ esac
 
 case "$add,$init,$update,$status,$cached" in
 1,,,,)
-	module_add "$@"
+	cmd_add "$@"
 	;;
 ,1,,,)
-	modules_init "$@"
+	cmd_init "$@"
 	;;
 ,,1,,)
-	modules_update "$@"
+	cmd_update "$@"
 	;;
 ,,,*,*)
-	modules_list "$@"
+	cmd_status "$@"
 	;;
 *)
 	usage
-- 
1.5.4.rc3.11.g4e67
