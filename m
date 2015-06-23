From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv6 1/3] git-rebase -i: add command "drop" to remove a commit
Date: Tue, 23 Jun 2015 15:17:08 -0400
Message-ID: <CAPig+cRbtNV8YfvOQNPD_wEiyEkyDeTtbahYA-Vd9Q+9uv6z9w@mail.gmail.com>
References: <1435009369-11496-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<CAPig+cT+idnGkR0V-UfwbHwvjd_U=zbjHx+so7Jz+4o1XU5eHw@mail.gmail.com>
	<1637608183.731706.1435086079947.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 23 21:17:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7Th4-0007Ve-Vl
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 21:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890AbbFWTRK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jun 2015 15:17:10 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:34228 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298AbbFWTRI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jun 2015 15:17:08 -0400
Received: by ykfy125 with SMTP id y125so11252548ykf.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 12:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=qNjCU7TRONmzpRmY+xeUQcFljEIqc3Wp0/6M6BoQBC0=;
        b=EuCG8tZO8egbO53zdEb4iajH0P6XC8+dXGUX6mard1qKbnKFEkEpqB/zuuiqKMDwd+
         cKO/WA6rOL/keV5X5dtrYPwBvJz0c7/nydcXyc5bw/uzZXzK9WG2ktdYOmcsZJGJe4gC
         ya8QMSunWNkWrXs/1Ksw0wfqnX2rjw6sBcaUymwWxjnAYDkfduKMHrKyUQ5QY48sZ7pd
         jUJlfiVstkWhnWD1mEiONDxIHRS8KIItuqmCSu6n+kqSH/kcjlS5R5+tz/n54/HTJbaK
         FCkK0f5A+9JcjnDTSpbHFWX10d05W6on18KxL01Z2g3U+t6jeBg/4JqhDoBql/hvxUgj
         4/yA==
X-Received: by 10.170.138.134 with SMTP id f128mr44534262ykc.90.1435087028159;
 Tue, 23 Jun 2015 12:17:08 -0700 (PDT)
Received: by 10.37.36.214 with HTTP; Tue, 23 Jun 2015 12:17:08 -0700 (PDT)
In-Reply-To: <1637608183.731706.1435086079947.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Google-Sender-Auth: GLWf7_lm2TMSnMpVUGoUrNNU5g4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272484>

On Tue, Jun 23, 2015 at 3:01 PM, Remi Galan Alfonso
<remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> > +test_rebase_end () {
>> > +       test_when_finished "git checkout master &&
>> > +       git branch -D $1 &&
>> > +       test_might_fail git rebase --abort" &&
>> > +       git checkout -b $1 master
>> > +}
>>
>> The way this is indented makes it difficult to see that lines 2 and =
3
>> are continuations of 1. Perhaps format it like this instead?
>>
>>     test_rebase_end () {
>>         test_when_finished "git checkout master &&
>>             git branch -D $1 &&
>>             test_might_fail git rebase --abort" &&
>>         git checkout -b $1 master
>>     }
>
> I completely agree with you, moreover it was indented like this befor=
e.
> I'll change it in my local version for now.
>
> Ironically, it was modified after the following:
>
> Galan R=C3=A9mi <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>> > > +test_expect_success 'rebase -i respects rebase.missingCommitsCh=
eck=3Dignore' '
>> > > +       test_config rebase.missingCommitsCheck ignore &&
>> > > +       test_when_finished "git checkout master &&
>> > > +               git branch -D tmp2" &&
>> >
>> > Strange indentation.

Clearly, that guy who made the "Strange indentation" review comment
didn't know what he was talking about. ;-)

In that earlier review, I must have missed the fact that the quoted
string spanned multiple lines, and, unfortunately, got too busy with
other things to say "ah, the indentation makes perfect sense" when
your response pointed out its true nature.

Matthieu's suggestion of formatting it like:

    test_when_finished "
        ... &&
        ...
    " &&

should help to avoid such misconceptions.
