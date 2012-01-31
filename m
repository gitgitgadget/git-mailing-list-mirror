From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH] add update to branch support for "floating submodules"
Date: Tue, 31 Jan 2012 21:55:41 +0100
Message-ID: <4F28554D.9090107@web.de>
References: <20111109174027.GA28825@book.fritz.box> <7vr51htbsy.fsf@alter.siamese.dyndns.org> <20111129220854.GB2812@sandbox-rc.fritz.box> <loom.20111210T062013-538@post.gmane.org> <7vborhaqgw.fsf@alter.siamese.dyndns.org> <CALFF=ZQKRgx_AodBQH17T9cSe_JFtoKie7DoMMfkTXCyCFospw@mail.gmail.com> <7vaa6x4m5l.fsf@alter.siamese.dyndns.org> <CABURp0pPqpkWXdC+97wR8HZeX=Nbi0bn-3ji+k9LQnj0kFjCnQ@mail.gmail.com> <4EE7BEF5.6050205@web.de> <CABURp0pDoS1wgJ+Fs3XFX=A_EuR4Gzi4mHLiQP+-icT_d3J+WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Leif Gruenwoldt <leifer@gmail.com>, git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 31 21:55:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsKk5-0006vT-0F
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 21:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660Ab2AaUzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 15:55:45 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:56973 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753558Ab2AaUzo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 15:55:44 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate03.web.de (Postfix) with ESMTP id 17B171B08EBAD
	for <git@vger.kernel.org>; Tue, 31 Jan 2012 21:55:43 +0100 (CET)
Received: from [192.168.178.20] ([91.3.201.190]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LvB2o-1SazDL2gPy-010gdJ; Tue, 31 Jan 2012 21:55:42
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <CABURp0pDoS1wgJ+Fs3XFX=A_EuR4Gzi4mHLiQP+-icT_d3J+WQ@mail.gmail.com>
X-Provags-ID: V02:K0:IOTgw+7d3iqqZg61WVlLPvLaWVuBIdg6jELlAeHaIZK
 IeSzLuOzFKookM/5duoDzq6fg7Vvz9uYStkgfq2a5SvDrp//VF
 wlL7lJvdYVLRA93gizVAN/YjL3FZClEfPBzj1RDhqEtRXM5rdB
 N9UdW/2EIcgBjS8cJgrcPFQyl/jsLVjxE0VwNXLWYAU3Px33Fm
 gYtzG1F+yG7oTSgUJpbKA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189472>

Am 30.01.2012 22:15, schrieb Phil Hord:
> I lost my grip on this thread over the holidays...
> 
> On Tue, Dec 13, 2011 at 4:09 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Am 13.12.2011 15:17, schrieb Phil Hord:
>>>   git pull origin topic_foo && git submodule foreach 'git pull origin topic_foo'
>>>
>>>   git submodule foreach 'git push origin topic_foo' && git push origin topic_foo
>>
>> This sounds to me like you would need the "--recurse-submodules" option
>> implemented for "git pull" and "git push", no?
> 
> Only if I have nested submodules, but yes, we do use --recurs* in our scripts.

I'm confused, push doesn't know the "--recurse-submodules" option
at all yet while pull only does a deep fetch when it is given, the
submodule work trees are not updated to the merge result right now.

>> And I miss to see how
>> floating would help when the tips of some submodules are not ready to
>> work with other submodules tips ...
> 
> By project policy, for any branch, all submodules' tips of the
> same-named branch should be interoperable.  The CI server looks after
> this, as much as he can.

We do the same thing on our CI server, but it can only test some
combinations (even though that tends to show most problems pretty
early). But in the end every superproject is responsible to use a
working set of submodule commits, and I would rather bet on a
combination the CI server tested than on what happens to be on the
current tips.

> I think of branch names as sticky notes (extra-lightweight tags,
> sometimes).  We have linear history in many of our vendor submodules,
> but multiple "branches" indicate where each superproject branch has
> presumably finished integration.

We also add a branch in submodules every time a superproject needs
to move away from the submodules master (so the commits won't get
lost by accident).

>>> But not all my developers are git-gurus yet, and they sometimes mess
>>> up their ad hoc scripts or miss important changes they forgot to push
>>> in one submodule or another.
>>
>> Sure, even though current git should help you some by showing changes
>> in the submodules.
> 
> Real newbies may not even remember to use 'git status' strategically.

Hmm, but then they will screw up things in the superproject too, no?

>>>  Or worse, their pull or push fails and
>>> they can't see the problem for all the noise.  So they email it to me.
>>
>> We circumvent that by not pulling, but fetching and merging in the
>> submodule first and after that in the superproject. You have much more
>> control about what is going wrong where (and can have more
>> git-experienced people help with - or even do - the merges).
> 
> I do that, too, and I wish I didn't have to.  I wish I could safely
> and sanely recover from a conflicted "git pull --recurse-submodules"
> pull from the superproject.

That's what my recursive checkout work is aiming at. Me thinks after
that we will also need some good ideas on how to present and help
solving submodule merge conflicts.

> That is, I wish doing so were as
> straightforward as recovering from the same condition would be if all
> my code were in one repository instead of in submodules.
>
> Which is the gist -- I wish submodules did not make git more
> complicated than it already is.

I think we can make working with submodule much easier than it is
now, the next step being updating all submodule work trees as git
updates the superproject's work tree. Even though I suspect that in
the long run submodules will always be a bit more complicated than
having everything in one repository, I'm confident that will be by
far outweighed by the advantages they bring.
