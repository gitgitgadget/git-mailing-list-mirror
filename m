From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Sun, 07 Apr 2013 20:34:27 +0200
Message-ID: <5161BC33.8060707@web.de>
References: <7v61zz9fu3.fsf@alter.siamese.dyndns.org> <CALkWK0n64BW8zQXweR38T6DjT+iYBbsZDPCLZ-4igqGJHoFwKw@mail.gmail.com> <7vr4im7m1y.fsf@alter.siamese.dyndns.org> <CALkWK0=jrO9MQotB+anAn-5YtG1RBTLWEnGL5=K4wy=yi7E-CQ@mail.gmail.com> <20130407161209.GG2222@serenity.lan> <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com> <20130407170201.GH2222@serenity.lan> <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com> <20130407175210.GI2222@serenity.lan> <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com> <20130407182112.GJ2222@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Apr 07 20:34:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOuQY-0001GN-1D
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 20:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934255Ab3DGSek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 14:34:40 -0400
Received: from mout.web.de ([212.227.17.11]:59999 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934251Ab3DGSej (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 14:34:39 -0400
Received: from [192.168.178.41] ([79.193.80.33]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MhDVJ-1UBUIh1pEf-00MNtb; Sun, 07 Apr 2013 20:34:31
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <20130407182112.GJ2222@serenity.lan>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:r75H/jdK0+enlUlAsuqmGLvxZQohbgd6o6TOuzQD2Ru
 abEu9GUjJN8Rf2+gmKeCiLJut0Apq5RY9m93XB//JqqgteY8k+
 C+MG7BRmqZFc0KbkTmFM4faZZETaZdOXtUnO17bVi4TMEOGhUY
 q4H6ktxDYSAxN2tkHSxum3TLwQBosYDTMYsG8l5CC46wiauuCB
 pf3voVYuLeBtfGTC41Xlg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220356>

Am 07.04.2013 20:21, schrieb John Keeping:
> On Sun, Apr 07, 2013 at 11:37:02PM +0530, Ramkumar Ramachandra wrote:
>> John Keeping wrote:
>>> On Sun, Apr 07, 2013 at 10:52:50PM +0530, Ramkumar Ramachandra wrote:
>>>> 3. Ability to have very many large submodule repositories without the
>>>> performance hit.  It makes sense to block stat() from going through
>>>> when you have floating submodules.  This means that many levels of
>>>> nesting are very easily possible.
>>>
>>> Can't I already control this to some degree?  Certainly the following
>>> commands take different amounts of time to run:
>>>
>>>     git status
>>>     git -c status.submodulesummary=true status
>>
>> You can't control the most fundamental thing, stat(): this is the
>> primary killer of performance on a large worktree.  There is currently
>> no way to block stat(): new-style submodules offers a way to configure
>> which submodules to block the stat() on.
> 
> So it would be something like per-submodule --untracked-files and
> --ignore-submodules settings?  I can see that being useful.

Ram is plain wrong here (just like he is on "git rm" and "git mv",
even though the latter is currently still in pu). This use case is
handled by submodules for years now. Take a look at the "ignore"
setting in .gitmodules which give you full control of the stat()s
in submodules, in addition you have the repo-wide option
diff.ignoreSubmodules.

The whole feature list is full of red herrings like this which
have nothing to do with the advantages of a new object, but talk
about UI issues which are easy to solve in both worlds.
