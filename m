From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCH] commit notes workflow
Date: Wed, 02 Mar 2011 01:21:54 +0100
Message-ID: <201103020121.54690.johan@herland.net>
References: <20110225133056.GA1026@sigill.intra.peff.net>
 <201102251658.22678.johan@herland.net>
 <20110301215907.GA23945@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 02 01:22:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuZpN-0004kr-HJ
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 01:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757604Ab1CBAV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 19:21:59 -0500
Received: from smtp.getmail.no ([84.208.15.66]:47435 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956Ab1CBAV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 19:21:58 -0500
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LHE000SZMCJLS30@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 02 Mar 2011 01:21:55 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id B9A8D1EA55E5_D6D8DA3B	for <git@vger.kernel.org>; Wed,
 02 Mar 2011 00:21:55 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 766991EA2CF7_D6D8DA3F	for <git@vger.kernel.org>; Wed,
 02 Mar 2011 00:21:55 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LHE00D25MCJ8020@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 02 Mar 2011 01:21:55 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <20110301215907.GA23945@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168284>

On Tuesday 01 March 2011, Jeff King wrote:
> On Fri, Feb 25, 2011 at 04:58:22PM +0100, Johan Herland wrote:
> > What about using something like "--- Notes ---" instead?
> 
> Yeah, it is true that many git users will never care about the
> patch-through-mail workflow. And I think these days that is OK, because
> rebase will take care to keep their commit message intact even if it
> doesn't format well in a "format-patch | am" pipeline.
> 
> I really wanted to keep it short and natural, though. Because eventually
> I'd like to have this on all the time via a config option, and I don't
> want to see "--- Notes ---" in every commit that doesn't have notes. But
> I _do_ want to be able to quickly say "oh, let me make a note on this"
> and just add a quick separator.
> 
> It wouldn't be a regression if people had to opt into the feature using
> the command-line or config option. So in theory they could learn about
> "---" then, unless we turn it on by default (but why would we? A user
> has to know about this feature to use it, so they can easily turn on the
> option).

I'm not so sure. Requiring users to opt in might be enough protection 
against false "---" positives. I'm just paranoid about someone turning this 
on in their global config, and then forgetting all about it when they format 
a commit message like this:

   Subject line of the commit message

   What
   ----
   Lorem ipsum dolor sit amet.

   Why
   ---
   eggs spam bacon spam spam spam.

(which will end the commit message after "Why", and add the last line as a 
note)

Just grepping through a "git log" from git.git master, I can find one 
almost-false-positive in b6b84d1 ("---" appears slightly indented), and 
grepping through linux-2.6 master, I find plenty potential for false 
positives:

  a2d49358ba9bc93204dc001d5568c5bdb299b77d (almost false positive)
  20cbd3e120a0c20bebe420e1fed0e816730bb988 (almost false positive)
  68845cb2c82275efd7390026bba70c320ca6ef86 (false positive)
  5e553110f27ff77591ec7305c6216ad6949f7a95 (false positive)
  9638d89a75776abc614c29cdeece0cc874ea2a4c (false positive)

Remember that developers sometimes cut-n-paste output from other programs 
(debug sessions, performance benchmarks, etc.) into their commit message, 
and that makes a false positive a lot more likely to slip through.

> Or maybe the divider should be configurable and default to something
> long. But clueful people can set it to "---". That kind of seems like
> overkill, though.

Not sure that would help. I consider myself "clueful" enough that I'd likely 
set it to "---", but I also know myself well enough that if I pasted some 
debug/performance output into a commit message, and that output happened to 
contain a "---", it would likely slip through...

> > > How should this interact with the commit-msg hook? In my
> > > implementation, it sees the whole thing, message and notes. Should we
> > > be picking apart the two bits after the editor and rewriting the
> > > COMMIT_EDITMSG before the hook sees it?
> > 
> > I'm not sure about this, but I suspect we should follow the same
> > behaviour as --verbose (i.e. does the commit-msg hook see the entire
> > diff inline in the commit message?).
> > 
> > A short look at builtin/commit.c indicates that we should leave
> > everything in there for the commit-msg hook (AFAICS, the commit-msg
> > hook is invoked from prepare_to_commit(), which is invoked from
> > cmd_commit() _before_ the verbose diff part is removed.)
> 
> Yeah, I think the commit-msg hook sees everything. Which is arguably not
> the most convenient behavior, but it is the most flexible. Sort of. The
> hook doesn't actually know whether "-v" was supplied, so it has to guess
> at what is "-v" junk and what is not.

Yeah, it might be messy today, but I don't think you can clean it up without 
changing the commit-msg hook interface, which to me means that the cleanup 
should probably happen in a separate series.

> I wonder if anyone actually uses
> "-v" these days. It seems like "git add -p" would have superseded it in
> most workflows.

I find myself using -v every now and then, to just have the diff handy while 
I construct the commit message. Makes it easier to refer to function names, 
etc. in the commit message.

> > > How should this interact with the post-rewrite hook? I obviously need
> > > to set that up for my workflow, too, but I haven't yet. This patch
> > > does nothing, but I'm pretty sure it should turn of "git commit
> > > --amend" calling the rewrite hook if we are using --notes (since the
> > > user has already seen and edited the notes, and we've written them
> > > out).
> > 
> > I don't see what this has to do with the post-rewrite hook. Currently,
> > the post-rewrite documentation ("git help hooks") states that it is run
> > _after_ the automatic notes copying. AFAICS, your --notes simply
> > replaces the usual automatic notes copying with a
> > semi-automatic "edit-and-copy" instead. But this all happens before the
> > port-rewrite hook is called, and thus shouldn't affect it.
> 
> I think this was just me showing my cluelessness about how the notes
> rewriting code worked. I was thinking you needed to have a post-rewrite
> hook to make it work at all, but it looks like it does the rewrite and
> then lets you tweak it.

Indeed, the notes rewrite does not depend on the post-rewrite hook at all.

> So my code doesn't turn off the existing copy, but it probably should.

Yeah, if the user edits the note, you don't want the notes rewriting code 
clobbering the edited note by copying the original note on top of it.

> Should the post-rewrite hook run after this? I'm not really sure what
> people use post-rewrite hooks for, to be honest.

Me neither, but from its name I gather that it should be run whenever a 
commit is "rewritten" (amend, rebase, etc.). As such, it binds closer to the 
commit rewrite itself, rather than to the accompanying notes copy (or "edit-
and-copy" in your case). That's why I argue that --notes should not affect 
the invocation of the post-rewrite hook.

> > Otherwise, this looks good to me from a precursory review.
> 
> Thanks. I'll work on some tests for the --cleanup and -v cases so we can
> be sure that it's behaving as we want, and then hopefully submit a nicer
> version.

Looking forward to it. :)


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
