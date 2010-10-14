From: Alexander Gladysh <agladysh@gmail.com>
Subject: Re: false positives from git diff-index when used with --git-dir
Date: Thu, 14 Oct 2010 21:20:23 +0400
Message-ID: <AANLkTimqvmecpt_j=HqHF1tircO5bPJHtRW-ePQ-wE+T@mail.gmail.com>
References: <AANLkTimyeE=OLdC0Zzdnidr_dssFfkMzS+r_39dYUVxz@mail.gmail.com> <20101014170227.GA14429@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 14 19:20:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6RU1-0004Ov-ML
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 19:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755606Ab0JNRUo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 13:20:44 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53601 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162Ab0JNRUo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Oct 2010 13:20:44 -0400
Received: by qwa26 with SMTP id 26so1737788qwa.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 10:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=pSjUpF8ndxJUV+wNtcZaETUTFA53SqxXpSQ4ko3xBRM=;
        b=xRN4R9GRu9S2/WqgdlZKZqIDNo+i5W8M/0wL0Kk4mTOaaXpEozBScpu1rwkhBCJHml
         5hfpx8lTs9JdjBkBi40gS5HnJ5IzY0iIiJGSjt5jn/wV+qWkIIfWa/Wgwt2o9zPun351
         aCXEJJkHGlRGaaD4Voa6xbdq9WDEHPoPVAvpk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NXD8Tl8lwg1Ej/ivXrAHTQp5aR8LK+kUR7i1DvsQ9qBps4fib69lGn/VI4oLsxMBAR
         v+xpe9eQlbfopxtf/eQ3xzBZ9RiQ1LM2y3m3Dnb19E56JRzS0FUv+dC2INDneloCQGyP
         jUvs9+lY4rdEpYCBRQeLXMQ2EcTwh58AO5W/o=
Received: by 10.229.219.70 with SMTP id ht6mr9105712qcb.105.1287076843192;
 Thu, 14 Oct 2010 10:20:43 -0700 (PDT)
Received: by 10.229.51.138 with HTTP; Thu, 14 Oct 2010 10:20:23 -0700 (PDT)
In-Reply-To: <20101014170227.GA14429@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159059>

On Thu, Oct 14, 2010 at 21:02, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 14, 2010 at 06:40:51PM +0400, Alexander Gladysh wrote:

>> I'm *sometimes* (once in about ten times I use it -- repository
>> changes between invocations of course) getting false positives from
>> git diff-index when I invoke git from another directory:

>> git --git-dir=3Dpath/to/.git --work-tree=3Dpath/to update-index -q -=
-refresh
>> git --git-dir=3Dpath/to/.git --work-tree=3Dpath/to diff-index --exit=
-code
>> --quiet HEAD

>> This is *really* annoying and really kills the benifits from my
>> workflow automation scripts.

>> Unfortunately I can't find a reproducible use case for this bug.

>> Is there anything I can do to help catch it?

> Can it reproduce over a large number of trials? I.e., something like:

> =C2=A0while true; do
> =C2=A0 =C2=A0git ... update-index ...
> =C2=A0 =C2=A0git ... diff-index ... || echo failed
> =C2=A0done

> If so, try adding a "sleep 1" between the two commands. If that fixes
> it, it implies a race condition in git.

No, I'm not able to reproduce it this way. (Perhaps some more complex
operations on git tree are required -- looks like it happens only if
tree was changed.)

> You could also try running under valgrind to see if there are any bad
> memory accesses, which could also produce intermittent buggy behavior=
=2E

Thanks, I'll try it.

It feels like a race condition somewhere. (Quite possibly even in my
automation tool -- since I'm not able to reproduce bug outside of it
-- if so, sorry for the noise.)

I'll try some more debugging and will get back to you if I will have
any new information.

Thank you,
Alexander.
