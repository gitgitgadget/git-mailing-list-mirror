From: Eric Niebler <eric@boostpro.com>
Subject: Re: help moving boost.org to git
Date: Mon, 05 Jul 2010 20:16:00 -0400
Message-ID: <4C3275C0.8000406@boostpro.com>
References: <4C31E944.30801@boostpro.com> <20100705220443.GA23727@pvv.org> 	<4C32668E.9040000@boostpro.com> <AANLkTimAqL8gvgIisLpWE6xj2p0jEZD5wetdGYJnOpdr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 02:16:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVvph-00021T-4V
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 02:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914Ab0GFAQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 20:16:09 -0400
Received: from boostpro.com ([206.217.198.21]:38573 "EHLO boostpro.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753025Ab0GFAQI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 20:16:08 -0400
Received: from [192.168.2.114] (c-76-118-178-34.hsd1.ma.comcast.net [76.118.178.34])
	(Authenticated sender: eric)
	by boostpro.com (Postfix) with ESMTPSA id 8F9DB14B2AC;
	Tue,  6 Jul 2010 01:16:06 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.10) Gecko/20100512 Lightning/1.0b1 Thunderbird/3.0.5
In-Reply-To: <AANLkTimAqL8gvgIisLpWE6xj2p0jEZD5wetdGYJnOpdr@mail.gmail.com>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150303>

On 7/5/2010 7:32 PM, Avery Pennarun wrote:
> (note: on this mailing list, you shouldn't drop names from the cc:
> line when replying to a thread)

Noted, thanks.

> On Mon, Jul 5, 2010 at 7:11 PM, Eric Niebler <eric@boostpro.com> wrote:
>> On 7/5/2010 6:04 PM, Finn Arne Gangstad wrote:
>>> This
>>> should fit eaily into a single repository. The Linux kernel is much
>>> larger, and that is sort of the canonical single repo git project. I
>>> _strongly_ recommend that you go for a single repo if you can make it
>>> work.
>>
>> It does fit into one repo, but that doesn't meet our needs for the
>> future. Users want to install and build library X and its dependencies,
>> not all of boost. This is increasingly becoming a problem as boost
>> grows. Imagine if a perl programmer had to download all of CPAN to use
>> or hack on any one perl module. Or if contributing to CPAN meant getting
>> the whole shebang, history and all. I'm sure even in the Linux kernel,
>> not *every* third-party driver is maintained in the master git repo.
> 
> Actually, that's mostly not true; there are a few third-party drivers
> that don't make it into the core Linux repo
<snip discussion showing my ignorance of Linux's repository structure>

Thanks for the correction. The CPAN/PyPi analogy is still apt.

>> We are aiming to make boost a clearing-house for C++ libraries (like
>> CPAN, or PyPi for python), turning the official boost distribution into
>> little more than a well-tested collection of the libraries that have
>> passed our peer-review and regression test process.
> 
> Of course you will want to have some kind of really excellent
> versioned dependency fetching system (exactly like CPAN or PyPi or
> ruby gems) if you want this to be nice.  git's submodules stuff is
> almost certainly not going to add any features you need/want.  On the
> other hand, cloning a separate git repo is pretty easy to write your
> CPAN-like script around.

Indeed, we are stealing the work of the python guys. Pip does most of
what we want. They've graciously been accepting our patches so it
happily clones git repos in order to satisfy dependencies now. It is
some kind of really excellent! :-)

>> In fact, the modularization has already been done, and work is well
>> underway on the infrastructure to support dependency tracking. But the
>> modularization is not history-preserving and needs to be redone.
> 
> If your code doesn't move too many files around, then splitting out
> the history is pretty easy with git-subtree (a tool I wrote that's not
> part of git):
> 
>    git subtree split --prefix=/path/to/subdir
> 
> And you get a new history for just that subdir.  That might do exactly
> what you want.  It also works iteratively, so you can export your
> history from svn, then re-export the changes as they occur over time.

This looks like it here:

  http://github.com/apenwarr/git-subtree

I'll have to read the docs. Thanks for the tip.

>>>> So,, what are the options? Can I somehow delete from each repository the
>>>> history that is irrelevant? Is these some feature of git I don't know
>>>> about that can solve this problem for us?
>>>
>>> How do you define "irrelevant"? Do you only require enough history for
>>> git annotate/blame to give correct results?  Or does this only refer
>>> to multiple repositories sharing the same ancient history?
>>
>> If multiple repositories share the same ancient history, wouldn't that
>> give git annotate/blame enough information? Sorry, git newbie here.
> 
> Yes, it would.  But how much of the ancient history do you want?  If
> you want all of it, you don't save any space in your repo.

Repos, plural. We'd save space because the history wouldn't be
duplicated in each one. Right? Or else I'm confused and this something
that will become clear after I understand what git subtree does.

Right now, the other boost developers are pushing for a solution that
uses grafts. I'm fuzzy on what they are exactly, but it seems that we'd
freeze a svn mirror and have anybody interested in history put grafts in
their local repository pointing back at the mirror. I don't know enough
yet to say what the pros/cons of this approach might be wrt git subtree.

>> The plan is to move to git. However, we don't expect this to happen
>> overnight, so a way to continue to pull changes from a svn mirror while
>> the new git repositories are being set up would be ideal.
> 
> This isn't too hard to do; you just need some scripts around git-svn
> and git-subtree (or whatever tool you use to do the splitting).  We've
> done this at work for a couple of years now and it's working fine.

Cool.

> The confusing part is taking *submissions* back through both channels.
> If you value your sanity, you probably want to only allow submissions
> back via svn while you're running the two in parallel; but that makes
> git's added features a lot less useful, so you probably want to run in
> parallel for only a short time.

Oh my! I don't think we'd open the git repositories for changes until
after we close down svn. This problem is hard enough.

-- 
Eric Niebler
BoostPro Computing
http://www.boostpro.com
