From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: git submodules and commit
Date: Wed, 16 Jul 2008 13:48:09 +0100
Message-ID: <320075ff0807160548qae5d702jafe3df63363c512c@mail.gmail.com>
References: <320075ff0807160331j30e8f832m4de3e3bbe9c26801@mail.gmail.com>
	 <320075ff0807160332k5e49c256tb4191de628ecf41c@mail.gmail.com>
	 <487DD1C7.3070701@viscovery.net>
	 <320075ff0807160402s7429291ela288b42d99c1ec53@mail.gmail.com>
	 <487DDCFC.9020007@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jul 16 14:49:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ6RT-0005hw-J3
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 14:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702AbYGPMsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 08:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754676AbYGPMsM
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 08:48:12 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:33076 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652AbYGPMsL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 08:48:11 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2715948ywe.1
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 05:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=e3gUDpTs7fM4eg1QKhasNEeARJfm1F+Efc0tvwcLC+o=;
        b=fnuSTSyS96gZhWEc1QGqKSpBBLimM0X5FLjzUKbbMp03iLa0VwaUzaPotAfXDCAXof
         q/kLi7njmkwHLXO85k+zS1pASs+atdREHaULoBXAWWdNLbGUmHTD7y3kB4uDY9GWIm9e
         VSzAxjsmPOiOTfE7LoyRXwB1vwbZRnxkudXrE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=iWABwZ3MGFETtxCoAoB/Qh1p4ZLZN2XWPjWTaQkBVVX+9dzaAzNDPg/xpEPPAMfSge
         Wh7rgOX+otadSv5vYgGB3gUHi8OdEjJfBK5ZlrZ4VHSMD/vk2fZZbTAvQpCGFj4IPoN1
         qCgZVmUydViW/zFFYOV5YX8BlznsohjjyEBG0=
Received: by 10.103.22.11 with SMTP id z11mr851504mui.83.1216212489553;
        Wed, 16 Jul 2008 05:48:09 -0700 (PDT)
Received: by 10.103.246.15 with HTTP; Wed, 16 Jul 2008 05:48:09 -0700 (PDT)
In-Reply-To: <487DDCFC.9020007@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88676>

> Ah, is this your actual scenario? Just to make sure we are talking about
> the same thing:
>
> - You own superproject P.
> - $Maintainer owns submodule S.
> - You use S in P.
> - You make changes to S that you would like $Maintainer to include in the
> next release.
> x You use in P your changes to S while $Maintainer has not yet released a
> new version of S with your changes.
> - Finally your changes arrive via the new release of S.
>
> That *is* the intended use-case for submodules. But you have to play the
> game by the rules:
>

Yes, that is the situation - with the proviso that it's not always
clear in company environments who $Maintainer actually is. For
example, if the only changes occurring in S come from me, then chances
are come release cycle, $Maintainer == me.

P and S aren't distant projects, they're closely coupled.

> - $Maintainer defines the official states of S.
>
Yes - there is one branch ('master') which the changes eventually
should be merged to, and releases will be performed on

> - You must never commit an unofficial state of S in P.
>

If by that you mean that the only person to move the branch 'master'
is $Maintainer, then I agree.
If by that you mean that you can't commit at all to the S tree (and
the S submodule pointer) then I don't agree, and I think that's a
serious limitation in productivity.

> The critical step in above list I marked with x:
>
> - During the period where only *you* have the new changes to S, you must
> *not* commit your submodule state to P. Instead, you write P in such a way
> that it can work with both the old version of S and the upcoming release
> that will have your changes[*]. This way you make sure that your consumers
> of P always have a working version regardless of which version of S they use.
>

Just to be clear - there's more than just 'me' working on P - there's
a whole team of people working on it. And there's Q R S and T teams
also working on projects that also have S.

Changes that happen to S are, often, new features or bug fixes. We
can't just stop because there isn't an 'official' version of S yet
(and the official version might end up simply being a FF anyway), so
saying 'don't commit your submodule state to P' is unrealistic.

And that should be the big advantage of git. If we suddenly find we
need some additional functionality in S, we just add it to our
P-branch-of-S. The $Maintainer (if he exists) can review these
upcoming changes in the tree, and merge them to master as appropriate
(or work with the projects to iron out cross-branch
incompatibilities). The best example is that S is a "product", and (by
management decree), the only product changes that happen will occur
because of *projects* (like P). And we can do this (and it's
infinitely better than svn, where 'ooh, branches too hard, everyone in
[P-T] just commit to trunk'. But the UI is an ache.


> - After you have received the new release of S from $Maintainer, you
> commit the new state of S in P. And if you are nice to your consumers of
> P, then you *do not* remove the workaround from P just yet, so that you
> don't force them to upgrade S. You will remove it later only if it becomes
> a maintainance burden.
>
Maintaining backwards compatibility isn't an issue at all for us.

> [*] If it is not possible to make P work with old and new versions, then
> you have to work closely with the $Maintainer so that you never need
> commit an unofficial state of S into P.
>
> -- Hannes
>
>
