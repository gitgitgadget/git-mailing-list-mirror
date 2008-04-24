From: "Tom ten Thij" <mail@tomtenthij.nl>
Subject: [PATCH/RFC] More colors for pretty format: yellow, purple, cyan, white and black
Date: Thu, 24 Apr 2008 18:26:52 +0100
Message-ID: <c19f1c910804241026q14f95af7qa0289018d08ac23a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com, rene.scharfe@lsrfire.ath.cx
X-From: git-owner@vger.kernel.org Thu Apr 24 19:27:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jp5ES-0006cL-Sc
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 19:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754163AbYDXR0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2008 13:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753830AbYDXR0x
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 13:26:53 -0400
Received: from rv-out-0708.google.com ([209.85.198.250]:7783 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753303AbYDXR0w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 13:26:52 -0400
Received: by rv-out-0506.google.com with SMTP id k29so1861430rvb.1
        for <git@vger.kernel.org>; Thu, 24 Apr 2008 10:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=vpkY5bEhi60/ScwC9bE0Th/dRjlU9xqTLZ+0AcXR9r8=;
        b=TWfRIgHqxFPGPoD3z+MguxmAx1zebv2GmcqMiORMfLwz95XM2hg6H6KeBtA2JR5tNkI2Vv4JnnTz2KY1gjGnP+34Gckafu2oad1kwkq4Kz9DGUbaltx23hOJsxv85UC48Ef7G/qCeSfzcZ6/TD/gEbDhflUOq1i8V7ksfJe36Vc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=M3zCUTPC/jvcx2bWJXVeR/wb3+vhaP4Ib3wqC5RLLth3CU4pPdIGmpwL4xhhbZPSknmeYCFvWETs6pUp71lAMJm0pej/iRtTf7zWGrhYNVp2KENCwVSzXvx0tHt9L52AvZnYv5RupPMVkR/dAoOEhOg5SSG1hj+SQHAW+NPwp5U=
Received: by 10.141.211.13 with SMTP id n13mr805982rvq.184.1209058012182;
        Thu, 24 Apr 2008 10:26:52 -0700 (PDT)
Received: by 10.140.162.5 with HTTP; Thu, 24 Apr 2008 10:26:52 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 20810e744dccff66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80311>

Signed-off-by: Tom ten Thij <git@tomtenthij.nl>
---
Add support for other colors in pretty format the same way %Cred
works. I reordered the if
statements to start with the reset case and order the others by ansi
color code. Not sure if
I have to edit other files or how to do testing for a complete patch.

 Documentation/pretty-formats.txt |    5 +++++
 pretty.c                         |   21 ++++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index e8bea3e..c8631f8 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -120,6 +120,11 @@ The placeholders are:
 - '%Cred': switch color to red
 - '%Cgreen': switch color to green
 - '%Cblue': switch color to blue
+- '%Cyellow': switch color to yellow
+- '%Cpurple': switch color to purple
+- '%Ccyan': switch color to cyan
+- '%Cwhite': switch color to white
+- '%Cblack': switch color to black
 - '%Creset': reset color
 - '%m': left, right or boundary mark
 - '%n': newline
diff --git a/pretty.c b/pretty.c
index 6872932..b497008 100644
--- a/pretty.c
+++ b/pretty.c
@@ -471,17 +471,32 @@ static size_t format_commit_item(struct strbuf
*sb, const char *placeholder,
        /* these are independent of the commit */
        switch (placeholder[0]) {
        case 'C':
-               if (!prefixcmp(placeholder + 1, "red")) {
+               if (!prefixcmp(placeholder + 1, "reset")) {
+                       strbuf_addstr(sb, "\033[m");
+                       return 6;
+               } else if (!prefixcmp(placeholder + 1, "black")) {
+                       strbuf_addstr(sb, "\033[30m");
+                       return 6;
+               } else if (!prefixcmp(placeholder + 1, "red")) {
                        strbuf_addstr(sb, "\033[31m");
                        return 4;
                } else if (!prefixcmp(placeholder + 1, "green")) {
                        strbuf_addstr(sb, "\033[32m");
                        return 6;
+               } else if (!prefixcmp(placeholder + 1, "yellow")) {
+                       strbuf_addstr(sb, "\033[33m");
+                       return 7;
                } else if (!prefixcmp(placeholder + 1, "blue")) {
                        strbuf_addstr(sb, "\033[34m");
                        return 5;
-               } else if (!prefixcmp(placeholder + 1, "reset")) {
-                       strbuf_addstr(sb, "\033[m");
+               } else if (!prefixcmp(placeholder + 1, "purple")) {
+                       strbuf_addstr(sb, "\033[35m");
+                       return 7;
+               } else if (!prefixcmp(placeholder + 1, "cyan")) {
+                       strbuf_addstr(sb, "\033[36m");
+                       return 5;
+               } else if (!prefixcmp(placeholder + 1, "white")) {
+                       strbuf_addstr(sb, "\033[37m");
                        return 6;
                } else
                        return 0;
-- 
1.5.4.4
