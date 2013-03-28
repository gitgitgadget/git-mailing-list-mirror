From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Composing git repositories
Date: Thu, 28 Mar 2013 21:40:44 +0100
Message-ID: <5154AACC.7050006@web.de>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com> <7vmwtqt8rs.fsf@alter.siamese.dyndns.org> <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com> <7vvc8comj5.fsf@alter.siamese.dyndns.org> <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com> <51537A7B.7050206@web.de> <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 21:41:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULJdS-0007WP-I5
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 21:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082Ab3C1Uky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 16:40:54 -0400
Received: from mout.web.de ([212.227.17.11]:50761 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576Ab3C1Uky (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 16:40:54 -0400
Received: from [192.168.178.41] ([91.3.172.174]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LopMx-1Ut0YJ1z6x-00gnYV; Thu, 28 Mar 2013 21:40:44
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:hIUuZhDNJEbMoOJqNCbgGVxsBshVRCLSSUVyv3Mrp6u
 J2WcLwsguXbl5n+AlSw9lUcEqEDV9F1QHEJq1v7rPjtwIGG6wZ
 e887G1Nrh6EiYGDNVg6cq/3b057fRuU3UruOm2n4Y/Qno/k9zz
 2Grk0LCo2aulzJ7fih7yY3etEs8vCbwKh+Pvul2mSS8UxJk2Co
 LVUuICnAOLfY+YSlFWSmA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219460>

Am 28.03.2013 10:16, schrieb Ramkumar Ramachandra:
> Jens Lehmann wrote:
>> Unless you acknowledge that submodules are a different repo, you'll
>> always run into problems. I believe future enhancements will make
>> this less tedious, but in the end they will stay separate repos
>> (which is the whole point, you'd want to use a different approach
>> - e.g. subtree - if you want to put stuff from different upstreams
>> into a single repo without keeping the distinction where all that
>> came from).
> 
> I acknowledge that it's a different repository.  It's just that I
> think that our current design has too many seams: why do you think
> it's impossible to make it seamless?
> 
> git-subtree is not an answer to anything.  Dumping all the history
> into one repository has its limited usecases, but it is no solution.

Guess what: submodules are the solution for a certain set of use
cases, and tools like subtree are a solution for another set of
use cases. There is no silver bullet.

>> What else than a commit object should that be??? Submodules are
>> there to have a different upstream for a part of your work tree,
>> and that means a commit in that repo is the only sane thing to
>> record in the superproject. A lot of thought has been put into
>> this, and it is definitely a good choice [1].
> 
> Linus argues that it shouldn't be a tree object, and I agree with
> that.  I don't see an argument that says that the commit object is a
> perfect fit (probably because it's not).

There was discussion about what to record in the index/commit of
the superproject in early submodule days (some time before I became
involved in Git, seems I currently cannot find a link to that). A
commit is the thing to record here because it *is* the perfect fit,
as some years of submodule experience show.

>> How? The "submodules suck, we should try a completely different
>> approach" thingy comes up from time to time, but so far nobody
>> could provide a viable alternative to what we currently do.
> 
> My argument is not "submodules suck; we should throw them out of the
> window, and start from scratch" at all.  I'm merely questioning the
> fundamental assumptions that submodules make, instead of proposing
> that we work around everything in shell.  We don't have to be married
> to the existing implementation of submodules and try to fix all the
> problems in shell.

You cannot simply change the fundamental assumptions of submodules
and expect them to be the same thing afterwards. And it doesn't
matter at all if we "fix all the problems in shell" or in C-code,
we'll fix the remaining problems that are fixable in whatever part
of Git it makes sense. And I don't have the impression you have an
idea about what submodules are good at, where they can be improved
and what problems they'll probably never solve.

>> And apart from that, let's not forget we identified some valuable
>> improvements to submodules in this thread:
>> [...]
>> All of those are topics I like to see materialize, and you are
>> welcome to tackle them.
> 
> Allow me a few days to think about changing the fundamental building
> blocks to make our shell hackery easier.

Please go ahead, but if your goal is "to make our shell hackery
easier" I'm not interested. I want to improve the user experience
of submodules and don't care much in what language we achieve that.
And I can't see anything fundamental being wrong with submodules but
strongly believe they are a perfect match for some very important
use cases (some of which I see happening at my $dayjob for some
years now), so I still don't see what you are trying to "fix" here.
