From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] t2017: redo physical reflog existance check
Date: Fri, 23 Jul 2010 12:04:37 -0300
Message-ID: <AANLkTin76s-ONFuP+OWdxB5LJNf2D1Du+hKxB2s_WhTa@mail.gmail.com>
References: <1279763190-32757-1-git-send-email-erick.mattos@gmail.com> 
	<7vlj93h120.fsf@alter.siamese.dyndns.org> <AANLkTilt5gx3Wj4eANfkIFm869Olns1rsMpCS81hS2BV@mail.gmail.com> 
	<7vsk3bey1e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 17:05:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcJoa-0007FI-Gg
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 17:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759478Ab0GWPFA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 11:05:00 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42484 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756148Ab0GWPE6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jul 2010 11:04:58 -0400
Received: by gwb20 with SMTP id 20so681178gwb.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=D6/rJW+jHkmSKsuiPJ7qO1911TvX41G+etqciWEHyQk=;
        b=tk9zCJwfvvSU5vu+0C8qj0Da/6DB2Y7bd3/1TMh05TMk69rDVwbGyVKqkopY/hm/5C
         oVt74oOv7ZIuBIZEsqmhXhtbv6embQBobHJkCQ/2QqwrueaMbugl73AR3txLJzCksEf8
         NZiIP4Kr5AALj7YeSMpE4+ejR+k6dIH0lCKSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=tvnccCJhrXt9mZXOfUNTN06OqrEXpf71EsGdfvdHGBtbTynOLAr8g/IpGYYhc0zBXH
         xv+jR7U/gUbefsKdD1WEBlj5StBKyDORpPz3WcuAb9N3jwtZ8j2I+lLLUHG66ZFb4y9z
         642bn3mW4KmrnEJwP02e1oLvTfIbgMRtxP0Z8=
Received: by 10.150.52.11 with SMTP id z11mr5768323ybz.117.1279897497573; Fri, 
	23 Jul 2010 08:04:57 -0700 (PDT)
Received: by 10.231.178.36 with HTTP; Fri, 23 Jul 2010 08:04:37 -0700 (PDT)
In-Reply-To: <7vsk3bey1e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151537>

2010/7/22 Junio C Hamano <gitster@pobox.com>:
> Erick Mattos <erick.mattos@gmail.com> writes:
>
>> To make the new orphan branch ready to have a reflog on that config
>> was as simple as creating a "touch file" for reflog. =C2=A0This is t=
he goal
>> achieved by code.
>
> I have to say that you are somewhat confused about the _goal_ then. =C2=
=A0touch
> is not a goal, it is means to a goal.

I believe you have understood the whole idea of my previous email even
though _words_ means a lot to you.  :-1

I meant that that was the code goal.  It was the implementation
objective which by itself was the solution chosen for the real
problem.

> It does not matter how you implement the user visible effect, be it a
> creation of an empty file, or some other means [*1*]. =C2=A0What matt=
ers is
> that the user won't get a reflog for a branch that really didn't get
> created and must-fail "rev-parse --verify" test checks that.
>
> Another thing that could matter would be that future actions that wan=
t to
> create a reflog for the same branch (perhaps after the user switches =
to
> 'master', another attempt is made to create eta with "checkout -b eta=
") or
> another branch with a similar or related name (say "eta/real") are no=
t get
> broken by whatever you do to implement the "we want to create a reflo=
g
> when a ref is actually made but not right now" feature. =C2=A0Perhaps=
 the right
> way to test that would be to actually try to run such operations and =
make
> sure they do not fail.

You were cutting off redundancy checks, weren't you?  If there is no
reflog file (tested by "test -f"), consequently no reflog (tested by
"rev-parse --verify") and no branch with the chosen name, certainly
someone can create one the "almost used" name, once there is no any
difference from a normal situation.

> [Footnote]
>
> *1* For example, you could have implemented the feature by adding a c=
onfig
> item in ".git/config: [branch "eta"] need-to-create-reflog", and taug=
ht
> refs.c::update_ref() to pay attention to it (I am not saying that it =
would
> be a better implementation).

About the late parenthesis: thank God! ;-)

I don't see a need for so much reluctance: "test -f" is not a taboo
inside a script in t folder and the added tests don't change anything
about the design and implementation which IMHO is well fit.

With those two patch lines of mine "--orphan with -l and
core.logAllRefUpdates=3Dfalse" testing script is finished.

=46inally: you are the man in charge so I would really like to enforce
that if you need me to do anything more I will be _really_ glad to
help.  I love git and everything good done to it it is done to me too
as one of its daily user.

Best regards
