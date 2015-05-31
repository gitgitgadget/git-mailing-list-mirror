From: Quentin Neill <quentin.neill@gmail.com>
Subject: Re: [PATCH v2] blame: add blame.showEmail configuration
Date: Sun, 31 May 2015 14:24:07 -0500
Message-ID: <CACfD1vvHMYw6J4Gi8eAND7Sm=aUb23U8Q_MBSzrWek0uuxPwdQ@mail.gmail.com>
References: <xmqq617bcgva.fsf@gitster.dls.corp.google.com>
	<1433021926-17762-1-git-send-email-qneill@quicinc.com>
	<xmqqa8wkaa4c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 21:24:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yz8qF-0001gC-8h
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 21:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758529AbbEaTYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 15:24:09 -0400
Received: from mail-qc0-f175.google.com ([209.85.216.175]:34161 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbbEaTYI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 15:24:08 -0400
Received: by qcbhb1 with SMTP id hb1so41292875qcb.1
        for <git@vger.kernel.org>; Sun, 31 May 2015 12:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cByZ15dAsJ9AmNDOPxqBSM35FlGfaCuuCbH3E2sbBe4=;
        b=YBl8LeECZYjX2pRRE7aDZAkD+q0+PuYoZCxkVNiXavfA4m/1RIczdRwM8OXF8E7xVj
         Kc/RzBZ/lWheewH/ZStYl5DnhfqqYwgKgp2I+SbSOhlXV//Kp774TC8P0HLhsoBNPSMw
         9O2uL6BXkgoWY5md8OTaadH2txj8WB7hV7jYs2m7Wxp6zxqRnkyTJlwu+8FJYe2ZuBY3
         TEX7dnmsy6J6XoYd2OSyuFQJOT+rncIQ6RXoUCLVpTDVUOiWSUBACHcMwNzFPNSs9LxA
         8U6ep2y6raBrCywPCYWLF7oo8+H8tfYey1gSgRcsFcFuyb2AZpaDro+Vh1HE7khRn4hM
         d95w==
X-Received: by 10.55.15.209 with SMTP id 78mr33205842qkp.53.1433100247142;
 Sun, 31 May 2015 12:24:07 -0700 (PDT)
Received: by 10.140.108.130 with HTTP; Sun, 31 May 2015 12:24:07 -0700 (PDT)
In-Reply-To: <xmqqa8wkaa4c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270346>

On Sun, May 31, 2015 at 1:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Quentin Neill <quentin.neill@gmail.com> writes:
>
>> From: Quentin Neill <quentin.neill@gmail.com>
>>
>> Complement existing --show-email option with fallback
>> configuration variable, with tests.
>> ---
>
> The patch itself looks very reasonable.  Thanks for getting back to
> us ;-)
>
> A few minor nits:
>
>     - Your in-body "From:" is redundant and unnecessary, as your
>       e-mail is coming from the same address.

I tried using 'git send-email' directly on the commit, not sure how or
why that occurred.
I will fall back to 'git format-patch' and 'git send-email' as I did
in my first post.

>     - You need "Signed-off-by: Quentin Neill <quentin.neill@gmail.com>"
>       after your log message (separate it with a blank line before
>       the sign-off, and place the sign-off before the three-dash
>       lines).
>
>> diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
>> index 5cdf3f1..faf1660 100755
>> --- a/t/t8002-blame.sh
>> +++ b/t/t8002-blame.sh
>> @@ -19,4 +19,66 @@ test_expect_success 'blame --show-email' '
>>               "<E at test dot git>" 1
>>  '
>>
>> +test_expect_success 'setup showEmail tests' '
>> +     echo "bin: test number 1" >one &&
>> +     git add . &&
>> +     GIT_AUTHOR_NAME=name1 GIT_AUTHOR_EMAIL=email1@test.git git commit -a -m First --date="2010-01-01 01:00:00"
>> +'
>> +
>> +cat >expected_n <<\EOF &&
>> +(name1 2010-01-01 01:00:00 +0000 1) bin: test number 1
>> +EOF
>> +
>> +cat >expected_e <<\EOF &&
>> +(<email1@test.git> 2010-01-01 01:00:00 +0000 1) bin: test number 1
>> +EOF
>
> These two commands outside test_expect_success are part of setup, so
>
>         test_expect_success 'setup showEmail tests' '
>                 echo "bin: test number 1" >one &&
>                 git add one &&
>                 GIT_AUTHOR_NAME=name1 \
>                 GIT_AUTHOR_EMAIL=email1@test.git \
>                 git commit -m First --date="2010-01-01 01:00:00" &&
>                 cat >expected_n <<-\EOF &&
>                 (name1 ...
>                 EOF
>                 cat >expected_e <<-\EOF
>                 (<email1@...
>                 EOF
>         '
>
> Also do not hesitate to break overlong lines with "\".
>
>> +find_blame() {
>
> style: "find_blame () {"
>
> Other than that, the patch looks good.
>
> Thanks.

Thanks for the help, one more version on the way.
