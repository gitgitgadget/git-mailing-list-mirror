From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: [PATCH] blameview: Use git-cat-file to read the file content.
Date: Tue, 30 Jan 2007 13:26:49 +0530
Message-ID: <45befa5a.3eba48a4.1e16.ffffabd9@mx.google.com>
References: <11701438112263-git-send-email->
Cc: junkio@cox.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 30 08:57:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBnrr-0008LJ-Bi
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 08:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965439AbXA3H5R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 02:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965437AbXA3H5Q
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 02:57:16 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:22180 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965439AbXA3H5P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 02:57:15 -0500
Received: by py-out-1112.google.com with SMTP id a29so949562pyi
        for <git@vger.kernel.org>; Mon, 29 Jan 2007 23:57:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:x-mailer:in-reply-to:references:message-id;
        b=FW2/zmq8c0B6uym/uNh+v8uOSsryHEbAbhLNtx3VNltzy6E8xZJ/CduhYxowoU2IBdbjc5niPn7fDChVNBsk2tyYwOlj5pQT3YuCxWAXxHIX3XaQSVLFDKZRlTov99McEDueY6KJQht+mt2COLFgQUReIyAnFWs5sIKfa3LAnMc=
Received: by 10.35.69.11 with SMTP id w11mr14494926pyk.1170143834762;
        Mon, 29 Jan 2007 23:57:14 -0800 (PST)
Received: from localhost ( [59.92.165.143])
        by mx.google.com with ESMTP id f6sm7280806pyh.2007.01.29.23.57.10;
        Mon, 29 Jan 2007 23:57:14 -0800 (PST)
X-Mailer: git-send-email 1.5.0.rc2.75.gdbaa0-dirty
In-Reply-To: <11701438112263-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38130>

From: Aneesh Kumar K.V <aneesh.kumar@gmail.com> - unquoted

Fix blameview to use git-cat-file to read the file content.
This make sure we show the right content when we have modified
file in the working directory which is not committed.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 contrib/blameview/blameview.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/contrib/blameview/blameview.perl b/contrib/blameview/blameview.perl
index e8bcb1b..8261e47 100755
--- a/contrib/blameview/blameview.perl
+++ b/contrib/blameview/blameview.perl
@@ -28,7 +28,8 @@ $fileview->get_column(0)->set_spacing(0);
 $fileview->set_size_request(1024, 768);
 $fileview->set_rules_hint(1);
 
-open(my $fh, '<', $fn)
+my $fh;
+open($fh, '-|', "git cat-file blob HEAD:$fn")
   or die "unable to open $fn: $!";
 while(<$fh>) {
   chomp;
-- 
1.5.0.rc2.75.gdbaa0-dirty
