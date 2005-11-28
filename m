From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH] git-mv: fully detect 'directory moved into itself'
Date: Mon, 28 Nov 2005 10:15:15 +0100
Message-ID: <200511281015.15188.Josef.Weidendorfer@gmx.de>
References: <200511272206.43113.Josef.Weidendorfer@gmx.de> <pan.2005.11.28.06.54.32.809941@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Nov 28 10:16:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Egf6c-0000Au-2M
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 10:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVK1JPV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 04:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbVK1JPV
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 04:15:21 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:60659 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1750834AbVK1JPU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 04:15:20 -0500
Received: from dhcp-3s-61.lrr.in.tum.de (dhcp-3s-61.lrr.in.tum.de [131.159.35.61])
	by mail.in.tum.de (Postfix) with ESMTP id E08A12841;
	Mon, 28 Nov 2005 10:15:16 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.9
In-Reply-To: <pan.2005.11.28.06.54.32.809941@smurf.noris.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12864>

This gives a better error message when trying to move a directory
into some subdirectory of itself; ie. no real bug fix: renaming
already failed before, but with a strange "invalid argument".

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>

---

This is a corrected version.

On Monday 28 November 2005 07:54, Matthias Urlichs wrote:
> Hi, Josef Weidendorfer wrote:
> 
> > +    if (($bad eq "") && ($dst =~ /^$src\//)) {
> 
> That should be
> 
> > +    if (($bad eq "") && ($dst =~ /^\Q$src\E\//)) {
> 
> otherwise you will mistakenly match "foo-bar" with "foo.bar".
> 

Ah, thanks.
You never end learning.

Josef


 git-mv.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 5d83477de7a407ab0ef183c6676114e1a507cf86
3c1ed8adaff3f7492ef2afdb5585ae7412a02817
diff --git a/git-mv.perl b/git-mv.perl
index ac19876..bfe3c29 100755
--- a/git-mv.perl
+++ b/git-mv.perl
@@ -108,7 +108,7 @@ while(scalar @srcArgs > 0) {
 	}
     }
     
-    if (($bad eq "") && ($src eq $dstDir)) {
+    if (($bad eq "") && ($dst =~ /^\Q$src\E\//)) {
 	$bad = "can not move directory '$src' into itself";
     }
 
---
0.99.9.GIT
