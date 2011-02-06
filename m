From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Sun, 6 Feb 2011 15:03:02 +0300
Message-ID: <AANLkTikmD8qZOE+hi1=aeeVJx2qQpzdm0tV1mLsx1tfB@mail.gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
	<201102050218.44325.johan@herland.net>
	<20110205214045.GA15668@dpotapov.dyndns.org>
	<201102060104.37146.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Feb 06 13:03:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm3Kh-0005Bq-7f
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 13:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954Ab1BFMDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 07:03:05 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:48933 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab1BFMDD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 07:03:03 -0500
Received: by qwa26 with SMTP id 26so2879247qwa.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 04:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=r7V/3k3RWGgSIuFNR1d7kxxqjHxhtafVROdauU0Rtks=;
        b=QdJiFJVFeKStl3egdsbUk5Z4HUCrZ1CsILKufA91tCgb3FD8yKB+Zv3nzWMaAO32yy
         FOSKEbQ6eQ6s1Qn1YjXTAUpL8ps6/Ifw0Q7xfeS82YWc8Ce5+FnrtnRAOmeAiba6WUyy
         TAoZIZbC1TQybsF1ALXztVZT6lKmO+oUASm7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=I8I3rAFbneuSFjiFrpGGgzb3iiiMDZLoOTjdJnorD0Rr+hnVVlEL8UG2GeIhrVIf1n
         VqaJELOzHKlonzEs6cV6WiO1AedyorSLfj/fYdsube8bGR1DiI02Kg3mO+GLoF+eULrx
         ROOmip6grrddGT++fB6fR5NeIeGbieG/QypDE=
Received: by 10.224.36.201 with SMTP id u9mr9038054qad.325.1296993782621; Sun,
 06 Feb 2011 04:03:02 -0800 (PST)
Received: by 10.229.213.4 with HTTP; Sun, 6 Feb 2011 04:03:02 -0800 (PST)
In-Reply-To: <201102060104.37146.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166144>

On Sun, Feb 06, 2011 at 01:04:36AM +0100, Johan Herland wrote:
>_
> As long as they point to the same object, there's no ambiguity, and when you_
> simply refer to tag "foo" (without specifying namespace) it all works, like_
> today. (Read footnote [2] of my proposal for more details on handling_
> ambiguity in tag names.)

I see no reason to create different namespaces, because semantically
there is only one namespace.

> However, when the remote tags point to different objects (i.e. the uncommon_
> case), there is an ambiguity, and we should deal with that ambiguity_
> properly, instead of silently adopting one of them arbitrarily.

To me, the proper handling ambiguity means that when I do "git fetch" I
immediately see warning about tag clashes. So, I agree with you that
current behavior is not good, but I disagree with you about having many
namespaces, because it postpones detection of the conflict until I try
to use. And well, git may detect ambiguity when I say "git show v1.0",
but if I look at my branch in gitk and see "v1.0" and may say to someone
that I use "v1.0" but that person looks at his tree and sees "v1.0" as
something different.

So, if there is two different tags with the same name, it is better to
report the problem as soon as possible, i.e. during "git fetch", and
then there is no reason to have separate namespaces for tags.

Dmitry
