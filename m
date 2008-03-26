From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH v4] filter-branch.sh: support nearly proper tag name filtering
Date: Wed, 26 Mar 2008 10:47:09 -0500
Message-ID: <47EA6FFD.1090805@nrlssc.navy.mil>
References: <7vmyolgbor.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 16:49:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeXrc-000389-4g
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 16:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382AbYCZPre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 11:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754788AbYCZPre
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 11:47:34 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54048 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754171AbYCZPrd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 11:47:33 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2QFlALd004102;
	Wed, 26 Mar 2008 10:47:11 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 26 Mar 2008 10:47:09 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7vmyolgbor.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 26 Mar 2008 15:47:09.0712 (UTC) FILETIME=[A6B96100:01C88F58]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15806001
X-TM-AS-Result: : Yes--19.362400-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwNDQyMS03MDQ0?=
	=?us-ascii?B?MjUtNzExNjEyLTcwMDQ3Ni03MDM5NjktNzAzNzg4LTcwMDYzMC03?=
	=?us-ascii?B?MDEyMjAtNzAxMjM2LTcwMDE2MC04MzM1MTgtNzAwMDc1LTEzOTAx?=
	=?us-ascii?B?MC03MDM3MzEtNzA1NTg0LTcwMjM1OC03MDAwNzQtNzAwODM5LTcw?=
	=?us-ascii?B?MTQ1NS0xODgwMTktMTg3MDY3LTcwMDcwMS03MDAxMDctNzA0NDEw?=
	=?us-ascii?B?LTcwODI1Ny03MDIxNDMtNzAzNzEyLTcwNDkzMC03MDYyNDktNzA5?=
	=?us-ascii?B?NTg0LTcwNDkyNy03MDAxMzMtNzAwOTQ5LTEyMTYyOC0xMDYzOTAt?=
	=?us-ascii?B?NzA2NDU0LTcwMzY1Ny0xMDY0MjAtNzAxOTQwLTcwNTkwMS03MDI1?=
	=?us-ascii?B?NTEtNzA3NzUwLTEyMTYyNC03MDA5NzEtODM0NjY4LTEyMTMzOC03?=
	=?us-ascii?B?MDAzMjQtNzAwOTcwLTcwMzE4Ny03MDI1OTgtMTM5NjI5LTcwMDA3?=
	=?us-ascii?B?My03MDA2NDgtMTg4MTk5LTcwNTQ1MC0xNDgwMzktMTQ4MDUxLTEw?=
	=?us-ascii?B?MDAzLTIwMDQy?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78286>

Add support for creating a new tag object and retaining the tag message,
author, and date when rewriting tags. The gpg signature, if one exists,
will be stripped.

This adds nearly proper tag name filtering to filter-branch. Proper tag
name filtering would include the ability to change the tagger, tag date,
tag message, and _not_ strip a gpg signature if the tag did not change.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
>> Of course, if we use ranges, we may have to worry about matching against
>> the tag body if the header gets any longer.
> 
> I do not think you have to worry if you did this:
> 
>         1,/^$/{
>                 s/object .*/object $newobject/
>                 s/type .*/type $newtype/
>                 ...
>         }

I am a sed light-weight. Thanks for teaching.

-brandon


 Documentation/git-filter-branch.txt |   14 ++++++++++----
 git-filter-branch.sh                |   18 ++++++++++++++++--
 t/t7003-filter-branch.sh            |   32 ++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 6 deletions(-)

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
index 22b6ed4..ee90660 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -406,8 +406,22 @@ if [ "$filter_tag_name" ]; then
 		echo "$ref -> $new_ref ($sha1 -> $new_sha1)"
 
 		if [ "$type" = "tag" ]; then
-			# Warn that we are not rewriting the tag object itself.
-			warn "unreferencing tag object $sha1t"
+			new_sha1=$(git cat-file tag "$ref" |
+				sed -n \
+				    -e "1,/^$/{
+					  s/^object .*/object $new_sha1/
+					  s/^type .*/type commit/
+					  s/^tag .*/tag $new_ref/
+					}" \
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
1.5.4.4.481.g5075
