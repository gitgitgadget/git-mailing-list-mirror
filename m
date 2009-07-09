From: "Martin Ettl" <ettl.martin@gmx.de>
Subject: found a resource leak in file builtin-fast-export.c
Date: Thu, 09 Jul 2009 09:57:28 +0200
Message-ID: <20090709075728.137880@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMX137881247126248308703"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 09:58:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOoWM-0006e8-Oj
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 09:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755822AbZGIH5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 03:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755068AbZGIH5b
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 03:57:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:50053 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753265AbZGIH5b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 03:57:31 -0400
Received: (qmail 27534 invoked by uid 0); 9 Jul 2009 07:57:28 -0000
Received: from 141.74.1.1 by www099.gmx.net with HTTP;
 Thu, 09 Jul 2009 09:57:28 +0200 (CEST)
X-Authenticated: #45868255
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
X-Provags-ID: V01U2FsdGVkX196LJ9Y57V6pPV67eJwm45SJ+CCMGr/2sggI1ZyFP
 4XhlhIp3dkNujAD15tWkU8GifdXbqWsPF5Bw== 
X-GMX-UID: 0ZpjA5RyQEV/GujS0ndpuKNCNzg2NQKU
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122939>

--========GMX137881247126248308703
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

i have checked the source base of git with the static code analyis tool cppcheck. It brougt up an issue in file 1.6.3.3/builtin-fast-export.c at line 447.

The tool printed the following waring:

[git-1.6.3.3/builtin-fast-export.c:447]: (error) Resource leak: f

I have attached a patch to resolve this.


Best regards

Ettl Martin

-- 
Neu: GMX Doppel-FLAT mit Internet-Flatrate + Telefon-Flatrate
für nur 19,99 Euro/mtl.!* http://portal.gmx.net/de/go/dsl02

--========GMX137881247126248308703
Content-Type: text/x-patch;
 charset="iso-8859-15";
 name="builtin-fast-export.c.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="builtin-fast-export.c.patch"

--- git-1.6.3.3/builtin-fast-export.c	2009-06-22 08:24:25.000000000 +0200
+++ git-1.6.3.3/builtin-fast-export_new.c	2009-07-09 09:44:28.000000000 +0200
@@ -442,8 +442,9 @@ static void export_marks(char *file)
 		deco++;
 	}
 
-	if (ferror(f) || fclose(f))
+	if (ferror(f))
 		error("Unable to write marks file %s.", file);
+  	fclose(f);
 }
 
 static void import_marks(char *input_file)

--========GMX137881247126248308703--
