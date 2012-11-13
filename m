From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-email: add proper default sender
Date: Tue, 13 Nov 2012 02:47:21 -0500
Message-ID: <20121113074720.GA18746@sigill.intra.peff.net>
References: <1352653610-2090-1-git-send-email-felipe.contreras@gmail.com>
 <20121112233546.GG10531@sigill.intra.peff.net>
 <CAMP44s0emar-C27SX-FDsUVB6Sevuy4fBFHuO2OD6xELCEjmGg@mail.gmail.com>
 <20121113000217.GH10531@sigill.intra.peff.net>
 <CAMP44s16y9WSmnTdb04EMSzXVgzfYP7pSMo6qZi0HY0bjouA0w@mail.gmail.com>
 <20121113032727.GA8387@sigill.intra.peff.net>
 <CAMP44s0SDHVzSd-8Rq7Z1sbiQ6m0pxX+2pgx16_DoWnHeyNsNQ@mail.gmail.com>
 <20121113040104.GA9361@sigill.intra.peff.net>
 <CAMP44s1w3oZhEUM-cnO=kECH2bhdOTGVuKy8JS4uhWFbA_oi3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 08:47:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYBDg-0004gq-MR
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 08:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798Ab2KMHr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 02:47:27 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46994 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347Ab2KMHrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 02:47:25 -0500
Received: (qmail 21146 invoked by uid 107); 13 Nov 2012 07:48:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Nov 2012 02:48:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2012 02:47:21 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s1w3oZhEUM-cnO=kECH2bhdOTGVuKy8JS4uhWFbA_oi3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209584>

On Tue, Nov 13, 2012 at 07:42:58AM +0100, Felipe Contreras wrote:

> >> > No, it's not. Those broken names do not come from the environment, but
> >> > from our last-resort guess of the hostname.
> >>
> >> That depends how you define environment, but fine, the point is that
> >> it happens.
> >
> > If you have a strawman definition that does not have anything to do with
> > what I said in my original email, then yes, it could happen.
> 
> It happens, I've seen commits with (none) not that long ago.

There was a bug that caused the check to fail in some cases. I fixed it
in f20f387 (this July).

But I still don't see how that has anything to do with what send-email
does or should do. That is why I said "strawman" above. You seem to
think I am saying that send-email should use the system that generated
those broken names, when I am saying the opposite.

> > But as I said already, "git var" uses IDENT_STRICT and will not
> > allow such broken names.
> 
> Since 1.7.11, sure. But not everyone is using such a recent version of
> git, and people with fully qualified domains would still get unwanted
> behavior.

Those people would also not be using a new version of git-send-email,
and it will always prompt. I thought we were talking about what
send-email should do in future versions. Namely, loosening that safety
valve (the prompt) because it is inconvenient, but tightening the checks
so that losing the safety valve is not a problem.

> > Did you read my email? I explicitly proposed that we would _not_ allow
> > send-email to use implicit email addresses constructed in that way.
> 
> I'm not talking about git send-email, I'm talking about your comment
> 'it has always been the case that you can use git without setting
> user.*', which has caused issues with wrong author/commmitter names in
> commits, and will probably continue to do so.

The second half of that sentence that you quoted above is "...instead
only using the environment." As in, environment variables like
GIT_AUTHOR_EMAIL, GIT_COMMITTER_EMAIL, and EMAIL. _Not_ implicit
generation of the email from the username and hostname.

I am tempted to fault myself for not communicating well, but I feel like
I have made that point at least 3 times in this conversation now. Is
that the source of the confusion?

> > Sorry, but that is not how things work on this project. You do not get
> > to cause regressions because you are too lazy to implement the feature
> > _you_ want in a way that does not break other people.
> 
> That doesn't change the fact that they would survive, and the fact
> that those users don't actually exist.

And you will survive if upstream git (whether it is me today or Junio
tomorrow) does not pick up your patch. I remember writing you a long
email recently about how one of the responsibilities of the maintainer
is to balance features versus regressions. I'll not bother repeating
myself here.

