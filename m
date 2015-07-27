From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 03/11] ref-filter: add option to pad atoms to the right
Date: Tue, 28 Jul 2015 00:12:24 +0530
Message-ID: <CAOLa=ZRVMnqxb-E29f_53igzJDTWNU0yjVACSq1CK8TCbaM-9w@mail.gmail.com>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
 <1437982035-6658-1-git-send-email-Karthik.188@gmail.com> <1437982035-6658-3-git-send-email-Karthik.188@gmail.com>
 <vpq3809aho9.fsf@anie.imag.fr> <xmqqr3ntioyh.fsf@gitster.dls.corp.google.com> <vpqk2tl4mvx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 27 20:43:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJnMe-0004R5-1p
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 20:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221AbbG0Smy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 14:42:54 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:33685 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199AbbG0Smy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 14:42:54 -0400
Received: by obdeg2 with SMTP id eg2so66506938obd.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 11:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=V/DkYOWRXybQhk9bHpHlKPG5tvtW5iXBAvHxo6XBH8M=;
        b=O8qDb6hPIdZSo9YPMQptkpUiwoXzkFKYotDDWg7kT5qq1yF9CnpQwePkcyCIex9dvs
         Cc52zMHCSJJyaEbNYZ92b17JhsEjhNXMxsM2VmstZ6AkcRNN2JHFYmira9md1JEeIwTr
         mwGaRqg4g+/SOD7F2ozGqwfL0Cq9yLtAWDLmPViZjw8l3vCWUDv9jJ7sRV8ATYNF1e9u
         Mmr9I9NeX0rXORxn5QULE4IvrVal9YQ6s30/LdfrA87N/vshZSV06cgKIp8BKN1ZbtaA
         +1vz0lJ0GjGpjM9rF//V9TvdZWLH2FS06DrXyEAc+tgvPV0HoaWpRpLVDTzRwZz4zPRp
         vRKg==
X-Received: by 10.60.41.138 with SMTP id f10mr29077100oel.84.1438022573583;
 Mon, 27 Jul 2015 11:42:53 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 27 Jul 2015 11:42:24 -0700 (PDT)
In-Reply-To: <vpqk2tl4mvx.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274695>

On Mon, Jul 27, 2015 at 9:24 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>> See my remark on previous patch: this test is not sufficient. You do
>>> not only need to check that %(padright) is taken into account, but you
>>> also need to check that it is taken into account for the right atom and
>>> only this one. I'd suggest
>>>
>>> --format '%(refname)%(padright:25)|%(refname)|%(refname)|'
>>>
>>> Only the middle column should be padded.
>>
>> This actually raises an interesting point.  It is equally valid to
>> view that format string as requesting to pad the first "|" with 24
>> spaces; in other words, %(padright:N) would apply to the next span,
>> be it a literal string up to the next %(atom), or the %(atom) that
>> comes immediately after it.
>
> For an arbitrary %(modifier), I'd agree, but in the particular case of
> %(padright), I think it only makes sense if applied to something of
> variable length
>

I agree with Matthieu here, Other than atom values, any user defined string
would be of known size, hence padding for such things would make no sense.

>> The thing is, the above _might_ be an OK way to ask the middle
>> refname to be padded, but I somehow find it very unnatural and
>> unintuitive to expect that this:
>>
>>       --format '%(padright:25)A Very Long Irrelevancy%(refname)'
>
> Yes, but on the other hand we already have:
>
>   git log --format='%<|(50)A very long irrevlevancy|%an|'
>
> that pads/truncate %an. So, consistancy would dictate that Karthik's
> version is the right one.

Sorry but I didn't understand what you're trying to say here, Matthieu.

>
>> My preference between the three is "%(padright:4)", etc. to apply to
>> the "next span", but I can live with "it is an error to pad-right
>> a far-away %(atom)".
>
> I think there are valid argument for the 3 versions. I'm fine with any
> of them, as long as there's a test that shows which one is picked.
>

Makes sense, thanks both of you :)

-- 
Regards,
Karthik Nayak
