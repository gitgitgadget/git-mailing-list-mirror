From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v14 07/13] ref-filter: add support for %(contents:lines=X)
Date: Sun, 30 Aug 2015 13:09:23 -0400
Message-ID: <CAPig+cROyc7vxddkfGSsBayT9i=VSacxcEuuNkEFf+oYoUs9kg@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
	<1440857537-13968-8-git-send-email-Karthik.188@gmail.com>
	<CAPig+cQmAkFAjUcJNJNF2gwunX6TKK+oQsd2QnmJwxLT=EEvjQ@mail.gmail.com>
	<CAOLa=ZSgjrg60r6bdWfCHC+J9_q+ZWUHXc7j_9ePkdTBE1+-Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 19:09:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZW66y-0000hH-7f
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 19:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbbH3RJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 13:09:24 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:33218 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497AbbH3RJY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 13:09:24 -0400
Received: by ykdz80 with SMTP id z80so58184193ykd.0
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 10:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=GLBzQAgJ7qyJQZpM4R4rymuYK0fuKlKcoNGmVQqCqYg=;
        b=Zz8I2iYACESNgBcV/n2pmIwd0tPXO1VCwXFonRLzmzWRLM0XlviQEyJVCH9axg7Mco
         NObOYTDPingt9lWOoLEqW2POgEYpoA7d1eff64GCFS89Z9KF3jyUIAAoSoivuflT8upi
         pllz5XGDFOb2qGkPl4ccrfYMDarJbyqrFx+ZWOuJIUoQqaXKrbhCbM0OfHtTa3BD6E30
         lKCKGi5gWxYdyb4CCFvWxIDYsftQHrUYwAEhxJYvtx+ySHgUYMRY59Bw295J3NKEaMNz
         fI4nZChsY+ykzqWmaKK3g55+HWZ040lqvDFz1baaMePAGXytBeL/9hq7P++pA+GahfFH
         MW0w==
X-Received: by 10.170.194.200 with SMTP id l191mr17400869yke.84.1440954563513;
 Sun, 30 Aug 2015 10:09:23 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Sun, 30 Aug 2015 10:09:23 -0700 (PDT)
In-Reply-To: <CAOLa=ZSgjrg60r6bdWfCHC+J9_q+ZWUHXc7j_9ePkdTBE1+-Kg@mail.gmail.com>
X-Google-Sender-Auth: FmkgFctRPKk6SpSsnstQlBLaGas
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276826>

On Sun, Aug 30, 2015 at 1:02 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Sun, Aug 30, 2015 at 1:23 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sat, Aug 29, 2015 at 10:12 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>  struct atom_value {
>>>         const char *s;
>>>         struct align *align;
>>> +       struct contents *contents;
>>
>> Same question as for 'align': Does 'contents' need to be
>> heap-allocated because it must exist beyond the lifetime of
>> 'atom_value'? If not, making it just a plain member of 'atom_value'
>> would simplify memory management (no need to free it).
>
> In this context that makes sense, as the value is only needed for the
> current atom value.
>
>> Also, will 'align' and 'contents' ever be used at the same time? If
>> not, it might make sense to place them in a 'union' (not for the
>> memory saving, but to make it clear to the reader that their use is
>> mutually exclusive).
>
> Not quite sure if it needs to be mutually exclusive (isn't that up to the user?)
> But this can be done, as they're separate atoms and at a time only one of them
> is used.

I meant "mutually exclusive" in the sense of only one or the other of
'align' and 'contents' ever being used within a single 'atom_value'
instance. (I wasn't referring to the user experience.)
