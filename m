From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Subtree with submodule inside?
Date: Wed, 06 Aug 2014 22:14:35 +0200
Message-ID: <53E28CAB.4040800@web.de>
References: <CAHd499CaCeHYGZSQeY8MRVnnjXBTgDy=OUqBYqNd1e5GiKre_A@mail.gmail.com>	<xmqqk36lmrpl.fsf@gitster.dls.corp.google.com> <CAHd499AmY+EYXAK8h_oYiOn-amnNrE1+a7qsQ4x7bCOVsJDxcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Robert Dailey <rcdailey.lists@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 22:14:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF7bn-0007ei-Bt
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 22:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496AbaHFUOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 16:14:46 -0400
Received: from mout.web.de ([212.227.17.12]:61042 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751426AbaHFUOp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 16:14:45 -0400
Received: from [192.168.178.41] ([79.193.79.121]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MZDKy-1X0sXQ1Qey-00KuRQ; Wed, 06 Aug 2014 22:14:36
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <CAHd499AmY+EYXAK8h_oYiOn-amnNrE1+a7qsQ4x7bCOVsJDxcw@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:ULx1z9YLhDhRPLYEm3zYk1AiVrsvTH28LZ3vMIkmrHwS0Kv6RGC
 iw75/RjEeRTX6JoFoo142OusWZ48WSb+cYepY1dfcEJcQ9I8KbzrlvER9+hOy1PQnm0+F+U
 3VYypaD46NSZ9c/oBVgkPnQ9OFkQj21bc5V5PCEDroNH4ncT3h1tKCPAncka2Dx1DIDoVni
 lzC7Ws8UNjQsLhngEpw3A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254900>

Am 06.08.2014 um 20:18 schrieb Robert Dailey:
> On Wed, Aug 6, 2014 at 12:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> My knee-jerk reaction would be "subtree would break submodules
>> badly, don't use it" ;-).
>>
>> After all, I invented subtree merge as an ugly interim workaround
>> before submodule subsystem got into a usable shape, hoping that new
>> projects can use submodules without resorting to subtree merges.
> 
> (Sorry Junio, I forgot to "Reply all" and accidentally sent this only
> to you. Resending to group)
> 
> Hi Junio. I agree it certainly does sound evil and defeats the purpose
> of the goal of ultimately creating a simple workflow :)
> 
> Could you go over how you feel the submodule system got into "usable"
> shape? It still seems to still have all of the problems I still hate:
> 
> * If you branch a production branch to implement a feature that also
> impacts the submodule, you need to branch the submodule. There is no
> easy interface for this and rather clumbsy, especially if people are
> using GUI tools like SourceTree (most of the people on my team are).

There were thoughts about having "git branch" optionally create a
branch in the submodule too. But in a lot of real world scenarios
that won't help because the same branch name won't necessarily make
sense in superproject and submodule at the same time, so you'd have
to create different branches anyway. But if it makes a significant
amount of users happy, I think adding --recurse-submodules to "git
branch" might make sense to make life easier for them.

I do not know SourceTree myself, but do you have any ideas you'd
like to share how you could envision to make branching less tedious?
I hope it at least shows you that there are modifications inside the
submodule while examining the superproject and provides an easy way
to start a new instance inside the submodule to commit the changes
there? Otherwise it'd make life unnecessarily hard for you.

> * Pull requests do not include submodule changes in the review (we use
> Atlassian Stash). So 1 pull request per submodule has to be performed
> and they have to be merged in the appropriate order.

Which seems to be a chore in your scenario, but is just the Right
Thing to do when someone else maintains the submodule. Given the
danger of a rebase in the submodule pulling away the commit recorded
in the superproject it is considered best practice to always merge
in the submodule into a never-to-be-rebased branch first before
committing the superproject. But I agree it is twice the work.

> * Submodules complicate an otherwise beautiful workflow that Git is
> supposed to provide (branching) in many ways, and also there are
> restrictions on the order in which you modify parent repository vs
> submodule.

I cannot remember anyone coming up with a better workflow when
having distinct repos (superproject and submodule). Subtree on the
other hand has other issues (like you can easily forget to push a
fix to a subtree to its upstream, which is something submodules
make you aware of). And the submodule workflow is as beautiful as
ever if you consider superproject and submodule different repos
(which they are), and then it is obvious that you have to do
everything twice ;-)

But I do have the impression that a lot of third party tools are
still rather submodule ignorant and of not much help there.

> If I'm going to put my common code in a separate module for the
> purposes of splitting apart projects that depend on the common code, I
> want the workflows that Git provides to remain simple. Subtrees seem
> to do that, you just sync with the common repo every now and then.

If you are only interested in single "from upstream into my repo"
workflow and don't care much about pushing your local changes back
to the common code repo, subtrees are easier to use than submodules.
But if you need or want to contribute your changes back, I believe
submodules gain the upper hand rather quickly.

But back to your original question: I do no see a way to import
another repo using a submodule via subtree either. You'd have to
consistently use submodules to make that work (even if that means
that you'll have three repos to think about, one being embedded in
the other).
