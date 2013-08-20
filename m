From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: CPPCheck found 24 high risk bugs in Git v.1.8.3.4
Date: Tue, 20 Aug 2013 22:34:10 +0200
Message-ID: <5213D2C2.6090006@web.de>
References: <85C8141E5DAD94428A121F706995A31F010F116FDAD3@MX1.net.tbe.com> <33FCCE7A2CD5494B88F3C5CDBC341DFD@PhilipOakley> <166132E40AA54EE387BA9B4558823C55@PhilipOakley> <CABPQNSZidMv4MEW+SqVm94pX4szw9QW8LFWsvBTOXYH7ezzycw@mail.gmail.com> <87eh9op5gq.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Philip Oakley <philipoakley@iee.org>,
	"Koch\, Rick \(Subcontractor\)" <Rick.Koch@tbe.com>,
	Git List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 20 22:34:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBsdE-0003yX-FY
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 22:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422Ab3HTUeU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Aug 2013 16:34:20 -0400
Received: from mout.web.de ([212.227.15.4]:62994 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266Ab3HTUeU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 16:34:20 -0400
Received: from [192.168.2.102] ([79.253.175.147]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0Le4Tw-1VsfZu2BJ6-00pvsR for <git@vger.kernel.org>;
 Tue, 20 Aug 2013 22:34:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <87eh9op5gq.fsf@igel.home>
X-Provags-ID: V03:K0:Pd3XLsNl+3A4urgYQcESqufeS5B/O2RHGbS5AA3GO3J8qwiRydq
 aq+wD81hilE+VId4tfjAjfm9HhJZkoVo8a7NRZjkvnt+6sM1+NMp7fosCNglQ+Avl0yBroo
 m6IkCGttwZLWumyeWt4WgLyQJQ9zkTkd6lbt+MCVkggmYRsQjW7QIPm+MKi5sHZ52LSSjSi
 lLmsCyaQ3IgxJERk6F5tQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232645>

Am 20.08.2013 20:44, schrieb Andreas Schwab:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
>> index d015e43..0641f4e 100644
>> --- a/compat/win32/syslog.c
>> +++ b/compat/win32/syslog.c
>> @@ -43,11 +43,14 @@ void syslog(int priority, const char *fmt, ...)
>>    va_end(ap);
>>
>>    while ((pos =3D strstr(str, "%1")) !=3D NULL) {
>> - str =3D realloc(str, ++str_len + 1);
>> - if (!str) {
>> + char *tmp =3D realloc(str, ++str_len + 1);
>> + if (!tmp) {
>>    warning("realloc failed: '%s'", strerror(errno));
>> + free(str);
>>    return;
>>    }
>> + pos =3D tmp + (pos - str);
>
> Pedantically, this is undefined (uses of both pos and str may trap af=
ter
> realloc has freed the original pointer), it is better to calculate th=
e
> difference before calling realloc.

And while at it, perhaps it's better to follow the suggestion in=20
http://msdn.microsoft.com/en-us/library/aa363679.aspx under Remarks and=
=20
replace "%1" with "%1!S!" instead of "% 1".

Ren=E9
