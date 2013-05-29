From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/5] test: improve rebase -q test
Date: Wed, 29 May 2013 12:11:25 -0500
Message-ID: <CAMP44s2S7_D+MavyqpQJWBQwBKS=QnFT+KUGHCPxN96jg+zMNw@mail.gmail.com>
References: <1369745671-22418-1-git-send-email-felipe.contreras@gmail.com>
	<1369745671-22418-5-git-send-email-felipe.contreras@gmail.com>
	<7vvc6311dr.fsf@alter.siamese.dyndns.org>
	<51a56a31947d6_807b33e1899765@nysa.mail>
	<7vr4gpvic7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 29 19:12:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhjun-0002ce-CN
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 19:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933802Ab3E2RLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 13:11:31 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:47412 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932829Ab3E2RL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 13:11:26 -0400
Received: by mail-wi0-f180.google.com with SMTP id hn14so3728202wib.1
        for <git@vger.kernel.org>; Wed, 29 May 2013 10:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=inINKspyU0gxXRFIxT7lWosIZ0Kg0GWZO7hFOdGCjl4=;
        b=QS3L6AAzPfY/tdGtqMKysuJ+0Gsy7iZWAYD79lV+ImJ1XjnEicP4m584umneWMMqEi
         9JJHid6saIzdW8afPB75gRbvmpD/52CSivl+eIdeaacKtkHu4iX9CRJD4GmRtbMZvgYB
         y0S3R4dgzqIG8MlY1qFfD1XPtW41O+UyF3exM7x2/N2Gv0B8E1CLv6hz+BloYZ+Jvzcb
         T09+Oi9ZUBNNxgDX9+CWMloe9pWoTu5ALBFWlh6HgbXHchubgVBBuNEXdziYcqiKaHfB
         hV44Ux5EXLi72nr0C2+zLXUTVW4g4Bqp0tMVPc0u6BOGP9MR8+4XxdPu5ykFrDN42mtv
         JNsA==
X-Received: by 10.180.189.136 with SMTP id gi8mr16164086wic.11.1369847485367;
 Wed, 29 May 2013 10:11:25 -0700 (PDT)
Received: by 10.194.47.4 with HTTP; Wed, 29 May 2013 10:11:25 -0700 (PDT)
In-Reply-To: <7vr4gpvic7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225845>

On Wed, May 29, 2013 at 11:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Junio C Hamano wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>> > Let's show the output so it's clear why it failed.
>>> >
>>> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>> > ---
>>> >  t/t3400-rebase.sh | 1 +
>>> >  1 file changed, 1 insertion(+)
>>> >
>>> > diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
>>> > index b58fa1a..fb39531 100755
>>> > --- a/t/t3400-rebase.sh
>>> > +++ b/t/t3400-rebase.sh
>>> > @@ -185,6 +185,7 @@ test_expect_success 'default to @{upstream} when upstream arg is missing' '
>>> >  test_expect_success 'rebase -q is quiet' '
>>> >    git checkout -b quiet topic &&
>>> >    git rebase -q master >output.out 2>&1 &&
>>> > +  cat output.out &&
>>> >    test ! -s output.out
>>> >  '
>>>
>>> It is one thing to avoid squelching output that naturally comes out
>>> of command being tested unnecessarily, so that "./txxxx-*.sh -v"
>>> output can be used for debugging.  I however am not sure if adding
>>> "cat" to random places like this is a productive direction for us to
>>> go in.
>>>
>>> A more preferrable alternative may be adding something like this to
>>> test-lib.sh and call it from here and elsewhere (there are about 50
>>> places that do "test ! -s <filename>"), perhaps?
>>>
>>>         test_must_be_an_empty_file () {
>>>                 if test -s "$1"
>>>                 then
>>>                         cat "$1"
>>>                         false
>>>                 fi
>>>         }
>>
>> Perhaps, but I'm not interested. I'm tired of obvious fixes getting rejected
>> for hypothetical "ideal" situations that we'll never reach.
>
> That's too bad.  Addition of "cat" where there does not need one is
> clearly not an obvious fix anyway.

If you are an actual real user of this code; a developer that is
running the test; and the test finally achieves it's designed goal of
detecting a failure, you would be left scratching your head wondering
what's the problem if running './test -v' doesn't show anything, even
after you have added debugging code to narrow down the issue.

I had to add that cat line not once, but more than two times in
different lines of development.

So yeah, a cat is needed, and the fact you don't see that amazes me,
specially after you have reprimanded me for using 'grep -q' instead of
'grep' for this very reason.

-- 
Felipe Contreras
