From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH] add update to branch support for "floating submodules"
Date: Mon, 06 Feb 2012 22:32:07 +0100
Message-ID: <4F3046D7.2010304@web.de>
References: <20111109174027.GA28825@book.fritz.box> <7vr51htbsy.fsf@alter.siamese.dyndns.org> <20111129220854.GB2812@sandbox-rc.fritz.box> <loom.20111210T062013-538@post.gmane.org> <7vborhaqgw.fsf@alter.siamese.dyndns.org> <CALFF=ZQKRgx_AodBQH17T9cSe_JFtoKie7DoMMfkTXCyCFospw@mail.gmail.com> <7vaa6x4m5l.fsf@alter.siamese.dyndns.org> <CABURp0pPqpkWXdC+97wR8HZeX=Nbi0bn-3ji+k9LQnj0kFjCnQ@mail.gmail.com> <4EE7BEF5.6050205@web.de> <CABURp0pDoS1wgJ+Fs3XFX=A_EuR4Gzi4mHLiQP+-icT_d3J+WQ@mail.gmail.com> <4F28554D.9090107@web.de> <CABURp0pSGGT8eyzNad-dNNx49oioAxOPOf3dmqu7M3fnV+PzdA@mail.gmail.com> <4F29BEB7.1080901@web.de> <CABURp0rt=LcjMfDU61m0de-gLpX1a3x3vhb0zVxCbceSvD9jFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Leif Gruenwoldt <leifer@gmail.com>, git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 22:32:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuWAi-0007DW-Ft
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 22:32:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754926Ab2BFVcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 16:32:20 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:52966 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754193Ab2BFVcT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 16:32:19 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate02.web.de (Postfix) with ESMTP id 421021BFFD6E3
	for <git@vger.kernel.org>; Mon,  6 Feb 2012 22:32:18 +0100 (CET)
Received: from [192.168.178.20] ([91.3.188.184]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0M40jS-1Slvjm3hoI-00rs8S; Mon, 06 Feb 2012 22:32:17
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0) Gecko/20120129 Thunderbird/10.0
In-Reply-To: <CABURp0rt=LcjMfDU61m0de-gLpX1a3x3vhb0zVxCbceSvD9jFw@mail.gmail.com>
X-Provags-ID: V02:K0:l1grqeIUVtBIkJgGD5Rz5fWoqoZoe04I0fhLuMsXHEX
 +xktwkz6P9pvvlmiJgXlgZ6qMXmz2hsS8odLGikhtD6AgdMfFL
 ONIUZTU1zqGCoh2PbhdQ6MEC+psviQ752gCqaV9RlHRw7Q4dr2
 lGbsdf3Rh2ynJdd9rFhKR6zy7o/FmLVK85K3JR8cHz5mK+b2+l
 SpzzwHHxkRrjvv10uyHzg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190108>

Am 06.02.2012 18:31, schrieb Phil Hord:
> On Wed, Feb 1, 2012 at 5:37 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Hmm, I really think the fact that submodules are unaware that they
>> are part of a superproject is a feature. I'd prefer seeing that kind
>> of problem being tackled by the CI server and/or user education. Or
>> maybe a pre-commit hook which issues a warning in that case?
> 
> I agree that submodule isolation is a feature essential to the
> architecture of git and the submodules implementation.  But it is also
> a limitation, not just of this example.  A pre-commit hook is a nice
> idea, but it doesn't help 'git status' (which is the standard go-to
> answer point for "where am I").

Yes, this feature also is a limitation. To put it in other words: I want
each submodule to be a full fledged repo of its own. IMO it must always
be possible to just clone a submodule without any superproject and run
any git command in it. And the other way around: each superproject must
be usable as a submodule in another superproject. That makes adding some
kind of "superproject awareness" in a sane way rather difficult, as a
repo can't say "I live in a superproject" or "I am the topmost project".

> This has me thinking more about recursing siblings now, though. I find
> myself typing something like this quite a lot:
>     git submodule foreach 'git grep "someFunction" || :'

There was an attempt to teach git grep the --recurse-submodules option,
but unfortunately it looks like this didn't lead anywhere so far.

> Or worse (in that the UI is more unwieldy):
>     git submodule foreach 'git log --oneline "-SsomeFunction" || :'

This could also be done by teaching git log the --recurse-submodules
option. Me thinks in the long run a lot of git commands should learn
that option to make it easy to optionally include submodules in
whatever they are doing. But my focus is on recursive checkout for the
next time, so I have no idea when I find some time to do that.

> But what I want is this:
>     git --git-dir=${TOP}/../.git grep --recurse-submodules "someFunction"
> 
> But not really, because I am lazy and that is too much typing.
>     git grep --include-siblings "someFunction"
> 
> Maybe I can add a "sib" macro to get this:
>     git sib grep "someFunction"

And from what you where saying earlier a "git sib status" would be nice
too? What about using alias commands for that functionality? They could
point to a script which searches the topmost repo and calls "git submodule
foreach 'git <command> "$@" || :'" from there ...
