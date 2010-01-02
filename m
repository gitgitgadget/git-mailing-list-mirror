From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 2/4] Documentation: reset: add some tables to describe the different options
Date: Sat, 2 Jan 2010 06:52:14 +0100
Message-ID: <201001020652.14289.chriscool@tuxfamily.org>
References: <20091230055008.4475.95755.chriscool@tuxfamily.org> <20091230055448.4475.83629.chriscool@tuxfamily.org> <7vd41uo16x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
X-From: git-owner@vger.kernel.org Sat Jan 02 06:49:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQwrr-0003Wm-3l
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 06:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272Ab0ABFte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 00:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081Ab0ABFte
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 00:49:34 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:33986 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106Ab0ABFte (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 00:49:34 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6596B81802D;
	Sat,  2 Jan 2010 06:49:23 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 37C9D81803B;
	Sat,  2 Jan 2010 06:49:21 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vd41uo16x.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136022>

On vendredi 01 janvier 2010, Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > This patch adds a DISCUSSION section that contains some tables to
> > show how the different "git reset" options work depending on the
> > states of the files in the working tree, the index, HEAD and the
> > target commit.
> >
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>
> Much nicer.

Thanks.

> >  Documentation/git-reset.txt |   66
> > +++++++++++++++++++++++++++++++++++++++++++ 1 files changed, 66
> > insertions(+), 0 deletions(-)
> >
> > diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> > index 2d27e40..c9044c9 100644
> > --- a/Documentation/git-reset.txt
> > +++ b/Documentation/git-reset.txt
> > @@ -67,6 +67,72 @@ linkgit:git-add[1]).
> >  <commit>::
> >  	Commit to make the current HEAD. If not given defaults to HEAD.
> >
> > +DISCUSSION
> > +----------
> > +
> > +The tables below show what happens when running:
> > +
> > +----------
> > +git reset --option target
> > +----------
> > +
> > +to reset the HEAD to another commit (`target`) with the different
> > +reset options depending on the state of the files.
>
> Together with these "mechanical definitions", I think the readers would
> benefit from reading why some are disallowed.

Ok, I will add some explanations along what you write below.

> > +      working index HEAD target         working index HEAD
> > +      ----------------------------------------------------
> > +       A       B     C    D     --soft   A       B     D
> > +                                --mixed  A       D     D
> > +                                --hard   D       D     D
> > +                                --merge (disallowed)
>
> "reset --merge" is meant to be used when resetting out of a conflicted
> merge.  Because any mergy operation guarantees that the work tree file
> that is involved in the merge does not have local change wrt the index
> before it starts, and that it writes the result out to the work tree, the
> fact that we see difference between the index and the HEAD and also
> between the index and the work tree means that we are not seeing a state
> that a mergy operation left after failing with a conflict.  That is why
> we disallow --merge option in this case, and the next one.
>
> > +      working index HEAD target         working index HEAD
> > +      ----------------------------------------------------
> > +       A       B     C    C     --soft   A       B     C
> > +                                --mixed  A       C     C
> > +                                --hard   C       C     C
> > +                                --merge (disallowed)
>
> The same as above, but you are resetting to the same commit.
>
> > +      working index HEAD target         working index HEAD
> > +      ----------------------------------------------------
> > +       B       B     C    D     --soft   B       B     D
> > +                                --mixed  B       D     D
> > +                                --hard   D       D     D
> > +                                --merge  D       D     D
> >
> > +      working index HEAD target         working index HEAD
> > +      ----------------------------------------------------
> > +       B       B     C    C     --soft   B       B     C
> > +                                --mixed  B       C     C
> > +                                --hard   C       C     C
> > +                                --merge  C       C     C
>
> As this table is not only about "--merge" but to explain "reset", I think
> other interesting cases should also be covered.
>
> w=A	i=B	H=B	t=B
>
> This is "we had local change in the work tree that was unrelated to the
> merge", and "reset --merge" should be a no-op for this path.
>
> w=A	i=B	H=B	t=C
>
> This "reset --merge" is like "using checkout to switch to a commit that
> has C but we have changes in the work tree", and should fail just like
> "checkout branch" in such a situation fails without "-m" option.

Ok I will add these cases too.

Thanks,
Christian.
