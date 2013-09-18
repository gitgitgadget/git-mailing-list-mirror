From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 3/3] git submodule update should give notice when run
 without init beforehand
Date: Wed, 18 Sep 2013 21:13:34 +0200
Message-ID: <5239FB5E.6060703@web.de>
References: <1379266703-29808-1-git-send-email-rctay89@gmail.com> <1379266703-29808-2-git-send-email-rctay89@gmail.com> <1379266703-29808-3-git-send-email-rctay89@gmail.com> <52373AA2.9050807@web.de> <CALUzUxoFLOP=-ub_VYr6LqRYQXOO7Tf1oP95mxuYZo-8_dxAZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 18 21:13:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMNC1-0005uH-O8
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 21:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072Ab3IRTNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 15:13:37 -0400
Received: from mout.web.de ([212.227.17.11]:55791 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751807Ab3IRTNg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 15:13:36 -0400
Received: from [192.168.178.41] ([79.193.82.99]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MFLQi-1VAE703E0K-00EKG1 for <git@vger.kernel.org>;
 Wed, 18 Sep 2013 21:13:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <CALUzUxoFLOP=-ub_VYr6LqRYQXOO7Tf1oP95mxuYZo-8_dxAZw@mail.gmail.com>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:SxtpkwAfm94AqTmb5WtzAK9XVrw+JxY1mCHM3/hxhyPhu0BK4UL
 SHDADXZE/ago1bBqzq2Uh6gcXfa2iZLbIHsEMX/I5gP6CGQiJ+gHRYrEQa1LcE1hMEc829P
 9s23OYXx3aBYsyj3BCCY0HvL8yESorVMSwYzoJP6j8I1u5i89ZixMvlReGUKc64wmCCXQqo
 CZrCwlKXYuPLpdWLPqvFA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234986>

Am 18.09.2013 12:12, schrieb Tay Ray Chuan:
> On Tue, Sep 17, 2013 at 1:06 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> 
> Thanks Jens for having a look!
> 
>> Am 15.09.2013 19:38, schrieb Tay Ray Chuan:
>>> When 'update' is run with no path in a repository with uninitialized
>>> submodules, the program terminates with no output, and zero status code.
>>> Be more helpful to users by mentioning this.
>>
>> [snip] it would be rather nasty to error out on every submodule
>> update.
> 
> Just to be sure we're on the right page, with this patch, the 'update'
> command still exits with status code zero (non-error), so this patch
> doesn't make it error out.

Ok, sorry for the confusion. But I still think we should not change
the default to print these messages, but make it an opt-in. And the
commit message (and maybe the documentation too) should talk about
the use cases where this makes sense.

>> After the 'autoinit' configuration (which lets upstream hint that
>> certain submodules should be initialized on clone) has materialzed we
>> might want to enable this error for these specific submodules.
> 
> That's cool, I'm looking forward to this. Could you point me to
> somewhere detailing this?

Not yet. I'm still wrestling with the autoupdate series, which is
the logical step before autoinit. autoupdate enables to configure
that initialized submodules are updated on checkout, reset, merge
and all the other work tree manipulating commands. autoinit then
also clones the repos of submodules into .git/modules and inits
them in .git/config, so that autoupdate will automagically populate
them. Unfortunately autoupdate is a rather largish series touching
lots of commands and needing tons of tests ...

> But in the meantime, on top of the advice.* config, how about having a
> submodule.<name>.ignoreUninit config to disable the message on a
> per-submodule basis?

I'd not add such an option unless users request it because it helps
their not-so-terribly-specific use case.

>> But in
>> any case the error message should contain a hint on how you can get
>> rid of the error in case you know what you are doing ;-).
> 
> The message does mention that you can throw in an --init to fix the
> problem. This "hint" is similar to what git-submodule prints when a
> <path> is passed (see region at line 807).

But for a lot of users that isn't a solution, as they never want to
init it, they want to ignore it. And if you explicitly ask to update
a special submodule, that message is ok.
