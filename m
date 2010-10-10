From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 3/3] bisect: check for mandatory argument of 'bisect replay'
Date: Sun, 10 Oct 2010 23:48:58 +0200
Message-ID: <1286747338-8521-3-git-send-email-szeder@ira.uka.de>
References: <1286747338-8521-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 23:49:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P53ls-0006zp-HY
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 23:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000Ab0JJVtT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 17:49:19 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:53422 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab0JJVtT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 17:49:19 -0400
Received: from [127.0.1.1] (p5B130D54.dip0.t-ipconnect.de [91.19.13.84])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MV0jR-1PD3ZQ0wN3-00YvaK; Sun, 10 Oct 2010 23:49:09 +0200
X-Mailer: git-send-email 1.7.3.1.148.g2fffa
In-Reply-To: <1286747338-8521-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:RkfrvhK2zdkd6nziXBsTlRXXj1XCRtdI6XAOJ1HrcKL
 u90DoFD+ep65hbYR6Fr0e58uiHHmFZrzR+QpQwAbbXmGLjNogK
 s25GkVlJxYRSAtupAa4ggAz+PBPZuGT6Z4zrpd9P/zSH2xtU5r
 X0lbUWXxMSjx0ig80O3exL3T0OUHPZXpGv9sUEN9OxRbBGJYQb
 2eAMtQNeZO439gwdbK3cQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158719>

'git bisect replay' has a mandatory logfile argument, but the current
implementation doesn't check whether the user has specified one.  When
the user omits the logfile argument, this leads to the following
unhelpful error message:

  cannot read  for replaying

So, check for the mandatory argument first, and provide a more
meaningful error message when it is omitted.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 git-bisect.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 68fcff6..c21e33c 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -343,6 +343,7 @@ bisect_clean_state() {
 }
=20
 bisect_replay () {
+	test "$#" -eq 1 || die "No logfile given"
 	test -r "$1" || die "cannot read $1 for replaying"
 	bisect_reset
 	while read git bisect command rev
--=20
1.7.3.1.148.g2fffa