As for whether they exist, what data do you have? Are you aware that the
test suite, for example, relies on setting GIT_AUTHOR_NAME but not
having any user.* config? When somebody comes on the list and asks why
every git program in the entire system respects GIT_* environment
variables as an override to user.* configuration _except_ for
send-email, what should I say?

> But let's look at the current situation closely:
> 
> PERL5LIB=~/dev/git/perl ./git-send-email.perl --confirm=always -1
> 
> 1) No information at all
> 
> fatal: empty ident name (for <felipec@nysa.(none)>) not allowed

That is dependent on your system. If you have a non-empty name in your
GECOS field, and if your machine has a FQDN, it will currently work (and
prompt).

> 2) Full Name + full hostname
> 
> Who should the emails appear to be from? [Felipe Contreras
> <felipec@nysa.felipec.org>]
> 
> That's right, ident doesn't fail, and that's not the mail address I
> specified, it's *implicit*.

Right. I never said it did. I said it currently rejected obviously bogus
stuff (like the ".(none)" above) due to IDENT_STRICT, but currently
allowed implicit definitions. And I also said that if we get rid of the
prompt, we should disallow implicit definitions like this, because the
prompt is the safety valve on sending out mails with broken from
addresses. I even wrote a patch that let you find out whether the ident
was generated implicitly.

> 3) Full Name + EMAIL
> 
> Who should the emails appear to be from? [Felipe Contreras
> <felipe.contreras@gmail.com>]

Which sounds fine to me. EMAIL is considered explicit, and I have not
seen any evidence that people are putting bogus values in their EMAIL
variable and complaining that it is git's fault for respecting it.

> 4) config user
> 
> Who should the emails appear to be from? [Felipe Contreras 2nd
> <felipe.contreras+2@gmail.com>]

OK.

> 5) GIT_COMMITTER
> 
> Who should the emails appear to be from? [Felipe Contreras 2nd
> <felipe.contreras+2@gmail.com>]
> 
> Whoa, what happened there?
> 
> Well:
> 
>   $sender = $repoauthor || $repocommitter || '';
>   ($repoauthor) = Git::ident_person(@repo, 'author');
>   % ./git var GIT_AUTHOR_IDENT
>   Felipe Contreras 2nd <felipe.contreras+2@gmail.com> 1352783223 +0100
> 
> That's right, AUTHOR_IDENT would fall back to the default email and full name.

Yeah, I find that somewhat questionable in the current behavior, and I'd
consider it a bug. Typically we prefer the committer ident when given a
choice (e.g., for writing reflog entries).

> 5.1) GIT_COMMITER without anything else
> 
> fatal: empty ident name (for <felipec@nysa.(none)>) not allowed
> var GIT_AUTHOR_IDENT: command returned error: 128

Right. Same bug as above.

> So $repoauthor || $repocommiter is pointless.

Agreed.

> 6) GIT_AUTHOR
> 
> Who should the emails appear to be from? [Felipe Contreras 4th
> <felipe.contreras+4@gmail.com>]

Right, that's what I'd expect.

> What about after my change?
> 
> 6.1) GIT_AUTHOR without anything else
> 
> fatal: empty ident name (for <felipec@nysa.(none)>) not allowed
> var GIT_COMMITTER_IDENT: command returned error: 128

Doesn't that seem like a regression? It used to work.

> 4) config user
> 
> From: Felipe Contreras 2nd <felipe.contreras+2@gmail.com>

OK.

> 5) GIT_COMMITTER
> 
> From: Felipe Contreras 2nd <felipe.contreras+2@gmail.com>

OK.

> 6) GIT_AUTHOR
> 
> From: Felipe Contreras 2nd <felipe.contreras+2@gmail.com>

Doesn't that seem like a regression? It used to use a different address,
and in every other git program, the environment takes precedence over
config.

> And what about your proposed change?

Let me be clear that I sent you a "something like this" patch to try to
point you in the right direction. If it has a bug or is incomplete, that
does not mean the direction is wrong, but only that I did not spend very
much time on the patch.

