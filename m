From: Eric Niebler <eric@boostpro.com>
Subject: Re: help moving boost.org to git
Date: Tue, 06 Jul 2010 14:00:29 -0400
Message-ID: <4C336F3D.1010906@boostpro.com>
References: <4C31E944.30801@boostpro.com> <20100705220443.GA23727@pvv.org> 	<4C32668E.9040000@boostpro.com> <AANLkTimAqL8gvgIisLpWE6xj2p0jEZD5wetdGYJnOpdr@mail.gmail.com> 	<4C3275C0.8000406@boostpro.com> <AANLkTikkKhvzsczKJwjsc0kmCmWQGAIUzc__Wr20Dbwd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 20:00:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWCRt-0007Ph-5z
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 20:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168Ab0GFSAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 14:00:42 -0400
Received: from boostpro.com ([206.217.198.21]:53647 "EHLO boostpro.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756083Ab0GFSAl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 14:00:41 -0400
Received: from [192.168.3.170] (host57.72.248.152.conversent.net [72.248.152.57])
	(Authenticated sender: eric)
	by boostpro.com (Postfix) with ESMTPSA id CB7C914BC97;
	Tue,  6 Jul 2010 19:00:35 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.10) Gecko/20100512 Lightning/1.0b1 Thunderbird/3.0.5
In-Reply-To: <AANLkTikkKhvzsczKJwjsc0kmCmWQGAIUzc__Wr20Dbwd@mail.gmail.com>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150381>

On 7/6/2010 1:27 PM, Avery Pennarun wrote:
> On Mon, Jul 5, 2010 at 8:16 PM, Eric Niebler <eric@boostpro.com> wrote:
>> On 7/5/2010 7:32 PM, Avery Pennarun wrote:
>>> Eric Niebler wrote:
>>>> If multiple repositories share the same ancient history, wouldn't that
>>>> give git annotate/blame enough information? Sorry, git newbie here.
>>>
>>> Yes, it would.  But how much of the ancient history do you want?  If
>>> you want all of it, you don't save any space in your repo.
>>
>> Repos, plural. We'd save space because the history wouldn't be
>> duplicated in each one. Right? Or else I'm confused and this something
>> that will become clear after I understand what git subtree does.
> 
> The statement "multiple repositories share the same ancient history"
> above is the part that's confusing.  If you use a tool like
> git-subtree or git-filter-branch, you're actually generating a "new
> history" based on the original history.  The "new history" obviously
> contains fewer files than the original, which would take less space.
> But if you want multiple repositories to "share the same ancient
> history" you can't rewrite it, and thus you aren't saving any space in
> any one repo.

I think I have reached understanding! Thank you. It *would* save if I
pull down, say, 100 of these new repos+ancient history because git would
just store the ancient history locally once. I'm also guessing git is
smart enough to avoid /downloading/ the ancient history 100x.

> I'm assuming you want to rewrite history to save space (since that's
> what this thread is about).  And git annotate/blame will work as long
> as your rewritten history contains all the files you care about in
> that repo.

Right. I now understand that, too.

>> Right now, the other boost developers are pushing for a solution that
>> uses grafts. I'm fuzzy on what they are exactly, but it seems that we'd
>> freeze a svn mirror and have anybody interested in history put grafts in
>> their local repository pointing back at the mirror. I don't know enough
>> yet to say what the pros/cons of this approach might be wrt git subtree.
> 
> The primary advantage of grafts is that you can do something easy
> *right now* and then fix it all up later.  eg. if you screw up your
> history extraction and do it better later, you can just re-graft it
> and you're done.

How does one screw up the history extraction, if one is not doing any
fancy history rewriting (in this scenario)? Be there dragons?

> A secondary advantage of grafts is that cloning the "primary"
> repository will be tiny since it doesn't have much ancient history.

Right. Only those who ask for it will pay for it. And only developers
will have need of it, and not all developers at that.

> A disadvantage of grafts is that each user has to deal with grafts in
> his cloned repo, and unless he does, things like 'git log' and 'git
> blame' won't show anything from the grafted history.  Supposedly 'git
> replace' was designed to help with this issue, but I've never used it
> so I don't know for sure.

I'll add it to the list of things to learn about.

> And of course, grafts don't actually do any history rewriting for you.
> You could split out a subtree's history and then graft it on, but the
> splitting process is still the same as it would be without grafts.
> The alternative would be to *not* rewrite history, just keep the
> entire history of the whole project in one place, and graft it on if
> you really need it.  That's actually pretty clean (and accurately
> reflects exactly what *really happened*, which is a nice feature to
> have in a vcs history), but you'll then never have a single repo of
> just one subproject with the entire history of that subproject.  That
> latter turns out to not actually be very important in practice, so you
> might want to do it.

That's starting to sound pretty good.

Thanks,

-- 
Eric Niebler
BoostPro Computing
http://www.boostpro.com
