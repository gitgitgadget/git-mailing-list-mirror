From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH] Internationalization of git-gui
Date: Sat, 21 Jul 2007 09:50:58 +0200
Message-ID: <200707210951.00210.stimming@tuhh.de>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com> <20070720105602.7dcm241ts0k0ww88@webmail.tu-harburg.de> <20070721021717.GS32566@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 09:51:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC9jv-0005SL-JV
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 09:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758662AbXGUHu4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 03:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758187AbXGUHu4
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 03:50:56 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:56991 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761AbXGUHuz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 03:50:55 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6L7om8T018668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 21 Jul 2007 09:50:48 +0200
Received: from [192.168.2.102] (p549012DA.dip0.t-ipconnect.de [84.144.18.218])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6L7oka4004174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 21 Jul 2007 09:50:48 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <20070721021717.GS32566@spearce.org>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53151>

Thanks for the detailed feedback.

Am Samstag, 21. Juli 2007 04:17 schrieb Shawn O. Pearce:
> Christian Stimming <stimming@tuhh.de> wrote:
> > I used (and prefer) "_" because that's the standard function name for
> > i18n'd strings when using gettext (talking about a "standard" way).
>
> but I don't think its worth the CPU cycles in
> Tcl to eval mc via _ every time we need a string when it only is
> saving us one keystroke on a function name, 

The actual lookup of the string in the translation catalog far outweighs the 
discussion of one extra function evaluation, but if that's what you prefer -

> *and* we are breaking  tradition with Tcl.
>
> So when in Rome, wear a toga.  Or in this case, use [mc ...].

Ok.

> > Do you want to have patches
> > submitted after some further changes (which ones?)
>
> Yes.  Here's a few to get started with and that are really obvious.
> Some I'm just asking for more information on.
>
>  - Import msgcat::mc and use [mc] instead of [_].

Will do.

>  - Please combine the second and third patches into a single change.
>  There is no reason to switch to [mc {}] only to switch to [mc ""].

Will do.

>  - Please use mc's formatting support, rather than [format].
>  Its shorter code.

Didn't know about that (you know, C gettext doesn't have that), and I'll have 
to check whether this might confuse xgettext on string extraction, but will 
probably be done.

>  - Don't bother trying to translate the strings "Tools" (for the
>  Tools menu) or "Migrate" (for its only menu option).  This block
>  of code doesn't even belong in git-gui.  Its for my day-job and
>  is a custom hack that I need to strip out and carry as a local
>  patch there, rather than in the public distribution.

Err... from looking at the code, it's not quite clear to me whether any code 
parts like these are not publicly shown to the user. For that reason I rather 
translated everything that was currently available in the file. But I'll 
happily remove this from the patch.

>  - In our Makefile we do the looping in GNU make using its
>  $(foreach) operator, rather than using the shell's for builtin.
>  In other words, can we have the catalog target look more like the
>  install target?

Sure. I did it this way because I'm more used to the shell syntax, but I'll 
change that.

>  - Can ALL_LINGUAS be automatically built from the directory
>  contents of the po/ directory?

Yes. I used this one because this variable always appears in gettext's 
autoconf infrastructure, but it's not required here. Will remove it.

>  - Can we define a dist rule for the maintainer to build the catalog
>  files, so the maintainer can convert the .po -> .msg for Tcl and
>  the user doesn't need the GNU tools installed to build git-gui?

Yes, I'll try to add that, but I'd need further feedback and testing whether 
it actually works.

> > and/or in different
> > formats?
>
> Please send one patch per email message, inline and not attached.
> This way they are easy to review, respond to and comment on.

I'll try to do that, but at the workplace where I work on this issue I'm 
forced to use a webmailer and I have to check whether this leaves the patches 
intact.

> > Do you prefer to have all changes in a smaller number of
> > commit rather than split the way I did before?
>
> No, this series looks reasonably fine to me structurally.
>
> Did you base the patches on git.git's git-gui/ subdirectory, 

Yes.

> or 
> did you base them on the git-gui.git repository?  Technically all
> patches for git-gui should be against the git-gui repository on
> repo.or.cz, as git-gui is its own project.  

Will do.

> Dscho recently created a fork of git-gui.git here:
>
>   http://repo.or.cz/w/git-gui/git-gui-i18n.git
>
> and added your patch series into it.  But I'd like to see some
> cleanups before it merges in, and I want to hold off on actually
> applying it into git-gui 0.8.0 is released, 

Was this meant to say "hold off until git-gui 0.8.0 is released"? Sure, no 
problem.

I'll submit an updated set of patches by beginning of next week. Thank you 
very much for the feedback.

Christian
