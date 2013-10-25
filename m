From: Jeff King <peff@peff.net>
Subject: Re: git grep: search whole tree by default?
Date: Fri, 25 Oct 2013 00:37:17 -0400
Message-ID: <20131025043717.GC11810@sigill.intra.peff.net>
References: <CAA01CsqgNKdDAc9OL9zdk=3tnK9GAG=6w+wP_XSoiefBOgfzRQ@mail.gmail.com>
 <vpqbo2guff7.fsf@anie.imag.fr>
 <xmqqmwlzrjdh.fsf@gitster.dls.corp.google.com>
 <87hac7hmrb.fsf@mcs.anl.gov>
 <xmqqob6fq0q1.fsf@gitster.dls.corp.google.com>
 <87zjpzg592.fsf@mcs.anl.gov>
 <vpqy55jogzr.fsf@anie.imag.fr>
 <20131024022736.GA24992@sigill.intra.peff.net>
 <xmqqd2muo3sz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jed Brown <jed@59A2.org>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 06:37:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZZ9L-0004iF-Rn
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 06:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369Ab3JYEhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 00:37:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:55242 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751237Ab3JYEhU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 00:37:20 -0400
Received: (qmail 31637 invoked by uid 102); 25 Oct 2013 04:37:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Oct 2013 23:37:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Oct 2013 00:37:17 -0400
Content-Disposition: inline
In-Reply-To: <xmqqd2muo3sz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236657>

On Thu, Oct 24, 2013 at 12:40:44PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > That would also provide people who do not like the change of default an
> > escape hatch to keep the current behavior. And I do not think scripted
> > use will be inconvenienced; they will already have to use "." or ":/" to
> > be explicit (if they care) since the behavior is changing.
> 
> There is a big difference between "scripted use will have an escape
> hatch" and "scripted use will not be inconvenienced".

I think my communication may have been muddled in transit. What I meant
regarding inconvenienced was "not any more so than by simply changing
the behavior in the first place, since scripts already will need to
start becoming explicit due to the behavior change".

And for the "escape hatch", I did not mean for scripts. I actually meant
for users who do not like the extra typing and complain "stupid git, I
always want '.'; you used to do what I want and now you do not".

> Even if we ignore the "helping your colleague at her terminal", cf.
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/133570/focus=133683

FWIW, I have never agreed with that line of reasoning. I was going to
explain why, but I see that I already did in response to the article you
linked. :)

> issue for now, adding a new configuration variable from day one
> makes the transition of scripts somewhat worse, I am afraid.  Doing
> so robs us a way to add such an annoying warning to help people
> foresee problems in their existing scripts before the default
> changes (the configuration presumably will disable the "this command
> line will behave differently after the default changes" warning).

If you want to have an annoying warning, why not consider the config a
tristate? Do X or do Y, or if unset, do X with an annoying warning
(which will switch to Y in the future). That does not help a user who
sets the variable after seeing the warning the first time, then later
runs a script that silently chooses the wrong behavior.

But neither does a warning that is squelched by advice.*, which the user
will also set soon after seeing it.

The only way to hit those scripts is to yell at the user anytime the
appropriate command-line override is not selected, with no way to turn
it off. That's what we're doing now with "git add". I think people find
it a little annoying. But perhaps it is the least of all evils.


Anyway, I have said my piece, and I think we are on the same page with
the tradeoffs (what they are, though we may value them differently).  I
do not care that strongly about the config option these days; as I said,
it was something I would have used in certain workflows, but I do not
foresee myself even setting it these days. So I am willing to forego it
if there are concerns it will make things worse.

-Peff
