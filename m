From: david@lang.hm
Subject: Re: Git commit generation numbers
Date: Fri, 22 Jul 2011 12:08:14 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1107221206370.11697@asgard.lang.hm>
References: <20110721202722.3765.qmail@science.horizon.com> <alpine.LFD.2.00.1107220907370.1762@xanadu.home> <alpine.DEB.2.02.1107221102180.6496@asgard.lang.hm> <201107222034.20510.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Nicolas Pitre <nico@fluxnic.net>,
	George Spelvin <linux@horizon.com>,
	Anthony Van de Gejuchte <anthonyvdgent@gmail.com>,
	git@vger.kernel.org, Phil Hord <hordp@cisco.com>,
	Shawn Pearce <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 22 21:09:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkL5o-0000kn-AL
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 21:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754673Ab1GVTI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 15:08:56 -0400
Received: from mail.lang.hm ([64.81.33.126]:60214 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754619Ab1GVTIz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 15:08:55 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id p6MJ8ET3009142;
	Fri, 22 Jul 2011 12:08:14 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <201107222034.20510.jnareb@gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177657>

On Fri, 22 Jul 2011, Jakub Narebski wrote:

> On Fri, 22 Jul 2011, David Lang <david@lang.hm> wrote:
>> On Fri, 22 Jul 2011, Nicolas Pitre wrote:
>>> On Fri, 22 Jul 2011, Jakub Narebski wrote:
>>>
>>>> BTW. with storing generation number in commit header there is a problem
>>>> what would old version of git, one which does not understand said header,
>>>> do during rebase.  Would it strip unknown headers, or would it copy
>>>> generation number verbatim - which means that it can be incorrect?
>>>
>>> They would indeed be copied verbatim and become incorrect.
>>
>> how would they become incorrect?
>
> Let's assume that the following history was created with new git, one
> that correcly adds generation number header to commits:
>
>
>  A(1)---B(2)---C(3)---D(4)---E(5)       <-- master
>          \
>           \----x(3)---y(4)---z(5)       <-- foo
>
> The numbers are generation numbers in commit object.
>
> Let's assume that this repository is fetched into repository instance
> that is managed by older git, one that doesn't understand generation
> header.
>
> Then, if we do
>
>  [old]$ git rebase master foo
>
> and if old git _copies_ generation number header _verbatim_, we would
> get:
>
>  A(1)---B(2)---C(3)---D(4)---E(5)                         <-- master
>                               \
>                                \---x'(3)--y'(4)--z'(5)    <-- foo
>
> Those generation numbers are *incorrect*; they should be:
>
>  A(1)---B(2)---C(3)---D(4)---E(5)                         <-- master
>                               \
>                                \---x'(6)--y'(7)--z'(8)    <-- foo
>
>
> That is IF unknown headers are copied verbatim during rebase.  For
> "encoding" header this is a good thing, for "generation" it isn't.

commit headers are _not_ copied during rebase

a rebase is not the exact same commit, it's a "logically equivalent" 
commit.

so when you do a rebase, you change the commit headers (you have to change 
the parent headers in any case, and you would have to change the 
generation numbers as well)

this was discussed earlier in this thread.

David Lang
