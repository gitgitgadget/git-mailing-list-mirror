From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4 1/2] gitweb: make static files accessible with PATH_INFO
Date: Wed, 28 Jan 2009 11:50:31 +0100
Message-ID: <1233139832-24124-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 11:52:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS81a-0003DL-N9
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 11:52:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbZA1Kuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 05:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbZA1Kuf
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 05:50:35 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:55486 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbZA1Kue (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 05:50:34 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1278108nfc.21
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 02:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=rUUbW17/RGXrqY1x7yoyeXsRTw3GPbQF86VG9kNLLQA=;
        b=RO9GptGINAilC5Cp8JEXWzAELFsLThNW6c+9F/5hdHKD+oZ/OIgNziNoccOwCYk/1I
         B7RGoZVW7RogxLAe01V+egl2CeqHEy6Xk2bw13BK3GS2NsRg2Wy3IMJiYL8SEIddFc+W
         SbRPIayGYE2ojny81D60qXbH7Ae57rxREwhyw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=frP0tYlQRZuK3aGP80jtBvob4ln3REf6rov7Oq4ooGJOUEWB2xtwOlgelxEHCy8lE1
         682BIk4EdC7BYlcbZdOcCfYmfDWGfXeBOsNdJ8P1fgsk7V81u5bTeDJCv4I/O/brEX7U
         duuMEhW6i0Ly0KhJTXkoI9MmjvJ4Ij9TELC7E=
Received: by 10.102.228.10 with SMTP id a10mr2678783muh.26.1233139832490;
        Wed, 28 Jan 2009 02:50:32 -0800 (PST)
Received: from localhost ([94.37.14.37])
        by mx.google.com with ESMTPS id 14sm4318132muo.39.2009.01.28.02.50.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jan 2009 02:50:31 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107526>

When gitweb is invoked with PATH_INFO and links to static files such as
the CSS and favicon/shortcut icon are relative URLs with relative paths
(as is the case when using the default Makefile), these files are not
accessible beyond the project list and summary page (e.g. in shortlog or
commit view).

Fix this by adding a <base> tag pointing to the script's own URL, that
ensure that all relative paths will be based on this.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 931db4f..f7aaf9a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2901,6 +2901,11 @@ sub git_header_html {
 <meta name="robots" content="index, nofollow"/>
 <title>$title</title>
 EOF
+# the stylesheet, favicon etc urls won't work correctly with path_info unless we
+# set the appropriate base URL
+	if ($ENV{'PATH_INFO'}) {
+		print "<base href='".esc_url($my_url)."' />\n";
+	}
 # print out each stylesheet that exist
 	if (defined $stylesheet) {
 #provides backwards capability for those people who define style sheet in a config file
-- 
1.5.6.5
