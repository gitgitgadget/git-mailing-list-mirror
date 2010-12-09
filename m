From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 5/8] git-gui: move 3way diff autodetect up
Date: Thu,  9 Dec 2010 21:47:56 +0100
Message-ID: <96986a5a805579d1e341fd0f5fa44ccf9b98b312.1291927657.git.bert.wesarg@googlemail.com>
References: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
 <56141ad4622dfc1ee991c9ee3be90dbf3e99b744.1291927657.git.bert.wesarg@googlemail.com>
 <ae1d2af4dad878c54959a72989cb170376b7fb95.1291927657.git.bert.wesarg@googlemail.com>
 <cc7284fbd48c589af26dd8f3905fb4244fedbfda.1291927657.git.bert.wesarg@googlemail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Dec 09 21:48:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQnPp-0003RY-LA
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 21:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757117Ab0LIUsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 15:48:19 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:50756 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757196Ab0LIUsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 15:48:16 -0500
Received: by mail-fx0-f43.google.com with SMTP id 18so2916089fxm.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 12:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=DlN3Bgl4tE8OsYmMxMUkOWSNL83C7xhjJ5NojLxPRQ8=;
        b=IgkUtTx9UxQdifPUcK7BRxWnlTtsFKi92V2HlmknRN6zyXDOLjSsOha/cjofv8AlFa
         NOHpjTO8Tfj2id9kcl7GlVfUCk3vfASireLLqDTZo5yW6vX1rwAUmQzenXyfFX30d9y1
         FDzNAICmSCpKMdnFsYjxUiDOX+FjLvCsT4Ks8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=coTZOzFEjr1FQi8a7MPpIDnpice3/y0XtYftGpNIu+ImMTmW9tYBX2muSKNY37nUav
         HUQ2LK3ukVp9s8Ad0rmMkaxf1Cl02KNDSIvFMiDPv7oy/XMQm8w/zRbhDNdS9LeY8l6h
         3+UEuUeBxXsQ0cCmKOqkPovdBQ9hhkafYm/Lg=
Received: by 10.223.79.13 with SMTP id n13mr4635472fak.139.1291927695757;
        Thu, 09 Dec 2010 12:48:15 -0800 (PST)
Received: from localhost (p3E990761.dip.t-dialin.net [62.153.7.97])
        by mx.google.com with ESMTPS id n15sm690395fam.36.2010.12.09.12.48.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 12:48:14 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.1200.ge4bf6
In-Reply-To: <cc7284fbd48c589af26dd8f3905fb4244fedbfda.1291927657.git.bert.wesarg@googlemail.com>
In-Reply-To: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
References: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163320>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 lib/diff.tcl |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index 20f50dd..2290919 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -393,6 +393,10 @@ proc read_diff {fd conflict_size cont_info} {
 		#
 		if {[regexp {^@@+ } $line]} {set ::current_diff_inheader 0}
 
+		# -- Automatically detect if this is a 3 way diff.
+		#
+		if {[string match {@@@ *} $line]} {set is_3way_diff 1}
+
 		if {$::current_diff_inheader} {
 			append current_diff_header $line "\n"
 
@@ -413,9 +417,6 @@ proc read_diff {fd conflict_size cont_info} {
 		}
 
 
-		# -- Automatically detect if this is a 3 way diff.
-		#
-		if {[string match {@@@ *} $line]} {set is_3way_diff 1}
 
 		if {[string match {new file *} $line]
 			|| [regexp {^(old|new) mode *} $line]
-- 
1.7.3.2.1200.ge4bf6
