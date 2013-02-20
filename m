From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v2 2/2] check-ignore.c, dir.c: fix segfault with '.'
 argument from repo root
Date: Wed, 20 Feb 2013 12:43:11 +0000
Message-ID: <20130220124311.GE7860@pacific.linksys.moosehall>
References: <CAOkDyE9VVuFn6B=Fe4XHxGCEW0MFgndx1X0+9hO36Soxb37YQw@mail.gmail.com>
 <1361301696-11307-1-git-send-email-git@adamspiers.org>
 <7vzjz03wid.fsf@alter.siamese.dyndns.org>
 <7vfw0s3qsq.fsf@alter.siamese.dyndns.org>
 <20130220015723.GB7860@pacific.linksys.moosehall>
 <7vtxp73dms.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 13:43:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U891Q-0002yE-G1
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 13:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934016Ab3BTMnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 07:43:15 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:34243 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933751Ab3BTMnP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 07:43:15 -0500
Received: from localhost (c.2.7.1.0.6.0.3.6.a.7.2.5.6.9.7.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:7965:27a6:3060:172c])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 4B9322E339;
	Wed, 20 Feb 2013 12:43:12 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vtxp73dms.fsf@alter.siamese.dyndns.org>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216707>

On Tue, Feb 19, 2013 at 06:47:23PM -0800, Junio C Hamano wrote:
> Adam Spiers <git@adamspiers.org> writes:
> >> Remove a sweep-the-issue-under-the-rug conditional in check-ignore
> >> that avoided to pass an empty string to the callchain while at it.
> >> It is a valid question to ask for check-ignore if the top-level is
> >> set to be ignored by default, even though the answer is most likely
> >> no, if only because there is currently no way to specify such an
> >
> > Hmm, I see very little difference between the use of "most likely" and
> > the use of the words "much" and "typically" which you previously
> > considered "a sure sign that the design of the fix is iffy".
> 
> Your patch were "The reason why feeding empty string upsets
       ^^^^^^^^^^
"patches were", or "patch was"?  It's not clear which patch(es) you're
referring to.

> hash_name() were not investigated; by punting the '.' as input, and
> ignoring the possibility that such a question might make sense, I
> can work around the segfault.

I don't see how explicitly referring to the possibility can be counted
as ignoring it.

> I do not even question if hash_name()
> that misbehaves on an empty string is a bug. Just make sure we do
> not tickle the function with a problematic input".

Presumably the "I" here refers to anthropomorphized commit message
rather than to me personally, since I did question hash_name()'s
behaviour several times already.

> The patch you are responding to declares that hash_name() should
> work sensibly on an empty string, and that is the _only_ necessary
> change for the fix.  We could keep "&& path[0]", but even without
> it, by fixing the hash_name(), we will no longer segfault.

Yes, and as already stated, I agree that is a good thing.

> My "most likely" is about "the special case '&& path[0]' produces
> correct result,

Sorry, I can't understand this.  You are paraphrasing something and
placing it inside "" quotes, but I can't find the corresponding
source.  I presumed it refers to this extract of your proposed patch's
commit message:

   "Remove a sweep-the-issue-under-the-rug conditional in check-ignore
    that avoided to pass an empty string to the callchain while at it.
    It is a valid question to ask for check-ignore if the top-level is
    set to be ignored by default, even though the answer is most
    likely no"

but I can't reconcile this extract with the paraphrase "the special
case '&& path[0]' produces correct result".

> and it is likely to stay so in the near future until
> we update .gitignore format to allow users to say 'ignore the top by
> default', which is not likely to happen soon".  It is not about the
> nature of the fix at all.
>
> Still do not see the difference?

I think I *might* be beginning to see you were getting at, although my
understanding is still clouded by the ambiguities detailed above.  Is
your point that the use of words like 'much' and 'typically' are a
"sure sign" of "iffy design" _when_used_to_talk_about_fixes_ but not
necessarily in other contexts?  If so then it makes a bit more sense
to me, even though I tend to disagree with such broadly sweeping
generalizations, especially when the qualifying context is missing.

That aside, your idea of looking out for "bad smells" not only in code
but also in the spoken language contained by commit messages and
design discussions is an interesting one.  I will try to bear that
technique in mind more consciously in the future, and see how well it
serves me.

> The removal of the "&& path[0]" is about allowing such a question
> whose likeliness may be remote.  In the current .gitignore format,
> you may not be able to say "ignore the whole thing by default", so
> in that sense, the answer to the question this part of the code is
> asking when given "." may always be "no".  Keeping the "&& path[0]"
> will optimize for that case.
> 
> And "unusual thing to ask" below is to judge if answering such a
> question is worth optimizing for (the verdict is "no, it is not a
> common thing to do").

Yes, I understand and agree with these paragraphs.

> >> entry in the .gitignore file. But it is an unusual thing to ask and
> >> it is not worth optimizing for it by special casing at the top level
> >> of the call chain.
> >
> > Although I agree with your proposed patch's sentiment of avoiding
> > sweeping this corner case under the rug, 'check-ignore .' still
> > wouldn't match anything if for example './' was a supported mechanism
> > for ignoring the top level.
> 
> It indicates that there may be more bugs (that may not result in
> segv) somewhere in check-ignore codepath, if (1)
> 
> 	echo ./ >.gitignore
>
> were to say "ignore everything in the tree by default.", and (2) the
> real ignore check does work that way, but (3)
> 
> 	git check-ignore .
> 
> says "we do not ignore that one".

Yes, I think we are saying exactly the same thing here, although if
"It indicates that [...]" refers to your proposed patch's commit
message then I don't think it indicates the possibility of these bugs
in the most obvious or explicit way.

> Such a bug may come from some
> code that is not prepared to see an empty pathname that refers to
> the top-level in the codepath, which was why I originally asked 
> 
>     Does the callchain that goes down to this function have other places
>     that assume they will never see an empty string, like this function
>     does, which I _think_ is the real issue?
> 
> in one of the previous messages.

Agreed.

> But is 
> 
> 	echo ./ >.gitignore
> 
> a way to say "ignore everything in the tree by default" in the first
> place?  I think historically that has never been the case, I recall
> that the list had discussions on that topic in the past (it may be
> before you appeared here), and I do not recall we reached a concensus
> that we should make it mean that nor applied a patch to do so.

Good question.  './' and '/' both seem like reasonable values here,
but if noone screamed loud enough for a decision and implementation
yet, it reinforces my description of it as a corner case, and suggests
that we probably shouldn't spend much more time on this thread of
diminishing returns ;-)
