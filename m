From: Christian Halstrick <christian.halstrick@gmail.com>
Subject: [JGIT PATCH] Repair make_jgit.sh to work in MSYS environment
Date: Thu, 9 Jul 2009 23:26:36 +0200
Message-ID: <20090709232636.00003106@unknown>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 23:26:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP18h-0006KE-TD
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 23:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045AbZGIV0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 17:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754559AbZGIV0l
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 17:26:41 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:36791 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949AbZGIV0k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 17:26:40 -0400
Received: by bwz25 with SMTP id 25so470840bwz.37
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 14:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=QgJ7pdf6tXKQ41O1bRf6MBDF64x0ME6bY9dxp0V820A=;
        b=naJ/5W6NawxHwT2KyVXIqDhvV7q/d5nl7PpxWTM8ikxOQBrn8rTVaJf4tag1bolFdD
         bhXSyWFdcaHHgst5JOdUgFEsA9WJP6kUpxwbIyiVNjiTGar+0fWGjYaDvkqOETG2KS25
         +3GI+X8CMTDDN5JZBgRKElBn0Mlco+8DZMpD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=t+QIiP7qwqI9aUE2zYfTA0xXsGlrpOgT/J7afkl0gqIU0mgyYWwRmVMXh+aVb8Ayue
         jnR1f4U8qRhkx24t1ppx0GOd5wtL4gukmdSb27ulKgrXXwxbdvqdT3MN+Z90lR5xn/gr
         ZAjHP9zaznHrUNpGKgh6YnBYQAxhYyJhYDLiU=
Received: by 10.103.11.5 with SMTP id o5mr688216mui.34.1247174799182;
        Thu, 09 Jul 2009 14:26:39 -0700 (PDT)
Received: from unknown (g226215147.adsl.alicedsl.de [92.226.215.147])
        by mx.google.com with ESMTPS id y6sm1551522mug.40.2009.07.09.14.26.37
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 09 Jul 2009 14:26:38 -0700 (PDT)
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.16.0; i586-pc-mingw32msvc)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123012>

From: Christian Halstrick <christian.halstrick@sap.com>

My MSYS installation sets the environment variable MSYSTEM to
"MINGW32" which was not handled in make_jgit.sh. Corrected that.
Also Suns Windows javac doesn't like classpathes with
/<driveletter/<dir>. When using `pwd -W` i get pathes accepted
by windows javac.

Signed-off-by: Christian Halstrick <christian.halstrick@sap.com>
---
 make_jgit.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/make_jgit.sh b/make_jgit.sh
index 027a074..baaa3af 100755
--- a/make_jgit.sh
+++ b/make_jgit.sh
@@ -22,9 +22,10 @@ then
 	R=`cygpath -m $R`
 	PSEP=";"
 fi
-if [ "$MSYSTEM" = "MINGW" ]
+if [ "$MSYSTEM" = "MINGW" -o "$MSYSTEM" = "MINGW32" ]
 then
 	PSEP=";"
+	R=`pwd -W`
 fi
 
 if [ -n "$JAVA_HOME" ]
-- 
1.6.3.2.1299.gee46c
