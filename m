From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 3/5] gitweb: use_pathinfo filenames start with /
Date: Thu, 16 Oct 2008 22:27:09 +0200
Message-ID: <1224188831-17767-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1224188831-17767-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1224188831-17767-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1224188831-17767-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 22:28:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqZSM-0000ID-6Z
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 22:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571AbYJPU1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 16:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754375AbYJPU1K
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 16:27:10 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:37054 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146AbYJPU1I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 16:27:08 -0400
Received: by ey-out-2122.google.com with SMTP id 6so78327eyi.37
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 13:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xPH8l+FnKIfgEaArqixQ0oCaJd/vw31v7lxAqevV19A=;
        b=f6v/5/ZDmNaaS8FCJ8K5ZnZMGZ9zIRT0ZP9y6o6xlOQY+/SdLgNphLD+1jMuPIhvV7
         /tfggGrdWckKztzMPig1dOzdcqIz6RsdxRa+lBAyX63q9By192bjTN2puy3kiU+yRMsE
         gZkhpsiy7cOTF8JgQZx/fU42AG5OkDGUQxfY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=m+EOVuOhNpkmn43vDQc7ujVugKpNJJ74ALeoFBK1A0AJfoNiSAExnHrrBk2f5niN5q
         gsp02gtIm6LppgY0mcpCTtscoCxt46lbHw0e+78UAejjgYxw/ByvSZ0b6R5HuoMvOBiq
         /KqXslNAzpjYLOWR/iBW6vzl1aZNhWAwIZiBo=
Received: by 10.210.77.2 with SMTP id z2mr3389737eba.184.1224188825804;
        Thu, 16 Oct 2008 13:27:05 -0700 (PDT)
Received: from localhost ([94.37.30.171])
        by mx.google.com with ESMTPS id 3sm2567423eyi.5.2008.10.16.13.27.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Oct 2008 13:27:04 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1224188831-17767-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98415>

When using path info, make filenames start with a / (right after the :
that separates them from the hash base). This minimal change allows
relative navigation to work properly when viewing HTML files in raw
('blob_plain') mode.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5337d40..49730f3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -727,7 +727,7 @@ sub href (%) {
 		# try to put as many parameters as possible in PATH_INFO:
 		#   - project name
 		#   - action
-		#   - hash or hash_base:filename
+		#   - hash or hash_base:/filename
 
 		# When the script is the root DirectoryIndex for the domain,
 		# $href here would be something like http://gitweb.example.com/
@@ -746,11 +746,11 @@ sub href (%) {
 			delete $params{'action'};
 		}
 
-		# Finally, we put either hash_base:file_name or hash
+		# Finally, we put either hash_base:/file_name or hash
 		if (defined $params{'hash_base'}) {
 			$href .= "/".esc_url($params{'hash_base'});
 			if (defined $params{'file_name'}) {
-				$href .= ":".esc_url($params{'file_name'});
+				$href .= ":/".esc_url($params{'file_name'});
 				delete $params{'file_name'};
 			}
 			delete $params{'hash'};
-- 
1.5.6.5
