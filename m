From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Added giteditor script to show diff while editing commit
 message.
Date: Wed, 21 Jan 2009 23:52:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901212343100.3586@pacific.mpi-cbg.de>
References: <1232570841-25641-1-git-send-email-ted@tedpavlic.com> <alpine.DEB.1.00.0901212216310.3586@pacific.mpi-cbg.de> <4977A2C9.1070502@tedpavlic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster <gitster@pobox.com>, git <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 23:54:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPlxI-0000pa-4Q
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 23:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbZAUWwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 17:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753218AbZAUWwY
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 17:52:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:50682 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751503AbZAUWwY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 17:52:24 -0500
Received: (qmail invoked by alias); 21 Jan 2009 22:52:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp061) with SMTP; 21 Jan 2009 23:52:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/rIDokvT3rFNTH2gdhlvHi21UYezeu5c+LGRMuSV
	+AfqjZS1kHJmjn
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4977A2C9.1070502@tedpavlic.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106695>

Hi,

On Wed, 21 Jan 2009, Ted Pavlic wrote:

> Thanks for your comments. I've responded below. I just want to 
> top-respond to your comment that the fundamental problem is that the 
> diff is in a separate file. In fact, this is the point of the script. I 
> want to be able to scroll through the diff output independent of the 
> commit message.

Once again, note that e.g. vi will not cope with the way you try to 
achieve that.

> > > From: Ted Pavlic<ted@tedpavlic.com>
> >
> > From: me
> 
> > Besides, I find it funny that you want to override git with $GIT.
> 
> Isn't it possible that someone has git somewhere else?

The script is called from within Git.  So you can rest assured that "git" 
is in the PATH, I guess.  Except in configurations where you have a 
properly installed GIT_EXEC_PATH, and run Git using an absolute path.

If you want to cater for such a case, sure go ahead :-)

> > > +# doesn't break
> > > +GITTMP="${TMPDIR-/tmp}/giteditor.$RANDOM.$RANDOM.$RANDOM.$$.git"
> > > +(umask 077&&  mkdir "${GITTMP}") || {
> > > +    echo "Could not create temporary directory! Exiting." 1>&2
> > > +    exit 1
> > > +}
> >
> > Umm.  Why?  Why do you need a temporary .git directory?
> 
> The script generates a new "diff" file that I would rather drop elsewhere
> (e.g., in a /tmp directory) rather than here in the current directory.

Why not .git/?  That would be the _natural_ place to put it.

> > > +    # Diff is non-empty, so edit msg and diff
> > > +    ${EDITOR} "${GITTMP}/${COMMITMSG}" "${GITTMP}/diff" || exit $?
> >
> > vi users will hate you, as you do not give them a chance to edit the
> > message after having seen the diff.
> 
> I don't see what you mean. I am a vi user (exclusively), and this script 
> works very well for me.

I cannot go back to the commit message when I said ":n" to get to the 
diff.

> > Besides all that criticism, there is also a fundamental issue.  The 
> > diff is in a separate file.
> 
> That's the point. If I wanted to put the diff in the commit buffer, I 
> would have used "git commit -v". I think many would like to be able to 
> scroll through the diff without having to scroll through the commit.
> 
> Is there no value in having the diff in a separate file?

In my case, no, for 2 reasons:

- I can always open a new shell (in ssh connections, I use screen) to get 
  the diff, and even better: I can restrict it to certain files, and I can 
  use the nice bookmarks "less" provides; dunno if vi would have them.

- My preference is definitely to look at the diff before committing, to be 
  certain that I did not fsck up.  And nothing would annoy me more than to 
  be in the middle of editing a commit message while I am looking at the 
  diff and telling myself "that is a stupid mistake, let's fix it" knowing 
  that the commit will not pick up the fix.

  So seeing the diff while composing the commit message is definitely too 
  late for me.

Ciao,
Dscho
