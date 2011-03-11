From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] find_unique_abbrev(): honor caller-supplied "len" better
Date: Thu, 10 Mar 2011 16:40:25 -0800
Message-ID: <7vzkp21ocm.fsf@alter.siamese.dyndns.org>
References: <E1PBKT9-0004Uk-Sm@tytso-glaptop> <20101028075631.GA7690@elte.hu>
 <AANLkTi=8SbOZizWpxLg=Bgp7atdgr8MsR6tnRDYr1+eW@mail.gmail.com>
 <20101028163854.GA15450@elte.hu>
 <AANLkTin62vAwJxcsrFk6Yn7Q6tzr-D=EmKKwPazuAJ11@mail.gmail.com>
 <7veiba9ev2.fsf@alter.siamese.dyndns.org>
 <7vhbba38mm.fsf_-_@alter.siamese.dyndns.org>
 <AANLkTimH9=OWD4+dPsdYaL2VPdDkTsUG_N3GBf168XqD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Namhyung Kim <namhyung@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 11 01:40:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxqPP-0006An-Ql
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 01:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754943Ab1CKAkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 19:40:40 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33178 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754941Ab1CKAkg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 19:40:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 049DC3D3A;
	Thu, 10 Mar 2011 19:42:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R5Or+NShc4jXCnxEtuCEmi4RXI0=; b=x3fbzL
	S3PAYjHq6G37ZFwwP96DgQrA1hs67y0B0SM7SDzb9jxF1xCETiBKD9nB8y0lritr
	+lp3TYXOLJqZuAzgidv/qjjQRkxwDWu/YezY/lUySNzi6TfyXM2l460hYr/4C83R
	GElo+2oq51hIw+7e4eRXH9Al59jvwOoA1jn8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aQ++401BPSt7wT241bhfxSZy8fe0o78K
	THvsIToraP3mjCzLT8BZkz+GgeAMWUZ1/WZ0Wi5Q7YpKbAKATCtZxhSD+ohMi1Zv
	LTsacK9xEepx7SSaAcQAdgVwfja/uj6nw52dWom/AYKNQsGd0QfyVAdzjxDx0tQi
	g1N2oWhAeWI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AEBA93D39;
	Thu, 10 Mar 2011 19:42:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 707CC3D38; Thu, 10 Mar 2011
 19:41:56 -0500 (EST)
In-Reply-To: <AANLkTimH9=OWD4+dPsdYaL2VPdDkTsUG_N3GBf168XqD@mail.gmail.com>
 (Linus Torvalds's message of "Thu, 10 Mar 2011 15:07:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 60602F92-4B78-11E0-8DE6-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168871>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> When you pass in 6 as a len, and that isn't sufficient, it expands it
> to (say) 10. And then you pass in 7 as a length, and now it's
> sufficient, so it keeps it at 7.

Hmph, that is not the way I wanted to do things.  If len is 6 and the
result needs to be 10 to be sufficient, it should still yield 10 if the
len you give is 7 (or 8 or 9 or 10).  Of course it would be stupid if you
don't do it that way.

I thought the code should work that way already (unless of course there is
an implementation bug).

How many characters do we need to name master uniquely today?

    $ ./git -c core.abbrevguard=0 rev-parse --short=1 master
    83c3c

Ok, so there are more than one object with 83c3 and 83c3c is the absolute
minimum.  We can ask for extra for futureproofing.

    $ ./git -c core.abbrevguard=3 rev-parse --short=1 master
    83c3c622

And we get three extra and the result is 8 characters long.  What if we
give len=7 that is still short?

    $ ./git -c core.abbrevguard=3 rev-parse --short=7 master
    83c3c622

Of course we allow the limit 7 to be busted to keep the futureproofing.

    $ ./git -c core.abbrevguard=3 rev-parse --short=8 master
    83c3c622

Obeying 8 doesn't hurt the futureproofing so the output remains the same.
But if you say len=9, you get 9

    $ ./git -c core.abbrevguard=3 rev-parse --short=9 master
    83c3c6222

even though we know 8 is plenty futureproof, but you get 9 because you
asked for 9.

What am I missing to be called "just stupid" and "crazy"?

The earlier code was adding the three extra over what was asked for.  With
guard=3 and len=7, you would have got 10 for this object that only needs 5
as absolute minimum today, and giving 8 would have been enough to stay
unique with room for 3 extra characters to grow.  That is what I was
fixing.

>  (b) You can't change DEFAULT_ABBREV except with the command line option.

I would agree that would need changing, but I think that is more or less
an independent issue.

I thought I took your patch to introduce the configuration when I sent the
abbrevguard as a companion patch, but apparently I didn't.  That would fix
the "grep DEFAULT_ABBREV" issue.
