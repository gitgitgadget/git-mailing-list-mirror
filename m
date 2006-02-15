From: Sam Vilain <sam@vilain.net>
Subject: Re: Handling large files with GIT
Date: Wed, 15 Feb 2006 13:40:24 +1300
Message-ID: <43F27878.50701@vilain.net>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>	<87slqty2c8.fsf@mid.deneb.enyo.de>	<46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>	<Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk>	<Pine.LNX.4.64.0602121939070.3691@g5.osdl.org>	<Pine.LNX.4.64.0602122049010.3691@g5.osdl.org>	<Pine.LNX.4.64.0602122058260.3691@g5.osdl.org>	<43F113A5.2080506@f2s.com>	<Pine.LNX.4.63.0602141953000.22451@wbgn013.biozentrum.uni-wuerzburg.de>	<Pine.LNX.4.64.0602141108050.3691@g5.osdl.org>	<43F249F7.5060008@vilain.net>	<Pine.LNX.4.64.0602141357300.3691@g5.osdl.org> <7vy80dpo9g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Feb 15 01:40:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9Ais-0002V9-Ge
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 01:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422900AbWBOAkj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 19:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422902AbWBOAkj
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 19:40:39 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:16288 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1422900AbWBOAkj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 19:40:39 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id B977F4C1A; Wed, 15 Feb 2006 13:40:35 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 584E01955;
	Wed, 15 Feb 2006 13:40:29 +1300 (NZDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <7vy80dpo9g.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16198>

Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
>>If somebody is interested in making the "lots of filename changes" case go 
>>fast, I'd be more than happy to walk them through what they'd need to 
>>change. I'm just not horribly motivated to do it myself. Hint, hint.
> 
> In case anybody is wondering, I share the same feeling.  I
> cannot say I'd be "more than happy to" clean up potential
> breakages during the development of such changes, but if the
> change eventually would help certain use cases, I can be
> persuaded to help debugging such a mess ;-).

Excellent.  Any speculations on where they might fit?  Clearly, it needs
to be out of the "tree".

Dealing with the three cases I mentioned before in my Warnocked post;

   1. caching - I'll consider this an "under the hood" thing, it really
                doesn't matter, so long as the tools all know.

   2. forensic - extra stuff at the end of the commit object?

      eg
         Copied: /new/path from /old/path:commit:c0bb171d..
           (for SVN case where history matters)
         Copied: /new/path from blob:b10b1d..
           (for general pre-caching case)
         Merged: /new/path from /old/path:commit:C0bb171d..
           (for an SVK clone, so we know that subsequent merges on
            /new/path need only merge from /old/path starting at commit
            C0bb171d..)

   3. retrospective - as above, but allow to specify old versions.

      eg
         Copied: /new/path:C0bb171d1 from /old/path:commit:c0bb171d2...
           (for SVN case where history matters)

Martin, is that enough for your CVS case?

Sam.
