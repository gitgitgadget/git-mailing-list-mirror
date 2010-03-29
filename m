From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: [PATCH 1/2] gitweb: dirty patch to make url rewriting involving '+' working
Date: Tue, 30 Mar 2010 00:34:02 +0200
Message-ID: <1269902043-11134-2-git-send-email-sylvain@abstraction.fr>
References: <7v39zmnceq.fsf@alter.siamese.dyndns.org>
 <1269902043-11134-1-git-send-email-sylvain@abstraction.fr>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sylvain Rabot <sylvain@abstraction.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 30 00:34:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwNXB-0004cr-As
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 00:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164Ab0C2WeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 18:34:08 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:37911 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250Ab0C2WeF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 18:34:05 -0400
Received: by bwz1 with SMTP id 1so3962639bwz.21
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 15:34:04 -0700 (PDT)
Received: by 10.204.136.156 with SMTP id r28mr722081bkt.112.1269902044198;
        Mon, 29 Mar 2010 15:34:04 -0700 (PDT)
Received: from localhost.localdomain (smj33-1-82-233-66-33.fbx.proxad.net [82.233.66.33])
        by mx.google.com with ESMTPS id a11sm41874051bkc.21.2010.03.29.15.34.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Mar 2010 15:34:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3
In-Reply-To: <1269902043-11134-1-git-send-email-sylvain@abstraction.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143524>

CGI::url method replaces '+' character by '%20', this patch reverts
this behavior to make url rewriting involving '+' in the base url working

Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
---
 gitweb/gitweb.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a2d2283..486996e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -33,6 +33,10 @@ our $version = "++GIT_VERSION++";
 our $my_url = $cgi->url();
 our $my_uri = $cgi->url(-absolute => 1);
 
+# dirty patch to make url rewriting with '+' character working
+$my_url =~ s/(.*)%20(.*)/$1+$2/g;
+$my_uri =~ s/(.*)%20(.*)/$1+$2/g;
+
 # Base URL for relative URLs in gitweb ($logo, $favicon, ...),
 # needed and used only for URLs with nonempty PATH_INFO
 our $base_url = $my_url;
-- 
1.7.0.3
