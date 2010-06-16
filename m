From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [WIP PATCH 0/3] implement merge strategy for submodule links
Date: Wed, 16 Jun 2010 19:16:42 +0200
Message-ID: <4C1906FA.7010906@web.de>
References: <cover.1276059473.git.hvoigt@hvoigt.net> <201006150159.42680.johan@herland.net> <4C17BA67.4060500@web.de> <201006160205.20705.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jun 16 19:16:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOwEO-00025C-G6
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 19:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554Ab0FPRQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 13:16:45 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:49981 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932482Ab0FPRQo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 13:16:44 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate03.web.de (Postfix) with ESMTP id DFF1A156C99DA;
	Wed, 16 Jun 2010 19:16:42 +0200 (CEST)
Received: from [80.128.110.21] (helo=[192.168.178.26])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OOwEE-0002lu-00; Wed, 16 Jun 2010 19:16:42 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <201006160205.20705.johan@herland.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18gNvIk/59wqxkGX+5b+f2hPFbpH5En6WG7/lFw
	muq/iHlAvY5JqAL43YBDMvzIBWkzkii6X545oIGZEv5FyrvpvC
	9g5R6WMEwLmeenwpkWPQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149267>

Am 16.06.2010 02:05, schrieb Johan Herland:
> - If the purpose is to re-use existing submodule merges then I'm afraid (as 
> I've argued above) that this would happen too seldom to be useful in 
> practice (and even then you would already have had to set up the appropriate 
> config for your branch, to enable Git to find this pre-existing merge at 
> all).

That this is all but happening seldom for us is the reason for this WIP
patch from Heiko. And other use cases won't be harmed by this change, no?
And if some are, we can add a config option to .gitmodules to control that.


> Taking a step back and comparing the merging of submodules vs. the merging 
> of regular files:
> 
> Git's rules are simple and straightforward for regular files: If both 
> sides/branches have changed the same area of code (and the changes don't 
> exactly coincide), you get a conflict. There's no magic/cleverness applied 
> to try to figure out what a good resolution would look like; it's a 
> conflict, and the user must resolve it. Simple as that.
> 
> I'd argue that the submodule case should be the same: If both sides/branches 
> change the submodule (and the SHA1s don't exactly match), you get a 
> conflict, and it's up to the user to resolve it.
> 
> We may to make an exception for the case where one SHA1 is a descendant of 
> the other (i.e. a fast-forward situation), since that seems like a safe 
> choice in most situations, but I don't feel safe doing much beyond that.

Yes, I would like to see that fast-forward case silently handled by a merge
in the superproject.

And if it is no fast-forward but you find a unique merge where both of these
SHA1s are included, you could advertise it as a possible solution but not
automagically add it to the index. So you give the maintainer of the
superproject the opportunity to assess a possible solution but spare him the
chore of trying to find the reason why the merge failed and what he can do
about it by showing him the right direction. He might then decide to take a
later commit of the submodule or resolve the whole issue differently, but
that is up to him.


>> And for me the first commit containing the others is the one I would like
>> to see then.
> 
> In that case you will have to modify Heiko's patches, because (I believe) 
> they currently choose the _latest_ commit containing the others...

Yes, but IMHO that is a bit too much forwarding.
