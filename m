From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 3/5] gitweb: use_pathinfo filenames start with /
Date: Mon, 13 Oct 2008 12:19:23 +0200
Message-ID: <1223893165-26022-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1223893165-26022-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1223893165-26022-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1223893165-26022-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 13 12:20:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpKXa-0003aN-N7
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 12:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763405AbYJMKTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 06:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763190AbYJMKTa
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 06:19:30 -0400
Received: from ik-out-1112.google.com ([66.249.90.183]:31420 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763189AbYJMKT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 06:19:28 -0400
Received: by ik-out-1112.google.com with SMTP id c30so1116584ika.5
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 03:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xPH8l+FnKIfgEaArqixQ0oCaJd/vw31v7lxAqevV19A=;
        b=ESc+edNiOYih4PtcGvfPPUpF3t2lIST7RxXRAjCAWX67A43+WkhSQAnarA8LedqoU4
         bYr7Cd5PhdulrKNxbFf+QIVLkVLsE38RcJtTEPCaIY6qYroUMvtNU9DI6/osklJkv9gV
         z2ROUmY2AKsMNOnTE0Mix1y3c18HEgkpWs97M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JPqUtEk9eUsiDjKJlrnRfW/+oKvlSTqQUJiKh/pxKmMg8G3uA4LXHna8YmgPlF7nL0
         QgcqiUwDmTpVU7EIAg+qowAJP8N8wwqofTJz+JnMVyo9dDk5fQXsx78wDuSMGu81BALc
         nU+Df0NwB9VHlnAo9bsxK/G3bKFKVp9nkBFz0=
Received: by 10.210.62.12 with SMTP id k12mr5266684eba.112.1223893165867;
        Mon, 13 Oct 2008 03:19:25 -0700 (PDT)
Received: from localhost ([78.15.14.149])
        by mx.google.com with ESMTPS id 5sm9547623eyh.2.2008.10.13.03.19.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Oct 2008 03:19:25 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1223893165-26022-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98102>

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
