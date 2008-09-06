From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] builtin-symbolic-ref: comment on the use of "resolve_ref" with reading == 0
Date: Sat, 6 Sep 2008 14:03:13 +0200
Message-ID: <200809061403.14592.chriscool@tuxfamily.org>
References: <20080906095543.c627b692.chriscool@tuxfamily.org> <7vwshpsi1g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 14:01:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbwTX-0000M0-WE
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 14:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbYIFL7k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Sep 2008 07:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbYIFL7k
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 07:59:40 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:42084 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbYIFL7k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2008 07:59:40 -0400
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 47823B0151;
	Sat,  6 Sep 2008 13:59:38 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp7-g19.free.fr (Postfix) with ESMTP id F1150B0142;
	Sat,  6 Sep 2008 13:59:37 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vwshpsi1g.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95071>

Le samedi 6 septembre 2008, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > diff --git a/builtin-symbolic-ref.c b/builtin-symbolic-ref.c
> > index bfc78bb..9490c47 100644
> > --- a/builtin-symbolic-ref.c
> > +++ b/builtin-symbolic-ref.c
> > @@ -12,6 +12,16 @@ static void check_symref(const char *HEAD, int
> > quiet) ...
> > +	/*
> > +	 * It doesn't seem logical to use "resolve_ref" with reading =3D=3D=
 0
> > +	 * as we are just checking if a ref exists,...
> > ...
> > +	 */
>
> I have to say that this comment is confused.
>
> When you have a full ref (as opposed to an abbreviated one that you m=
ight
> give to dwim_ref()), you can use it for two kinds of things:
>
>  (1) You can use it to find out what _object_ the ref points at.  Thi=
s is
>      "reading" the ref, and the ref, if it is not symbolic, has to ex=
ist,
>      and if it is symbolic, it has to point at an existing ref, becau=
se
>      the "read" goes through the symref to the ref it points at.

Then the parameter should perhaps be=20
called "get_object", "get_target", "full_dereference" or something like=
=20
that instead of "reading".

>  (2) Anything else.  This could be a prelude to "writing" to the ref,=
 in
>      which case a write to a symref that points at yet-to-be-born ref
>     will create the real ref pointed by the symref, so such a symref =
is
>     not an error.  It has to answer "here is the real ref you should =
write
>     into" (or, "we will write into").
>
>      But the access that is not "reading" does not have to be "writin=
g";
>      it can be merely checking _where it leads to_.  And check_symref=
()
>      uses this call for exactly that purpose.  This access is not
>      "checking if a ref exists".

In "resolve_ref" in refs.c there is the following comment:

		/* Special case: non-existing file.
		 * Not having the refs/heads/new-branch is OK
		 * if we are writing into it, so is .git/HEAD
		 * that points at refs/heads/master still to be
		 * born.  It is NOT OK if we are resolving for
		 * reading.
		 */

that seems to mean that we are either "writing" or "reading".

> So reading=3D=3D0 is the logical thing to do here.

It seems logical after your explanations, yes, and thank you for them, =
but I=20
don't think it is logical when reading the existing source code or=20
comments.

Regards,
Christian.
