From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] transport-helper: report errors properly
Date: Sat, 13 Apr 2013 00:42:29 -0500
Message-ID: <CAMP44s1pZW6OJ2nkegKFQq6=npPSiD4dX_z37t63B9baaFW16w@mail.gmail.com>
References: <20130410211311.GA24277@sigill.intra.peff.net>
	<20130410211552.GA3256@sigill.intra.peff.net>
	<CAMP44s02K5ydKLNi0umMkuAicoVTWyCdVfjs0yssCa2oyFShGQ@mail.gmail.com>
	<7vfvywj4au.fsf@alter.siamese.dyndns.org>
	<CAMP44s2QJJnSRVVJscLsTnXk5zdGbA2utefF5SO7=90+ttENew@mail.gmail.com>
	<7vd2u0hdmj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 13 07:42:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQtES-0001tV-Qu
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 07:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330Ab3DMFmc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Apr 2013 01:42:32 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:52244 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab3DMFmb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Apr 2013 01:42:31 -0400
Received: by mail-la0-f45.google.com with SMTP id gw10so3091406lab.18
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 22:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=quE2lZa83vwomQfIx9/sKNcUCy3jKCtguDPGwp11KRE=;
        b=bo1/tZ1sBTEQMPbl577mv0YtcdKxWX2heKiNFRHqoORjfTnhyb6V2ZuH0wk3V3obIJ
         e4CGf32r4+JjZ1X3FemHbFNB6LPhaG2G37WpP3Z/5XF8nhMiSN4JB1tJWLRwyRKt9SgC
         dAejKdmDc/QQ+5qz8nidiSSx0uyV6KupGFU2k6pCf+S3W1yjj7GT2tUuZyhCSiYcwFRf
         etjsMr6KoKjgCpfaa4SgN+bQNvIfAuSbQIFqFxT6UBwolcJV6CLK78Is/C3MCMXsp19x
         kx+zl3pQhyK6vqBuiwDexEo8Ucy/MHCa98YUZRw/0fQ/VzPfh8t8vy/w98XRkVn4d9i3
         kNLw==
X-Received: by 10.112.139.226 with SMTP id rb2mr6759768lbb.12.1365831749951;
 Fri, 12 Apr 2013 22:42:29 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Fri, 12 Apr 2013 22:42:29 -0700 (PDT)
In-Reply-To: <7vd2u0hdmj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221050>

On Thu, Apr 11, 2013 at 6:05 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> And if you must, you might was well label them with "REMINDER", no,
>> wait, that's what "TODO" comments are for, where people can see them=
,
>> and not *forget* them.
>
> Yeah, good point.

Moreover, I think there's a clear double standard. Consider this commit=
:

commit 99d3206010ba1fcc9311cbe8376c0b5e78f4a136
Author: Antoine Pelisse <apelisse@gmail.com>
Date:   Sat Mar 23 18:23:28 2013 +0100

    combine-diff: coalesce lost lines optimally

    This replaces the greedy implementation to coalesce lost lines by u=
sing
    dynamic programming to find the Longest Common Subsequence.

    The O(n=C2=B2) time complexity is obviously bigger than previous
    implementation but it can produce shorter diff results (and most li=
kely
    easier to read).

    List of lost lines is now doubly-linked because we reverse-read it =
when
    reading the direction matrix.

The commit message is 9 lines, and the diffstat 320 insertions(+), 64
deletions(-). Moreover, there are some important bits of information
on the mailing list that never made it to the commit message:

---
Best-case analysis:
All p parents have the same n lines.
We will find LCS and provide a n lines (the same lines) new list in
O(n=C2=B2), and then run it again in O(n=C2=B2) with the next parent, e=
tc.
It will end-up being O(pn=C2=B2).

Worst-case analysis:
All p parents have no lines in common.
We will find LCS and provide a 2n new list in O(n=C2=B2).
Then we run it again in O(2n x n), and again O(3n x n), etc, until
O(pn x n).
When we sum these all, we end-up with O(p=C2=B2 x n=C2=B2)
---

---
Unfortunately on a commit that would remove A LOT of lines (10000)
from 7 parents, the times goes from 0.01s to 1.5s... I'm pretty sure
that scenario is quite uncommon though.
---

This is not mentioned in the commit message; on which situations this
implementation would be worst and why it's OK either way.

---
As you can see the last test is broken because the solution is not
optimal for more than two parents. It would probably require to extend
the dynamic programming to a k-dimension matrix (for k parents) but the
result would end-up being O(n^k) (when removing n consecutives lines
from p parents). I'm not sure there is any better solution known yet to
the k-LCS problem.
Implementing the dynamic solution with the k-dimension matrix would
probably require to re-hash the strings (I guess it's already done by
xdiff), as the number of string comparisons would increase.
---

The fact that the last test is broken is not mentioned at all.

Now let's compare to the final version of my patch which is 19 lines
40 insertions(+), 1 deletion(-). The ration of commit message lines
vs. code changed lines is 19/41(0.46) whereas Antoine's patch is
3/128(0.02), a difference of over 19 times. Granted, some single-line
changes do require a good chunk of explanation, but this is not one of
them; this single line patch doesn't even change the behavior of the
code, simply changes a silent error exit to a verbose error exit,
that's all. Antoine's patch has a lot more potential to trigger
something unexpected.

And the chances that somebody would have to look at Antoine's patch is
quite high, especially since a failing test-case is introduced. The
chances that anybody would look at mine are very very low.

So either Antoine's commit message was fine, and so was mine, or it
was sorely lacking explanation.

To me, the reality is obvious: my patch didn't require such a big
commit message, the short version was fine, the only reason Jeff King
insisted on a longer version is because the patch came from me.
Antoine's patch might have benefited from a little more explanation,
but not every issue that was discussed in the mailing list was
necessary (in my patch virtually every issue discussed was added to
the commit message).

This is the definition of double standard.

Cheers.

--=20
=46elipe Contreras
