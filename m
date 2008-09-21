From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 6/6] gitweb: prevent double slashes in PATH_INFO hrefs
Date: Sun, 21 Sep 2008 22:57:43 +0200
Message-ID: <1222030663-22540-7-git-send-email-giuseppe.bilotta@gmail.com>
References: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1222030663-22540-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1222030663-22540-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1222030663-22540-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1222030663-22540-5-git-send-email-giuseppe.bilotta@gmail.com>
 <1222030663-22540-6-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Lea Wiemann <lewiemann@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 21 22:59:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhW1a-0002t7-8p
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 22:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbYIUU5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 16:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752723AbYIUU5u
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 16:57:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:19442 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbYIUU5s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 16:57:48 -0400
Received: by nf-out-0910.google.com with SMTP id d3so407275nfc.21
        for <git@vger.kernel.org>; Sun, 21 Sep 2008 13:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=lZLU27pNb/rLjdjoRhq7vXrCVHVPFqIFHcs2rWcI1rU=;
        b=c68XDG8CTZIkTGS7X43XGjlpqNjJaAydrgePyd3YsZdCEZGeIXNpg/ol3zh7Mog9km
         I2MuFiPq1li1PQdX+JuH1gBK9hs2vW+JQny+FYq8v6D2SMms8lhBiP+IzNP2XoTYpcj9
         36MAzGma1n0SLFV6qNpGxI6Yv9puboL/EpFQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mOH1jkn+f369yKJ4YNbPxJo9TFnkpNl6kNzPoiw4BWmPl72YmCAHFHo9XvuwRkVpbv
         28gXNg3Qk14gZBozqPRiZNYBe9SRqzUTwhVxHn0kOQ2sVX1UP+DvlxAWsl84mEhpb2i+
         VqMZ1XAS05d203Jx0buLtkAs+t7Lm4/0hGcng=
Received: by 10.210.30.1 with SMTP id d1mr3833449ebd.57.1222030667175;
        Sun, 21 Sep 2008 13:57:47 -0700 (PDT)
Received: from localhost ( [94.37.17.250])
        by mx.google.com with ESMTPS id 20sm6356434eyc.9.2008.09.21.13.57.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Sep 2008 13:57:46 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1222030663-22540-6-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96438>

When using PATH_INFO in combination with a rewrite rule that hides the
cgi script name, links to projects and/or actions without projects might
be generated with a double slash.

Fix by removing the trailing slash (if present) from $href before
appending PATH_INFO data.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4a91d07..ebab86b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -675,6 +675,8 @@ sub href (%) {
 
 	my ($use_pathinfo) = gitweb_check_feature('pathinfo');
 	if ($use_pathinfo) {
+		$href =~ s,/$,,;
+
 		# use PATH_INFO for project name
 		$href .= "/".esc_url($params{'project'}) if defined $params{'project'};
 		delete $params{'project'};
-- 
1.5.6.5
