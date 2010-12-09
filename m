From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 6/8] git-gui: always reset the current tag
Date: Thu,  9 Dec 2010 21:47:57 +0100
Message-ID: <83035737417287ef9f1ad246e269f0e31dbe5e03.1291927657.git.bert.wesarg@googlemail.com>
References: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
 <56141ad4622dfc1ee991c9ee3be90dbf3e99b744.1291927657.git.bert.wesarg@googlemail.com>
 <ae1d2af4dad878c54959a72989cb170376b7fb95.1291927657.git.bert.wesarg@googlemail.com>
 <cc7284fbd48c589af26dd8f3905fb4244fedbfda.1291927657.git.bert.wesarg@googlemail.com>
 <96986a5a805579d1e341fd0f5fa44ccf9b98b312.1291927657.git.bert.wesarg@googlemail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Dec 09 21:48:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQnPq-0003RY-6j
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 21:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757222Ab0LIUsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 15:48:20 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:50756 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199Ab0LIUsT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 15:48:19 -0500
Received: by mail-fx0-f43.google.com with SMTP id 18so2916089fxm.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 12:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=NJA69CZjHPzzYALGmvow2czS3jI2uSSqTJGefKCHGMs=;
        b=YnOOq5TBbibF7wd/M2ZkGVfdGBF92hUgJbCCDmuCzTsCuq9Fuw1P2X+6SS/dj4grDC
         FtE6Za+jCOdyUCY8A4E9XNeV5suCxtjBaH95FUgQ1QTu7408ckkKZth2ZXNDVzKBBMUe
         ccm1ZX1Fp+4zVsMBUmWV/LEXvypcDhM44AwDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xzPR2LnNn85INKBn35EXUPDhukxTMMlj4nLnioA9PyXDYX7f/4dRkbBSxQ+syx+V3D
         rBbqzzLFubDyEmvIVMC9uVgIvAE2LxlvxIe+bL57pPIcEw+WzHaY8ZHjldJSX7qwNYti
         3xCjymRi/vCKWwaVm/TpVVNLlG8remyOxl7B8=
Received: by 10.223.125.68 with SMTP id x4mr2417789far.65.1291927698295;
        Thu, 09 Dec 2010 12:48:18 -0800 (PST)
Received: from localhost (p3E990761.dip.t-dialin.net [62.153.7.97])
        by mx.google.com with ESMTPS id n15sm691349fam.12.2010.12.09.12.48.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 12:48:17 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.1200.ge4bf6
In-Reply-To: <96986a5a805579d1e341fd0f5fa44ccf9b98b312.1291927657.git.bert.wesarg@googlemail.com>
In-Reply-To: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
References: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163315>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 lib/diff.tcl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index 2290919..91ed7c6 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -382,6 +382,8 @@ proc read_diff {fd conflict_size cont_info} {
 		foreach {line markup} [parse_color_line $line] break
 		set line [string map {\033 ^} $line]
 
+		set tags {}
+
 		# -- Check for start of diff header.
 		if {   [string match {diff --git *}      $line]
 		    || [string match {diff --cc *}       $line]
@@ -426,7 +428,6 @@ proc read_diff {fd conflict_size cont_info} {
 			|| [string match {Binary files * and * differ} $line]
 			|| $line eq {\ No newline at end of file}
 			|| [regexp {^\* Unmerged path } $line]} {
-			set tags {}
 		} elseif {$is_3way_diff} {
 			set op [string range $line 0 1]
 			switch -- $op {
-- 
1.7.3.2.1200.ge4bf6
