From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] transport-helper: avoid dependency on thread-utils.h
Date: Fri, 10 Dec 2010 05:48:39 -0600
Message-ID: <20101210114839.GA5771@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 10 12:49:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR1TO-0005GQ-My
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 12:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517Ab0LJLtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 06:49:09 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43957 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755506Ab0LJLtI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 06:49:08 -0500
Received: by yxt3 with SMTP id 3so1968817yxt.19
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 03:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=m/jtilk83r/USz0scnXs4fts42kIrrnbVBBIGDqSu4A=;
        b=Iv9NV5TxF7stIoIDfoyCjw7I5xEPYeK0kuACybBBSvMaz93bMPhaU2lHcA68OcCzRX
         2/sC+xnw1c328Az1ZXuyg6XVtFF6M3ckHOlyl3cIaV5cgyCrjgAAUP6azuognQWK+n3y
         oY134uaUaPbp9d/fin4gXsVLvHNFbxtvpR2GY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=pHTI7e+R1sWf/TPWUwOrY2Zvagcwq52Q3XN4zw9ivqom0KmChwpkfXf24CDT52OaR3
         jEl74cMdACq8LHenCIVnPiULXcybtddH/TbB7dmWMhG6OgA60oDuX1VS0vV67U0dLE7f
         vXdP2sfWJbBIB5rVg3LqyoFCdtzsrnInFzWsU=
Received: by 10.236.109.7 with SMTP id r7mr1460457yhg.78.1291981746168;
        Fri, 10 Dec 2010 03:49:06 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.ameritech.net [69.209.58.175])
        by mx.google.com with ESMTPS id j64sm1851195yha.35.2010.12.10.03.49.04
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 03:49:05 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163406>

Since the transport-helper does not use recursive mutexes or ask the
number of cores, it does not require any declarations from the
thread-utils lib.  Removing the unnecessary #include avoids false
positives from "make CHECK_HEADER_DEPENDENCIES=1".

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
The #include directive in question was added in 7851b1e60
(remote-fd/ext: finishing touches after code review, 2010-11-17),
at the same times as the necessary #include for <pthread.h>.
This patch seems to work for me, but I wouldn't be surprised if
to be missing something.

 transport-helper.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 3a50856..7c99051 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -11,7 +11,6 @@
 
 #ifndef NO_PTHREADS
 #include <pthread.h>
-#include "thread-utils.h"
 #endif
 
 static int debug;
-- 
1.7.2.4
