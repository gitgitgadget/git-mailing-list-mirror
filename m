From: Alex Riesen <raa.lkml@gmail.com>
Subject: fix potential deadlock in create_one_file
Date: Thu, 5 Jan 2006 10:00:12 +0100
Message-ID: <81b0412b0601050100v519e76c8u11f4d484f9d28e0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_9708_18616691.1136451612527"
X-From: git-owner@vger.kernel.org Thu Jan 05 10:00:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuQys-0004oj-PY
	for gcvg-git@gmane.org; Thu, 05 Jan 2006 10:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbWAEJAT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jan 2006 04:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752121AbWAEJAT
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jan 2006 04:00:19 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:1031 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752118AbWAEJAR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2006 04:00:17 -0500
Received: by nproxy.gmail.com with SMTP id x29so97936nfb
        for <git@vger.kernel.org>; Thu, 05 Jan 2006 01:00:13 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=JS43+BoS3geeuZZye7Acov+XlcJa2G6m8oHZnaWAajIaW9s1ybNGsdqWELtTVLPbvj6bhsApGRvYy4yy2u0bJTLXvWmwslSpFJBK+5yohzFylCoGcU+U5c5kQoQS6KeUjHXDWkQeiYAZ2QJroBjpZG8U8tWiaDfHuWSS1kKrZNE=
Received: by 10.48.163.10 with SMTP id l10mr675244nfe;
        Thu, 05 Jan 2006 01:00:12 -0800 (PST)
Received: by 10.48.248.4 with HTTP; Thu, 5 Jan 2006 01:00:12 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14186>

------=_Part_9708_18616691.1136451612527
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

It can happen if the temporary file already exists (i.e. after a panic
and reboot).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

------=_Part_9708_18616691.1136451612527
Content-Type: text/plain; 
	name=0002-fix-potential-deadlock-in-create_one_file.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0002-fix-potential-deadlock-in-create_one_file.txt"

Subject: [PATCH] fix potential deadlock in create_one_file.

It can happen if the temporary file already exists.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>


---

 apply.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

f7ac9127638a013d0f1d60e02a06fde10909824c
diff --git a/apply.c b/apply.c
index d5e7bfd..ff3782b 100644
--- a/apply.c
+++ b/apply.c
@@ -1635,7 +1635,8 @@ static void create_one_file(const char *
 			}
 			if (errno != EEXIST)
 				break;
-		}			
+			++nr;
+		}
 	}
 	die("unable to write file %s mode %o", path, mode);
 }
-- 
1.0.GIT

------=_Part_9708_18616691.1136451612527--
