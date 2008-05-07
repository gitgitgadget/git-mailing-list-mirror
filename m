From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] Makefile: update the default build options for AIX
Date: Wed, 07 May 2008 09:38:02 -0500
Message-ID: <4821BECA.8020509@nrlssc.navy.mil>
References: <1210149355875-git-send-email-mike@abacus.co.uk>	 <4821992F.4060201@viscovery.net> <e2b179460805070551x7a0072e0w4d406ef4112849ce@mail.gmail.com> <4821AB32.8090700@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 07 16:45:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtktL-0008IG-G6
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 16:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762107AbYEGOnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 10:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760787AbYEGOnm
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 10:43:42 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:47118 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762332AbYEGOni (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 10:43:38 -0400
Received: from starfish.gems.nrlssc.navy.mil (starfish.nrlssc.navy.mil [128.160.50.76])
	by mail.nrlssc.navy.mil (8.13.8/8.13.8) with ESMTP id m47Ec3aN016147;
	Wed, 7 May 2008 09:38:03 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 May 2008 09:38:03 -0500
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <4821AB32.8090700@viscovery.net>
X-OriginalArrivalTime: 07 May 2008 14:38:03.0304 (UTC) FILETIME=[F49F3A80:01C8B04F]
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81442>

Johannes Sixt wrote:
> The #define fopen in git-compat-util.h essentially defeats the effect of
> _LARGE_FILES as far as fopen() calls are concerned: If
> FREAD_READS_DIRECTORIES is not defined, fopen() would be redirected to
> fopen64(), but when it is defined, it is redirected to git_fopen(), which
> in turn uses fopen() instead of fopen64() (due to the #undef in
> compat/fopen.c).
> 

How about something like this?

diff --git a/compat/fopen.c b/compat/fopen.c
index ccb9e89..70b0d4d 100644
--- a/compat/fopen.c
+++ b/compat/fopen.c
@@ -1,5 +1,5 @@
+#undef FREAD_READS_DIRECTORIES
 #include "../git-compat-util.h"
-#undef fopen
 FILE *git_fopen(const char *path, const char *mode)
 {
        FILE *fp;


-brandon
