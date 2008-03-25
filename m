From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH v3] filter-branch.sh: support nearly proper tag name filtering
Date: Tue, 25 Mar 2008 10:44:48 -0500
Message-ID: <47E91DF0.5070302@nrlssc.navy.mil>
References: <7v63vbr4eq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 16:52:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeBP2-0003Gf-8N
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 16:49:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757419AbYCYPsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 11:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757594AbYCYPs3
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 11:48:29 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:56786 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756081AbYCYPs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 11:48:28 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2PFimIZ014746;
	Tue, 25 Mar 2008 10:44:49 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Mar 2008 10:44:48 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7v63vbr4eq.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 25 Mar 2008 15:44:48.0489 (UTC) FILETIME=[2822B590:01C88E8F]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15806001
X-TM-AS-Result: : Yes--18.505400-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwNDQyMS03MDQ0?=
	=?us-ascii?B?MjUtNzExNjEyLTcwMDQ3Ni03MDM5NjktNzAzNzg4LTcwMDYzMC03?=
	=?us-ascii?B?MDEyMjAtNzAxMjM2LTcwMDE2MC04MzM1MTgtNzAwMDc1LTEzOTAx?=
	=?us-ascii?B?MC03MDE2MTgtNzAxNDU1LTcwNDkyNy03MDA5MDUtNzAzMTEyLTcw?=
	=?us-ascii?B?MjAyMC03MDYxNTktNzAzNDM1LTcwNTQ2MS03MDE1OTQtNzAwNzAx?=
	=?us-ascii?B?LTE4ODAxOS03MDU1ODQtNzAyMzU4LTcwMDA3NC03MDA4MzktNzA0?=
	=?us-ascii?B?NDEwLTcwODI1Ny03MDIxNDMtNzAzNzEyLTcwNDkzMC03MDYyNDkt?=
	=?us-ascii?B?NzA5NTg0LTcwMDEzMy03MDA5NDktMTIxNjI4LTEwNjM5MC03MDY0?=
	=?us-ascii?B?NTQtNzAzNjU3LTEwNjQyMC03MDE5NDAtNzA1OTAxLTcwMjU1MS03?=
	=?us-ascii?B?MDc3NTAtMTIxNjI0LTcwMDk3MS04MzQ2NjgtMTIxMzM4LTcwMDMy?=
	=?us-ascii?B?NC03MDA5NzAtNzAzMTg3LTcwMjU5OC0xMzk2MjktNzAwMDczLTcw?=
	=?us-ascii?B?MDY0OC0xODgxOTktNzA1NDUwLTE0ODAzOS0xNDgwNTEtMTAwMDMt?=
	=?us-ascii?B?MjAwNDA=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78194>

Add support for creating a new tag object and retaining the tag message,
author, and date when rewriting tags. The gpg signature, if one exists,
will be stripped.

This adds nearly proper tag name filtering to filter-branch. Proper tag
name filtering would include the ability to change the tagger, tag date,
tag message, and _not_ strip a gpg signature if the tag did not change.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Junio C Hamano wrote:
> What I meant with my earlier comment was that it would have been more
> robust if you did a sequence of:
> 
> 	s/type .*/type $newtype/
>         s/object .*/object $newobject/
> 
> instead of relying on the order in the existing objects, but I should have
> been more explicit about c\ as well.

Yep, that is better. This version implementing your suggestions won't silently
create a valid tag from one that mktag would have barfed on.

If you think the strict ordering that mktag requires could be relaxed in the
future, then the line number addresses in sed could be changed to ranges
like:

	-e "1,4s/^object ..*/object $newobject/"

Of course, if we use ranges, we may have to worry about matching against
the tag body if the header gets any longer.

-brandon


 Documentation/git-filter-branch.txt |   14 ++++++++++----
 git-filter-branch.sh                |   16 ++++++++++++++--
 t/t7003-filter-branch.sh            |   32 ++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 2a78549..9d11b41 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -133,10 +133,16 @@ use "--tag-name-filter cat" to simply update the tags.  In this
 case, be very careful and make sure you have the old tags
 backed up in case the conversion has run afoul.
 +
