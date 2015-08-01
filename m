From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC/PATCH 04/11] ref-filter: add 'ifexists' atom
Date: Sat, 1 Aug 2015 00:05:09 -0700
Message-ID: <CA+P7+xoCoFrgT_vspcSqrAfg6kvCGRR9k_1stpf1YiyQUWJeKg@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-4-git-send-email-Karthik.188@gmail.com>
 <xmqq8ua0f9lk.fsf@gitster.dls.corp.google.com> <CAOLa=ZTUJHnXWJyr0wp0CZgR9S1pBxCEsGRiDPsJdUyzTZaZUw@mail.gmail.com>
 <xmqqy4hy973q.fsf@gitster.dls.corp.google.com> <xmqqtwsm94j1.fsf@gitster.dls.corp.google.com>
 <vpqh9omek39.fsf@anie.imag.fr> <CAOLa=ZTC9xJu9WCnF9VVf9wRLSK4=R3576UJ6CqAC7GEGDbCOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 09:05:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLQrb-0006vh-50
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 09:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbbHAHFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2015 03:05:30 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34935 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbbHAHF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2015 03:05:29 -0400
Received: by iodd187 with SMTP id d187so104767741iod.2
        for <git@vger.kernel.org>; Sat, 01 Aug 2015 00:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0phB9lD66laCTkTLChWRF27TI8LqBMvyqF5bwNvbdws=;
        b=t2f1w9RffbjgAGUC0r5qL5oAjOqoQ/LIEhBFXgXd84UjoZq9dWWWH8WAcByFyDlm5z
         i0PNJ235THSE5cmcDS1EktLynpGbRK49jXGCWTrGX8NfKK2E1MErGc+T1GWKGIBVnlYs
         YVhVSgl9B9Sqx2xxnHMPM1N59pajIE3ODanJeE92HGxn4qOFWX6ky1/hnOj06853qS2A
         t3jIkoBf30m5+O/U9WGrZH9eFsPL8+QRzt3MTj70zDMc/r0wnbj5M85hxztRd2CNL8O0
         DMBIigXqaaLeqAKFDlOTckXgGpbQObTXpgjXxDQ/hJSmA9vuc2tcBAfKfHGy+WSQmJ6/
         0u8w==
X-Received: by 10.107.153.206 with SMTP id b197mr12324435ioe.71.1438412729267;
 Sat, 01 Aug 2015 00:05:29 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Sat, 1 Aug 2015 00:05:09 -0700 (PDT)
In-Reply-To: <CAOLa=ZTC9xJu9WCnF9VVf9wRLSK4=R3576UJ6CqAC7GEGDbCOQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275113>

On Fri, Jul 31, 2015 at 11:46 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Thu, Jul 30, 2015 at 2:51 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>>> Couldn't think of a better replacer, any suggestions would be welcome :)
>>>>
>>>> See below.
>>>> ...
>>>> One way to do all of the above is ...
>>>
>>> Note that is just "one way", not the only or not necessarily the
>>> best.  It certainly is not the easiest, I think.
>>>
>>>     %(if:atom)...%(endif)
>>>
>>> might be easier to implement.
>>
>> And I find it easier to read or write too. Nested parenthesis in a
>> format string make them really tricky. That removes the need for
>> escaping since the content of the if/endif is a format string like the
>> others, it can use the same escaping rules (IIRC, %% to escape a %).
>>
>
> THat's a really good point. Will work on this :)
>
> --
> Regards,
> Karthik Nayak
> --


Not sure how much work it would take to extent other atoms to this
behavior, such as %(padright) and %(align) and such, that way they
could operate on literals and so forth.

Maybe not worth it as part of this GSoC project, as it may be too
complicated, but maybe something to mark as a "TODO" for future or
something?

The only issue being that it might mean we have to keep the old
implementation too for backwards compatibility .. Maybe it's easier to
implement that I think, or maybe it's far more challenging than I
think....

Regards,
Jake
