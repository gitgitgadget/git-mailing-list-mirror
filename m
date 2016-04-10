From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 02/21] bisect: allow 'bisect run' if no good commit is known
Date: Sun, 10 Apr 2016 15:18:55 +0200
Message-ID: <1460294354-7031-3-git-send-email-s-beyer@gmx.net>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 15:21:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apFIg-0000Tk-Uq
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590AbcDJNU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:20:57 -0400
Received: from mout.gmx.net ([212.227.17.20]:49530 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753379AbcDJNUK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:20:10 -0400
Received: from fermat.fritz.box ([92.76.224.62]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0LiWzQ-1bNUdH0ZGW-00cfCo; Sun, 10 Apr 2016 15:19:59
 +0200
X-Mailer: git-send-email 2.8.1.137.g522756c
In-Reply-To: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:y7sYHfp/ulCK28DJjrH2/FXc3Y/X+ay85Bp3eekZD5jTFgrZKDO
 Zb6bbXVLaK6oYNfK8kv0sQYhF1X4VhaGoeFwBsV7/zi6s4yW50BYGMU8w4H0hBKHuiH5mCm
 0TRXg7q5xGztLTBU4Lbh5B8ENBkaWZXi/0s3YhDHyzJJ+K47fNrwMB230hMUKUpheyWgBuk
 s7WTRgISep9MTBeswfG3w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i7sq3/oUkaA=:qS2HHhcdF3tjejo42y9hYg
 N0KIUc4Cr0sPCM0NTeuGbt/YfdoYHd3/vo1f1BUZ8qEc4hIya1ko5y9lG8feoz5IfHr9qojD8
 nswTBDjaOmVeK81Kyx5ffhjJ82nHgEn9plI3Gd/BNEiP5J0Ak+PJehjS0wloE64LtS1y89tsL
 43/v0Y6HA0MwB+vANwtSfye9nR3uivdk61vJUsZIqa0fnaUEdNikm/RyCkf0S6g6/btGMH3qh
 f4704JDTLyRtTz+t4aYJUhj5lHVBW5Hqg2e8dpLFgpwQfuwqjm3Ao3PHLL2bj7d2OU/Gno5yB
 LjQ8+80/lbvm5pyhVg4Dl9OBBsvQswr3j9uNLBaCaSXuPf0k3j/LgBBEkE+0ZwRCyqq3XcaON
 sdJPcIssmoN015SY64St0QwMjdr38T7YLo8Nz8psBJ+ktEj/vgQDthxY+K+JhgPAgme1Fb0vd
 7/nHvmhbTeps31Lie12QWsaYSaWkHA5MFuPh36b1BrO88FnRr85WfrcNLKTxXSCpCl7tKIuCK
 T77uY+3JxZVMJTEKjXSYe1yeY0MVSu8DKcO/LqXKm88flvBnY2Y89rotHZfz1Vaa0gtnC1Gm8
 DBA11fki89iV8PLwijGG7uYojsuExiQ+eyVDV1RrudwPSBnuJJp1pncYYDr/6gyPQ4k1NIUCf
 3ykt9LDJg4NOXXpqYBazZbqnjizgakD86Zm9LSZL1YgL0/pOr3LBZMlpLPnyUrIosH01WU9vw
 nUi27xhXDqC9yCOmVTCIK5V1GZlO7quM8h0G+prxqZ8r4Q+NabQwtJx150I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291160>

Now that the documentation talks about bisecting without a good commit
being known, this should also be allowed for "git bisect run".

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

Notes:
    This is a new patch in the patchset.

 git-bisect.sh | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 5c93a27..f44ce1e 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -39,6 +39,8 @@ _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 TERM_BAD=bad
 TERM_GOOD=good
+IF_NO_GOOD=ask
+AUTONEXT=false
 
 bisect_head()
 {
@@ -312,11 +314,11 @@ bisect_next_check() {
 	,,*)
 		: have both $TERM_GOOD and $TERM_BAD - ok
 		;;
-	*,)
+	*,false)
 		# do not have both but not asked to fail - just report.
 		false
 		;;
-	t,,"$TERM_GOOD")
+	t,,ask)
 		# have bad (or new) but not good (or old).  we could bisect although
 		# this is less optimum.
 		eval_gettextln "Warning: bisecting only with a \$TERM_BAD commit." >&2
@@ -331,6 +333,9 @@ bisect_next_check() {
 		fi
 		: bisect without $TERM_GOOD...
 		;;
+	t,,true)
+		:
+		;;
 	*)
 		bad_syn=$(bisect_voc bad)
 		good_syn=$(bisect_voc good)
@@ -343,13 +348,13 @@ revision, you can use \"git bisect next\" to find one." >&2
 }
 
 bisect_auto_next() {
-	bisect_next_check && bisect_next || :
+	bisect_next_check $AUTONEXT && bisect_next || :
 }
 
 bisect_next() {
 	case "$#" in 0) ;; *) usage ;; esac
 	bisect_autostart
-	bisect_next_check $TERM_GOOD
+	bisect_next_check $IF_NO_GOOD
 
 	# Perform all bisection computation, display and checkout
 	git bisect--helper --next-all $(test -f "$GIT_DIR/BISECT_HEAD" && echo --no-checkout)
@@ -478,7 +483,9 @@ bisect_replay () {
 }
 
 bisect_run () {
-	bisect_next_check fail
+	bisect_next_check $IF_NO_GOOD
+	AUTONEXT=true
+	IF_NO_GOOD=true
 
 	while true
 	do
-- 
2.8.1.137.g522756c
