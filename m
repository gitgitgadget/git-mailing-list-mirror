From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] better introduction of GIT with USE_NSEC defined
Date: Thu, 05 Mar 2009 12:55:25 +0100
Message-ID: <49AFBDAD.5040501@viscovery.net>
References: <cover.1236187259.git.barvik@broadpark.no> <6d937a859ca499f534eea08720fca84f3d4ded2f.1236187259.git.barvik@broadpark.no> <49AF9745.8050207@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Thu Mar 05 12:57:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfCCa-0001c0-Vt
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 12:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755014AbZCELzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 06:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754947AbZCELze
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 06:55:34 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:30638 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754960AbZCELzd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 06:55:33 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LfCAg-00034Q-2b; Thu, 05 Mar 2009 12:55:26 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id CA97A6C4; Thu,  5 Mar 2009 12:55:25 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <49AF9745.8050207@viscovery.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112302>

Johannes Sixt schrieb:
> Kjetil Barvik schrieb:
>> -	istate->timestamp.sec = st.st_mtime;
>> -#ifdef USE_NSEC
>> +	istate->timestamp.sec = (unsigned int)st.st_mtime;
>>  	istate->timestamp.nsec = (unsigned int)st.st_mtim.tv_nsec;
>> -#else
>> -	istate->timestamp.nsec = 0;
>> -#endif
> 
> Doesn't this break on systems where st_mtime is time_t and st_mtim does
> not exist?

Yes, it breaks. You can test this on Linux by commenting out these two
lines in git-compat-util.h:

diff --git a/git-compat-util.h b/git-compat-util.h
index dcf4127..ab4b615 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -44,8 +44,8 @@
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
 #define _ALL_SOURCE 1
-#define _GNU_SOURCE 1
-#define _BSD_SOURCE 1
+/*#define _GNU_SOURCE 1*/
+/*#define _BSD_SOURCE 1*/

 #include <unistd.h>
 #include <stdio.h>

The result even passes the test suite (as long as I don't merge
kb/checkout-optim, of course).

-- Hannes
