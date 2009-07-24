From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 07/10] gitweb: Add -partial_query option to href() subroutine
Date: Sat, 25 Jul 2009 00:44:07 +0200
Message-ID: <1248475450-5668-8-git-send-email-jnareb@gmail.com>
References: <1248475450-5668-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 25 00:46:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUTXC-0008Cv-Kt
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 00:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920AbZGXWqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 18:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754925AbZGXWqc
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 18:46:32 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:34156 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754921AbZGXWqb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 18:46:31 -0400
Received: by fxm18 with SMTP id 18so1688607fxm.37
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 15:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JdfF3cvSQ+KSvTtNIkYSaQWWVr0LBbblcfnOS5qemKM=;
        b=URKsIVmyxy0tw3r7mxjoSwx7Ui6VVTLf6u24T9jbnHhZfI1GWdyewPlPYCnhfXRTOX
         zXZMFEZ2eDlKuAxar2hSbT+wEFLdHLJ6Le+STtqxwi0iV9DzYeednwCp/2Q/jZ2jw0hN
         EILNIq9iUYsGNY92aN1hJCLqF5wRczml1tbFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Afq+2NZjVODY6Tou5JUlZLAc2QHKPPV23vFDEUv9afjO0X1Y92oa1aIjhffP4HXHK1
         QkR85LHIFd+pMyXPTXtPhJGtBQUqKsNmxZLhdBNt7+1+1WX3ADcLjYWxNuhyP6aLBJaW
         Y2G21M+2g5AeZkuan5kuZbqf4nZtYYqNZOG5A=
Received: by 10.103.137.19 with SMTP id p19mr1988270mun.8.1248475590633;
        Fri, 24 Jul 2009 15:46:30 -0700 (PDT)
Received: from localhost.localdomain (abwq33.neoplus.adsl.tpnet.pl [83.8.240.33])
        by mx.google.com with ESMTPS id e9sm14736728muf.2.2009.07.24.15.46.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Jul 2009 15:46:30 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6OMq7fD005833;
	Sat, 25 Jul 2009 00:52:12 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6OMpaHW005830;
	Sat, 25 Jul 2009 00:51:36 +0200
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1248475450-5668-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123965>

href(..., -partial_query=>1) is meant to generate links which have not
all parameters filled, and which can be completed by simply appending
';<param>=<value>'.  This feature was implemented for future AJAX-y
'blame_incremental' in JavaScript.

Originally by Petr Baudis as part of "gitweb: Incremental blame"
patch, to deal with path_info URLs in JavaScript part easily and
correctly.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This change is extracted from incremental blame patch by Petr Baudis.
In previous version of this series it was part of 5/3 patch
introducing 'blame_incremental' view.

However as you can see in incremental blame patch by Matrin Koegler:
  http://thread.gmane.org/gmane.comp.version-control.git/47902/focus=47905

this is not strictly necessary. JavaScript (which is sole user of this
'-partial-query' parameter) can simply check if there is '?' character
in link already.  On the other hand side it makes JavaScript code a bit
simpler.

 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2cb60be..0d91ac7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -992,7 +992,8 @@ sub href {
 			}
 		}
 	}
-	$href .= "?" . join(';', @result) if scalar @result;
+	$href .= "?" . join(';', @result)
+		if ($params{-partial_query} or scalar @result);
 
 	return $href;
 }
-- 
1.6.3.3
