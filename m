From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH AMENDED] help: add "man.viewer" config var to use "woman" or "konqueror"
Date: Mon, 3 Mar 2008 08:38:48 +0100
Message-ID: <200803030838.48976.chriscool@tuxfamily.org>
References: <200802290814.39366.chriscool@tuxfamily.org> <200803010100.m2110ULs008889@localhost.localdomain> <7vir079ong.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Xavier Maillard <xma@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 08:33:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW5BB-0004hR-JB
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 08:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbYCCHdI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2008 02:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbYCCHdH
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 02:33:07 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:46857 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765AbYCCHdE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2008 02:33:04 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id BA8571AB2E4;
	Mon,  3 Mar 2008 08:33:03 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 8D3CC1AB2DB;
	Mon,  3 Mar 2008 08:33:03 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <7vir079ong.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75901>

Le samedi 1 mars 2008, Junio C Hamano a =E9crit :
> Xavier Maillard <xma@gnu.org> writes:
> > This patch makes it possible to view man pages using other tools
> > than the "man" program. It also implements support for emacs'
> > "woman" and konqueror with the man KIO slave to view man pages.
> >
> > Note that "emacsclient" is used with option "-e" to launch "woman"
> > on GNU emacs and this works only on versions >=3D 22.
> >
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> > Amended-by: Xavier Maillard <xma@gnu.org>
>
> When you do something like this, please CC the original author
> to keep him in the loop.

Yes please.

> I really do not think doing it this way would scale.  What if
> somebody prefers konq under X, and otherwise woman but wants to
> fall back to man?
>
> I do not think checking emacsclient version _every time_ is a
> good idea either, but for the sake of discussing an alternative
> approach, let's say that is fine.
>
> How about allowing multi-valued man.viewer like this:
>
>         [man]
>                 viewer =3D woman
>                 viewer =3D konqueror
>                 viewer =3D man

I tried the above in my .git/config and I get:

$ git config man.viewer
woman
error: More than one value for the key man.viewer: konqueror
error: More than one value for the key man.viewer: man

so I guess this can work only in C.

> and have:
>
>         static struct man_viewer {
>                 char *name;
>                 void (*exec)(const char *);
>         } viewers[] =3D {
>                 { "woman", exec_woman },
>                 { "konqueror", exec_konqueror },
>                 { "man", exec_man },
>                 { NULL, },
>         };
>
> Then you can iterate the man.viewer values, ask the viewer's
> exec() function to show the page (or return when it is not
> in an environment that it can be useful).
>
> show_man_page() would become:
>
> 	for (each viewer in user's config)
> 		viewer.exec(page); /* will return when unable */
> 	die("no man viewer handled the request");

Great idea, I will see if I can do that in some latter patches.

Thanks,
Christian.