> 6.1) GIT_AUTHOR without anything else
> 
> Even if the previous problem was solved:
> 
> export GIT_AUTHOR_NAME='Felipe Contreras 4th'; export
> GIT_AUTHOR_EMAIL='felipe.contreras+4@gmail.com'
> ./git var GIT_EXPLICIT_IDENT
> 0
> 
> No explicit ident? This is most certainly not what the user would expect.

Yes, it looks like we do not set up the explicit ident flags when
parsing the author. So my patch is insufficient.

> 5.2) GIT_COMMITTER with Full Name and full hostname
> 
> export GIT_COMMITTER_NAME='Felipe Contreras 3nd'; export
> GIT_COMMITTER_EMAIL='felipe.contreras+3@gmail.com'
> ./git var GIT_EXPLICIT_IDENT
> 1
> 
> From: Felipe Contreras <felipec@nysa.felipec.org>
> 
> It is explicit, yeah, but 'git send-email' would not be picking the
> committer, it would pick the author.

Yep.

The explicitness needs to be tied to the specific ident we grabbed.
Probably adding a "git var GIT_AUTHOR_EXPLICIT" would be enough, or
alternatively, adding a flag to "git var" to error out rather than
return a non-explicit ident (this may need to adjust the error
handling of the "git var" calls from send-email).

> > I tried to help you by pointing you in the right direction and even
> > providing a sample "git var" patch.
> 
> Are you 100% sure that was the right direction?

I think that respecting the usual ident lookup but disallowing implicit
identities (either totally, or causing them to fallback to prompting) is
the right direction.  I agree my patch was not a complete solution. I'm
sorry if it led you astray in terms of implementation, but I also think
I've been very clear in my text about what the behavior should be.

> I think the right approach is more along these lines:

I think that is moving in the right direction, but...

> --- a/ident.c
> +++ b/ident.c
> @@ -291,9 +291,9 @@ const char *fmt_ident(const char *name, const char *email,
>         }
> 
>         if (strict && email == git_default_email.buf &&
> -           strstr(email, "(none)")) {
> +               !(user_ident_explicitly_given & IDENT_MAIL_GIVEN)) {
>                 fputs(env_hint, stderr);
> -               die("unable to auto-detect email address (got '%s')", email);
> +               die("no explicit email address");

I think this needs to be optional, otherwise you are breaking callers
who use IDENT_STRICT but are OK with the implicit ident (e.g.,
commit, format-patch with threading).

You can argue whether "git commit" should disallow such addresses, but
that is a separate topic from how send-email should behave.

> Not only will this fix 'git send-email', but it will also fix 'git
> commit' so that we don't end up with authors such as 'Felipe Contreras
> <felipec@nysa.felipec.org>' ever again.

While simultaneously breaking "git commit" for people who are happily
using the implicit generation. I can see the appeal of doing so; I was
tempted to suggest it when I cleaned up IDENT_STRICT a few months back.
But do we have any data on how many people are currently using that
feature that would be annoyed by it?

> > But it is not my itch to scratch.
> 
> Suit yourself, it's only git users that would get hurt. I can always
> use my own 'git send-email' (as I am doing right now).

Don't get me wrong. I think the spirit of your patch is correct, and it
helps some git users. But it also hurts others. And it is not that hard
to do it right.

It may be something I would work on myself in the future, but I have
other things to work on at the moment, and since you are interested in
the topic, I thought you would be a good candidate to polish it enough
to be suitable upstream. But instead I see a lot of push-back on what I
considered to be a fairly straightforward technical comment on a
regression.

And now I have wasted a large chunk of the evening responding to you,
neither accomplishing my other tasks nor polishing this topic. I do not
mind reviewing patches or responding to discussions, nor do I consider
them time wasted; they are an important part of the development process.
But I feel like I am fighting an uphill battle just to convince you that
regressions are bad, and that I am having to make the same points
repeatedly.  That makes me frustrated and less excited about reviewing
your patches; and when I say "it is not my itch", that is my most polite
way of saying "If that is going to be your attitude, then I do not feel
like dealing with you anymore on this topic".

-Peff
