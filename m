From: Pavel Roskin <proski@gnu.org>
Subject: Re: Some ideas for StGIT
Date: Mon, 06 Aug 2007 13:17:26 -0400
Message-ID: <1186420646.12895.3.camel@dv>
References: <1186163410.26110.55.camel@dv>
	 <b0943d9e0708060236x19674e4cjf04cec716ae6246c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 19:17:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II6DN-0005T3-02
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 19:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761969AbXHFRRd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 13:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765162AbXHFRRc
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 13:17:32 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:45515 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765144AbXHFRR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 13:17:29 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1II6Fb-0007hN-So
	for git@vger.kernel.org; Mon, 06 Aug 2007 13:20:16 -0400
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1II6Cs-0005kI-Me; Mon, 06 Aug 2007 13:17:26 -0400
In-Reply-To: <b0943d9e0708060236x19674e4cjf04cec716ae6246c@mail.gmail.com>
X-Mailer: Evolution 2.10.3 (2.10.3-2.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55160>

On Mon, 2007-08-06 at 10:36 +0100, Catalin Marinas wrote:

> > The main point in favor of quilt is that it allows to edit the patches
> > with the text editor.  One can pop all patches, edit them and push the
> > all back.
> 
> If this is the main feature they need, they probably don't need git at
> all and quilt would be enough. I was using quilt before starting StGIT
> but the main problem I had with plain patches approach was the
> conflict solving.

OK, I understand it wasn't a good idea to ask for improvement on behalf
of others.

> StGIT does a 'git-diff | git-apply' as a patch push optimization and
> we could even cache the diff but the current algorithm is that if
> git-apply fails, StGIT falls back to a three-way merge and even an
> interactive user merge (via xxdiff for example). I find the three-way
> merging (automatic or interactive) much more powerful than fuzzy patch
> application.

I agree.  I have no problem with what StGIT does internally.

> If we would allow patch editing, the 'stg push' algorithms wouldn't
> know when git-apply failed because the patch was edited or the base
> was changed. Falling back to the three-way merge would lose the edited
> patch. If one doesn't need three-way merging, quilt is good enough.

I suggest that StGIT saves the original patch and then does interdiff
between the old and the new patch.  The original patch is applied first
just as it's applied now, and then the difference is applied on top of
that.

Temporary files should be kept in case of failure.

> Other advantages of the three-way merging is the detection of full
> patches or hunks merged upstream (the former can also be achieved by
> testing the reverse-application of the patches).

I'm fully with you here.  Having git history can only be a good thing.

> I don't usually edit patches during development, I prefer to edit the
> source files and review the diff. It happens many times to move hunks
> between patches but I usually towards the bottom patches in the stack
> (using stg export and emacs) and the three-way merging automatically
> removes the merged hunks from top patches.

What I normally need to edit is the comments.  Editing the code is
risky, although I may want to rename some badly named variable
introduced by the patch.

> > I don't suggest that StGIT gives up on the git-based storage, but this
> > mode of operation could be implemented in two ways.
> >
> > One is to have a command opposite to "export".  It would read the files
> > that "export" produces, replacing the existing patches.
> 
> As Yann said, we already have 'stg import --replace'.

Thanks!

> > Another approach would be to reexamine the patch after "stg refresh -es"
> > and to apply it instead of the original patch.  If the patch doesn't
> > apply, the options would be to discard the edits or to re-launch the
> > editor.
> 
> That's an interesting idea but maybe we should have a separate command
> like --edit-full to edit the full patch + log (part of the
> functionality already available in import).

I hate to be in a situation when I want to edit something but cannot,
because I didn't run some command before.  What I like about StGIT is
that it allows me to do things my way.

I don't know if I want to change the patch before I see it.

> > Finally, it would be great to have TLS support in the mail command.
> > Mercurial has it, and looking at their mail.py, it doesn't seem to be
> > much work.
> 
> Indeed, the SMTP Python objects already provide support for TLS via starttls().

And hg provides a great example.

-- 
Regards,
Pavel Roskin
