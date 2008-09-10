From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH] Use compatibility regex library for OSX/Darwin
Date: Wed, 10 Sep 2008 11:49:47 +0200
Message-ID: <48C7983B.8010308@viscovery.net>
References: <20080907184537.GA4148@regex.yaph.org> <e2b179460809100103t4266650bnac00097cfb86c0b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Arjen Laarhoven <arjen@yaph.org>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 11:52:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdMNP-0005Bu-6W
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 11:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbYIJJtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 05:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbYIJJtu
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 05:49:50 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:47761 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbYIJJtu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 05:49:50 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KdMKZ-0001XS-Ll; Wed, 10 Sep 2008 11:49:47 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6E5EE6D9; Wed, 10 Sep 2008 11:49:47 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <e2b179460809100103t4266650bnac00097cfb86c0b1@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95505>

Mike Ralphson schrieb:
> 2008/9/7 Arjen Laarhoven <arjen@yaph.org>
>> The standard libc regex library on OSX does not support alternation
>> in POSIX Basic Regular Expression mode.  This breaks the diff.funcname
>> functionality on OSX.
>>
>> Also, I'm sure the problem occurs on more non-Linux systems (or non
>> GNU libc systems).  If people who have access to those systems (BSD's,
>> HP-UX, AIX, etc) can test it, I'd be happy to add those systems to the
>> patch so it can fix for multiple systems at once.

The MinGW part of this patch works just fine:

Tested-by: Johannes Sixt <johannes.sixt@telecom.at>

> I can confirm that the issue shown up by your new testcase is also
> present in AIX 5.3.
...
> but I'm afraid I don't know how to get the combination of gcc + AIX ld
> to link to this in preference to the system defined regex functions.

Does this patchlet help? It gives no warnings or errors on my AIX 4.3.3
box and passes the new test (which fails without this).

diff --git a/Makefile b/Makefile
index 98d67f1..0637419 100644
--- a/Makefile
+++ b/Makefile
@@ -702,6 +702,8 @@ ifeq ($(uname_S),AIX)
 	INTERNAL_QSORT = UnfortunatelyYes
 	NEEDS_LIBICONV=YesPlease
 	BASIC_CFLAGS += -D_LARGE_FILES
+	COMPAT_CFLAGS += -Icompat/regex
+	COMPAT_OBJS += compat/regex/regex.o
 endif
 ifeq ($(uname_S),GNU)
 	# GNU/Hurd
