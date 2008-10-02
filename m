From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4] gitweb: use_pathinfo filenames start with /
Date: Thu,  2 Oct 2008 02:10:32 +0200
Message-ID: <1222906234-8182-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1222906234-8182-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1222906234-8182-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1222906234-8182-4-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 02:11:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlBnK-00017h-6u
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 02:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923AbYJBAKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 20:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752969AbYJBAKQ
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 20:10:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:48915 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbYJBAKO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 20:10:14 -0400
Received: by nf-out-0910.google.com with SMTP id d3so341125nfc.21
        for <git@vger.kernel.org>; Wed, 01 Oct 2008 17:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8geiwcnSZvBdy7MplQhiKAj0BUMfrw2aPiaZ9T7BoAo=;
        b=d7Lrymll/H7beEberGVzGCxJkHvSK96PUqNyyH0S82PbMjMklclO6nK4GGykh2lzGn
         /8so8q6QAdONtxDLjpNnzwAhwImQ6BwV6NfFkNiaaTt1KS3hTHzQ3Z6fQYJDRV0fCQNf
         lLzy1nZFHJbk2MmhrsPzVnxetzCHc5aqAy9h8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wmqFXnkatfBzkEwCPbHTNZH9ir11+hb3Pcf/LtDQWTfcCGkSF/vHBawEySA1RIsrLz
         BisvyyPE0CR+BijjN1i5FKCNxM4YP4eC8kd5SDKQcFWkfW9sQahrKgbQmcIPY5Szeq/b
         /VZJMqFSOYOl9yvmABNelfkaA4DdUioDtAXyA=
Received: by 10.210.39.2 with SMTP id m2mr10492156ebm.97.1222906213526;
        Wed, 01 Oct 2008 17:10:13 -0700 (PDT)
Received: from localhost ([78.15.6.228])
        by mx.google.com with ESMTPS id 5sm1121321eyf.8.2008.10.01.17.10.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Oct 2008 17:10:12 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1222906234-8182-4-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97282>

When using path info, make filenames start with a / (right after the :
that separates them from the hash base). This minimal change allows
relative navigation to work properly when viewing HTML files.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2c380ac..3e5b2b7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -690,7 +690,7 @@ sub href (%) {
 		# try to put as many parameters as possible in PATH_INFO:
 		#   - project name
 		#   - action
-		#   - hash or hash_base:filename
+		#   - hash or hash_base:/filename
 
 		# Strip any trailing / from $href, or we might get double
 		# slashes when the script is the DirectoryIndex
@@ -708,11 +708,11 @@ sub href (%) {
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
