From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 7/8] git-gui: handle special content lines only in the diff header section
Date: Thu,  9 Dec 2010 21:47:58 +0100
Message-ID: <6581252c19fb2c89a7f2d3e77e62b32f689d5e38.1291927657.git.bert.wesarg@googlemail.com>
References: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
 <56141ad4622dfc1ee991c9ee3be90dbf3e99b744.1291927657.git.bert.wesarg@googlemail.com>
 <ae1d2af4dad878c54959a72989cb170376b7fb95.1291927657.git.bert.wesarg@googlemail.com>
 <cc7284fbd48c589af26dd8f3905fb4244fedbfda.1291927657.git.bert.wesarg@googlemail.com>
 <96986a5a805579d1e341fd0f5fa44ccf9b98b312.1291927657.git.bert.wesarg@googlemail.com>
 <83035737417287ef9f1ad246e269f0e31dbe5e03.1291927657.git.bert.wesarg@googlemail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Dec 09 21:48:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQnPq-0003RY-OL
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 21:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757232Ab0LIUsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 15:48:23 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:50756 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757223Ab0LIUsV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 15:48:21 -0500
Received: by mail-fx0-f43.google.com with SMTP id 18so2916089fxm.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 12:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=dXwVm3H6K8FGTEjAqoifjyTsNqMmnxycwrcMhfvhVp8=;
        b=cWYP0ukPy0k6lM6uw1r1/biJu2SjlcUS/BOMYX7fOOS3wh5Q7+XpT2JVSZq0KIwFPH
         BmVOrX8WxjS7xdbq8Piq2psuUSRZlWOucVF9FVciWGQzNbSdXUzWdm3aYccWZD+sCZV5
         9n7EiE8EcDdXcWWJsccFF8ZJBJnjw+DEVpCRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mZ7+bR/BFFFGTJCIjnnH/4dAcwCPjfbDmtt81ISQf9wO9FyuOca9SFHNE7Ljauii3+
         qcMNr1XrParHLq52RceMedGGmN/YiF3PoRuBsXQ6WYATGUTH/x7FJ+ed1Q7LJO3EQCB1
         k4iLNaSmNLANxVc0v2hQ6sUiVBnXN5TExK2MU=
Received: by 10.223.72.4 with SMTP id k4mr3145575faj.97.1291927700997;
        Thu, 09 Dec 2010 12:48:20 -0800 (PST)
Received: from localhost (p3E990761.dip.t-dialin.net [62.153.7.97])
        by mx.google.com with ESMTPS id k6sm694367faa.6.2010.12.09.12.48.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 12:48:20 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.1200.ge4bf6
In-Reply-To: <83035737417287ef9f1ad246e269f0e31dbe5e03.1291927657.git.bert.wesarg@googlemail.com>
In-Reply-To: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
References: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163317>

These two also stop the diff header.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 lib/diff.tcl |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index 91ed7c6..4eaf7e7 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -400,7 +400,14 @@ proc read_diff {fd conflict_size cont_info} {
 		if {[string match {@@@ *} $line]} {set is_3way_diff 1}
 
 		if {$::current_diff_inheader} {
-			append current_diff_header $line "\n"
+
+			# -- These two lines stop a diff header and shouldn't be in there
+			if {   [string match {Binary files * and * differ} $line]
+			    || [regexp {^\* Unmerged path }                $line]} {
+				set ::current_diff_inheader 0
+			} else {
+				append current_diff_header $line "\n"
+			}
 
 			# -- Cleanup uninteresting diff header lines.
 			#
@@ -418,16 +425,12 @@ proc read_diff {fd conflict_size cont_info} {
 			regsub {^(deleted|new) file mode 120000} $line {\1 symlink} line
 		}
 
-
-
 		if {[string match {new file *} $line]
 			|| [regexp {^(old|new) mode *} $line]
 			|| [string match {deleted file *} $line]
 			|| [string match {deleted symlink} $line]
 			|| [string match {new symlink} $line]
-			|| [string match {Binary files * and * differ} $line]
-			|| $line eq {\ No newline at end of file}
-			|| [regexp {^\* Unmerged path } $line]} {
+			|| $line eq {\ No newline at end of file}} {
 		} elseif {$is_3way_diff} {
 			set op [string range $line 0 1]
 			switch -- $op {
-- 
1.7.3.2.1200.ge4bf6
