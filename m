From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Tue, 04 Sep 2007 13:36:26 +0200
Message-ID: <46DD433A.5040604@eudaptics.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com> <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC5ED4.8050202@trolltech.com> <46DD0C16.70101@eudaptics.com> <Pine.LNX.4.64.0709041145230.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 04 13:36:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISWhy-0005On-Vq
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 13:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbXIDLge (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 07:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbXIDLge
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 07:36:34 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:9286 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbXIDLgd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 07:36:33 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1ISWhr-0002Ly-ME; Tue, 04 Sep 2007 13:36:32 +0200
Received: from [192.168.1.42] (j6t.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5953E6B7; Tue,  4 Sep 2007 13:36:26 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0709041145230.28586@racer.site>
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.369, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57554>

Johannes Schindelin schrieb:
> On Tue, 4 Sep 2007, Johannes Sixt wrote:
>> Therefore, I've pushed out a fixup patch at the top of mingw.git's devel 
>> branch that converts mtime to local time
> 
> On Linux, we compare to UTC to begin with, right?  We should do that here, 
> too...  So if time(NULL) does not return UTC on MinGW, we have to wrap 
> that function, too.

According to MSDN, time(NULL) returns "the number of seconds elapsed since 
[epoch] according to the system clock". Please don't ask me what "the system 
clock" is.

Reading the implementation of time(), it starts with GetLocalTime(), 
determines whether daylight saving is in effect, and continues with another 
round of timezone adjustment - mind you: _not_ a timezone reversal (!!). 
Doesn't this look extremely bogus?

It seems we really need a wrapper for time().

-- Hannes
