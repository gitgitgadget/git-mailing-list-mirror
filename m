From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Sun, 14 Jul 2013 15:28:06 +0100
Message-ID: <20130714142806.GA2239@serenity.lan>
References: <7vvc4jtjqa.fsf@alter.siamese.dyndns.org>
 <51DF1F56.9000705@kdbg.org>
 <7vzjtspwvo.fsf@alter.siamese.dyndns.org>
 <51E03B18.5040502@kdbg.org>
 <7vli5bllsd.fsf@alter.siamese.dyndns.org>
 <51E0605E.9020902@kdbg.org>
 <7vy59biih4.fsf@alter.siamese.dyndns.org>
 <51E0F93A.8050201@kdbg.org>
 <7vwqougwec.fsf@alter.siamese.dyndns.org>
 <7vr4f2gr4m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 16:28:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyNI9-0004hD-1u
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 16:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646Ab3GNO2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 10:28:21 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:52185 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563Ab3GNO2T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 10:28:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id AADDB22B5C;
	Sun, 14 Jul 2013 15:28:18 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rWVJFGfALXvA; Sun, 14 Jul 2013 15:28:17 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 916F323ABC;
	Sun, 14 Jul 2013 15:28:13 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vr4f2gr4m.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230365>

On Sat, Jul 13, 2013 at 01:08:09PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > If "--lockref" automatically implies "--allow-no-ff" (the design in
> > the reposted patch), you cannot express that combination.  But once
> > you use "--lockref" in such a situation , for the push to succeed,
> > you know that the push replaces not just _any_ ancestor of what you
> > are pushing, but replaces the exact current value.  So I do not think
> > your implicit introduction of --allow-no-ff via redefining the
> > semantics of the plus prefix is not adding much value (if any),
> > while making the common case less easy to use.
> >
> >> No; --lockref only adds the check that the destination is at the
> >> expected revision, but does *NOT* override the no-ff check.
> >
> > You _could_ do it in that way, but that is less useful.
> 
> Another issue I have with the proposal is that we close the door to
> "force only this one" convenience we have with "+ref" vs "--force
> ref".  Assuming that it is useful to require lockref while still
> making sure that the usual "must fast-forward" rule is followed (if
> that is not the case, I do not see a reason why your proposal is any
> useful---am I missing something?), I would prefer to allow users a
> way to decorate this basic syntax to say:
> 
>     git push --lockref master jch pu
> 
> things like
> 
>  (1) pu may not fast-forward and please override that "must
>      fast-forward" check from it, while still keeping the lockref
>      safety (e.g. "+pu" that does not --force, which is your
>      proposal);
> 
>  (2) any of them may not fast-forward and please override that "must
>      fast-forward" check from it, while still keeping the lockref
>      safety (without adding "--allow-no-ff", I do not see how it is
>      possible with your proposal, short of forcing user to add "+"
>      everywhere);
> 
>  (3) I know jch does not fast-forward so please override the "must
>      fast-forward", but still apply the lockref safety, pu may not
>      even satisfy lockref safety so please force it (as the "only
>      force this one" semantics is removed from "+", I do not see how
>      it is possible with your proposal).

I haven't been following this thread too closely, but I was assuming
that the interface would be something like this:

    git push origin +master
    git push --force origin master

mean the same thing and do what they do now.

    git push origin *master
    git push --lockref origin master

both mean the same thing: using the new compare-and-swap mode only
update master if the remote side corresponds to remotes/origin/master
[1].

    git push origin *master:refs/heads/master:@{1}

means to push the local ref master to the remote ref refs/heads/master
if it currently points at "@{1}".

In this scenario, giving both --lockref and --force should be an error
because the user is probably confused (the obvious interpretation is
that --force wins, but I don't think that's sensible).

I'm not sure what should happen with:

    git push --force origin *master

where it appears that the user is asking for a compare-and-swap update
of master but the --force is overriding this.  I think we have to let
--force win because when the refspec comes from remote.<name>.push we
have to let the command-line --force override the specified behaviour.

I don't particularly like the name --lockref, the original --cas feels
more descriptive to me.


[1] In fact, I suspect this would have to be "the ref that
    refs/heads/master maps to using remote.origin.fetch".