-Note that there is currently no support for proper rewriting of
-tag objects; in layman terms, if the tag has a message or signature
-attached, the rewritten tag won't have it.  Sorry.  (It is by
-definition impossible to preserve signatures at any rate.)
+Nearly proper rewriting of tag objects is supported. If the tag has
+a message attached, a new tag object will be created with the same message,
+author, and timestamp. If the tag has a signature attached, the
+signature will be stripped. It is by definition impossible to preserve
+signatures. The reason this is "nearly" proper, is because ideally if
+the tag did not change (points to the same object, has the same name, etc.)
+it should retain any signature. That is not the case, signatures will always
+be removed, buyer beware. There is also no support for changing the
+author or timestamp (or the tag message for that matter). Tags which point
+to other tags will be rewritten to point to the underlying commit.
 
 --subdirectory-filter <directory>::
 	Only look at the history which touches the given subdirectory.
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 22b6ed4..05f7c7b 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -406,8 +406,20 @@ if [ "$filter_tag_name" ]; then
 		echo "$ref -> $new_ref ($sha1 -> $new_sha1)"
 
 		if [ "$type" = "tag" ]; then
-			# Warn that we are not rewriting the tag object itself.
-			warn "unreferencing tag object $sha1t"
+			new_sha1=$(git cat-file tag "$ref" |
+				sed -n \
+				    -e "1s/^object ..*/object $new_sha1/"  \
+				    -e '2s/^type ..*/type commit/'         \
+				    -e "3s/^tag ..*/tag $new_ref/"         \
+				    -e '/^-----BEGIN PGP SIGNATURE-----/q' \
+				    -e 'p' |
+				git mktag) ||
+				die "Could not create new tag object for $ref"
+			if git cat-file tag "$ref" | \
+			   grep '^-----BEGIN PGP SIGNATURE-----' >/dev/null 2>&1
+			then
+				warn "gpg signature stripped from tag object $sha1t"
+			fi
 		fi
 
 		git update-ref "refs/tags/$new_ref" "$new_sha1" ||
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 6827249..1daaf54 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -203,4 +203,36 @@ test_expect_success 'Subdirectory filter with disappearing trees' '
 	test $(git rev-list master | wc -l) = 3
 '
 
+test_expect_success 'Tag name filtering retains tag message' '
+	git tag -m atag T &&
+	git cat-file tag T > expect &&
+	git filter-branch -f --tag-name-filter cat &&
+	git cat-file tag T > actual &&
+	git diff expect actual
+'
+
+faux_gpg_tag='object XXXXXX
+type commit
+tag S
+tagger T A Gger <tagger@example.com> 1206026339 -0500
+
+This is a faux gpg signed tag.
+-----BEGIN PGP SIGNATURE-----
+Version: FauxGPG v0.0.0 (FAUX/Linux)
+
+gdsfoewhxu/6l06f1kxyxhKdZkrcbaiOMtkJUA9ITAc1mlamh0ooasxkH1XwMbYQ
+acmwXaWET20H0GeAGP+7vow=
+=agpO
+-----END PGP SIGNATURE-----
+'
+test_expect_success 'Tag name filtering strips gpg signature' '
+	sha1=$(git rev-parse HEAD) &&
+	sha1t=$(echo "$faux_gpg_tag" | sed -e s/XXXXXX/$sha1/ | git mktag) &&
+	git update-ref "refs/tags/S" "$sha1t" &&
+	echo "$faux_gpg_tag" | sed -e s/XXXXXX/$sha1/ | head -n 6 > expect &&
+	git filter-branch -f --tag-name-filter cat &&
+	git cat-file tag S > actual &&
+	git diff expect actual
+'
+
 test_done
-- 
1.5.5.rc1.1.gb5ed86.dirty
