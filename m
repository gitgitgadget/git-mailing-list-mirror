From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Replace instances of export VAR=VAL with VAR=VAL; export
 VAR
Date: Wed, 28 Nov 2007 15:56:11 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711281552440.27959@racer.site>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com>
 <C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr>
 <D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com>
 <CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com> <474AC136.8060906@viscovery.net>
 <451492C9-F3EA-4C37-A1AD-59FC72E0A0A2@wincent.com> <Pine.LNX.4.64.0711261340470.27959@racer.site>
 <97F6E8DE-4022-4458-B6A9-C644A6EDC1E3@wincent.com> <7vir3m94ku.fsf@gitster.siamese.dyndns.org>
 <50645A3B-C5F0-4A99-A2B8-AD9251024244@wincent.com> <7v1waa7lcv.fsf@gitster.siamese.dyndns.org>
 <1570EAD5-9F47-4105-B3DA-49CA6FA57369@wincent.com> <Pine.LNX.4.64.0711281355460.27959@racer.site>
 <474D7956.8050401@viscovery.net> <Pine.LNX.4.64.0711281428180.27959@racer.site>
 <474D7D92.2000106@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 16:57:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxPHF-0006Nd-Bo
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 16:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756950AbXK1P4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 10:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754685AbXK1P4W
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 10:56:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:56826 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752160AbXK1P4V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 10:56:21 -0500
Received: (qmail invoked by alias); 28 Nov 2007 15:56:19 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp004) with SMTP; 28 Nov 2007 16:56:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/t6MgNHmrtqIMK/ASeVD8co5tYtv+06zaVmTGQS8
	my0fVQVLrnTDIr
X-X-Sender: gene099@racer.site
In-Reply-To: <474D7D92.2000106@viscovery.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66362>


