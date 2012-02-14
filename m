From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/2] test: tests for the "double > from mailmap" bug
Date: Tue, 14 Feb 2012 23:06:37 +0200
Message-ID: <CAMP44s3YRHgMPX2Hzydm_TLB27OABWETjABMcwrHmDk-=pN2hw@mail.gmail.com>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
	<20120214203431.GB13210@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 22:06:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxPaH-0001q5-Mk
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 22:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761009Ab2BNVGj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 16:06:39 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:34095 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757259Ab2BNVGi convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 16:06:38 -0500
Received: by lbom4 with SMTP id m4so165246lbo.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 13:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=+uDmuhylDVsjJfpWfPbH2342Pfd4qmRVantzdUot7z0=;
        b=gpyW+mFG4V20tybdxVQ6pkVVWqBAQookloX/kHYLzu/4+mTNbfB3QhgNmvh52EmJsQ
         JLfmsNiZKCL/Z/zoEsRHk+MOrUbw+w5Q+yuASkL8sOIDO6JLs33e2iqS8TocmlGqjXdd
         MnPWA+Taw6rM35LQPRuHl933iaCguPR7lXDns=
Received: by 10.152.114.169 with SMTP id jh9mr15556130lab.20.1329253597390;
 Tue, 14 Feb 2012 13:06:37 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Tue, 14 Feb 2012 13:06:37 -0800 (PST)
In-Reply-To: <20120214203431.GB13210@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190757>

Hi,


On Tue, Feb 14, 2012 at 10:34 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Felipe Contreras wrote:
>
>> I sent both the fix and the tests. Another fix was applied, but we a=
re still
>> missing the tests.
>>
>> These are good before, and after the fix.
>
> To summarize the previous discussion[1]: some people had comments, an=
d
> you seem to have found value in exactly none of them. =C2=A0OK. =C2=A0=
CC-ing
> Peff, since he at least probably has looked over this code before.

Just because you have comments doesn't mean I *must* address them. We
have a difference of opinion, nothing wrong with that.

> By the way, the address you are using for Marius is out of date.
>
>> Felipe Contreras (2):
>> =C2=A0 t: mailmap: add 'git blame -e' tests
>
> So that people don't destroy this test in later refactorings, I would
> like to collect statements that we want the test to ensure remain
> true.
>
> Apparently the fix in f026358e ("mailmap: always return a plain mail
> address from map_user()", 2012-02-05) was for the case of the name
> changing and email address not changing due to mailmap mapping. =C2=A0=
Most
> callers use a separate buffer for the email address so there is room
> to modify the name in place, but "git blame" keeps angle brackets in
> the same buffer for no obvious reason I can see. =C2=A0(Callers shoul=
d
> be able to add the brackets themselves instead of relying on
> ci.author_mail to contain them, but that's a story for another day.)
>
> Anyway, the existing tests for the returned email missed this since
> it does not affect "git shortlog -e" but only "git blame -e".
> Therefore this patch reuses the test data for shortlog -e and lets us
> use it for blame, too. =C2=A0It is easier to understand after the oth=
er
> patch, IMHO.

This is not related to f026358e. The test added by this patch would
pass before and after f026358e.

This is what I mean by reading too much into the patch. There's
nothing to it; "add 'git blame -e' tests" just adds tests for 'git
blame -e', it doesn't catch any issues related to f026358e; it just
makes sure there are no further regressions with the tests that are
already passing.

Again, some tests for 'git blame -e' > no tests for 'git blame -e'.

> This is _not_ meant as a more general test for the "git blame -e"
> format (which would belong somewhere near t8008) as far as I can tell=
=2E
> It is just checking that mailmap doesn't screw up.

Thus the 't: mailmap: ' prefix.

>> =C2=A0 t: mailmap: add simple name translation test
>
> Before, I thought this might be a straightforward test for the bug
> fixed by f026358e. =C2=A0That didn't justify the patch that touches
> several different test assertions.
>
> In fact it seems to be intended to test the case addressed by f026358=
e
> (name changing, email not) in various mailmap callers: "git shortlog =
-e",
> "git log --pretty", "git blame".

No. As the summary says, it's intended to add a simple name
translation test, which is missing from all the tests that spawn from
the repository generated in 'Shortlog output (complex mapping)' test.
This is the most minimal patch that can be generated if you add a
commit to this repository, and any further tests that are related to
it would look the same.

As Junio pointed out what is missing from the explanation is that this
simple name translation test is targeted toward the 'git blame'
commands, because such translation is not tested for them currently.

Cheers.

--=20
=46elipe Contreras
