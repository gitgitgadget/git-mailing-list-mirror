From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] mmap implementation for mingw.
Date: Fri, 21 Nov 2008 10:44:09 +0100
Message-ID: <492682E9.3030302@viscovery.net>
References: <loom.20081121T024302-370@post.gmane.org> <49266A59.4010404@viscovery.net> <gg5t5s$qc8$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 10:45:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3SZt-0002cL-Aw
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 10:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbYKUJoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 04:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbYKUJoN
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 04:44:13 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:42837 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbYKUJoM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 04:44:12 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L3SYb-00041y-Jl; Fri, 21 Nov 2008 10:44:09 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3EA37A865; Fri, 21 Nov 2008 10:44:09 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <gg5t5s$qc8$1@ger.gmane.org>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "lilzmailsa01.liwest.at", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Please "reply to all" to keep the Cc list. Vasyl' Vavrychuk
	schrieb: >> Did you notice any differences with this? Or is this change just
	>> because-we-can? > Not yet. This patch makes sense only if there is a noticable
	speed improvement. I doubt that the gain is measurable in the warm-cache
	case, but in the cold-cache case we can perhaps indeed save a number of disk
	accesses if whole pack files need not be slurped in (which the current mmap
	replacements do). [...] 
	Content analysis details:   (-1.4 points, 7.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101504>

Please "reply to all" to keep the Cc list.

Vasyl' Vavrychuk schrieb:
>> Did you notice any differences with this? Or is this change just
>> because-we-can?
> Not yet.

This patch makes sense only if there is a noticable speed improvement. I
doubt that the gain is measurable in the warm-cache case, but in the
cold-cache case we can perhaps indeed save a number of disk accesses if
whole pack files need not be slurped in (which the current mmap
replacements do).

> Maybe write own getpagesize() based on GetSystemInfo()?

It's probably worth it (but only if mmap() makes sense at all).
getpagesize() is used in the "sliding window" code to access pack files,
and then the offset is non-zero and must be aligned properly. Make this a
separate commit.

-- Hannes
