From: Gabor Bernat <bernat@primeranks.net>
Subject: Re: [PATCH] filter-branch: add passed/remaining seconds on progress
Date: Sun, 6 Sep 2015 11:49:38 +0200
Message-ID: <CANy2qHfHmydkn6BtoDFy0bOfrvRe03L+EO+ofjD5D3wDLdjW=A@mail.gmail.com>
References: <1441379798-15453-1-git-send-email-bernat@primeranks.net>
 <xmqqk2s6f2zj.fsf@gitster.mtv.corp.google.com> <CAPig+cRh-7BDOoumLxyh6_tNspL3ANq_wCE5f_VoQt6UwUFckQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mikael Magnusson <mikachu@gmail.com>, cbailey32@bloomberg.net,
	Lee.Carver@servicenow.com, Michael Witten <mfwitten@gmail.com>,
	Gabor Bernat <gabor.bernat@gravityrd.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 11:50:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYWaW-0006lv-MU
	for gcvg-git-2@plane.gmane.org; Sun, 06 Sep 2015 11:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbbIFJuA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Sep 2015 05:50:00 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33457 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbbIFJt6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Sep 2015 05:49:58 -0400
Received: by wiclk2 with SMTP id lk2so60247749wic.0
        for <git@vger.kernel.org>; Sun, 06 Sep 2015 02:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=Qe14/6bMj0qI2S7UZUGL86rwldcgekb2iUneEDyBtYA=;
        b=YETv1adCreVGzLUZNakyaBBdyRMgsR1KdgUFyxiszqNUibeYViOyEow61M1dOnjrUU
         aSdZKICMh30NJclYfUVstXCyNmlihmXFVCeS5srfPPtVStDgZ1/zMuhuvdo+MRHWIFQv
         tUByjdsQ6JmTANnDpjWolm9bP1F7DPxjD1K9WDddYa4dUx40/7xm6ZS/1Ccx40DwYI1t
         VT7eCCd1aAfrwXplqINEqezXAG7B+oRmYWFgoIzUDG9WzM0QQhSZQuWxp1IcxsZi70Ic
         CY/jXFOexDqzmECRT/FpAAjqiH0666Cc2cnptN5gzE5JbODQOZ2uGZSQpDtbEuw6UAwk
         W6Ig==
X-Received: by 10.194.246.199 with SMTP id xy7mr17271954wjc.61.1441532997583;
 Sun, 06 Sep 2015 02:49:57 -0700 (PDT)
Received: by 10.194.72.134 with HTTP; Sun, 6 Sep 2015 02:49:38 -0700 (PDT)
In-Reply-To: <CAPig+cRh-7BDOoumLxyh6_tNspL3ANq_wCE5f_VoQt6UwUFckQ@mail.gmail.com>
X-Google-Sender-Auth: nmOJBwvrj4CY4dpE2sRU2EmrbDU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277419>

On Fri, Sep 4, 2015 at 10:15 PM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Fri, Sep 4, 2015 at 2:34 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> G=C3=A1bor Bern=C3=A1t <bernat@primeranks.net> writes:
>>> +echo $(date +%s) | grep -q '^[0-9]+$';  2>/dev/null && show_second=
s=3Dt
>>
>> That is very strange construct.  I think you meant to say something
>> like
>>
>>         if date '+%s' 2>/dev/null | grep -q '^[0-9][0-9]*$'
>>         then
>>                 show_seconds=3Dt
>>         else
>>                 show_seconds=3D
>>         fi
>
> The final format suggested[1] for this test was:
>
>     { echo $(date +%s) | grep -q '^[0-9][0-9]*$'; } 2>/dev/null &&
>         show_eta=3Dt
>
>> A handful of points:
>>
>>  * "echo $(any-command)" is suspect, unless you are trying to let
>>    the shell munge output from any-command, which is not the case.
>
> Primarily my fault. I don't know what I was thinking when suggesting =
that.

Yes, the initial construct was different, willing to make this change.

>
>>  * "grep" without -E (or "egrep") takes BRE, which "+" (one or more)
>>    is not part of.
>
> This seems to have mutated from the suggested form.
>
>>  * That semicolon is a syntax error.  I think whoever suggested you
>>    to use it meant to squelch possible errors from "date" that does
>>    not understand the "%s" format.
>
> This also mutated. The suggested form wanted to suppress errors from
> 'date' if it complained about "%s", and from 'grep'. In retrospect,
> applying it to 'grep' is questionable. I was recalling this warning
> from the Autoconf manual[2]:
>
>     Some of the options required by Posix are not portable in
>     practice. Don't use =E2=80=98grep -q=E2=80=99 to suppress output,=
 because many
>     grep implementations (e.g., Solaris) do not support -q. Don't use
>     =E2=80=98grep -s=E2=80=99 to suppress output either, because Posi=
x says -s does
>     not suppress output, only some error messages; also, the -s
>     option of traditional grep behaved like -q does in most modern
>     implementations. Instead, redirect the standard output and
>     standard error (in case the file doesn't exist) of grep to
>     /dev/null. Check the exit status of grep to determine whether it
>     found a match.
>
> however, Git tests use 'grep -q' heavily, so perhaps we don't worry a=
bout that.

So we should keep it as it is.

>
>>  * I do not think you are clearing show_seconds to empty anywhere,
>>    so an environment variable the user may have when s/he starts
>>    filter-branch will seep through and confuse you.
>
> The empty assignment was implied in my example, but I should have bee=
n
> more explicit and shown a more complete snippet:
>
>     show_eta=3D
>     ...
>     { echo $(date +%s) | grep -q '^[0-9][0-9]*$'; } 2>/dev/null &&
>         show_eta=3Dt
>
> The suggested 'if' form has the attribute of being clearer.

My bad, sorry for that. Will amend.

>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/276531/fo=
cus=3D276837
> [2]: https://www.gnu.org/software/autoconf/manual/autoconf.html#grep

Any other pain points, or this construction will satisfy everybody?
