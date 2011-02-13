From: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
Subject: [PATCH] Don't optimize code in debug build
Date: Sun, 13 Feb 2011 09:32:56 +0100
Message-ID: <AANLkTinw7DJ3hP7ACcScHTYy-Dvizq-OxefP6e0dEBbR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 13 09:33:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoXOA-0006Rf-Hd
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 09:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435Ab1BMIc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 03:32:58 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35687 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288Ab1BMIc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 03:32:56 -0500
Received: by vxb37 with SMTP id 37so2100922vxb.19
        for <git@vger.kernel.org>; Sun, 13 Feb 2011 00:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:content-type;
        bh=wD1DzJ9j709bzg+ZjBfZzPQPj1uDV9Agqy6L3e/U33s=;
        b=fOmecl4/fQCnY7/ODwH5Vy+gekoDZeSWZJK6GMHQ5BWowRcR/t0d+W57q+EMt9dL4i
         lsPDID8gSokS7Cz7eHSGTKihu+RD88Wq1NuhG6vLW6yO7IommiV5bFE1IHr2ixBcFOSA
         ZMxQmgGVM0BHxNuC61fDwvTvPcdpUUJ3+oJg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=oNH4tcZvJhIbyaWRYjM44RamYHT0+3V+jPyHy+SHK/nTP/fLI44vl102dVfCBajo7z
         /JnPKgC71jjDxsf0M27tobeLewObaMKnL+eaBf78oGvB99A0i/duStzLSGdzZQ8T/bXM
         NSr7z7uzGl2fRVX22tLmrwFhXAO19eX3wyI0E=
Received: by 10.220.188.74 with SMTP id cz10mr3179144vcb.71.1297585976087;
 Sun, 13 Feb 2011 00:32:56 -0800 (PST)
Received: by 10.220.195.132 with HTTP; Sun, 13 Feb 2011 00:32:56 -0800 (PST)
X-Google-Sender-Auth: 5PG5Q3dyajbuGztaOGosL8soZ5c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166644>

Code optimization makes debugging harder.

Signed-off-by: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
---
My first patch to this list, so please be gentle ;)

Patch fixes most important problem. There are other improvement possible:
- "-g" is not needed in normal build IMO, I'd move it to debug
- I'd add -O0 -fno-inline to debug too, but maybe it's too gccish
(OTOH there's -g already)

 Makefile |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index ade7923..32d3a69 100644
--- a/Makefile
+++ b/Makefile
@@ -262,7 +262,10 @@ endif

 # CFLAGS and LDFLAGS are for the users to override from the command line.

-CFLAGS = -g -O2 -Wall
+CFLAGS = -g -Wall
+ifndef DEBUG
+CFLAGS += -O2
+endif
 LDFLAGS =
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
-- 
1.7.1

-- 
Piotrek
