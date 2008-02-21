From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 2/2] Add support for url aliases in config files
Date: Thu, 21 Feb 2008 10:31:09 -0600
Message-ID: <47BDA74D.8080608@freescale.com>
References: <200802202203.m1KM37aR012221@mi1.bluebottle.com>  <alpine.LSU.1.00.0802202221130.17164@racer.site>  <7v4pc316gq.fsf@gitster.siamese.dyndns.org> <76718490802201726t677b1498ma3bdb3dbf25dd781@mail.gmail.com> <alpine.LFD.1.00.0802201735030.7833@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?44GX44KJ44GE?= =?UTF-8?B?44GX44Gq44Gq44GT?= 
	<nanako3@bluebottle.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 17:48:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSEaJ-0003uw-QZ
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 17:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759390AbYBUQrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 11:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752806AbYBUQrJ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 11:47:09 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:54075 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbYBUQrI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 11:47:08 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m1LGVCCV013136;
	Thu, 21 Feb 2008 09:31:13 -0700 (MST)
Received: from [10.214.72.61] (mvp-10-214-72-61.am.freescale.net [10.214.72.61])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m1LGVBxj001641;
	Thu, 21 Feb 2008 10:31:11 -0600 (CST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.LFD.1.00.0802201735030.7833@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74632>

Linus Torvalds wrote:
> 
> The only really sane use of this is the one that Daniel started out with: 
> you may have a "external" representation of a name, but for your own 
> purely local configuration reasons, you may want to map that name into 
> another one that works for you.
> 

[ snip ]

> So it's generally *not* that it's an "alias" for another site, since it 
> isn't that in general - it may just be a very local configuration thing. 
> It's also not really that you would call it one thing and others would 
> call it another thing: you want to call it the *same* thing as others call 
> it, but you want to work around some specific site issue (or just use a 
> cache that is closer without having to think about it).

I totally agree with all that.

> 	[access "git://git.kernel.org/*"]
> 		proxy = proxy-program
> 		url = "ssh://master.kernel.org/*"
> 
> which admittedly looks rather strange too, but at the same time it does 
> make sense from a "what do we really want to do?" standpoint.
> 
> Of course, in this case Daniel didn't actually do that "proxy" part, but I 
> think the argument that we should try to make the config file syntax 
> describe what the user wants to do is still very true. So skip that 
> "proxy" part (maybe somebody wants to do that too some day), and leave the 
> 
> 	[access "original"]
> 		url = "rewritten"
> 
> kind of syntax.
> 
> (And no, I'm not at all married to the "access" and "url" parts - I don't 
> care. I'm just saying that syntax should be tied to what people want to 
> do, not anything else.

Right.  And I think part of the issue is, which of the two forms will
be present in the user's git requests?  He'd _like_ to use the same,
canonical name everyone else does, but for whatever reason, it has to
be rewritten for the actual transportation implementation to work.
Sort of like virtual/physical address definitions here?

    [virtual_url "git://git.kernel.org/"]
        physical_url = "ssh://master.kernel.org/"

But maybe it needs to be:

    physical_url ["ssh://master.kernel.org/"]
        virtual_url = "git://git.kernel.org/"
        virtual_url = "git://kernel.org/"

The git user would use the virtual_url, but it would be translated
to the physical_url for the underlying implementation to work.

I think it is more than paint coloring at work here.  The important
part is to convey the concepts properly with the names.  The reader
of the config file has to be able to tell which way the mapping is run.

jdl
