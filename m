From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [RFC] Is using git describe resilient enough for setting the 
	build version of git?
Date: Sun, 21 Feb 2010 01:07:05 -0500
Message-ID: <32541b131002202207s7e9794cdg94d4bc305a0e9213@mail.gmail.com>
References: <4B8082ED.7020505@think.zenbe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Steve Diver <squelch@think.zenbe.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 07:53:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj4yd-000422-98
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 07:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329Ab0BUGH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 01:07:27 -0500
Received: from mail-yx0-f193.google.com ([209.85.210.193]:55881 "EHLO
	mail-yx0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab0BUGH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 01:07:26 -0500
Received: by yxe31 with SMTP id 31so205062yxe.21
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 22:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Kdx1VE5b5To43MnXrg5UxZR671wIkxER1sNOnnFXDwI=;
        b=JUH8hhtO986sqJbc7tSBL4kbiZ/yeH08IDMVbXmh228uDqwwkpVuIJRALqLydykXoT
         wSFMvmpb8bEnfseloG+tbCohR7au+b8Q4ZSZ5QKhlyFch1Bwf/7Rbt3kJZAk16ZH0aL+
         kDGOT+UxWXHWBkPhhatR7Pms/0RXEcJvhZveo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=uhul9Z4qkHQvQVKUH8zPuimkx+B2qrQcBe4JagEDyW7BZs2T+Lgzvrq8ORmbUqS4Tj
         nbFsGiE1ORbUqEBm89RHOc4tFg5OJMVq0k9hzgDT2aPB/q4Gr2pvn84D4O66rh7DF6aZ
         pLJWgmfbm+crqsXf2P5pvbVf7EpY8PNRJydhA=
Received: by 10.150.238.16 with SMTP id l16mr876333ybh.7.1266732445104; Sat, 
	20 Feb 2010 22:07:25 -0800 (PST)
In-Reply-To: <4B8082ED.7020505@think.zenbe.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140596>

On Sat, Feb 20, 2010 at 7:48 PM, Steve Diver <squelch@think.zenbe.com> wrote:
> Reading the manual entry for "git describe"[1] there is a note saying that
> the hash suffix does not guarantee disambiguity, and given that a tag may be
> incorrect or missing, there is a chance - albeit with diminishing odds -
> that the 5 digit hash/tag combination might lead to some obscure problems at
> some point along the line.
>
> The chance of this happening really is low, but there is a chance all the
> same. We cannot foresee all errors, but identifying, and further reducing
> the odds of some must be good. Without doing the math, a guess would be that
> the probability of a repeat 5 digit abbreviated hash suffix increases the
> longer a tagged version is in place, so never will be 100% safe.

Not really.  Note that the number *before* the hash is the number of
commits between your version and the tag.  So the only way to get an
actual undetectable overlap would be to have two commits that are both
the same number of commits on top of the given tag, *and* both start
with the same first five digits.  It's just not very likely at all.
Besides which, using the hash code feature of git-describe is most
useful for the short periods between versions, not as a long-term
thing.  After a new release comes out it's unlikely anyone will care
if the previous hash prefixes were overlapping.

> I may be wrong, but the only scenario where I see DEF_VER being used by
> GIT-VERSION-GEN, would be when there are no tags for git describe to
> retrieve. ie "git pull --no-tags"
>
> If my understanding is correct, DEF_VER is unique and set at the same time
> as the tagged version, so wouldn't it be desirable to cross check, or
> include this value instead of relying solely on the tag when present during
> the generation of GIT-VERSION-FILE at build time?

If I recall correctly, the main reason for DEF_VER is when building
git from a tarball, in which case 'git describe' wouldn't be able to
tell you anything useful.

Have fun,

Avery
