From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] filter-branch: add passed/remaining seconds on progress
Date: Sun, 6 Sep 2015 06:05:53 -0400
Message-ID: <CAPig+cRifOpvz87j9xPP_sUpGtr_oz5SsQ-87ZmEEnQNZ3yXyA@mail.gmail.com>
References: <1441379798-15453-1-git-send-email-bernat@primeranks.net>
	<xmqqk2s6f2zj.fsf@gitster.mtv.corp.google.com>
	<CAPig+cRh-7BDOoumLxyh6_tNspL3ANq_wCE5f_VoQt6UwUFckQ@mail.gmail.com>
	<CANy2qHfHmydkn6BtoDFy0bOfrvRe03L+EO+ofjD5D3wDLdjW=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mikael Magnusson <mikachu@gmail.com>, cbailey32@bloomberg.net,
	Lee.Carver@servicenow.com, Michael Witten <mfwitten@gmail.com>,
	Gabor Bernat <gabor.bernat@gravityrd.com>
To: Gabor Bernat <bernat@primeranks.net>
X-From: git-owner@vger.kernel.org Sun Sep 06 12:06:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYWpn-0005bJ-Py
	for gcvg-git-2@plane.gmane.org; Sun, 06 Sep 2015 12:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbbIFKF4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Sep 2015 06:05:56 -0400
Received: from mail-yk0-f193.google.com ([209.85.160.193]:34822 "EHLO
	mail-yk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbbIFKFy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Sep 2015 06:05:54 -0400
Received: by ykek143 with SMTP id k143so5352497yke.2
        for <git@vger.kernel.org>; Sun, 06 Sep 2015 03:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=fWG7wKkVw7PyJTN/koJMZgwZqBI4csdwDM+AK7UXomQ=;
        b=HdbyIrK2vmxnf0DMNuEMqSa0wo7elQ/RAT+vUtKiMO6ECEfAjQs8hPtWCt/Z+T8I9L
         uzqkkwGXC6GwRpwZY1d9tH/0ZzqT0Knc5386Cs6tfgTfaJO70ece7GMdua3R/44Y6hrr
         9LyOMzmqqhVSLhvxHXAromV1LPA97qGEpEfElxpKEzGDdU8YMYzBAJpVX6OLRHpX4VDC
         GJIBuMdExyvJbB7UJ84IcbocycT2SbQLmEnFpIpu1/0uuCGpGinDjD6fyPUUCSt2oKWr
         QUQdpOE2W40iSA8ITqc9U5Eck8DndRDp3m08/MgSIutccd3cXb3rDHI5hncS6lAt381O
         NmFw==
X-Received: by 10.13.217.5 with SMTP id b5mr4378721ywe.166.1441533953896; Sun,
 06 Sep 2015 03:05:53 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Sun, 6 Sep 2015 03:05:53 -0700 (PDT)
In-Reply-To: <CANy2qHfHmydkn6BtoDFy0bOfrvRe03L+EO+ofjD5D3wDLdjW=A@mail.gmail.com>
X-Google-Sender-Auth: LzcEB7sQA7zhbO-TJ-PkCu7IJfc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277421>

On Sun, Sep 6, 2015 at 5:49 AM, Gabor Bernat <bernat@primeranks.net> wr=
ote:
> On Fri, Sep 4, 2015 at 10:15 PM, Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>> On Fri, Sep 4, 2015 at 2:34 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>> G=C3=A1bor Bern=C3=A1t <bernat@primeranks.net> writes:
>>>> +echo $(date +%s) | grep -q '^[0-9]+$';  2>/dev/null && show_secon=
ds=3Dt
>>>
>>> That is very strange construct.  I think you meant to say something
>>> like
>>>
>>>         if date '+%s' 2>/dev/null | grep -q '^[0-9][0-9]*$'
>>>         then
>>>                 show_seconds=3Dt
>>>         else
>>>                 show_seconds=3D
>>>         fi
>>
>> This also mutated. The suggested form wanted to suppress errors from
>> 'date' if it complained about "%s", and from 'grep'. In retrospect,
>> applying it to 'grep' is questionable. I was recalling this warning
>> from the Autoconf manual[2]:
>>
>>     Some of the options required by Posix are not portable in
>>     practice. Don't use =E2=80=98grep -q=E2=80=99 to suppress output=
, because many
>>     grep implementations (e.g., Solaris) do not support -q. Don't us=
e
>>     =E2=80=98grep -s=E2=80=99 to suppress output either, because Pos=
ix says -s does
>>     not suppress output, only some error messages; also, the -s
>>     option of traditional grep behaved like -q does in most modern
>>     implementations. Instead, redirect the standard output and
>>     standard error (in case the file doesn't exist) of grep to
>>     /dev/null. Check the exit status of grep to determine whether it
>>     found a match.
>>
>> however, Git tests use 'grep -q' heavily, so perhaps we don't worry =
about that.
>
> So we should keep it as it is.

Use of 'grep -q' seems to be fine, however, Junio's comment was about
the errant semicolon, which should not be kept.

>>>  * I do not think you are clearing show_seconds to empty anywhere,
>>>    so an environment variable the user may have when s/he starts
>>>    filter-branch will seep through and confuse you.
>>
>> The empty assignment was implied in my example, but I should have be=
en
>> more explicit and shown a more complete snippet:
>>
>>     show_eta=3D
>>     ...
>>     { echo $(date +%s) | grep -q '^[0-9][0-9]*$'; } 2>/dev/null &&
>>         show_eta=3Dt
>>
>> The suggested 'if' form has the attribute of being clearer.
>
> My bad, sorry for that. Will amend.
>
> Any other pain points, or this construction will satisfy everybody?

Junio's proposed if/then/else construct should be satisfactory.
