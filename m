From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 4/7] reset: add option "--keep" to "git reset"
Date: Wed, 30 Dec 2009 06:47:24 +0100
Message-ID: <200912300647.25184.chriscool@tuxfamily.org>
References: <20091212042042.3930.54783.chriscool@tuxfamily.org> <20091212043259.3930.21831.chriscool@tuxfamily.org> <7viqcbn9w3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 06:44:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPrMf-0003FX-06
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 06:44:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbZL3Fox convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Dec 2009 00:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbZL3Fow
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 00:44:52 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:54301 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889AbZL3Fow convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Dec 2009 00:44:52 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 78C54818076;
	Wed, 30 Dec 2009 06:44:40 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 77300818036;
	Wed, 30 Dec 2009 06:44:35 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7viqcbn9w3.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135856>

On samedi 12 d=E9cembre 2009, Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>
> >   B      B     C     D   --keep    (disallowed)
> >                          --merge    C      C     C
>
> For --keep this is the same as the first case (except that the "parti=
ally
> updated the index" happened to be "100% pertially") and it makes sens=
e to
> disallow it.
>
> However, I think --merge _should_ have D (target) in all of the three=
 in
> the result in this case, as I mentioned in my response to [PATCH 3/7]=
=2E=20
> Is that "the bug" you talked about there?

No it is not the bug I talked about. It was a bug in the documentation=20
patch. Thanks for finding it! I left some "C" on the merge line from an=
=20
earlier documentation patch but I should have changed them to "D" like=20
that:

   B      B     C     D   --keep    (disallowed)
                          --merge    D     D     D

[...]

> It also is tempting to say that we should forbid "reset --merge" with=
out
> an unmerged entry in the index, but that wouldn't work.  A mergy
> operation would have left unmerged entries in the index initially bef=
ore
> giving the control back to the user, but the user may have used "edit=
 &&
> git add" to resolve them, and then decided that it is not worth
> committing.  By the time "reset --merge" is run, there may not be any
> unmerged path left in the index.
>
> I am suggesting extra safety measures primarily because I am worried =
that
> people will get confused by these two similar looking options that ar=
e
> meant for entirely different use cases.  An obvious alternative solut=
ion
> to avoid the confusion is not to add "--keep" in the first place.  Wh=
ile
> I think that is rather a cop-out than a solution, it might make more
> sense. It is hopeless to educate users to pick the right one, if even=
 the
> author of the new option mistakenly thinks that "--keep is merely a
> better version of --merge".

I just think it is better in some cases not always.

> My preference is at this point to first have patches [1/7] to [3/7] t=
o
> update "reset --merge" (I am not sure about the "--mixed in $GIT_DIR"
> change, though), with a new follow-up patch [3.5/7] to fix "reset
> --merge" to reset paths that were cloberred by the merge to the targe=
t
> (not HEAD), and start cooking these changes in 'pu' and then 'next'.

Ok, I will send a patch series to do that except that I I don't underst=
and=20
exactly what the follow up patch [3.5/7] shoud do. Perhaps you asked fo=
r=20
this additional patch because of the documentation bug above?

> That will lay groundwork of using unpack_trees() in "reset" and after
> they stabilize, build new modes like "--keep" on top of it.

Ok.

Thanks,
Christian.
