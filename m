From: Pat Thoyts <patthoyts@gmail.com>
Subject: Re: [msysGit] Re: [PATCH v4 02/15] mingw: implement syslog
Date: Wed, 13 Oct 2010 22:17:19 +0100
Message-ID: <AANLkTinj21hnpsHR49nS0u_FtpwA=2Q7ygNpowufRoDC@mail.gmail.com>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
	<1286833829-5116-3-git-send-email-kusmabite@gmail.com>
	<20101011221146.GB6277@burratino>
	<AANLkTinkpTavtw3Rmubfht56tzGnHckHXRc0L-C83daE@mail.gmail.com>
	<20101011223746.GA6637@burratino>
	<AANLkTinBvZ_L-fq1u4tPX6rNW6X3jeoOO23-yLpdxSu0@mail.gmail.com>
	<4CB60743.2030908@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kusmabite@gmail.com, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	avarab@gmail.com, Mike Pape <dotzenlabs@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 23:17:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P68hn-0007IP-82
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 23:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522Ab0JMVRV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Oct 2010 17:17:21 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52823 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779Ab0JMVRU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Oct 2010 17:17:20 -0400
Received: by qyk5 with SMTP id 5so982860qyk.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 14:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nz/Wv2DO1pA6L/cyHzKplS4uuGnnVQYevuBH3nEdjbg=;
        b=HYnAsG8fV2LZeA/mBMxllRPSmVRTYKkpxLAjslwT8aY0JObdtK6ckVwzll/cSUHZMu
         xBLUrFYsHdu1bwdVRJtUW/kfunoTXxYzpSxphqp/02/689gU6Zing2vNgc9hnij7ukB/
         cGIuNGKZT6W2hE1MlN5E5k2gVFVTGTXJ9C8I0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ru4HqOWSQyDzWiltJfMnO8N+gfDxga0FJL2ivlvMNv1qmM6UA5aGInV+LzvHpLW+1J
         bwhMG3pHFWJqMdF9Hfy18hQ6gEMhJt6sSoVRx8YRNpjjwjtNgTBUzxsFKs6/lOF4dbu2
         UfcBjb5/lq9vUM3GdOfsDbBkjGtlqqymCzZMs=
Received: by 10.229.215.208 with SMTP id hf16mr8046801qcb.79.1287004639599;
 Wed, 13 Oct 2010 14:17:19 -0700 (PDT)
Received: by 10.229.45.203 with HTTP; Wed, 13 Oct 2010 14:17:19 -0700 (PDT)
In-Reply-To: <4CB60743.2030908@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158977>

On 13 October 2010 20:23, Eric Sunshine <sunshine@sunshineco.com> wrote=
:
> On 10/13/2010 08:36 AM, Erik Faye-Lund wrote:
>>
>> On Tue, Oct 12, 2010 at 12:37 AM, Jonathan Nieder<jrnieder@gmail.com=
>
>> =C2=A0wrote:
>>>
>>> Erik Faye-Lund wrote:
>>>
>>>> The string gets inlined into itself (with a limit of 100 expansion=
s)
>>>> leading to string like "foo %1 bar" becoming "foo foo foo ... foo =
%1
>>>> bar bar bar ... bar". With our expansion, it becomes "foo % 1 bar"
>>>> instead.
>>>
>>> Ah, ok. =C2=A0Sounds like there is no need to worry about requests =
for "%%1"
>>> etc. =C2=A0Thanks for explaining.
>>>
>> Actually, %%1 is a bit of a tricky one. It seems that %%1 is used to
>> escape %1 on Windows 7, but not on earlier Windows version. I did te=
st
>> this on Vista an XP earlier, but I'll re-test again later and report
>> back, in case my earlier tests were flawed.
>
> If that worked universally, escaping '%1' to '%%1' certainly would be=
 nicer
> than '% 1'. (More generally, escape '%n' to '%%n', where n is a numbe=
r.) It
> also would simplify the log message.
>
>> Can %%1 occur in an IPv6 address at all? If not, I'm tempted to not
>> handle it (unless it turns out I was wrong about %%1-escaping on Vis=
ta
>> and XP).
>
> According to sources I have studied, %%1 would be unlikely (or perhap=
s
> invalid) in IPv6 addresses.
>
> http://en.wikipedia.org/wiki/IPv6_address#Link-local_addresses_and_zo=
ne_indices

Not on windows. Try ipconfig:
   Link-local IPv6 Address . . . . . : fe80::c9fb:7840:66f5:b2e9%13
   Default Gateway . . . . . . . . . : fe80::20c:76ff:fe1e:e00%11
and so on. Its an interface fragment or something.

However - we really don't care. You can just substitute these to
spaces and no-one will care. Keep it simple.
