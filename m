From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] git-instaweb: Remove pidfile after stopping web server
Date: Fri, 28 May 2010 21:11:23 +0200
Message-ID: <1275073885-26537-2-git-send-email-jnareb@gmail.com>
References: <1275073885-26537-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@suse.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 28 21:09:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OI4wA-0000YE-PJ
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 21:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784Ab0E1TJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 May 2010 15:09:38 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37851 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580Ab0E1TJg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 15:09:36 -0400
Received: by mail-fx0-f46.google.com with SMTP id 10so1005565fxm.19
        for <git@vger.kernel.org>; Fri, 28 May 2010 12:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ScIgkwhy31oZcmc4taudWQZwnVbl/hz3a1Y39tSfiBA=;
        b=e4rCpLvGeW7N9xVZRFDALGhw3gnBwRDOXb0N0nJH/xUSNfpC7Iiw6zRdET+s64MZgc
         bmZRQEG0bcfz0F1OK2Ruoj+/0xznORgQa5T/y7YgfEuoesh7oxJtf+HrWZW72DIgyIzW
         8Z0ilowju7ooyEedLqEnFgCz4l6v5S/4lxnTs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mrTyDbbTMvQic7ZWSvipTIlAH+KWw4fOpzO7gpx+ZtG8bvgF/ByrcRTp6U8KRLtKO2
         IHndqB7kguMceUie6KGCPe20zWjTTLrx84ivzlsIFhRgqx/5Qps2qbd4H4pDqxaxzVNB
         N02LsPn2pB/dI3yUB76FqS5wbR3HEUF6cXoOg=
Received: by 10.223.5.89 with SMTP id 25mr790529fau.87.1275073774932;
        Fri, 28 May 2010 12:09:34 -0700 (PDT)
Received: from localhost.localdomain (abwk209.neoplus.adsl.tpnet.pl [83.8.234.209])
        by mx.google.com with ESMTPS id 13sm13023723fad.7.2010.05.28.12.09.32
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 28 May 2010 12:09:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1275073885-26537-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147931>

This way running e.g. "git instaweb" after "git instaweb --stop" would
not try to kill already stopped web server.

This is probably important only for those web servers that are
"daemonized" by git-instaweb itself, i.e. for those where it is
git-instaweb that creates pidfile.  Currently it is includes only
'mongoose' web server, but it would also include 'plackup' web server
(added in later commit).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 git-instaweb.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 5c700b6..a8c5dc0 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -114,6 +114,7 @@ EOF
 
 stop_httpd () {
 	test -f "$fqgitdir/pid" && kill $(cat "$fqgitdir/pid")
+	rm -f "$fqgitdir/pid"
 }
 
 while test $# != 0
-- 
1.7.0.1
