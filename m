From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4] gitweb: make static files accessible with PATH_INFO
Date: Wed, 28 Jan 2009 01:52:12 +0100
Message-ID: <1233103932-6325-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 01:53:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRygX-0002JT-HU
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 01:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbZA1AwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 19:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbZA1AwQ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 19:52:16 -0500
Received: from mu-out-0910.google.com ([209.85.134.185]:54246 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbZA1AwP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 19:52:15 -0500
Received: by mu-out-0910.google.com with SMTP id g7so4745933muf.1
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 16:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=X47X6q/wx4V4KIjG4kvLW00jSUWrSjPEmeSI2U1GFbs=;
        b=HB+5s2yDJv7L+28WiewOVLaCwqh5f3xDpjCHXmCULHWcYHvDehgMc7fC3R7bQyuNEj
         xFb9OjGqDrlI4jjfTv0sXMsnO2ElPqlN0M+dlzWuK5bFNpEa/eY2aHyWfpAsKVl8wQFz
         /UlGksBofoGxv0f8QABWe5SVnRdEvdPnJ6EL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=pKcwEP3PrvMtuNaSQoIBxpXOr1UNBVP8/L0GVsdj93iR3IXBp3VkrZ0O1iU7h8PCZp
         5ak2J789TgEZPxWGIXG/6EdejVra/eDY27ceeq13L64RsycphVsVZE/FNNsgellaGT8F
         vVC57BI6PK8CTjI6Xv+wpn5nqNtedqgrKgkW4=
Received: by 10.103.160.10 with SMTP id m10mr716487muo.50.1233103933152;
        Tue, 27 Jan 2009 16:52:13 -0800 (PST)
Received: from localhost ([94.37.14.37])
        by mx.google.com with ESMTPS id e8sm2439554muf.30.2009.01.27.16.52.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jan 2009 16:52:12 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107436>

When PATH_INFO is defined, static files such as the default CSS or the
shortcut icon are not accessible beyond the summary page (e.g. in
shortlog or commit view).

Fix this by adding a <base> tag pointing to the script's own URL.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 931db4f..55e3081 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2901,6 +2901,11 @@ sub git_header_html {
 <meta name="robots" content="index, nofollow"/>
 <title>$title</title>
 EOF
+# the stylesheet, favicon etc urls won't work correctly with path_info unless we
+# set the appropriate base URL
+	if ($ENV{'PATH_INFO'}) {
+		print "<base href=\"$my_url\" />\n";
+	}
 # print out each stylesheet that exist
 	if (defined $stylesheet) {
 #provides backwards capability for those people who define style sheet in a config file
-- 
1.5.6.5
