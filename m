From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <tavestbo@trolltech.com>
Subject: [PATCH/RFC] git-pull: forward --summary to git-rebase to allow diffstat on --rebase
Date: Wed, 25 Feb 2009 23:37:47 +0100
Message-ID: <49A5C83B.8050100@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 25 23:29:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcSG9-0002UX-5b
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 23:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759262AbZBYW2Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 17:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759193AbZBYW2Q
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 17:28:16 -0500
Received: from hoat.troll.no ([62.70.27.150]:40139 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756973AbZBYW2P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 17:28:15 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id DC69520C2E;
	Wed, 25 Feb 2009 23:28:12 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id D093B20C0F;
	Wed, 25 Feb 2009 23:28:12 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n1PMSAVO023490;
	Wed, 25 Feb 2009 23:28:10 +0100
Received: from [172.24.90.10] ( [172.24.90.10])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Wed, 25 Feb 2009 23:28:10 +0100 (CET)
x-scalix-Hops: 1
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111506>

git-rebase gets aliases for --summary and --stat to --verbose, as well
as a --no-stat, so that git-pull can just forward the --summary directl=
y.

Signed-off-by: Tor Arne Vestb=F8 <tavestbo@trolltech.com>
---

Would something like this be welcomed? I'd be happy to tweak the
implementation, and add docs, tests, and a config option like
merge.stat. Just wanted to check the mood first :)

git-pull.sh   |    2 +-
 git-rebase.sh |    5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 75c3610..12e0ae8 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -179,7 +179,7 @@ fi
=20
 merge_name=3D$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || e=
xit
 test true =3D "$rebase" &&
-	exec git-rebase $strategy_args --onto $merge_head \
+	exec git-rebase $no_stat $strategy_args --onto $merge_head \
 	${oldremoteref:-$merge_head}
 exec git-merge $no_stat $no_commit $squash $no_ff $log_arg $strategy_a=
rgs \
 	"$merge_name" HEAD $merge_head
diff --git a/git-rebase.sh b/git-rebase.sh
index 528b604..9940eea 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -257,9 +257,12 @@ do
 		esac
 		do_merge=3Dt
 		;;
-	-v|--verbose)
+	-v|--verbose|--stat|--summary)
 		verbose=3Dt
 		;;
+	-n|--no-stat)
+		verbose=3D
+		;;
 	--whitespace=3D*)
 		git_am_opt=3D"$git_am_opt $1"
 		;;
--=20
1.6.1.GIT
