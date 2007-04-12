From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Thu, 12 Apr 2007 15:56:37 +1200
Message-ID: <461DADF5.2010902@vilain.net>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <200704101828.37453.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0704101122510.6730@woody.linux-foundation.org> <200704102004.08329.andyparkins@gmail.com> <Pine.LNX.4.64.0704101219280.6730@woody.linux-foundation.org> <7vwt0kugmy.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704101325580.6730@woody.linux-foundation.org> <461D798B.3040008@vilain.net> <Pine.LNX.4.64.0704111854160.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 05:56:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbqQR-0003zn-PR
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 05:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030521AbXDLD4o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 23:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030614AbXDLD4o
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 23:56:44 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:37749 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030521AbXDLD4o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 23:56:44 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 7BCE413A403; Thu, 12 Apr 2007 15:56:41 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 6F99913A3E1;
	Thu, 12 Apr 2007 15:56:37 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <Pine.LNX.4.64.0704111854160.4061@woody.linux-foundation.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44316>

Linus Torvalds wrote:
>> Whoa... "missing" subproject data?
>>     
> Absolutely. Not just subproject data. The whole subproject is often 
> missing.
>
> If I fetch the KDE superproject, I generally do *not* want every single 
> subproject. In fact, I'd likely just want one or two subprojects.
>   

Ok, but couldn't this be considered a variation of a lightweight checkout?

The only reason I'm worried about this is the case where the
superproject contains *thousands* of subprojects. Eg, a superproject for
all repo.or.cz projects. Say in a day 200 projects get updated with a
few commits - do you have to do 200 pulls or just one? But maybe that
problem can be solved in another way, or maybe it won't really hurt so
much in practice and still be faster/more efficient than rsync mirroring.

This is especially the case in concert with gittorrent, which will need
modifications to support sharing multiple repositories (not that that's
a huge issue, given there's no implementation yet).

>> Surely, unless you're doing lightweight/shallow clones, if you have a
>> gitlink you've also got the dependent repository? Otherwise the
>> reachability rule will be broken.
>>     
>
> The reachability rule *must* be breakable. That's why fsck currently 
> doesn't care AT ALL.
>
> It's much better to break that rule than to even check it! I'd rather 
> leave fsck like it is now, than to *ever* fix it, if the "fix" involves 
> "you have to always fetch all submodules to shut fsck up".
>   

Well fsck can be fixed easily enough to not descend, like lightweight
checkouts.

What I really want to avoid is the situation where you can't checkout,
even though you didn't indicate a shallow/lightweight clone.

What else might this decision impact? Obviously with a smaller base you
have fewer delta targets, though that's probably not a real issue.

Sam.
