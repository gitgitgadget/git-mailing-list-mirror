From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 3/8] git-gui: name also new symlinks so
Date: Thu,  9 Dec 2010 21:47:54 +0100
Message-ID: <ae1d2af4dad878c54959a72989cb170376b7fb95.1291927657.git.bert.wesarg@googlemail.com>
References: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
 <56141ad4622dfc1ee991c9ee3be90dbf3e99b744.1291927657.git.bert.wesarg@googlemail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Dec 09 21:48:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQnPn-0003RY-Bp
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 21:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756655Ab0LIUsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 15:48:12 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:50756 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756838Ab0LIUsL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 15:48:11 -0500
Received: by fxm18 with SMTP id 18so2916089fxm.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 12:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=zpoZ0BHljW7Y2xdHvMhUlcQ56prpHp8dnRkCkKRCF5M=;
        b=lyvqCF5VbHz96fUluQyDEmyOGkKeKyabGlqjrpYb2AEPJoZCkNwFt3aY7GGzJpaxyC
         yGNkMxfF7WG07fZM41uWv/z2jVYdwiFnw2TuNQfVi+7Lqly9msRlb84UsqBoKB69nchs
         KoBV7vG6gbqmpxxdsy09cYqEcxyPArxjQmcTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MqnGjvq6iveaQFxwo5hSc7evmFKl2d+M2ZOOoVD7TeMEvQAhxVSKRoZ9WprlzHxDyI
         dtU3vjBtevjER5poAwS4ROFky3gEfIQK+srWhdpgdpz1yOVPmtWg7BRwp5SjS2s6XtoM
         YXw/c0WR2vMnK+HhbdT+ZoTSN8/iEgmftMgyk=
Received: by 10.223.123.195 with SMTP id q3mr8826975far.35.1291927689671;
        Thu, 09 Dec 2010 12:48:09 -0800 (PST)
Received: from localhost (p3E990761.dip.t-dialin.net [62.153.7.97])
        by mx.google.com with ESMTPS id a6sm8958fak.3.2010.12.09.12.48.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 12:48:08 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.1200.ge4bf6
In-Reply-To: <56141ad4622dfc1ee991c9ee3be90dbf3e99b744.1291927657.git.bert.wesarg@googlemail.com>
In-Reply-To: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
References: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163318>

and rename them only in the diff header

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 lib/diff.tcl |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index 0b72924..aa30089 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -406,12 +406,13 @@ proc read_diff {fd conflict_size cont_info} {
 			    || [string match {index *}           $line]} {
 				continue
 			}
-		}
 
-		if {$line eq {deleted file mode 120000}} {
-			set line "deleted symlink"
+			# -- Name it symlink, not 120000
+			#    Note, that the original line is in $current_diff_header
+			regsub {^(deleted|new) file mode 120000} $line {\1 symlink} line
 		}
 
+
 		# -- Automatically detect if this is a 3 way diff.
 		#
 		if {[string match {@@@ *} $line]} {set is_3way_diff 1}
@@ -421,6 +422,7 @@ proc read_diff {fd conflict_size cont_info} {
 			|| [regexp {^(old|new) mode *} $line]
 			|| [string match {deleted file *} $line]
 			|| [string match {deleted symlink} $line]
+			|| [string match {new symlink} $line]
 			|| [string match {Binary files * and * differ} $line]
 			|| $line eq {\ No newline at end of file}
 			|| [regexp {^\* Unmerged path } $line]} {
-- 
1.7.3.2.1200.ge4bf6
