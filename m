From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Remove useless if-before-free tests.
Date: Mon, 18 Feb 2008 10:01:09 +0100
Message-ID: <87ve4my6y2.fsf@rho.meyering.net>
References: <871w7bz1ly.fsf@rho.meyering.net>
	<alpine.LSU.1.00.0802172210470.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 18 10:01:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR1sh-0004UA-46
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 10:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296AbYBRJBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 04:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755286AbYBRJBM
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 04:01:12 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:54861 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755233AbYBRJBL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 04:01:11 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 0750617B536
	for <git@vger.kernel.org>; Mon, 18 Feb 2008 10:01:10 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id E0D3317B547
	for <git@vger.kernel.org>; Mon, 18 Feb 2008 10:01:09 +0100 (CET)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 7969828E1A;
	Mon, 18 Feb 2008 10:01:09 +0100 (CET)
In-Reply-To: <alpine.LSU.1.00.0802172210470.30505@racer.site> (Johannes
	Schindelin's message of "Sun, 17 Feb 2008 22:16:47 +0000 (GMT)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74250>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 17 Feb 2008, Jim Meyering wrote:
>
>> It is equivalent not just because POSIX has required free(NULL) to work
>> for a long time, but simply because it has worked for so long that no
>> reasonable porting target fails the test. Here's some evidence from
>> nearly 1.5 years ago:
>>
>>     http://www.winehq.org/pipermail/wine-patches/2006-October/031544.html
>
>>From this mail, we see that there is at least one target where this leads
> to a crash (remember, git should run on more platforms than Wine).

Hi,

Thanks for the feedback.

FYI, you don't have to go back 20+ years to 3BSD to find a system on
which free(NULL) fails :-)  SunOS4's did, too.  So if that is a reasonable
porting target for git, then you will need the wrapper.  With references
to "SunOS" in Makefile and configure, I did wonder about that.  Let me
know and I'll adjust the proposed patch.

> However, such a crash is pretty obvious in our test-suite, I guess, and
> thus we could easily introduce something like this into git-compat-util.h
> should the need ever arise:
>
> #ifdef FREE_NULL_CRASHES
> inline void gitfree(void *ptr)
> {
> 	if (ptr)
> 		free(ptr);
> }
> #define free gitfree
> #endif
>
> IOW I like that type of cleanup.

:-)
