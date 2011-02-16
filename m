From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] rebase: be cleverer with rebased upstream branches
Date: Wed, 16 Feb 2011 11:45:49 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102161122350.14950@debian>
References: <1297691481-3308-1-git-send-email-martin.von.zweigbergk@gmail.com> <7vzkpxm45e.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1102152040370.14950@debian> <AANLkTinmxbYLB-K+VzY50NtOAPwd-q3WwAosAHqKRq_0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Feb 16 17:46:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpkVs-000337-DX
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 17:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238Ab1BPQpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 11:45:55 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:34823 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191Ab1BPQpy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 11:45:54 -0500
Received: by qyj19 with SMTP id 19so3862094qyj.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 08:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=la+40cDvsbU1CgFkwCxaFWwy73dKytXCIL9L4sqe1eg=;
        b=qZtiVRUm1DQu8D6MlehtLDp5645Pn6VCiO7LitIgK5e9kfQDFVbSq5owXr7W8gLkIP
         M/eEPidKCDfwmhhQS2ZhXnnx+nG8ZvZNkJTWYJf7/NEFc3OMY5xlLEUrzRnByrKevP4e
         BuKAEDcXXPFnox/CzkbHC9+udf1k/IbTjlNn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=Ogy0U/jpWxdvm1qnE8sV4HzVrV2RCV2WNC/PqRrGGg2vnedVvo2nBy52gd8CKgO9HJ
         G7WUeSf/+pd/1gBFjmRHdVqTt5S3e9WNQAFaCm69R2W9VNnCRGs0TzXlOikBBM70RKYT
         rRJmJWdfzJ5+b3PyXZlcNHWS1ryMjqixJ+Vkk=
Received: by 10.224.89.15 with SMTP id c15mr1076979qam.91.1297874753338;
        Wed, 16 Feb 2011 08:45:53 -0800 (PST)
Received: from [192.168.1.100] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id b5sm132600vcx.4.2011.02.16.08.45.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Feb 2011 08:45:51 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <AANLkTinmxbYLB-K+VzY50NtOAPwd-q3WwAosAHqKRq_0@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166974>

On Wed, 16 Feb 2011, Santi B?jar wrote:

> On Wed, Feb 16, 2011 at 3:03 AM, Martin von Zweigbergk
> <martin.von.zweigbergk@gmail.com> wrote:
> > On Tue, 15 Feb 2011, Junio C Hamano wrote:
> >
> >> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
> >>
> >> > diff --git a/git-rebase.sh b/git-rebase.sh
> >> > index 5abfeac..1bc0c29 100755
> >> > --- a/git-rebase.sh
> >> > +++ b/git-rebase.sh
> >>       test -n "$upstream_name" &&
> >>         for reflog in $(git rev-list ...)
> >>         do
> >>               ...
> >>       done
> >>
> >> Don't you need to make sure $upstream_name is a branch (or a ref in
> >> general that can have a reflog), or does it not matter because the
> >> "rev-list -g" will die without producing anything and you are discarding
> >> the error message?
> >
> > Exactly as you suspect. Is it too ugly?
> 
> I also prefer Junio's version.

I fixed the test + for loop, if that's what you mean by "Junio's
version". Or did you mean "make sure $upstream_name is a branch"? I
could do that as well if you like. I have no preference.

> >        .-u@{0}
> >       /
> >      .---u@{1}
> >     /
> > x---y-----u@{2}
> >     \
> >      .---u@{3}---b
> >       \
> >        .-u@{4}
> >
> >
> > I have an idea inspired by bisection, Thomas's exponential stride, and
> > what someone (you?) mentioned the other day about virtual merge
> > commits. I haven't tried it out, but let me know what you think. I'll
> > try to explain it using an example only:
> >
> > Exponential stride phase:
> > 1. candidates={ u@{0} }
> >   merge-base b $candidates -> y, _not_ in $candidates
> > 2. candidates={ u@{1} u@{2} }
> >   merge-base b $candidates -> y, _not_ in $candidates
> > 3. candidates={ u@{3} u@{4} u@{5} u@{6} }
> >   merge-base b $candidates -> u@{3}, in $candidates
> 
> Doesn't it indicate that u@{3} is the commit we are looking for? I
> haven't found a counterexample...

Yes, of course. Stupid me ;-). Forget about the other half. (I think
that's what I did manually to match the sha1 back to the ref name, but
that is of course complete non-sense to do in the script.)

> If this is true the following patch can implement it for git-pull.sh and
> git-rebase.sh (sorry if it is space damaged):

Thanks! Will have a closer look at it later today. If I understand
correctly, you simply call merge-base with the _entire_ reflog. I
would have thought that would be slow, but it's great if that is fast
enough. The resulting code looks very nice and short. Thanks again.


/Martin
