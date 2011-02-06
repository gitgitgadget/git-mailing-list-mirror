From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] git pull: Remove option handling done by fetch
Date: Sun, 06 Feb 2011 22:59:44 +0100
Message-ID: <4D4F19D0.2000408@web.de>
References: <4D4C5EBC.2090100@web.de> <201102042326.08607.j6t@kdbg.org> <4D4D33E7.4000303@web.de> <7vipwwx56r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 06 23:00:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmCeB-000591-PN
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 22:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551Ab1BFV7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 16:59:49 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:45633 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859Ab1BFV7t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 16:59:49 -0500
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate01.web.de (Postfix) with ESMTP id A92AC18774BE9;
	Sun,  6 Feb 2011 22:59:47 +0100 (CET)
Received: from [93.240.100.155] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PmCe3-00078M-00; Sun, 06 Feb 2011 22:59:47 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7vipwwx56r.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+M+rIMIe2dPTVVbze2cZlVrQdtl1YTYpSROTyY
	HUnV2Zi8oboCcx1vwUAIe/n0JWlnltHv5TUjeHih+MeiNrtbj6
	QTSwJPj2ghVHR2Ip0OgQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166205>

Am 06.02.2011 21:45, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Yes, but isn't that exactly what the pull man-page says? Quote:
>> "Options meant for git pull itself and the underlying git merge
>> must be given before the options meant for git fetch."
> 
> Yes, it says that, and I think that was a weasely way to say "the command
> line parser in git-pull is broken".  The lines you are removing was from
> the patch that fixed that breakage, aren't they?

Nope, they were from the patch where I taught "git fetch" the
"--recurse-submodules" option and was not aware at that time that
"git pull" should just pass on almost all fetch options (the only
exceptions to that rule being -q, -v, -n and --progress). The thing
I had in mind was to later pass the same "--recurse-submodules"
option to the merge command too (when I finished implementing that
option). But when I understood later that pull handles the fetch
options in an interesting way I noticed that it would depend on the
order of options given if the "--recurse-submodules" would then be
passed to both fetch and merge or just to fetch, which will lead to
an interesting and unintuitive behavior I was not eager to expose.

So yes, I hit the strangeness of the "git pull" option parsing, but
decided to not mess it up further by adding another option to the
ones it does handle differently but play by the rules which are
used now (The other possibility would have been to document it
as a new option to "git pull", but that would have lead to the
problem I described earlier when merge will learn that option too).

So I have no strong feelings about this patch but believe it is the
right thing to do as long as "git pull" handles its options the way
it does. But looking at the confusion that option handling caused
I think it might be a worthwhile idea to overhaul it.

(CCed Jonathan, as he is the author of the lines I quoted)
