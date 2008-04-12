From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: git-bisect annoyances
Date: Sat, 12 Apr 2008 08:56:59 +0200
Message-ID: <200804120856.59290.chriscool@tuxfamily.org>
References: <20080409101428.GA2637@elte.hu> <200804110741.40732.chriscool@tuxfamily.org> <20080411114104.GE9205@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Carl Worth <cworth@cworth.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Sat Apr 12 08:52:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkZbD-000399-La
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 08:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753622AbYDLGvk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Apr 2008 02:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753534AbYDLGvk
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 02:51:40 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:37620 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753514AbYDLGvj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Apr 2008 02:51:39 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 161611AB2BC;
	Sat, 12 Apr 2008 08:51:38 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id ABF071AB2E8;
	Sat, 12 Apr 2008 08:51:37 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <20080411114104.GE9205@elte.hu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79336>

Le vendredi 11 avril 2008, Ingo Molnar a =E9crit :
> * Christian Couder <chriscool@tuxfamily.org> wrote:
> > >  #
> > >  # So perhaps this new, unnamed branch is what is causing the
> > > trouble? # Lets try a specific branch then:
> > >  #
> > >
> > >  dione:~/linux-tmp4> git-checkout master
> > >  Previous HEAD position was 4991408... Linux 2.6.24
> > >  Switched to branch "master"
> > >
> > >  dione:~/linux-tmp4> git-bisect start
> > >  won't bisect on seeked tree
> >
> > This seems to work for me with git 1.5.5 on the git tree:
> >
> > What git version do you have ?
>
> git-core-1.5.4.3-2.fc8, like for the previous report.
>
> and it worked for me too in a later tree - so the condition seems
> transient.

Yes, it probably depends on what you have done before.
I didn't look at it yet, but I will have a look soon.
Anyway as Junio said, there have been some improvements in 1.5.5 so it =
might=20
be a good idea to upgrade.

> > >  dione:~/linux-tmp4> git-bisect good v2.6.24 bad HEAD
> > >  dione:~/linux-tmp4>
> >
> > This is really bad, because, as you can see from the man page or "g=
it
> > bisect -h" (see also the patch I just sent), "git bisect good" can
> > take many known good revisions:
> >
> > git bisect good [<rev>...]
> >         mark <rev>... known-good revisions.
> >
> > So you marked also "bad" and HEAD as "good".
> >
> > This is really strange, because here I get for example:
> >
> > $ git-bisect good bad HEAD
> > Bad rev input: bad HEAD
> >
> > So you must have something tagged as "bad" or have a "bad" branch, =
and
> > that's why the command works for you but does the wrong thing.
>
> no, there are no 'bad' braches or revisions.

You are right, we have got some bugs here I think.

In my case bad and HEAD were neither proper revs, that's why I got an e=
rror.
But I realized that as long as there is one proper rev in what you give=
=20
to "git bisect good" it will ignore bad revs and mark as good the prope=
r=20
rev you gave it.

I just sent a patch to fix this, but I am not sure it's the right fix.
More work is probably needed. Ooops I just spotted one bug in my patch.
Please wait, I will send another one.

> and ... if "git-bisect good X bad Y" is invalid syntax it should be
> detected by the tool ...=20

Yes.

Thanks again,
Christian.
