From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Sun, 6 Feb 2011 20:28:26 +0300
Message-ID: <AANLkTi=gd5iu0i=ggqJC++N_rL+nU6RO9PNw=jMpT0NH@mail.gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
	<201102060104.37146.johan@herland.net>
	<AANLkTikmD8qZOE+hi1=aeeVJx2qQpzdm0tV1mLsx1tfB@mail.gmail.com>
	<201102061711.45460.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Feb 06 18:28:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm8PY-0001Ec-Pa
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 18:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324Ab1BFR22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 12:28:28 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:46028 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744Ab1BFR21 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 12:28:27 -0500
Received: by qyj19 with SMTP id 19so1009899qyj.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 09:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=PxgefA7x7Haqoh9uXRAWqGYSrKr+GxMKLZpPI/GfZgs=;
        b=Ke3Tmk0BVbg0pvuIB7ihwwHlGwLkZtnvDe7grYwU7c3QP4+9V0m5AXUb5Ps9ph+yYO
         LK/VjftxsxeCXETA6d8eneIIEqSFXGN7YDNHwxLQdn2+D/ycptpacc2e2NBtzZFJRGNU
         qlISqqtdU+o5pGfqHaTo0fidDNaufVs5VxmtI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=DB8RWvSvKpN21OtU1UIxr7ejExQFRZCW7E8WUoBSdfFjdagOaiH/9gIXhNPFkE5sr4
         xhS4eXLKzUg1gFVIkwhlg1FnX/FeOuIuAuDWmxMItDJRD1Bi784cqXewUlkLT4xbehTa
         P7TJCHze3ks6wKYygMdGiYSeUZ+zTXOVJnS9E=
Received: by 10.224.36.201 with SMTP id u9mr9267265qad.325.1297013306721; Sun,
 06 Feb 2011 09:28:26 -0800 (PST)
Received: by 10.229.213.4 with HTTP; Sun, 6 Feb 2011 09:28:26 -0800 (PST)
In-Reply-To: <201102061711.45460.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166157>

On Sun, Feb 06, 2011 at 05:11:45PM +0100, Johan Herland wrote:
> On Sunday 06 February 2011, Dmitry Potapov wrote:
> > On Sun, Feb 06, 2011 at 01:04:36AM +0100, Johan Herland wrote:
> > >_
> > >
> > > As long as they point to the same object, there's no ambiguity, and
> > > when you_ simply refer to tag "foo" (without specifying namespace) it
> > > all works, like_ today. (Read footnote [2] of my proposal for more
> > > details on handling_ ambiguity in tag names.)
> >_
> > I see no reason to create different namespaces, because semantically
> > there is only one namespace.
>_
> In practice, there is almost always one namespace (i.e. your repo belongs to_
> only one project with project-wide unique tags). However, in any distributed_
> system, the only-one-namespace is fundamentally a myth.

By your logic git 1.7.4 is a myth, because I have not specified from
what repository I pull it. But, IMHO, it is a myth that having different
namespaces solves the problem, because in _most_ cases, you really want
to have a single namespace _semantically_, so you can communicate with
other people using this tag name. In your case of semi-related projects,
it should be two namespaces, because there are _two_ different projects
(even if they share a lot of common history). How do I know that they
are different? Because they have different release schedulers, and v1.0
means different for each of them.

> > To me, the proper handling ambiguity means that when I do "git fetch" I
> > immediately see warning about tag clashes. So, I agree with you that
> > current behavior is not good, but I disagree with you about having many
> > namespaces, because it postpones detection of the conflict until I try
> > to use. And well, git may detect ambiguity when I say "git show v1.0",
> > but if I look at my branch in gitk and see "v1.0" and may say to someone
> > that I use "v1.0" but that person looks at his tree and sees "v1.0" as
> > something different.
>_
> In that case it would be wrong of gitk to display "v1.0". Instead it should_
> display a longer, unambiguous name, e.g. "origin/v1.0".

But it is still ambiguous because my "origin" may be different from
yours origin. It is only unambiguous when it look at it _locally_ but
that makes it completely useless for communication with other people.
One project should have only one version with the same tag regardless
where it came from.

I agree in your use case of semi-related projects you need separate
namespaces. But I don't think it is how most people use git. It may
be nice to have an option that will make tag namespace separate, but
I do not think it should be default. Not until, it is widely tested.


Dmitry
