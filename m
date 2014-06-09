From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH] clone: add clone.recursesubmodules config option
Date: Mon, 09 Jun 2014 15:17:07 +0200
Message-ID: <5395B3D3.9060501@web.de>
References: <xmqqoay9wvo6.fsf@gitster.dls.corp.google.com> <1401874256-13332-1-git-send-email-judge.packham@gmail.com> <xmqqvbsgvb9l.fsf@gitster.dls.corp.google.com> <20140604194216.GA4636@sandbox-ub> <539020D1.1090601@gmail.com> <20140606055430.GC77405@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	mara.kim@vanderbilt.edu, Jonathan Nieder <jrnieder@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>,
	Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 15:17:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtzRv-0006co-Kn
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 15:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbaFINRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 09:17:16 -0400
Received: from mout.web.de ([212.227.15.4]:61342 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932636AbaFINRO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 09:17:14 -0400
Received: from [192.168.178.41] ([79.193.75.200]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0M5Oql-1WZHzt3tL5-00zXvc; Mon, 09 Jun 2014 15:17:11
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140606055430.GC77405@book.hvoigt.net>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:FuMgtqjQ+K157gnG3AcZAL0qIafyIq+cHgNS9pHkn5QCXzTlkQh
 V5bqzDM1Jxok291pbzv6SF3tgFhbXpE0446+mFQ9My/ZZfWbcCVDf29WTj1vtQGHAGMKk+A
 qCATtSLweQg55nK312QBGRQh/a0Hn44cTKyRYspcRWR68hJmPOjc5nw/A0cDqPXU+G/atxz
 +X/NoNIEeyxajRFPjdyuw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251076>

Am 06.06.2014 07:54, schrieb Heiko Voigt:
> On Thu, Jun 05, 2014 at 07:48:33PM +1200, Chris Packham wrote:
>> On 05/06/14 07:42, Heiko Voigt wrote:
>>> So either we do this "magically" and all valid boolean values are
>>> forbidden as tags or we would need a different config option. Further
>>> thinking about it: Maybe a general option that does not only apply to
>>> clone would suit the "views" use-case more. E.g. "submodule.tags" or
>>> similar.
>>>
>>> Also please note: We have been talking about adding two configurations
>>> for submodules:
>>>
>>> 	submodule."name".autoclone (IIRC)
>>>
>>> I am not sure whether that was the correct name, but this option should
>>> tell recursive fetch / clone whether to automatically clone a submodule
>>> when it appears on a fetch in the history.
>>>
>>> 	submodule."name".autoinit
>>>
>>> And this one is for recursive checkout and tells whether an appearing
>>> submodule should automatically be initialized.
>>>
>>> These options fullfill a similar use-case and are planned for the future
>>> when recursive fetch/clone and checkout are in place (which is not that
>>> far away). We might need to rethink these to incoporate the "views from
>>> tags" idea nicely and since we do not want a configuration nightmare.
>>
>> I'm a little confused at how autoclone and autoinit differ. Aren't they
>> the same? i.e. when this module appears grab it by default. I see
>> autoupdate as a little different meaning update it if it's been
>> initialised. Also does autoinit imply autoupdate?
> 
> autoclone is about cloning the history of submodules. So e.g. when a
> submodule first appears in the superprojects history whether it should
> automatically be cloned to .git/modules.
> 
> autoinit is all about the checkout phase. When a commit with a new
> submodule is checked out: Should that new submodule be automatically
> initialised?

To me those two only make sense together, so I see them as a single
option. But then maybe some developers would like to clone everything
so they are plane-safe in case they intend to do "git submodule
update --init" later at 30.000 feet without internet access ... so
yes, technically we have three distinct steps: clone, init & update.

> As far as autoupdate is concerned: Maybe autoinit can imply that it is
> enabled, yes. But I guess we still need autoupdate for the case of big
> submodules that cause to much performance trouble if updated by every
> checkout.
> 
> So its actually three values: autoclone, autoinit, autoupdate. Damn,
> these configurations become more complicated everytime. Maybe we should
> try to clean them, up once we have everything, with Git 3.0 ;-) If
> anyone has an idea how to get rid of some right now...

I suspect that once they are introduced we'll never be able to get
rid of them again ;-)

> Radically different thinking: How about just one: submodule.auto =
> true/false configuration and that means you opt in to doing everything
> as automatic as possible. Since we are still implementing we could stick
> a prominent warning in the documentation that the user should be
> prepared for behavioral changes.
> 
> Once everybody is happy with that we could switch the default from false
> to true.

I like that. (And if we really need /clone-but-no-init-or-update/ or
/clone-and-init-but-no-update/ settings later we could add two new
values additionally to true/false to make that work with a single
setting too). So I'm convinced that a single option is the way to go.

>> At $dayjob we have a superproject which devs clone this has submodules
>> for the important and/or high touch repositories. We have other
>> repositories that are normally build from a tarball (or not built at
>> all) but we can build them from external repositories if needed. The
>> latter case is painfully manual. If autoinit/autoupdate existed we'd
>> probably setup out projects with.
>>
>>     [submodule "linux"]
>>         autoinit = true
>> 	autoupdate = true
>>     [submodule "userland"]
>>         autoinit = true
>> 	autoupdate = true
>>     [submodule "not-used-that-much"]
>> 	autoupdate = true
>>
>> We probably wouldn't make use of tags because we're building complete
>> embedded systems and generally want everything, even if we are doing
>> most of our work on a particular target we need to do builds for other
>> targets for sanity checks.
> 
> Yep thats exactly what we already do at $dayjob but with
> submodule.*.update=none. Since that conveniently also disables the
> initialisation, developers only get the basic code and not everyone
> needs to have the media and some big external libs.
> 
> I would reuse 'update' in the long run. But I guess for the transition
> we will need the extra autoupdate one to keep annoyance levels low.

I'm not sure reusing 'update' is going to work: 'update' currently
controls what "git submodule update" will do: nothing, checkout,
merge or rebase (and we shouldn't change that because of backwards
compatibility). We're talking about a new setting telling regular
git commands to do the submodule work tree update without having to
manually call "git submodule update". And I believe we'll always
need 'update' as it is for people who'll want to do a manual "git
submodule update", especially when we change the default of
'submodule.auto' to true in 3.0.

And by the way: wouldn't it make more sense to tell the user /what/
we do automatically? So maybe 'submodule.autoupdate' is a better
name for the new switch? The fact that it also does clone and init
under the hood looks more like a technical detail to the user, no?
And I'd like to avoid users uttering "auto-what?" when they hear
about this setting ;-) And it would make clear that 'update' is
what we do and 'autoupdate' makes it happen without having to call
"git submodule update".
