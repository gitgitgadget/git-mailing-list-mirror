From: Sergey Vlasov <vsu@altlinux.ru>
Subject: gitk: Fix restoring of column widths in the commit tree
Date: Sun, 11 Feb 2007 19:58:33 +0300
Message-ID: <11712131153045-git-send-email-vsu@altlinux.ru>
References: <20070211195643.b1f548f2.vsu@altlinux.ru> <117121311393-git-send-email-vsu@altlinux.ru>
Cc: git@vger.kernel.org, Sergey Vlasov <vsu@altlinux.ru>
To: Mark Levedahl <mdl123@verizon.net>,
	Junio C Hamano <junkio@cox.net>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Feb 11 17:59:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGI2o-0004LP-J0
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 17:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbXBKQ6s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 11:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbXBKQ6s
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 11:58:48 -0500
Received: from master.altlinux.org ([62.118.250.235]:2048 "EHLO
	master.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbXBKQ6r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 11:58:47 -0500
Received: by master.altlinux.org (Postfix, from userid 584)
	id 06442E3F71; Sun, 11 Feb 2007 19:58:46 +0300 (MSK)
X-Mailer: git-send-email 1.5.0.rc4.50.g403de
In-Reply-To: <117121311393-git-send-email-vsu@altlinux.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39296>

On Linux with Tk 8.4.13 after each gitk restart the column dividers
were shifting more and more to the right.  Apparently the value from
[winfo width $canv] is larger than the value of the -width option
specified when creating the widget due to non-zero -highlightthickness
used by default.  But gitk never shows the focus highlight on canvases
used for the commit tree, so we can just set "-highlightthickness 0",
which fixes the width mismatch.

(The code before commit 3468e71f452701b3eff6a2aeb826bbe0cdad8270
subtracted 2 from widths of canvases when saving them - apparently to
account for that hidden highlightthickness; I suppose that Cygwin
behaves differently - hope that "-highlightthickness 0" will give
proper results everywhere.)

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---
 gitk |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 7e6ee56..ea3d68a 100755
--- a/gitk
+++ b/gitk
@@ -459,14 +459,17 @@ proc makewindow {} {
     set canv .tf.histframe.pwclist.canv
     canvas $canv -width $geometry(canv) \
 	-background $bgcolor -bd 0 \
+	-highlightthickness 0 \
 	-yscrollincr $linespc -yscrollcommand "scrollcanv $cscroll"
     .tf.histframe.pwclist add $canv
     set canv2 .tf.histframe.pwclist.canv2
     canvas $canv2 -width $geometry(canv2) \
+	-highlightthickness 0 \
 	-background $bgcolor -bd 0 -yscrollincr $linespc
     .tf.histframe.pwclist add $canv2
     set canv3 .tf.histframe.pwclist.canv3
     canvas $canv3 -width $geometry(canv3) \
+	-highlightthickness 0 \
 	-background $bgcolor -bd 0 -yscrollincr $linespc
     .tf.histframe.pwclist add $canv3
 
-- 
1.5.0.rc4.50.g403de
