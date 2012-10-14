From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: A design for subrepositories
Date: Sun, 14 Oct 2012 15:28:19 +0200
Message-ID: <507ABDF3.4040106@web.de>
References: <20121013163322.685276teuhqhjc82.lealanko@webmail.helsinki.fi> <7vd30m2sbr.fsf@alter.siamese.dyndns.org> <20121014002304.14167k2j2ctspiuw.lealanko@webmail.helsinki.fi> <7vzk3p1xh3.fsf@alter.siamese.dyndns.org> <20121014131928.25943ezwa6fveyls.lealanko@webmail.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lauri Alanko <la@iki.fi>
X-From: git-owner@vger.kernel.org Sun Oct 14 15:28:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNOFA-0001lV-4M
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 15:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225Ab2JNN2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 09:28:24 -0400
Received: from mout.web.de ([212.227.15.4]:50594 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753217Ab2JNN2X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 09:28:23 -0400
Received: from [192.168.178.41] ([79.193.81.106]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MDPEX-1T9Ifg3OGL-00HXZZ; Sun, 14 Oct 2012 15:28:22
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <20121014131928.25943ezwa6fveyls.lealanko@webmail.helsinki.fi>
X-Provags-ID: V02:K0:8yLNuO17K/d62XScs4A8yX24ZDf0H4LTgEGiPzWzSv/
 59P2dcxNmV5mov3A0xnDu3E9NU1RK03HSCW2qWP15pY8h/VNST
 b+xqz4ep4R0KZhjYyeBMfbdsOcroczNf3opv5Pa1OG6FjaEkQe
 mKIQhjCvfAge9bOxtHZWvhTDzEqCJ7YBNIyPJ0C6nSelkOBw4Q
 9sICBRI8DTjXFKD8mC0pA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207663>

Am 14.10.2012 12:19, schrieb Lauri Alanko:
> Quoting "Junio C Hamano" <gitster@pobox.com>:
> 
>>> If the
>>> submodules ever get reorganized and foo is moved to ./bar, then it is
>>> impossible to check out older versions or alternate branches, since
>>> the submodule is no longer where it is expected to be at the origin.
>>
>> Isn't that exactly what the "module name" vs "module path" mapping
>> in .gitmodules file is meant to address?
> 
> Yes, and as I showed after the part you quoted, it is possible to refer to a module by name, although it looks like such a hack that I can't imagine it's currently something that git-submodule is intended to support.

Your initial statement is not correct. It is possible to check out older
versions or alternate branches (at least since we moved the .git directory
into the .git directory of the superproject). So no improvement gained
here by your proposal (although I concede that the current user experience
is suboptimal until my recursive submodule update work hits mainline).

>>> But still, "git submodule update" only looks at the modules in the
>>> currently checked-out tree. If we have other branches or old tags that
>>> refer to other submodules, there's no simple way to fetch those, too.

Did you notice that "git fetch" fetches all those submodules too which
have been updated in the commits fetched for the superproject, no matter
on what branch they are on?

>> Didn't I already suggest you to think about how you can improve
>> existing "git submodule" to suit your use case better?
> 
> Yes, and I listed three possible ways. Two of them seem technically unattractive, whereas one of them (submodules as ref directories) seems like a huge change that could introduce incompatibilities. That is why a separate tool seems like a cleaner choice.

What's wrong with making git clone all submodules together with the
superproject (when the user said he wants to update all submodules on
clone too by setting a - still to be added - config option)? That's my
plan to make automagic recursive submodule cloning work and it would
clone all submodules seen in the history of the superproject to
.git/modules so they could easily be checked out later (and those
present in the HEAD of the superproject will be checked out immediately
like "git clone --recurse-submodules" does right now). Were not there
yet, but that's how I believe that should work.

> There is actually a fourth alternative: extend the git protocol so that a remote repository could be queried for its list of submodules.

That information is contained in the different versions of the .gitmodules
file, so no need to extend anything here.

I saw nothing in your proposal which couldn't been handled by submodules,
and for every issue there already have been proposals on how to do that.
So adding another tool doesn't make any sense here. But you are welcome
helping us to improve the submodule script (and some core commands too)
to make submodules cover your use case too.
