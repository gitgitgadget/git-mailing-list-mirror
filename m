From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: remove PATH_INFO from $my_url and $my_uri
Date: Wed,  3 Sep 2008 11:57:19 +0200
Message-ID: <1220435839-29360-6-git-send-email-giuseppe.bilotta@gmail.com>
References: <1220435839-29360-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1220435839-29360-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1220435839-29360-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1220435839-29360-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1220435839-29360-5-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Lea Wiemann <lewiemann@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 11:59:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kap8S-0000SL-3L
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 11:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbYICJ5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 05:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752359AbYICJ5o
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 05:57:44 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:13977 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbYICJ5l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 05:57:41 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1366057eyi.37
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 02:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=NClryhMBTkmSQqsCGiZQYvxtY7iJ84M0xeeKisB8yfs=;
        b=t4BHwDtYPFlMow8xzD7B6LQRHAMPx6M7vQezYpU2wVieMGsjGUGZWXclnkAruLR15z
         BN2gRBcBM+WWEus5yh0nbnx3NHUyZG/wbMin5S7fGYYCKNkqW53D5J4hns+XGvIWlZZq
         mTOANANr32PvoUddbWqBKiB9cxxAnIeM9+xGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ER4/WJPtAwcPITY5rmyL1PKsfZIoMNXDRLVMjPltBSD3mKxs4391srzRS7t0NLqgqy
         q5+hoFjTBRNf35N4UyfsMT3bKVx4o8EwCfBrdD7VCgBvDYs1Yqwn5W1SIpwePADmCcfy
         uhmuygNy23oNL8OofjEx9l25C/8BSPj+z1QMY=
Received: by 10.210.44.1 with SMTP id r1mr9844181ebr.69.1220435860285;
        Wed, 03 Sep 2008 02:57:40 -0700 (PDT)
Received: from localhost ( [78.15.13.249])
        by mx.google.com with ESMTPS id f6sm47844973nfh.12.2008.09.03.02.57.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Sep 2008 02:57:39 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1220435839-29360-5-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94780>

This patch (combined with appropriate server configuration) allows usage
of the gitweb CGI script as DirectoryIndex for the server root even when
the pathinfo feature is enabled.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 573b416..99c891e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -26,6 +26,10 @@ our $cgi = new CGI;
 our $version = "++GIT_VERSION++";
 our $my_url = $cgi->url();
 our $my_uri = $cgi->url(-absolute => 1);
+if (my $path_info = $ENV{"PATH_INFO"}) {
+	$my_url =~ s,$path_info$,,;
+	$my_uri =~ s,$path_info$,,;
+}
 
 # core git executable to use
 # this can just be "git" if your webserver has a sensible PATH
-- 
1.5.6.5
