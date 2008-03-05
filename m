From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on
 maxsize reached
Date: Wed, 05 Mar 2008 10:18:10 +0100
Message-ID: <47CE6552.60308@viscovery.net>
References: <200803041459.29000.michal.rokos@nextsoft.cz> <47CD78C9.80003@viscovery.net> <200803050937.40345.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: Michal Rokos <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Wed Mar 05 10:19:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWpm6-00078Q-Pi
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 10:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757332AbYCEJSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 04:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757329AbYCEJSO
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 04:18:14 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:21806 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757190AbYCEJSM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 04:18:12 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JWpkh-0000Jg-LE; Wed, 05 Mar 2008 10:17:31 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6F97D6EF; Wed,  5 Mar 2008 10:18:10 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200803050937.40345.michal.rokos@nextsoft.cz>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76201>

Michal Rokos schrieb:
> HP-UX B.11.11 9000/800
> case1: -1
> case2: -1
> case3: 5
> case4: 5
> 
> HP-UX B.11.23 ia64
> case1: -1
> case2: -1
> case3: 5
> case4: 5
> 
> So HPUX impl is the same as a Windows one. So we can share the replacement.
> Please note that there's no va_copy() on HPUX.

It's not the same on Windows, which returns:

case1: -1
case2: 5
case3: 5
case4: 5

IOW, HPUX et.al. take the *size* of the buffer, whereas Windows takes the
maximal number of characters to write excluding NUL.

Which means that we need another configuration variable on Windows:

  -DSNPRINTF_SIZE_CORR=1

and

#ifndef SNPRINTF_SIZE_CORR
#define SNPRINTF_SIZE_CORR 0
#endif

in the replacement implementation. But I can do this myself in the course
of the MinGW port.

BTW, this is not only an issue of vsnprintf, but also of snprintf!

-- Hannes
