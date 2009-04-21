From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/5] bisect--helper: add "--next-exit" to output bisect results
Date: Tue, 21 Apr 2009 07:57:55 +0200
Message-ID: <200904210757.55162.chriscool@tuxfamily.org>
References: <20090419115607.c7089503.chriscool@tuxfamily.org> <7vprf7k93h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 08:00:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw92C-00043q-Sx
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 08:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbZDUF7M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Apr 2009 01:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbZDUF7M
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 01:59:12 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:35530 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126AbZDUF7L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2009 01:59:11 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id F0AB59400CC;
	Tue, 21 Apr 2009 07:59:04 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 1055A940067;
	Tue, 21 Apr 2009 07:59:02 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vprf7k93h.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117095>

Le lundi 20 avril 2009, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > The goal of this patch is to port more shell code from the
> > "bisect_next" function in "git-bisect.sh" to C code in
> > "builtin-bisect--helper.c".
> >
> > So we port the code that interprets the bisection result and stops =
or
> > continues (by checking out the next revision) the bisection process=
=2E
> >
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>
> Just to make sure I understand correctly, with this and patch 5/5, we=
 can
> then drop the --next-vars helper command, right?

Yes, that's right. I just sent two patches to remove useless code.

> > @@ -16,6 +17,12 @@ static const char **rev_argv;
> >  static int rev_argv_nr;
> >  static int rev_argv_alloc;
> >
> > +static const unsigned char *current_bad_sha1;
> > +
> > +static const char *argv_diff_tree[] =3D {"diff-tree", "--pretty", =
NULL,
> > NULL}; +static const char *argv_checkout[] =3D {"checkout", "-q", N=
ULL,
> > "--", NULL}; +static const char *argv_show_branch[] =3D {"show-bran=
ch",
> > NULL, NULL};
>
> I do appreciate that you kept this step in "rewrite in C" theme a
> straight rewrite to still call out the executables.  We can turn thes=
e
> into internal calls in future steps, but that is a separate issue.
>
> I suspect that the show-branch call outlived its usefulness with this
> patch; it will now be a low hanging fruit to call format_commit_messa=
ge()
> internally to reduce one fork+exec.

I will have a look at that.

Thanks,
Christian.
