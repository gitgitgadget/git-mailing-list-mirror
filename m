From: Russell Steicke <russellsteicke@gmail.com>
Subject: [PATCH] (tig) Fix signed char comparison where char is unsigned by default.
Date: Tue, 18 Mar 2008 17:47:43 +0900
Message-ID: <20080318084743.GA16827@maggie.localnet>
Reply-To: Russell Steicke <russellsteicke@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 18 09:48:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbXUy-0005iy-Bq
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 09:48:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbYCRIr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2008 04:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbYCRIr7
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Mar 2008 04:47:59 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:23119 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbYCRIrz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2008 04:47:55 -0400
Received: by an-out-0708.google.com with SMTP id b6so1234565ana.37
        for <git@vger.kernel.org>; Tue, 18 Mar 2008 01:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:reply-to:mime-version:content-type:content-disposition:x-boo:x-message-flag:x-system:x-uptime:user-agent;
        bh=8A8COM9Zqle4kuccLhgCHRZP5L+2857GRw2WTktKdJA=;
        b=NTVFQrAZVTRmOQqSkalmSft1F9ApxJAyj40+8UUuX34iFLeMcF2NZgGNCqElg6ucTjJ3hFly62X6L6cD55jVZ5Bl/sTpHPg5m13XlNmTaovMlTlKnQc5jBFKQJ+n2e4A2POHmqQ1h6WdOxa4tmARrucLE8VdtARUgWhG7ExShWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:reply-to:mime-version:content-type:content-disposition:x-boo:x-message-flag:x-system:x-uptime:user-agent;
        b=BBqIdX9dxgEN3v3tQjWPJh20y99wQNNG3ZxmpALheRwrQBu33QAmpOVGPsbJvJxb5TcfM9huGsCc8+7wW6cu+cQc0iq7iHQXfu8VVLurMn7MG2Ma9pSPnLzqYloI7v0RtPVZRuV7yyULgDGujKS/3TLy3Jr1R1zscIwwYIMwW0A=
Received: by 10.100.201.16 with SMTP id y16mr1207320anf.72.1205830072357;
        Tue, 18 Mar 2008 01:47:52 -0700 (PDT)
Received: from localhost ( [203.33.247.40])
        by mx.google.com with ESMTPS id d19sm36245052and.6.2008.03.18.01.47.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Mar 2008 01:47:51 -0700 (PDT)
Content-Disposition: inline
X-Boo: Boo!
X-message-flag: I see that you run Outlook...
X-System: Linux maggie 2.6.22-2-powerpc64
X-Uptime: 14:42:16 up 39 days, 21:16, 18 users,  load average: 1.51, 1.82, 1.75
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77494>

tig uses a char as a flag, and expects that to have three
values: TRUE, FALSE, and -1.  When char is unsigned char (such
as on PPC), this fails with the compiler warning "comparison is
always false due to limited range of data type".

So explicitly make the flag a signed char.

Detecting the int8_t type with the autoconf macro
AC_CREATE_STDINT_H would probably be a better fix.

Signed-off-by: Russell Steicke <russellsteicke@gmail.com>
---
 tig.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tig.c b/tig.c
index 89a4c5d..448ce20 100644
--- a/tig.c
+++ b/tig.c
@@ -434,7 +434,7 @@ static iconv_t opt_iconv		= ICONV_NONE;
 static char opt_search[SIZEOF_STR]	= "";
 static char opt_cdup[SIZEOF_STR]	= "";
 static char opt_git_dir[SIZEOF_STR]	= "";
-static char opt_is_inside_work_tree	= -1; /* set to TRUE or FALSE */
+static signed char opt_is_inside_work_tree	= -1; /* set to TRUE or FALSE */
 static char opt_editor[SIZEOF_STR]	= "";
 
 enum option_type {
-- 
1.5.4.4


-- 
Russell Steicke

-- Fortune says:
Everything I like is either illegal, immoral or fattening.
		-- Alexander Woollcott
