From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: help moving boost.org to git
Date: Tue, 6 Jul 2010 13:27:56 -0400
Message-ID: <AANLkTikkKhvzsczKJwjsc0kmCmWQGAIUzc__Wr20Dbwd@mail.gmail.com>
References: <4C31E944.30801@boostpro.com> <20100705220443.GA23727@pvv.org> 
	<4C32668E.9040000@boostpro.com> <AANLkTimAqL8gvgIisLpWE6xj2p0jEZD5wetdGYJnOpdr@mail.gmail.com> 
	<4C3275C0.8000406@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Niebler <eric@boostpro.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 19:28:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWBwY-00078b-0H
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 19:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442Ab0GFR2U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 13:28:20 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44378 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127Ab0GFR2T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 13:28:19 -0400
Received: by pwi5 with SMTP id 5so2059689pwi.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 10:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=oGFf1/BOv8FSQdl+cAAz3rCbcpQoCoVvJIh18WBj/VQ=;
        b=SNbgnGbVugyj0QIB7dvOfXUrIt66N+31biPyO4Ryme4F7AC3Y2/Tg4a/OghXa3F7Au
         wNL8c9TaZVCrVTiu3UPZxA3i9n20doZ88KmOj1OL+TK7bIpo+yOvWpkhYoC2suUhwl4e
         BQwty8W9I9jcelMEh5VCIar6cBwv5RN9qM5Tk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fpn4iaIC5rQ8/2f/aGy1nFh7JZ3M06um3NYSBZsYGamkaOfVG7Dv6dVFipXiM66SUg
         Oivudjyxp46GKK/EwJkGSGSflCv5q5OT0xlxFjP6F4AXje0jX5wqekmC32VN78bN9iMv
         YIpQQc6lZG15Y9By27k6q/OxmWiVExdTtTKWI=
Received: by 10.142.126.1 with SMTP id y1mr6017974wfc.99.1278437297422; Tue, 
	06 Jul 2010 10:28:17 -0700 (PDT)
Received: by 10.151.45.4 with HTTP; Tue, 6 Jul 2010 10:27:56 -0700 (PDT)
In-Reply-To: <4C3275C0.8000406@boostpro.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150371>

On Mon, Jul 5, 2010 at 8:16 PM, Eric Niebler <eric@boostpro.com> wrote:
> On 7/5/2010 7:32 PM, Avery Pennarun wrote:
>> Eric Niebler wrote:
>>> If multiple repositories share the same ancient history, wouldn't t=
hat
>>> give git annotate/blame enough information? Sorry, git newbie here.
>>
>> Yes, it would. =A0But how much of the ancient history do you want? =A0=
If
>> you want all of it, you don't save any space in your repo.
>
> Repos, plural. We'd save space because the history wouldn't be
> duplicated in each one. Right? Or else I'm confused and this somethin=
g
> that will become clear after I understand what git subtree does.

The statement "multiple repositories share the same ancient history"
above is the part that's confusing.  If you use a tool like
git-subtree or git-filter-branch, you're actually generating a "new
history" based on the original history.  The "new history" obviously
contains fewer files than the original, which would take less space.
But if you want multiple repositories to "share the same ancient
history" you can't rewrite it, and thus you aren't saving any space in
any one repo.

I'm assuming you want to rewrite history to save space (since that's
what this thread is about).  And git annotate/blame will work as long
as your rewritten history contains all the files you care about in
that repo.

> Right now, the other boost developers are pushing for a solution that
> uses grafts. I'm fuzzy on what they are exactly, but it seems that we=
'd
> freeze a svn mirror and have anybody interested in history put grafts=
 in
> their local repository pointing back at the mirror. I don't know enou=
gh
> yet to say what the pros/cons of this approach might be wrt git subtr=
ee.

The primary advantage of grafts is that you can do something easy
*right now* and then fix it all up later.  eg. if you screw up your
history extraction and do it better later, you can just re-graft it
and you're done.

A secondary advantage of grafts is that cloning the "primary"
repository will be tiny since it doesn't have much ancient history.

A disadvantage of grafts is that each user has to deal with grafts in
his cloned repo, and unless he does, things like 'git log' and 'git
blame' won't show anything from the grafted history.  Supposedly 'git
replace' was designed to help with this issue, but I've never used it
so I don't know for sure.

And of course, grafts don't actually do any history rewriting for you.
 You could split out a subtree's history and then graft it on, but the
splitting process is still the same as it would be without grafts.
The alternative would be to *not* rewrite history, just keep the
entire history of the whole project in one place, and graft it on if
you really need it.  That's actually pretty clean (and accurately
reflects exactly what *really happened*, which is a nice feature to
have in a vcs history), but you'll then never have a single repo of
just one subproject with the entire history of that subproject.  That
latter turns out to not actually be very important in practice, so you
might want to do it.

>> The confusing part is taking *submissions* back through both channel=
s.
>> If you value your sanity, you probably want to only allow submission=
s
>> back via svn while you're running the two in parallel; but that make=
s
>> git's added features a lot less useful, so you probably want to run =
in
>> parallel for only a short time.
>
> Oh my! I don't think we'd open the git repositories for changes until
> after we close down svn. This problem is hard enough.

It can be done, and I've done it :)  But you're wise to avoid that situ=
ation.

Have fun,

Avery
