From: Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCH 2/3] contrib/subtree: remove use of -a/-o in [ commands
Date: Sun, 24 Mar 2013 22:17:13 +0100
Message-ID: <20130324211713.GA6155@ruderich.org>
References: <1364153863-27437-1-git-send-email-pcampbell@kemitix.net>
 <1364153863-27437-3-git-send-email-pcampbell@kemitix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Campbell <pcampbell@kemitix.net>
X-From: git-owner@vger.kernel.org Sun Mar 24 22:17:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJsIV-0000B8-9D
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 22:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832Ab3CXVRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 17:17:19 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:33922 "EHLO
	zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763Ab3CXVRS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 17:17:18 -0400
Received: from localhost (pD9E97571.dip.t-dialin.net [::ffff:217.233.117.113])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Sun, 24 Mar 2013 22:17:14 +0100
  id 00000000000000B0.00000000514F6D5A.00005DC7
Content-Disposition: inline
In-Reply-To: <1364153863-27437-3-git-send-email-pcampbell@kemitix.net>
User-Agent: Mutt/1.5.21 (2013-03-19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218987>

From: Paul Campbell <pcampbell@kemitix.net>

Use of -a and -o in the [ command can have confusing semantics.

Use a separate test invocation for each single test, combining them with
&& and ||.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
Signed-off-by: Simon Ruderich <simon@ruderich.org>
---

On Sun, Mar 24, 2013 at 07:37:42PM +0000, Paul Campbell wrote:
> Use a separate test invocation for each single test, combining them with
> && and ||, and use ordinary parentheses for grouping.

Hello Paul,

Parentheses are only necessary if both && and || are used to
enforce precedence; the shell can split the commands without
needing the parentheses. In these cases they can all be removed.

Regards
Simon

 contrib/subtree/git-subtree.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 5701376..d02e6c5 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -119,7 +119,7 @@ esac
 
 dir="$(dirname "$prefix/.")"
 
-if [ "$command" != "pull" -a "$command" != "add" -a "$command" != "push" ]; then
+if test "$command" != "pull" && test "$command" != "add" && test "$command" != "push"; then
 	revs=$(git rev-parse $default --revs-only "$@") || exit $?
 	dirs="$(git rev-parse --no-revs --no-flags "$@")" || exit $?
 	if [ -n "$dirs" ]; then
@@ -181,9 +181,9 @@ cache_set()
 {
 	oldrev="$1"
 	newrev="$2"
-	if [ "$oldrev" != "latest_old" \
-	     -a "$oldrev" != "latest_new" \
-	     -a -e "$cachedir/$oldrev" ]; then
+	if test "$oldrev" != "latest_old" \
+	     && test "$oldrev" != "latest_new" \
+	     && test -e "$cachedir/$oldrev"; then
 		die "cache for $oldrev already exists!"
 	fi
 	echo "$newrev" >"$cachedir/$oldrev"
@@ -273,12 +273,12 @@ find_existing_splits()
 			git-subtree-split:) sub="$b" ;;
 			END)
 				debug "  Main is: '$main'"
-				if [ -z "$main" -a -n "$sub" ]; then
+				if test -z "$main" && test -n "$sub"; then
 					# squash commits refer to a subtree
 					debug "  Squash: $sq from $sub"
 					cache_set "$sq" "$sub"
 				fi
-				if [ -n "$main" -a -n "$sub" ]; then
+				if test -n "$main" && test -n "$sub"; then
 					debug "  Prior: $main -> $sub"
 					cache_set $main $sub
 					cache_set $sub $sub
@@ -541,7 +541,7 @@ cmd_add_commit()
 	tree=$(git write-tree) || exit $?
 	
 	headrev=$(git rev-parse HEAD) || exit $?
-	if [ -n "$headrev" -a "$headrev" != "$rev" ]; then
+	if test -n "$headrev" && test "$headrev" != "$rev"; then
 		headp="-p $headrev"
 	else
 		headp=
-- 
1.8.2

-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
