From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFH] plumber's puzzle
Date: Mon, 23 Apr 2007 17:51:19 -0700
Message-ID: <462D5487.2000601@zytor.com>
References: <7v647ombi6.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0704221341080.9964@woody.linux-foundation.org> <7vps5wkph5.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0704221546160.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 02:52:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg9GE-0001Un-3V
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 02:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031003AbXDXAv7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 20:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031005AbXDXAv7
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 20:51:59 -0400
Received: from terminus.zytor.com ([192.83.249.54]:55931 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031003AbXDXAv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 20:51:58 -0400
Received: from [172.27.0.16] (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l3O0pJ2t017444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Apr 2007 17:51:20 -0700
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <alpine.LFD.0.98.0704221546160.9964@woody.linux-foundation.org>
X-Virus-Scanned: ClamAV 0.88.7/3152/Mon Apr 23 15:34:59 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=2.0 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_96_XX,RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no
	version=3.1.8
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45396>

Linus Torvalds wrote:
> 
> On Sun, 22 Apr 2007, Junio C Hamano wrote:
>> I should be happy that I figured out what is going on, but I am
>> not very happy with this patch.
> 
> That actually looks like the right patch.
> 
> The "fflush() before fork()" thing is a real issue, and a real bug. Stdio 
> is buffered, and yes, fork() will duplicate the buffer if not flushed.
> 
> Of course, I'm not 100% sure that is the right _place_ for the fflush() 
> call. I wonder if we should just do the fflush() closer to the place that 
> generates the data. As it is, we may have other things like that lurking.
> 
> Of course, delaying the fflush as long as possible is likely good for 
> performance, so doing it just before the fork() (even if it may be ugly 
> and somewhat unexpected at that point to have to do it) may just be the 
> right thing regardless...
> 

It might be worthwhile to have a wrapper function for fork() which adds 
fflush(NULL); before forking?

	-hpa
