From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 1/3] gitweb: make static files accessible with PATH_INFO
Date: Sat, 31 Jan 2009 02:31:50 +0100
Message-ID: <1233365512-7130-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1233365512-7130-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 31 02:33:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT4jS-0000JH-VJ
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 02:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915AbZAaBbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 20:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753900AbZAaBbv
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 20:31:51 -0500
Received: from fk-out-0910.google.com ([209.85.128.184]:32199 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581AbZAaBbu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 20:31:50 -0500
Received: by fk-out-0910.google.com with SMTP id f33so664359fkf.5
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 17:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7Ak3wMrsqwrXf40xGl1a//HEGr+kNotkvBNIuJYGrCs=;
        b=N4QEEJaawHDuw1/zWuH+ZCLHR8lijOPs4ufhDhnCf5WJ6eYzubehuLRBoKT17OzNq3
         BPa835LdjM/27Qr8P7Q4achzNsJejzLxvGVqlf5rBF56CeQrXPUnSg6omkGAhOSVlwMW
         i5VJBXvNtP2Mbl3Vs7AcAjj5s38say/JwpGbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BwOGYyt6xp6CHYUggU/i+QK8A/yv4itx+8zyobZ95zVdN7obTSXHXwoZVsn2AiFIbb
         55IRM3aeexLdfj3JDpnbhWbD/sobGy8QHdsm5edQTutYMCS9XKF4JvkXTab0J/13y9oE
         sF/R3XsGnc8btMV/cQJdUk2YSt550MLuoAWrM=
Received: by 10.181.218.10 with SMTP id v10mr652242bkq.2.1233365509108;
        Fri, 30 Jan 2009 17:31:49 -0800 (PST)
Received: from localhost ([94.37.14.37])
        by mx.google.com with ESMTPS id c28sm2095281fka.26.2009.01.30.17.31.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Jan 2009 17:31:48 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1233365512-7130-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107899>

Gitweb links to a number of static files such as CSS stylesheets,
favicon or the git logo. When, such as with the default Makefile, the
paths to these files are relative (i.e. doesn't start with a "/"), the
files become inaccessible in any view other tha project list and summary
page if gitweb is invoked with a non-empty PATH_INFO.

Fix this by adding a <base> element pointing to the script's own URL,
which ensure that all relative paths will be resolved correctly.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 931db4f..538bd5a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2901,6 +2901,11 @@ sub git_header_html {
 <meta name="robots" content="index, nofollow"/>
 <title>$title</title>
 EOF
+# the stylesheet, favicon etc urls won't work correctly with path_info unless we
+# set the appropriate base URL
+	if ($ENV{'PATH_INFO'}) {
+		print '<base href="'.esc_url($my_url).'" />\n';
+	}
 # print out each stylesheet that exist
 	if (defined $stylesheet) {
 #provides backwards capability for those people who define style sheet in a config file
-- 
1.5.6.5
