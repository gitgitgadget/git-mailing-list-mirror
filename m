From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Mon, 02 Mar 2009 14:57:52 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0903021452010.17877@perkele.intern.softwolves.pp.se>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se>
 <49ABB529.1080500@viscovery.net>
 <alpine.DEB.2.00.0903021137110.17877@perkele.intern.softwolves.pp.se>
 <alpine.DEB.1.00.0903021153520.10279@pacific.mpi-cbg.de>
 <alpine.DEB.2.00.0903021256200.17877@perkele.intern.softwolves.pp.se>
 <a2633edd0903020512u5682e9am203f0faccd0acf6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 02 15:00:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le8gW-0007ie-09
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 14:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbZCBN6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 08:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbZCBN57
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 08:57:59 -0500
Received: from smtp.getmail.no ([84.208.20.33]:58171 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606AbZCBN56 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 08:57:58 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KFV00I6VTGKVX00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 02 Mar 2009 14:57:56 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFV00MEVTGHID10@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 02 Mar 2009 14:57:53 +0100 (CET)
Received: from perkele ([84.215.142.63]) by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFV00FUHTGH6990@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 02 Mar 2009 14:57:53 +0100 (CET)
Received: by perkele (Postfix, from userid 501)	id 03B4B2FC03; Mon,
 02 Mar 2009 14:57:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id F3A032FC02	for <git@vger.kernel.org>; Mon,
 02 Mar 2009 14:57:52 +0100 (CET)
In-reply-to: <a2633edd0903020512u5682e9am203f0faccd0acf6a@mail.gmail.com>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111940>

Hi!

> Makes sense too. I think the whole API would have to be changed to use 
> TCHAR*.

I'd rather just say wchar_t explicitely. I'm not particularly fond of macros 
that change under your feet just because you fail to define a symbol 
somewhere...

> Then you need to do the right conversion at the right places, this will be 
> quite tricky, painful work, but there is probably no way around that.

In the other project I worked on we ended up wrapping all file-related calls 
in our own porting interface, and then let each platform we compiled for 
implement their own methods for handling Unicode paths. For Windows it's 
trivial since all APIs are Unicode. For Unix-like OSes it's tricky as you 
have to take the locale settings into account, but fortunately the world is 
slowly moving towards UTF-8 locales, which eases the pain a bit.

> Note that not only conversions will be needed but you'll also need to 
> adjust all routines handling filenames to use the proper Unicode version. 
> (strchr -> _tstrchr, open -> _topen, strcpy -> _tstrcpy, strlen -> 
> _tcslen, ...).

Not necessarily. If the code can be set up to use UTF-8 char* internally, 
not everything needs to be rewritten (I've done that too, only took a 
couple of years to move the codebase over to all-Unicode).

-- 
\\// Peter - http://www.softwolves.pp.se/
