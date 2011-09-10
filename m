From: Haitao Li <lihaitao@gmail.com>
Subject: Re: [PATCH v3] date.c: Support iso8601 timezone formats
Date: Sat, 10 Sep 2011 16:06:50 +0800
Message-ID: <CABk5KLgyk_MRd6DLkdaK2s_5pxLQNipKmLJtCjNO2TaLLEr6UA@mail.gmail.com>
References: <1315320996-1997-1-git-send-email-lihaitao@gmail.com>
 <1315563033-9476-1-git-send-email-lihaitao@gmail.com> <7vhb4lvflb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 10 10:07:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2IbO-0001m0-1z
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 10:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755667Ab1IJIHP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Sep 2011 04:07:15 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:40804 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754890Ab1IJIHL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Sep 2011 04:07:11 -0400
Received: by vxi9 with SMTP id 9so1676731vxi.19
        for <git@vger.kernel.org>; Sat, 10 Sep 2011 01:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=BrKevJPPAR/jw2hQZe8L6RPvBXmUQVkKY25E5TRjKz8=;
        b=Ku5o+CRs4jzQYj5nLuQzNtCz6pJvFHvoN0r5nubKR4/CrDYNq2k6Ig3ROZgzFrkGho
         LgJt4l7CHJJagzyRkQ7olej7jcBfOsHGdTChmQR0g85TbnAFHSE1p6gT+DwSU8mQo2n8
         3mrTUSJJ6l8kqkQwKsXjA+GFn3ulBXAUAMBqQ=
Received: by 10.52.178.164 with SMTP id cz4mr388426vdc.467.1315642030132; Sat,
 10 Sep 2011 01:07:10 -0700 (PDT)
Received: by 10.52.159.129 with HTTP; Sat, 10 Sep 2011 01:06:50 -0700 (PDT)
In-Reply-To: <7vhb4lvflb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181149>

On Sat, Sep 10, 2011 at 12:35 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Haitao Li <lihaitao@gmail.com> writes:
>
>> Timezone designators including additional separator (`:`) are ignore=
d.
>> Actually zone designators in below formats are all valid according t=
o
>> ISO8601:2004, section 4.3.2:
>> =C2=A0 =C2=A0 [+-]hh, [+-]hhmm, [+-]hh:mm
>
> Thanks for a re-roll.
>
>> This patch teaches git recognizing zone designators with hours and
>> minutes separated by colon, or minutes are empty.
>
> The last sentence above makes it sound as if you are accepting
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"2011-09-17 12:34:56 +09:"
>
> but I suspect that is not what you intend to allow. =C2=A0Perhaps "we=
 allowed
> hh and hhmm and this teaches Git to recognize hh:mm format as well"?
>
Yes, this is a better one. Sorry for my English, and thanks for the sug=
gestion.

>> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
>> index f87abb5..5235b7a 100755
>> --- a/t/t0006-date.sh
>> +++ b/t/t0006-date.sh
>> @@ -40,6 +40,11 @@ check_parse 2008-02 bad
>> =C2=A0check_parse 2008-02-14 bad
>> =C2=A0check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
>> =C2=A0check_parse '2008-02-14 20:30:45 -0500' '2008-02-14 20:30:45 -=
0500'
>> +check_parse '2008-02-14 20:30:45 -0015' '2008-02-14 20:30:45 -0015'
>> +check_parse '2008-02-14 20:30:45 -5' '2008-02-14 20:30:45 -0500'
>> +check_parse '2008-02-14 20:30:45 -05' '2008-02-14 20:30:45 -0500'
>> +check_parse '2008-02-14 20:30:45 -:30' '2008-02-14 20:30:45 +0000'
>> +check_parse '2008-02-14 20:30:45 -05:00' '2008-02-14 20:30:45 -0500=
'
>> =C2=A0check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 -0500' =
EST5
>
> The above are from Peff, no? =C2=A0We should credit him for tests in =
the
> proposed log message.

Yes, we should credit Peff. Sorry for not knowing log message is used f=
or this.

>
> Because the three formats 8601 specifies are "hh", "hhmm", or "hh:mm"
> after +/-, among the above new tests, it appears to me that zone
> designators "-5" and "-:30" should yield "bad", instead of being acce=
pted.

Yes, the spec clearly states 2 digits are mandatory. "-5" should be
regarded as invalid here.

The above test *ignores* ":30" by setting offset to "+0000", this is
to conform to how it works previously, less than 3 digits in offset
are ignored. I agree it's better to *reject* them instead.

> The same for "+09:" I mentioned above, which is not in the new test.
>
Will add.

Thanks again for the suggestions!
