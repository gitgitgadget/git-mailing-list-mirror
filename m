From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Thu, 09 Jan 2014 09:31:13 +0100
Message-ID: <52CE5E51.4060507@web.de>
References: <20140106160202.GE27265@t2784.greatnet.de> <CALas-ijXQFcUHWk-jJrLifqsMHAKo6NNKya+jR6RJGGDXY76hg@mail.gmail.com> <CALas-ijNgaTQr77DZw3acypgaJHpDFVnGdq97ECM4zu+CPma0w@mail.gmail.com> <xmqqd2k3ejfr.fsf@gitster.dls.corp.google.com> <CALas-ihPmJSf9eH0P7Vf28pB4zN_dsa_2=fe+_moZgiP0C3UTA@mail.gmail.com> <20140107194503.GA26583@odin.tremily.us> <20140107223858.GB10782@sandbox-ub> <CALas-ihk6cVfosQ+Ov4QKUcfzvbXrYSonQvsN8Ay1+GTq_Ae-w@mail.gmail.com> <20140108010504.GE26583@odin.tremily.us> <CALas-iheQ4Rfxvty5guEieVwa8SffRnhRdHkNXUKwmuHRXD2Xg@mail.gmail.com> <20140109000338.GM29954@odin.tremily.us> <CALas-igFQtG1qa2+grMAtZ9mDE-xGuXkDGwGvSXL8_FzPfXBLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Francesco Pretto <ceztko@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Jan 09 09:31:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1B1S-0002vZ-5v
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 09:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbaAIIbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 03:31:23 -0500
Received: from mout.web.de ([212.227.15.3]:57308 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508AbaAIIbV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 03:31:21 -0500
Received: from [192.168.178.41] ([84.132.136.118]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0M6DjG-1VC4T732SY-00y8c1 for <git@vger.kernel.org>;
 Thu, 09 Jan 2014 09:31:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <CALas-igFQtG1qa2+grMAtZ9mDE-xGuXkDGwGvSXL8_FzPfXBLQ@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:heWiKIhaZajcuv2yHdwRob+1LoutK6TD5/FxyiYcmafnJjTpJON
 47pJ4bGo1+QtVrjocIbSWUfKQRAVZU8xHK2HOs/PbAjvzUM8/E5HZFJgtmgQHH09Gh3xGfE
 QrkPR6vUGxnw0vHWfbRULAH5XqJoQqCBGs6xPrCUGxd0xmaQ98Z0k2v0iBUAcRdQcQT9W/m
 i8fRB9A+qHab5gxEmHdWA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240252>

Am 09.01.2014 02:09, schrieb Francesco Pretto:
> 2014/1/9 W. Trevor King <wking@tremily.us>:
>>
>> However, submodule.<name>.local-branch has nothing to do with remote
>> repositories or tracking branches.
> 
> My bad: this means the feature is still not entirely clear to me.
> 
>>
>>   [branch "my-feature"]
>>         remote = origin
>>         merge = refs/heads/my-feature
>>         [submodule "submod"]
>>             local-branch = "my-feature"
>>
>> and I don't think Git's config supports such nesting.
>>
> 
> Aesthetically, It doesn't look very nice.

And I'm not sure we even need that. What's wrong with having the
branch setting in the .gitmodules file of the my-feature branch?
The only problem I can imagine is accidentally merging that into
a branch where that isn't set, but that could be solved by a merge
helper for the .gitmodules file.

>> I can resuscitate that if folks want, but Heiko felt that my initial
>> consolidation didn't go far enough [2].  If it turns out that we're ok
>> with the current level of consolidation, would you be ok with
>> "non-checkout submodule.<name>.update" as the trigger [3]?
> 
> For me it was ok with what you did:
> -------------------------------------------------
> if "just_cloned" and "config_branch"
> then
>      !git reset --hard -q"
> fi
> -------------------------------------------------
> 
> So yes: at the first clone 'checkout' keeps attached HEAD, while
> 'merge' and 'rebase' attach to the branch.

It have the impression that attaching the head to the given branch
for merge and rebase might be the sensible thing to do, but it
would be great to hear from users of merge and rebase if that
would break anything for them in their current use cases for these
settings.

> If it's not the first clone, you should take no action (and your
> original patch was ok about this).

I'm not sure this is the right thing to do, after all you
configured git to follow that branch so I'd expect it to be
updated later too, no? Otherwise you might end up with an old
version of your branch while upstream is a zillion commits
ahead.

>>  I think
>> that adding a halfway step between the current status and full(ish)
>> submodule.<name>.local-branch support is just going to confuse people
> 
> Well, for now you got some success in confusing me with this "local-branch" :)
> 
> At certain point  you may ask maintainers what are the accepted
> features (because all these debates should be about getting, or not
> getting, endorsement about something) and finalize a patch so people
> can further review.

First I'd like to see a real consensus about what exactly should
happen when a branch is configured to be checked out (and if I
missed such a summary in this thread, please point me to it ;-).
And we should contrast that to the exact checkout and floating
branch use cases.

So what should happen on initial clone, later updates, updates
where the local and the remote branch diverged, when superproject
branches are merged (with and without conflicts), on a rebase in
the superproject and so on.

After that we can discuss about how to implement them (even though I
believe we won't need a new submodule command at the end of this
process, simply because if it isn't configurable we cannot teach git
checkout and friends to do that automatically for us later).

And from reading this discussion I believe we need another value for
the ignore option which only ignores changes to the SHA-1 but not to
work tree modifications of a submodule work tree relative to its HEAD
(or make that two: another one which ignores untracked files too and
only shows modification of tracked files). Otherwise users of the
floating or attached model can easily miss submodule modifications.
