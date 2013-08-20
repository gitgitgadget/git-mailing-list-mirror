From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: CPPCheck found 24 high risk bugs in Git v.1.8.3.4
Date: Wed, 21 Aug 2013 00:28:33 +0200
Message-ID: <CABPQNSbj4UkjN-MptGZ-NRSd_JzazPwcdVjWM-bpMfFuUM1XMQ@mail.gmail.com>
References: <85C8141E5DAD94428A121F706995A31F010F116FDAD3@MX1.net.tbe.com>
 <33FCCE7A2CD5494B88F3C5CDBC341DFD@PhilipOakley> <166132E40AA54EE387BA9B4558823C55@PhilipOakley>
 <CABPQNSZidMv4MEW+SqVm94pX4szw9QW8LFWsvBTOXYH7ezzycw@mail.gmail.com>
 <87eh9op5gq.fsf@igel.home> <5213D2C2.6090006@web.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Philip Oakley <philipoakley@iee.org>,
	"Koch, Rick (Subcontractor)" <Rick.Koch@tbe.com>,
	Git List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Aug 21 00:29:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBuQR-0003wi-3o
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 00:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404Ab3HTW3P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Aug 2013 18:29:15 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:45511 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab3HTW3O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Aug 2013 18:29:14 -0400
Received: by mail-oa0-f45.google.com with SMTP id m1so2073612oag.18
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 15:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=MTS3JhFt/ZsSd/NhCW8oHI8HQ0tFB+9pJf6mWt8sEBc=;
        b=PFPxt0m/L3TUdj2iy961YGGa0ua3WW77ExXoAfTj1zORiLnCuDnXyWO1rKSi5oOXWB
         KZsSFTpWj+9Bg0b5FSPG971ffqIsq4Jvv4CH/VWnSM9mJjiL/9HSzyAD1e9v5foOCdOi
         Xixlm/igM/DfBuRU/Rpz6d7DDSvYkcCWiRMFwltxHizKmvR9DvU+n/sEfbxeRJlYJPIX
         nlGdgD+ww6K7fMDMv5qXjH9yigSTEEJz5DNCvPCThGm4d5fnNrDh3CnNNlHAvX5aV4GW
         ZwbQ29w/62jePmvs7CIyagIqLjVZ4wgcqfiv+qf2FnT906CpsabrYsP2YfXd6XsiWbEj
         5qpg==
X-Received: by 10.182.143.5 with SMTP id sa5mr4329107obb.80.1377037754215;
 Tue, 20 Aug 2013 15:29:14 -0700 (PDT)
Received: by 10.76.162.68 with HTTP; Tue, 20 Aug 2013 15:28:33 -0700 (PDT)
In-Reply-To: <5213D2C2.6090006@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232655>

On Tue, Aug 20, 2013 at 10:34 PM, Ren=E9 Scharfe <l.s.r@web.de> wrote:
> Am 20.08.2013 20:44, schrieb Andreas Schwab:
>
>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>
>>> diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
>>> index d015e43..0641f4e 100644
>>> --- a/compat/win32/syslog.c
>>> +++ b/compat/win32/syslog.c
>>> @@ -43,11 +43,14 @@ void syslog(int priority, const char *fmt, ...)
>>>    va_end(ap);
>>>
>>>    while ((pos =3D strstr(str, "%1")) !=3D NULL) {
>>> - str =3D realloc(str, ++str_len + 1);
>>> - if (!str) {
>>> + char *tmp =3D realloc(str, ++str_len + 1);
>>> + if (!tmp) {
>>>    warning("realloc failed: '%s'", strerror(errno));
>>> + free(str);
>>>    return;
>>>    }
>>> + pos =3D tmp + (pos - str);
>>
>>
>> Pedantically, this is undefined (uses of both pos and str may trap a=
fter
>> realloc has freed the original pointer), it is better to calculate t=
he
>> difference before calling realloc.
>
>
> And while at it, perhaps it's better to follow the suggestion in
> http://msdn.microsoft.com/en-us/library/aa363679.aspx under Remarks a=
nd
> replace "%1" with "%1!S!" instead of "% 1".
>

If my memory serves me correct, we considered this, but found that
it wasn't implemented until Vista. I could be mis-remembering, though.
