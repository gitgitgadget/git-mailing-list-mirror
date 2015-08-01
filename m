From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC/PATCH 07/11] branch: move 'current' check down to the
 presentation layer
Date: Sat, 1 Aug 2015 00:06:56 -0700
Message-ID: <CA+P7+xqYi9ERzNF1XWMK30_Sbf7y5wnhjWzZGae6wxkTZHDOUQ@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-7-git-send-email-Karthik.188@gmail.com>
 <vpqbnewxwcx.fsf@anie.imag.fr> <CAOLa=ZTy+KX4K_inpDoMy+thzFdF2RF93yMEHJUExzT4OvjPww@mail.gmail.com>
 <vpqk2tjmgeg.fsf@anie.imag.fr> <CAOLa=ZRUnF12gO=AKg3E373XETqoykqOXSkPvr7DHCVrOeggAA@mail.gmail.com>
 <vpq4mkmejsh.fsf@anie.imag.fr> <CAOLa=ZRq7zowwse7OGeU_AwJe_Z0WDn1qoYaH_A6AD5g92e_GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 09:07:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLQtM-0007xa-Lx
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 09:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbbHAHHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2015 03:07:19 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:35725 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbbHAHHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2015 03:07:16 -0400
Received: by iodd187 with SMTP id d187so104788934iod.2
        for <git@vger.kernel.org>; Sat, 01 Aug 2015 00:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=F4NbQgojFR2HwWEK1mkJGaa9SDAK36UfdhOaJvie/JI=;
        b=YG+0kRcQsF2iw0o5fpxKEEW5ibDVm9GLQP/fG1HX1rjwp9zDr62qnbXeviwIYJ7Vy0
         7CyTml38U3hTbi3yz0e51NcKKt0M99c+U2NManUXg5eJg/5TlKbnZIhkl1ieo0KrpkU6
         txFieF7VHDHvP/qDBOCXO7or2estRoW/sbUTEJYQEldrD+06hKni41TdcsLgnynpUzV+
         hXLRuXahYDOJRj5RMRx/KkQCr5w/N520U0UBmznEWhtaUrArWeyap8IRfgPABHJ8eH9k
         Dyv3QgXYwNJY5E4lq2SR3wEPw2vu1l+62q6lc/Jb4HdZmNcejuG+9MDnc8NZnHSdNLW0
         yklw==
X-Received: by 10.107.133.214 with SMTP id p83mr10840289ioi.146.1438412835491;
 Sat, 01 Aug 2015 00:07:15 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Sat, 1 Aug 2015 00:06:56 -0700 (PDT)
In-Reply-To: <CAOLa=ZRq7zowwse7OGeU_AwJe_Z0WDn1qoYaH_A6AD5g92e_GQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275114>

On Fri, Jul 31, 2015 at 11:48 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Thu, Jul 30, 2015 at 2:57 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> What I was thinking of was something like this :
>>>
>>> struct strbuf format = STRBUF_INIT;
>>> char c = ' ';
>>> if (current)
>>>     c = '*';
>>> strbuf_addf(&format, "%c....", c, other format options...);
>>> show_ref_array_item(item, format.buf, quote_style, 0);
>>> strbuf_release(&format);
>>
>> I think that would interact badly with verify_ref_format(). Usually, you
>> have just one format string and call verify_ref_format() on it, not a
>> different format string for each ref_array_item. That would probably be
>> solvable.
>>
>
> Good point! I just was wondering if we need another atom just to print a star.
> But your points certainly are valid. I'll implement this. Thanks :)
>
>>> This would remove the need of making the printing of the "*" to be
>>> needed by ref-filter. As this is only needed in branch.c
>>>
>>> If going on what you're saying we could have a "%(starifcurrent)" atom or
>>> something, but I don't see a general use for this.
>>
>> To have a really customizeable format, you would want to allow e.g.
>>
>>   git branch --format '%(starifcurrent) %(objectname) %(refname)'
>>
>> if the user wants to get the sha1 before the refname, and still have the
>> star in front. It's a bit frustrating to have a hardcoded format that
>> the user can't reproduce with the --format option, since it means you
>> can't easily make a small variation on it.
>>
>
> Agreed. will have a "starifcurrent" atom :)
>
> --

Wonder if there is some sort of more "generic" atom that would work? I
can't think of anything obvious at all though... it may be worth
having this even though it definitely seems less useful generically,
as the reason above where --format should be at least as expressive as
the builtin formatting.

Regards,
Jake
