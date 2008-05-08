From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] compat/fopen.c: avoid clobbering the system defined fopen
 macro
Date: Thu, 08 May 2008 09:34:49 +0200
Message-ID: <4822AD19.6000609@viscovery.net>
References: <7vfxsudrt0.fsf@gitster.siamese.dyndns.org>	 <4821E81A.4030600@nrlssc.navy.mil> <e2b179460805080027pf9ff518xf4fcbb248ecac4bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 09:35:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju0fI-0004wY-MW
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 09:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757118AbYEHHe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 03:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757141AbYEHHe4
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 03:34:56 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:4620 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756984AbYEHHez (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 03:34:55 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ju0eQ-00055G-8N; Thu, 08 May 2008 09:34:50 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0AC9FAFCC; Thu,  8 May 2008 09:34:50 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <e2b179460805080027pf9ff518xf4fcbb248ecac4bf@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81511>

Mike Ralphson schrieb:
> I guess there may still be a case for not defining _LARGE_FILES by
> default on AIX as all the warnings may be off-putting or mask other
> issues. Maybe instead having a comment for those who need large
> pack-file support? Will submit amended Makefile patch if there's
> interest.

Since with this patch we are treating fopen specially anyway, we could go
one step further and do this, too:
---
diff --git a/git-compat-util.h b/git-compat-util.h
index b2708f3..dad4d48 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -230,6 +230,9 @@ void *gitmemmem(const void *haystack,
 #endif

 #ifdef FREAD_READS_DIRECTORIES
+#ifdef fopen
+#undef fopen
+#endif
 #define fopen(a,b) git_fopen(a,b)
 extern FILE *git_fopen(const char*, const char*);
 #endif
