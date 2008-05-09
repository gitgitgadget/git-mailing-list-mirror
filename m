From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git gc & deleted branches
Date: Fri, 09 May 2008 10:14:12 -0500
Message-ID: <48246A44.7020303@nrlssc.navy.mil>
References: <20080508210125.GC32762@sigill.intra.peff.net> <alpine.LFD.1.10.0805081712270.23581@xanadu.home> <20080508211734.GA819@sigill.intra.peff.net> <48236F69.2060900@nrlssc.navy.mil> <20080508213107.GA1016@sigill.intra.peff.net> <48237344.6070405@nrlssc.navy.mil> <20080508214454.GA1939@sigill.intra.peff.net> <48237650.5060008@nrlssc.navy.mil> <20080508224827.GA2938@sigill.intra.peff.net> <loom.20080509T011318-478@post.gmane.org> <20080509041921.GA14773@sigill.intra.peff.net> <E1B43061-69C7-43D7-9A57-34B7C55DF345@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Fri May 09 17:15:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuUJu-0001sU-OW
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 17:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887AbYEIPOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 11:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753649AbYEIPOt
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 11:14:49 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40325 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbYEIPOs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 11:14:48 -0400
Received: from starfish.gems.nrlssc.navy.mil (starfish.nrlssc.navy.mil [128.160.50.76])
	by mail.nrlssc.navy.mil (8.13.8/8.13.8) with ESMTP id m49FEEe4027055;
	Fri, 9 May 2008 10:14:14 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 9 May 2008 10:14:14 -0500
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <E1B43061-69C7-43D7-9A57-34B7C55DF345@adacore.com>
X-OriginalArrivalTime: 09 May 2008 15:14:14.0173 (UTC) FILETIME=[57630CD0:01C8B1E7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81615>

Geert Bosch wrote:
> 
> On May 9, 2008, at 00:19, Jeff King wrote:
> 
>> I like it. It makes an easy rule to say "packed objects _never_ get
>> pruned, they only get demoted to loose objects." And then of course
>> we have sane rules for pruning loose objects.
> 
> Isn't there an issue with the "git gc" triggering because there
> may be too many loose unreferenced objects?
> Still, I do like the approach.

This would be an argument for going the extra mile and having the loose
objects adopt the timestamp of their pack file. In the normal case they
would probably be pruned immediately during the same git-gc run.

> Maybe unreferenced objects and old refs should go to a .git/lost+found
> directory and be expired from there. This has a couple of benefits:

>   -  Objects will not be accessible by ordinary git commands for a while,
>      before they are really removed, avoiding surprises

Unreferenced objects are sometimes used by other repositories which have
this repository listed as an alternate. So it may not be a good idea to
make the unreferenced objects inaccessible.

-brandon
