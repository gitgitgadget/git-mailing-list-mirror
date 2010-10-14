From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] Re: [PATCH v4 02/15] mingw: implement syslog
Date: Thu, 14 Oct 2010 02:47:01 +0200
Message-ID: <AANLkTi=C9RqQ-EKFN9fsBSHsSopgSuevTpjBj-R0jWcs@mail.gmail.com>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-3-git-send-email-kusmabite@gmail.com> <20101011221146.GB6277@burratino>
 <AANLkTinkpTavtw3Rmubfht56tzGnHckHXRc0L-C83daE@mail.gmail.com>
 <20101011223746.GA6637@burratino> <AANLkTinBvZ_L-fq1u4tPX6rNW6X3jeoOO23-yLpdxSu0@mail.gmail.com>
 <4CB60743.2030908@sunshineco.com> <AANLkTinj21hnpsHR49nS0u_FtpwA=2Q7ygNpowufRoDC@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	Mike Pape <dotzenlabs@gmail.com>
To: Pat Thoyts <patthoyts@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 02:50:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6C1M-00085j-H9
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 02:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915Ab0JNAuD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Oct 2010 20:50:03 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53487 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843Ab0JNAuB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Oct 2010 20:50:01 -0400
Received: by vws2 with SMTP id 2so2276909vws.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 17:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=MiBF+JGWVXwWsQmrHNO/039js8cbdbVEB64kahiAam8=;
        b=H8PkWvGBcgdCZn0bsKysEOazIiQTZRwGZE/vgRyZIO9wBnwAr4JHCZwELxvPdNIrSq
         oHEjI0K97M0Wa1qlSdzogaV2IJ9GakIfZYEpyPKTytIT2HFqQIccmUBGJqjXEZaiME5J
         4P5wYffegL00NTB9X88ET/iVpCYs6h3464EOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=nawvC+kwpr2k8URea+ZFznujSoGILQnjaSbOTRTWGwNxi4QUM+zTtP/w2Bhl6IuzCH
         5/zob163V/a0bEX621dc6DcmCjsy3sGMc8oExmcx2PVmi6DgQZpwI35104fjAZFwZwIU
         Oyw1V9JBkj8d3dwsCseuxVgFbN7lMaFDm0r3Q=
Received: by 10.220.100.76 with SMTP id x12mr3040858vcn.65.1287017400471; Wed,
 13 Oct 2010 17:50:00 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Wed, 13 Oct 2010 17:47:01 -0700 (PDT)
In-Reply-To: <AANLkTinj21hnpsHR49nS0u_FtpwA=2Q7ygNpowufRoDC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159009>

On Wed, Oct 13, 2010 at 11:17 PM, Pat Thoyts <patthoyts@gmail.com> wrot=
e:
> On 13 October 2010 20:23, Eric Sunshine <sunshine@sunshineco.com> wro=
te:
>> On 10/13/2010 08:36 AM, Erik Faye-Lund wrote:
>>>
>>> On Tue, Oct 12, 2010 at 12:37 AM, Jonathan Nieder<jrnieder@gmail.co=
m>
>>> =A0wrote:
>>>>
>>>> Erik Faye-Lund wrote:
>>>>
>>>>> The string gets inlined into itself (with a limit of 100 expansio=
ns)
>>>>> leading to string like "foo %1 bar" becoming "foo foo foo ... foo=
 %1
>>>>> bar bar bar ... bar". With our expansion, it becomes "foo % 1 bar=
"
>>>>> instead.
>>>>
>>>> Ah, ok. =A0Sounds like there is no need to worry about requests fo=
r "%%1"
>>>> etc. =A0Thanks for explaining.
>>>>
>>> Actually, %%1 is a bit of a tricky one. It seems that %%1 is used t=
o
>>> escape %1 on Windows 7, but not on earlier Windows version. I did t=
est
>>> this on Vista an XP earlier, but I'll re-test again later and repor=
t
>>> back, in case my earlier tests were flawed.
>>

Meh. Windows XP does not escape %%1 to %1, it has the same
expansion-problem as %1 does. In other words, my old assertion is
still valid.

>> If that worked universally, escaping '%1' to '%%1' certainly would b=
e nicer
>> than '% 1'. (More generally, escape '%n' to '%%n', where n is a numb=
er.) It
>> also would simplify the log message.
>>
>>> Can %%1 occur in an IPv6 address at all? If not, I'm tempted to not
>>> handle it (unless it turns out I was wrong about %%1-escaping on Vi=
sta
>>> and XP).
>>
>> According to sources I have studied, %%1 would be unlikely (or perha=
ps
>> invalid) in IPv6 addresses.
>>
>> http://en.wikipedia.org/wiki/IPv6_address#Link-local_addresses_and_z=
one_indices
>
> Not on windows. Try ipconfig:
> =A0 Link-local IPv6 Address . . . . . : fe80::c9fb:7840:66f5:b2e9%13
> =A0 Default Gateway . . . . . . . . . : fe80::20c:76ff:fe1e:e00%11
> and so on. Its an interface fragment or something.
>
> However - we really don't care. You can just substitute these to
> spaces and no-one will care. Keep it simple.
>

Uh, none of these contain a double percent-sign. Am I misunderstanding
what you're replying to?
