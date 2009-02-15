From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: [PATCH] Fix file mark handling and sort side-effects in git.el
Date: Sun, 15 Feb 2009 10:35:38 -0800
Message-ID: <e38bce640902151035s18e374e6j25e3887728722700@mail.gmail.com>
References: <18834.27724.991388.339214@hungover.brentg.com>
	 <87hc31kzrb.fsf@wine.dyndns.org>
	 <e38bce640902120738h7b9bb75o42e1524cbfd95169@mail.gmail.com>
	 <18836.22386.987021.484807@hungover.brentg.com>
	 <87ocx3hbkq.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Sun Feb 15 19:37:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYlrZ-0004no-9Z
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 19:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209AbZBOSfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 13:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754034AbZBOSfl
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 13:35:41 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:35086 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754195AbZBOSfk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 13:35:40 -0500
Received: by yw-out-2324.google.com with SMTP id 5so860846ywh.1
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 10:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vsB57RRpfUoVQCGfG6+YhHdbGwzeHRr9uqAJZtTHM58=;
        b=q6Aeka+91HL8nvuLhlCjUuXk5ZMs7eCCtS8V+7SOGtWcRgdCASxf0YfPL3wb7hH3UC
         0G7+SnDv79En0CwlN47Q7hJ4HVF+MH3DiLynoNBl3rcwyZHLy+OFGwx1fcAGMII0Hy+h
         p4gBhllKNnZuvKERkxnIPmgzfB0FzhcsKQyb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=x2xL/0seEhMp6fj34RDfoZbwfDRC8fK5V6dsWL47RFkpZtNrezmAO5WmRFXnkyKINu
         2OWg1BB8gBmVZNvqVar3a6MTXXjzxkbCvnINcO6ztXMdmbDTMKsedeCJRt+TBdzdN9tZ
         kKWU1XG7eyeav//+0u85q+mOZED+jpBtq0IK8=
Received: by 10.90.83.2 with SMTP id g2mr1735112agb.79.1234722938930; Sun, 15 
	Feb 2009 10:35:38 -0800 (PST)
In-Reply-To: <87ocx3hbkq.fsf@wine.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110029>

On Sun, Feb 15, 2009 at 9:08 AM, Alexandre Julliard <julliard@winehq.org> wrote:
>
> Brent Goodrick <bgoodr@gmail.com> writes:
>
> > My rationale for adding append function calls to the sort calls is to
> > leave the callers value alone since the caller needs to make use of
> > the list value in subsequent operations, especially for issuing
> > messages.
>
> My point is that the callers that need it should take care of it
> themselves, instead of forcing a copy even in cases where it's not
> necessary. And the copy can most likely be avoided completely by
> changing how the success message is printed.
>
> >  > If you mean using git-add-file to do an update-index on an already
> >  > tracked file, that's not what it's meant to do.
> >
> > That would be fine in, say, Perforce where once a file is added it
> > stays added even if the user mades additional edits. I don't agree
> > that is the best approach in the case the Emacs interface to git in
> > git.el, since there is that "third" state where I could have added the
> > file, then edited it, then forgot that I had edited it and proceeded
> > naively to commit, only to be surprised later that the subsequent edit
> > to the file was not committed.
>
> The design of git.el is that the index is not exposed directly, it's
> treated as an implementation detail. So "add" in git.el is only for
> adding an untracked file, it's not for updating the index contents of an
> already tracked file; that's an unnecessary operation since git.el uses
> the file marks to determine what gets committed.

Ok, now that makes sense to me. Part of the problem here is that there
is no statement in the user manual about git.el's intent to hide the
index. Perhaps something to the effect of "If you are new to using
Emacs but not new to git, then you need to know that bla bla ...".
Otherwise, I think users may get tripped up by this as I was. Was
there a manual in the works for git.el or did I just miss it in recent
checkins?

>
> It does get a bit confusing if you constantly mix command-line and
> git.el commands, but you are not supposed to do that, you should be able
> to do everything from the git.el buffer. I'm sure hiding the index
> offends the git purists, but IMHO it makes things more Emacs-ish and
> easier to use, especially if you are used to things like dired or
> pcl-cvs or vc-dir with other VC systems.

That makes sense to me from the Emacs standpoint.

However, there is still a minor bug: If you edit two new files (not
known to git), then run M-x git-status, those two new files will show
up as Unknown as expected. But, mark both of them, and type "a" will
show a message in the minibuffer for only one of the files. If you
then look in the *Messages* buffer, you will find that a message for
only one of the files.

However, the *git-status* buffer does properly reflect the two added
files by their state being changed to "Added". Since you may have a
ton of files that are being added, it probably doesn't make a whole
lot of sense to dump a long message into the minibuffer with all of
those names.  By the same token, it doesn't make sense to emit one
message per file either. Instead, would you be willing to change that
message to just state "Added n files" where "n" is the number of files
added?  I would provide a patch, but that patch would necessitate the
fix to the "files" variable being damaged by the sort function, since
the git.el code seems to not even to take that into account (and is
the root cause of why only one message is emitted AFAIK).  The other
alternative is to take the length of the files list before calling the
list-damaging functions, but that just seems so not in the spirit of
current Elisp coding practice.

Thanks,
bg
