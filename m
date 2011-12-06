From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Auto update submodules after merge and reset
Date: Tue, 06 Dec 2011 22:32:04 +0100
Message-ID: <4EDE89D4.7040001@web.de>
References: <4ED57EED.4040705@qualcomm.com> <4ED5E9D2.4060503@web.de> <4EDD6A8C.40008@qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Max Krasnyansky <maxk@qualcomm.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 22:32:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY2cb-0001ax-Mn
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 22:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019Ab1LFVcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 16:32:13 -0500
Received: from fmmailgate05.web.de ([217.72.192.243]:41431 "EHLO
	fmmailgate05.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539Ab1LFVcM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 16:32:12 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate05.web.de (Postfix) with ESMTP id 8A5CC67C160F
	for <git@vger.kernel.org>; Tue,  6 Dec 2011 22:32:11 +0100 (CET)
Received: from [192.168.178.25] ([80.187.97.183]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MCZP8-1RgKMM0wgE-009SsP; Tue, 06 Dec 2011 22:32:09
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4EDD6A8C.40008@qualcomm.com>
X-Provags-ID: V02:K0:lxDkXz3yBBAWyWo/zSNDW5G9+UZinA9/r8W1RroTWzX
 CsYKLaMryh49FepDIM1gkJGFTmGrv6ZjpPukSpEP+4HYFibn5v
 wpBFXgIV4thRDBsXTiRd9p4ccnBlfBSnsoec7TRrsfNWjpxdVd
 7/Xi/eAGcfNh+Fax0J01vU07oQvG2+6ZHp7VXkK3e58X4F4l9f
 k8dWydzxG10jUDaMYpWpg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186387>

Am 06.12.2011 02:06, schrieb Max Krasnyansky:
> On 11/30/2011 12:31 AM, Jens Lehmann wrote:
>> I'm working on a patch series to teach Git to optionally update the submodules work trees on checkout, reset merge and so on, but I'm not there yet.

> Everything you suggested sounds great. We're on the same page (config option, etc).
> How far along are you? Do you have a tree I could pull from to play with things?
> I could help with testing, bug fixes and/or implementing parts of it. Let me know.

Great to hear that! Please see my GitHub repo for the current state:
https://github.com/jlehmann/git-submod-enhancements

It has two interesting branches:

git-checkout-recurse-submodules:
This was my first attempt to tell unpack_trees() to checkout submodules
and works quite well. Porcelain checks out submodules by default while
plumbing learned the --recurse-submodules option to do that (and git gui
and gitk use that option so stuff like "Revert Changes" does work on
submodules :-). I use it at work for some time and it works quite well,
but doesn't handle new or deleted submodules. And unfortunately the way
I added the flag to control submodule checkout doesn't allow to add a
per-submodule configuration option.

recursive_submodule_checkout:
This is where new development happens. I added the basic infrastructure
to have global and per-submodule configuration controlling the checkout
and ported the unpack_trees() changes from git-checkout-recurse-submodules
here. I also added removal and creation of submodules based on the now
moved gitdir. This branch has rudimentary tests but still needs quite some
work.

I expect to have some time around the end of year to move things forward.
It'd be cool if you could check the current state, after that we can
decide how to move the topic forward together.

> For now I implemented automatic submodules update using 'post-merge' hook. But obviously it does
> not handle reset and things. I'm thinking of adding 'post-reset' and 'pre-merge' that would be useful
> for this and maybe other things.

I doubt hooks can be more than a band aid for submodule checkout. I thought
about doing that too and came to the conclusion it will only handle some of
the issues. And you'll have to provide a real life use case to get a new
hook accepted ;-)
