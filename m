From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH] add update to branch support for "floating submodules"
Date: Tue, 13 Dec 2011 22:09:09 +0100
Message-ID: <4EE7BEF5.6050205@web.de>
References: <20111109174027.GA28825@book.fritz.box> <7vr51htbsy.fsf@alter.siamese.dyndns.org> <20111129220854.GB2812@sandbox-rc.fritz.box> <loom.20111210T062013-538@post.gmane.org> <7vborhaqgw.fsf@alter.siamese.dyndns.org> <CALFF=ZQKRgx_AodBQH17T9cSe_JFtoKie7DoMMfkTXCyCFospw@mail.gmail.com> <7vaa6x4m5l.fsf@alter.siamese.dyndns.org> <CABURp0pPqpkWXdC+97wR8HZeX=Nbi0bn-3ji+k9LQnj0kFjCnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Leif Gruenwoldt <leifer@gmail.com>, git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 22:10:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaZcR-000824-JM
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 22:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910Ab1LMVKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 16:10:31 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:42994 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692Ab1LMVKa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 16:10:30 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate02.web.de (Postfix) with ESMTP id BAE461BB4DFB5
	for <git@vger.kernel.org>; Tue, 13 Dec 2011 22:10:28 +0100 (CET)
Received: from [192.168.178.25] ([80.187.110.206]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0M0hsk-1QkFAM3RpW-00umbJ; Tue, 13 Dec 2011 22:10:28
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <CABURp0pPqpkWXdC+97wR8HZeX=Nbi0bn-3ji+k9LQnj0kFjCnQ@mail.gmail.com>
X-Provags-ID: V02:K0:6MY+lxDuLlRbX/RSks8ad8MVw/LtFDXoIZka5FPxxu5
 ADl2XsXi/Dd2Gje6Ulp3xtOzxHIiGO73XC5HOx0vL1Edf9eTtK
 unZqPVxKkSrdHW3cscauBpRqYZKXnEGlkngbtQXafLTQmsKq9Z
 kNTIQ2ul4H/UyOYfCr5fk9spmRMGEqphrGvrW2yx4idTlpqBfe
 n6dj9O5yMDLz0Lifia3RQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187061>

Am 13.12.2011 15:17, schrieb Phil Hord:
> On Mon, Dec 12, 2011 at 2:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> [...]
>> Distro package dependency tracking is a poor analogy for many reasons, but
>> I'll only touch a few.
> [...]
>> Naively, one might think that two branches, branch-1.0 and branch-2.0, can
>> be defined in the repository of L, tell somebody (like "superproject that
>> covers all the packages in the distro") that A wants branch-1.0 and B
>> wants branch-2.0 of L respectively, to emulate this, but if one thinks
>> further, one would realize that it is insufficient. For one thing, it is
>> unclear what should happen when both A and B are asked to be checked out,
>> but more importantly, in dependency requirements on real distro packaging,
>> the application C could say "I want v1.0 API but v1.4 is broken and not
>> compatible with me", which won't fit on the two-branches model. A
>> workaround to add more branches to L could be devised but any workaround
>> cannot be a good solution that allows a random application C among 47
>> others to dictate how the branch structure of L project should look like.
>>
>> Fortunately, the dependency management is a solved problem by distro
>> package management and build systems, and they do so without using
>> anything from submodules. There is no point reinventing these logic in git
>> submodules and emulating poorly.
>>
>> The only remotely plausible analogy around distro packaging would be a
>> superproject full of all the packages in a distro as its submodules, and
>> records exact versions of each and every package that goes on a release
>> CD (or DVD). In that case, you do want to have a central registry that
>> records what exact version of each package is used to cut the CD and the
>> mother of all modules superproject could be one way to implement it. But
>> that is not an example of floating, but is a direct opposite.
>>
>> This exchange convinced me further that anybody who wishes to use
>> "floating" is better off either by doing one or both of the following:
>>
>>  - using "exact" but not updating religiously, as the interdepency
>>   requirement in their project is not strict; or
>>
>>  - not using submodules at all, but merely keeping these unrelated A, B, C
>>   and L as standalone repositories next to each other in the directory
>>   structure.
> 
> My interdependency requirements are not so cut-and-dry.  We use
> submodules to isolate controlled regions of code.  We may need to
> share our project with a contractor who is allowed to see code
> pertaining to "vendorA" but not that for "vendorB" or "VendorN".  But
> our in-house developers want to have all the vendor code in one place
> for convenient integration. Submodules do this nicely for us.  We can
> give the contractor just the main modules and the VendorA modules and
> he'll be fine.  In-house devs get all the submodules (using the
> vendor-ALL superproject).
> 
> But this necessarily means there is too much coupling for comfort
> between our submodules.   For example, when an API changes in the main
> submodule, each of the vendor submodules is affected because they each
> implement that API in a custom method.  Some of those vendor modules
> belong to different people.  Submodule synchronization becomes a real
> chore.

Hmm, maybe having vendor-specific branches in the superproject would
help here. But that is hard to tell without knowing more details about
your setup. But I suspect your vendor-ALL superproject is exactly the
right spot to deal with these kind of problems (and if that isn't easy
that might be a result of the difficulty of the problem you are trying
to solve here, keeping different vendors in sync with your API ;-).

> Floating would help, I think.  Instead I do this:
> 
>   git pull origin topic_foo && git submodule foreach 'git pull origin topic_foo'
> 
>   git submodule foreach 'git push origin topic_foo' && git push origin topic_foo

This sounds to me like you would need the "--recurse-submodules" option
implemented for "git pull" and "git push", no? And I miss to see how
floating would help when the tips of some submodules are not ready to
work with other submodules tips ...

> But not all my developers are git-gurus yet, and they sometimes mess
> up their ad hoc scripts or miss important changes they forgot to push
> in one submodule or another.

Sure, even though current git should help you some by showing changes
in the submodules.

>  Or worse, their pull or push fails and
> they can't see the problem for all the noise.  So they email it to me.

We circumvent that by not pulling, but fetching and merging in the
submodule first and after that in the superproject. You have much more
control about what is going wrong where (and can have more
git-experienced people help with - or even do - the merges).

> On my git server, I have a hook that automatically propagates each
> push to "master" from the submodules into the superproject.  But this
> is tedious and limited.  And it relies on a centralized server.

But for closely related stuff that is a good option. Our continuous
integration server shows us quite some breakage between submodules
before they hit a superproject, which is really helpful.

> You may say this itch is all in my head, but it sure seems real to me.

This definitely is a real problem. Lets see how far git can help you
here...
