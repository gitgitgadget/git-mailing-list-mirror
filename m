From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] fsck.c:fsck_commit() use starts_with() and skip_prefix()
Date: Wed, 19 Mar 2014 05:33:02 -0400
Message-ID: <CAPig+cQ=3tjC47FgPRFkDW1dgE9p1uKsAiZ6uZoNXR0mBMjuBA@mail.gmail.com>
References: <1395182512-17179-1-git-send-email-darrazo16@gmail.com>
	<CAPig+cRoRzZKjW3cY86iQxz9iZ_TKT-yyu=6Va5aV_DsCAQquA@mail.gmail.com>
	<CAPig+cQko2fdCVmNyTufpGW=RRCxVt5G4xdWC7OrQmC9nXfKzg@mail.gmail.com>
	<CAOfd7q0p5gtaPMuds8LkO8q3FJnAJgb_2-6cKeNiqFqEvP52Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Othman Darraz <darrazo16@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 10:33:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQCsV-0000Uy-FP
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 10:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932816AbaCSJdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 05:33:05 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:45775 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932191AbaCSJdD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 05:33:03 -0400
Received: by mail-yk0-f174.google.com with SMTP id 20so22501139yks.5
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 02:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1iqFA6C4kjLTVb7S1OmMePV7KOMPRrBfLMv03kzrI5M=;
        b=J76LQV+BtuRVCOo622alhCZvTjpC490DGHJ5ggCYYimpjjw/2CRXh883pCHxSze2Z+
         E8TD4/Iam9g9gu/TK3JWBqU1qrV46xmdsoNYZi2u5fT+Wm+Eg3uh8in1XRh0Qvm2CFpF
         MRRiPP+aG3n7V0JY4Wr4sc6zybF0S+D9NxwhNc66oTiRWLGABZygb/NNd2sWqQOVZUNJ
         ZAZxSj2ZkoRTYJoBrohjZ+ZjvgHx1OFZzA+0vpyfbGvcDkNPgT0nrx0u6ckbiH6sIe/1
         yV1CsKyNa+wPkKWoTLpq93/tkf++Ni6vI9t+5ZeYQuIRm61Mll0O5oS263reoxZoINFP
         Zgkw==
X-Received: by 10.236.128.170 with SMTP id f30mr9922851yhi.89.1395221582353;
 Wed, 19 Mar 2014 02:33:02 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Wed, 19 Mar 2014 02:33:02 -0700 (PDT)
In-Reply-To: <CAOfd7q0p5gtaPMuds8LkO8q3FJnAJgb_2-6cKeNiqFqEvP52Ww@mail.gmail.com>
X-Google-Sender-Auth: oclUEt7Dd1CBrq0HTl9TR_sNFgs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244425>

On Wed, Mar 19, 2014 at 5:04 AM, Othman Darraz <darrazo16@gmail.com> wrote:
> 2014-03-19 0:12 GMT+01:00 Eric Sunshine <sunshine@sunshineco.com>:
>> On Tue, Mar 18, 2014 at 7:09 PM, Eric Sunshine <sunshine@sunshineco.com>
>> wrote:
>>
>> >> diff --git a/fsck.c b/fsck.c
>> >> index 64bf279..5eae856 100644
>> >> --- a/fsck.c
>> >> +++ b/fsck.c
>> >> @@ -290,7 +290,7 @@ static int fsck_commit(struct commit *commit,
>> >> fsck_error error_func)
>> >>         int parents = 0;
>> >>         int err;
>> >>
>> >> -       if (memcmp(buffer, "tree ", 5))
>> >> +       if (starts_with(buffer, "tree "))
>> >>                 return error_func(&commit->object, FSCK_ERROR, "invalid
>> >> format - expected 'tree' line");
>> >>         if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
>> >
>> > One of the reasons for using starts_with() rather than memcmp() is
>> > that it allows you to eliminate magic numbers, such as 5. However, if
>> > you look closely at this code fragment, you will see that the magic
>> > number is still present in the expression 'buffer+5'. starts_with(),
>> > might be a better fit.
>>
>> Of course, I meant "skip_prefix() might be a better fit".
>
> Thank you for your review and feedbacks.
>  Actually I made a mistake because I misunderstood how to run the tests, I
> was using the wrong Makefile.

For quick initial testing, you can just run the single test script.
For instance:

    (cd t && ./t1450-fsck.sh)

Once you have that running correctly, then run the entire test suite
to ensure that your changes didn't break anything else.

> Secondly I think , as well, that skip_prefix()
> is a better fit. Nevertheless, as the variable buffer change in this
> function, using skip_prefix() implies the use of cast.

Yes, the variable named 'buffer' changes, but does the content of the
memory referenced by 'buffer' ever change? If not, then 'buffer' could
be made 'const', thus eliminating the need for the cast. (Note that
changing it to 'const' might involve a bit of extra work, but the
question is still pertinent.)

> I will make the
> changes right now.
>
> Thank you for your time.
>
> Othman DARRAZ
