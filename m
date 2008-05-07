From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] Makefile: update the default build options for AIX
Date: Wed, 07 May 2008 12:36:18 -0500
Message-ID: <4821E892.4080104@nrlssc.navy.mil>
References: <1210149355875-git-send-email-mike@abacus.co.uk>	 <4821992F.4060201@viscovery.net>	 <e2b179460805070551x7a0072e0w4d406ef4112849ce@mail.gmail.com>	 <4821AB32.8090700@viscovery.net> <4821BECA.8020509@nrlssc.navy.mil>	 <e2b179460805070815u6cc627feo6137084fe7c5a635@mail.gmail.com>	 <4821CD5C.5010506@nrlssc.navy.mil>	 <7vfxsudrt0.fsf@gitster.siamese.dyndns.org> <e2b179460805070920i2ff5798dpacb5c55d851d5ede@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 19:38:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtnag-0007rR-0A
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 19:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761925AbYEGRhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 13:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761910AbYEGRhB
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 13:37:01 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54449 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761925AbYEGRg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 13:36:59 -0400
Received: from starfish.gems.nrlssc.navy.mil (starfish.nrlssc.navy.mil [128.160.50.76])
	by mail.nrlssc.navy.mil (8.13.8/8.13.8) with ESMTP id m47HaI24022527;
	Wed, 7 May 2008 12:36:18 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 May 2008 12:36:18 -0500
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <e2b179460805070920i2ff5798dpacb5c55d851d5ede@mail.gmail.com>
X-OriginalArrivalTime: 07 May 2008 17:36:18.0435 (UTC) FILETIME=[DB6AB530:01C8B068]
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81466>

Mike Ralphson wrote:
> Indeed. Please add ascii-art diagrams and don't use long words. I may
> then have a chance of understanding how this works,

I think this is simpler than you are making it out to be.

All the git source files currently #include git-compat-util.h. When a
platform is missing a function, we implement that function in the compat/
subdirectory and add an entry for it in git-compat-util.h.

In this case we found a problem that could be worked around by replacing every
call to fopen with an internal function. So we did the standard thing of
creating a new function in the compat/ subdirectory named git_fopen() and added
macro statements within git-compat-util.h to redefine fopen to be git_fopen.
But, git_fopen needs to call the _real_ fopen and it _also_ includes git-compat-util.h.
So, after including git-compat-util.h, we undefined the fopen macro to undo the
assignment that we had just performed. This doesn't work if the system is also setting
an fopen macro. So the fix is to avoid clobbering the system setting at all when
compiling compat/fopen.c

-brandon
