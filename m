From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 3/5] gitweb: use_pathinfo filenames start with /
Date: Tue, 21 Oct 2008 21:34:52 +0200
Message-ID: <1224617694-29277-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1224617694-29277-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1224617694-29277-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1224617694-29277-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 21:36:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsN1l-0004hL-5j
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 21:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303AbYJUTek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 15:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219AbYJUTek
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 15:34:40 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:64243 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbYJUTej (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 15:34:39 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2671110fkq.5
        for <git@vger.kernel.org>; Tue, 21 Oct 2008 12:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=9IkuNUlKt88jgQQnRaa8aCPoTavpP43HmxcHSI8Fx9A=;
        b=Pq552TAANVlkWBb2XYU7UIiwA+6VOSclHKBHk0kj384crI/EzN02ORgsrzDkf2uJCw
         42SgmZBIV9ALdoU1hB9PfTNMlkQaN4Dvl8WIngKl0wx6UBOQxQCZN69gwH0viHnt4fFn
         QBM9JQ2LI6+tqHOPb6/aBRFISpXJNDXC/ubwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KoEAeMyulXsECCWG1vuq9SRB3GrYxwKruGZ1SD9IaWJwM3xKfoegB4FtMf34eZmabk
         KwvXJOhHcQYsa08qmO2us4CiukcqYsJ/fp0D25apl8HDBxePxJZ1YonOMrxF7TCUctCE
         3Hhchp9vGu6Yr7sBqga58kao8UzUPXtM+METs=
Received: by 10.181.60.13 with SMTP id n13mr3058496bkk.39.1224617677670;
        Tue, 21 Oct 2008 12:34:37 -0700 (PDT)
Received: from localhost ([94.37.30.171])
        by mx.google.com with ESMTPS id y15sm10156373fkd.17.2008.10.21.12.34.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Oct 2008 12:34:36 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1224617694-29277-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98813>

Generate PATH_INFO URLs in the form project/action/hash_base:/filename
rather than project/action/hash_base:filename (the latter form is still
accepted in input).

This minimal change allows relative navigation to work properly when
viewing HTML files in raw ('blob_plain') mode.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 27587aa..9da547d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -734,7 +734,7 @@ sub href (%) {
 		# try to put as many parameters as possible in PATH_INFO:
 		#   - project name
 		#   - action
-		#   - hash or hash_base:filename
+		#   - hash or hash_base:/filename
 
 		# When the script is the root DirectoryIndex for the domain,
 		# $href here would be something like http://gitweb.example.com/
@@ -753,11 +753,11 @@ sub href (%) {
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