It might be POSIX, but there are shells that do not like the
expression 'export VAR=VAL'.  To be on the safe side, rewrite them
into 'VAR=VAL' and 'export VAR'.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Wed, 28 Nov 2007, Johannes Sixt wrote:

	> Johannes Schindelin schrieb:
	> > 
	> > On Wed, 28 Nov 2007, Johannes Sixt wrote:
	> > 
	> > > Johannes Schindelin schrieb:
	> > > > -			s/.*/export GIT_'$uid'_NAME='\''&'\''/p
	> > > > +			s/.*/GIT_'$uid'_NAME='\''&'\''\nexport
	> > > > GIT_'$uid'_NAME/p
	> > >
	> > > Recently there was a report that \n in the substitution side 
	> > > of s/// is not supported by all seds :-(
	> > 
	> > Okay, how about replacing the line with
	> > 
	> > +			s/.*/GIT_'$uid'_NAME='\''&'\''\
	> > +export GIT_'$uid'_NAME/p
	> > 
	> > Hmm?  (It works here.)
	> 
	> This looks good. The other case I'm refering to was also solved 
	> in this way.

	Done.

 git-clone.sh         |    2 +-
 git-filter-branch.sh |   23 +++++++++++++++--------
 git-quiltimport.sh   |   10 ++++++----
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 24ad179..ecf9d89 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -229,7 +229,7 @@ cleanup() {
 trap cleanup 0
 mkdir -p "$dir" && D=$(cd "$dir" && pwd) || usage
 test -n "$GIT_WORK_TREE" && mkdir -p "$GIT_WORK_TREE" &&
-W=$(cd "$GIT_WORK_TREE" && pwd) && export GIT_WORK_TREE="$W"
+W=$(cd "$GIT_WORK_TREE" && pwd) && GIT_WORK_TREE="$W" && export GIT_WORK_TREE
 if test yes = "$bare" || test -n "$GIT_WORK_TREE"; then
 	GIT_DIR="$D"
 else
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 19cab5a..074b2c0 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -66,17 +66,20 @@ set_ident () {
 			h
 			s/^'$lid' \([^<]*\) <[^>]*> .*$/\1/
 			s/'\''/'\''\'\'\''/g
-			s/.*/export GIT_'$uid'_NAME='\''&'\''/p
+			s/.*/GIT_'$uid'_NAME='\''&'\''\
+export GIT_'$uid'_NAME/p
 
 			g
 			s/^'$lid' [^<]* <\([^>]*\)> .*$/\1/
 			s/'\''/'\''\'\'\''/g
-			s/.*/export GIT_'$uid'_EMAIL='\''&'\''/p
+			s/.*/GIT_'$uid'_EMAIL='\''&'\''\
+export GIT_'$uid'_EMAIL/p
 
 			g
 			s/^'$lid' [^<]* <[^>]*> \(.*\)$/\1/
 			s/'\''/'\''\'\'\''/g
-			s/.*/export GIT_'$uid'_DATE='\''&'\''/p
+			s/.*/GIT_'$uid'_DATE='\''&'\''\
+export GIT_'$uid'_DATE/p
 
 			q
 		}
@@ -84,7 +87,7 @@ set_ident () {
 
 	LANG=C LC_ALL=C sed -ne "$pick_id_script"
 	# Ensure non-empty id name.
-	echo "[ -n \"\$GIT_${uid}_NAME\" ] || export GIT_${uid}_NAME=\"\${GIT_${uid}_EMAIL%%@*}\""
+	echo "case \"\$GIT_${uid}_NAME\" in \"\") GIT_${uid}_NAME=\"\${GIT_${uid}_EMAIL%%@*}\" && export GIT_${uid}_NAME;; esac"
 }
 
 USAGE="[--env-filter <command>] [--tree-filter <command>] \
@@ -206,7 +209,8 @@ done < "$tempdir"/backup-refs
 ORIG_GIT_DIR="$GIT_DIR"
 ORIG_GIT_WORK_TREE="$GIT_WORK_TREE"
 ORIG_GIT_INDEX_FILE="$GIT_INDEX_FILE"
-export GIT_DIR GIT_WORK_TREE=.
+GIT_WORK_TREE=.
+export GIT_DIR GIT_WORK_TREE
 
 # These refs should be updated if their heads were rewritten
 
@@ -231,7 +235,8 @@ done > "$tempdir"/heads
 test -s "$tempdir"/heads ||
 	die "Which ref do you want to rewrite?"
 
-export GIT_INDEX_FILE="$(pwd)/../index"
+GIT_INDEX_FILE="$(pwd)/../index"
+export GIT_INDEX_FILE
 git read-tree || die "Could not seed the index"
 
 ret=0
@@ -267,7 +272,8 @@ while read commit parents; do
 		git read-tree -i -m $commit:"$filter_subdir"
 	esac || die "Could not initialize the index"
 
-	export GIT_COMMIT=$commit
+	GIT_COMMIT=$commit
+	export GIT_COMMIT
 	git cat-file commit "$commit" >../commit ||
 		die "Cannot read commit $commit"
 
@@ -401,7 +407,8 @@ if [ "$filter_tag_name" ]; then
 
 		[ -f "../map/$sha1" ] || continue
 		new_sha1="$(cat "../map/$sha1")"
-		export GIT_COMMIT="$sha1"
+		GIT_COMMIT="$sha1"
+		export GIT_COMMIT
 		new_ref="$(echo "$ref" | eval "$filter_tag_name")" ||
 			die "tag name filter failed: $filter_tag_name"
 
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 6b0c4d2..233e5ea 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -77,8 +77,9 @@ for patch_name in $(grep -v '^#' < "$QUILT_PATCHES/series" ); do
 	}
 
 	# Parse the author information
-	export GIT_AUTHOR_NAME=$(sed -ne 's/Author: //p' "$tmp_info")
-	export GIT_AUTHOR_EMAIL=$(sed -ne 's/Email: //p' "$tmp_info")
+	GIT_AUTHOR_NAME=$(sed -ne 's/Author: //p' "$tmp_info")
+	GIT_AUTHOR_EMAIL=$(sed -ne 's/Email: //p' "$tmp_info")
+	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
 	while test -z "$GIT_AUTHOR_EMAIL" && test -z "$GIT_AUTHOR_NAME" ; do
 		if [ -n "$quilt_author" ] ; then
 			GIT_AUTHOR_NAME="$quilt_author_name";
@@ -104,8 +105,9 @@ for patch_name in $(grep -v '^#' < "$QUILT_PATCHES/series" ); do
 			GIT_AUTHOR_EMAIL="$patch_author_email"
 		fi
 	done
-	export GIT_AUTHOR_DATE=$(sed -ne 's/Date: //p' "$tmp_info")
-	export SUBJECT=$(sed -ne 's/Subject: //p' "$tmp_info")
+	GIT_AUTHOR_DATE=$(sed -ne 's/Date: //p' "$tmp_info")
+	SUBJECT=$(sed -ne 's/Subject: //p' "$tmp_info")
+	export GIT_AUTHOR_DATE SUBJECT
 	if [ -z "$SUBJECT" ] ; then
 		SUBJECT=$(echo $patch_name | sed -e 's/.patch$//')
 	fi
-- 
1.5.3.6.2065.gd47ac
