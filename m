From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [BUG] gitweb: XSS vulnerability of RSS feed
Date: Mon, 12 Nov 2012 22:13:27 +0100
Message-ID: <CANQwDwdRTeaVS5cMic5gv9SP1A8Z1vruOsZBFfMDQDTZHBAtvQ@mail.gmail.com>
References: <20121111232820.284510@gmx.net> <CAM9Z-n=6xsC7yiKJ+NU-CxNPxEXWmJzvXLUocgZgWPQnuK6G4Q@mail.gmail.com>
 <20121112202413.GD4623@sigill.intra.peff.net> <20121112202701.GE4623@sigill.intra.peff.net>
 <7vmwymh83r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Drew Northup <n1xim.email@gmail.com>,
	glpk xypron <xypron.glpk@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 22:14:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY1KV-0004Hq-5R
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 22:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399Ab2KLVNt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Nov 2012 16:13:49 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:33637 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265Ab2KLVNs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Nov 2012 16:13:48 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so6722141oag.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 13:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=JKsS4ss0U8THD4upbkobqlm6951kwdz3mzsosMTwa08=;
        b=jj3a/KlhF37eIXzq7tenr/6EXouOh6MWI8NGQVVQg1AgmlKriFP1+3dRCw2LtZRcgp
         sR1C5uzRHvlmmmVRKd5LZNFaYguC5r6mLcK/sh59Vrgtt9TlrqQVj/DA9PCAoHLOSJ0j
         Y5Xgp7H8YElRpuDUhgasrcPK8UZUhU3rc3c9GoVydtgO6gCi8lH0IpxzP2QMlImZwfJU
         7ble8FqEHI2nWvLOOgBi9SKLAA3XBAurHDLtSBiUPz5QclzvW6B7a1cn0BnMl2s86PyA
         kk8SmAwMqJCV410Pu2l/7Lch30BK8WHPDXgftRvqwC0wxzRq+75dgVGsFD/R0gsjdr7c
         Ctfg==
Received: by 10.60.8.103 with SMTP id q7mr15333652oea.70.1352754828102; Mon,
 12 Nov 2012 13:13:48 -0800 (PST)
Received: by 10.76.91.134 with HTTP; Mon, 12 Nov 2012 13:13:27 -0800 (PST)
In-Reply-To: <7vmwymh83r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209526>

On Mon, Nov 12, 2012 at 9:36 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jeff King <peff@peff.net> writes:
>> On Mon, Nov 12, 2012 at 03:24:13PM -0500, Jeff King wrote:
>>
>>> I think the right answer is going to be a well-placed call to esc_h=
tml.
>>
>> I'm guessing the right answer is this:
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 10ed9e5..a51a8ba 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -8055,6 +8055,7 @@ sub git_feed {
>>               $feed_type =3D 'history';
>>       }
>>       $title .=3D " $feed_type";
>> +     $title =3D esc_html($title);
>>       my $descr =3D git_get_project_description($project);
>>       if (defined $descr) {
>>               $descr =3D esc_html($descr);
>>
>> but I did not test it (and I am not that familiar with gitweb, so it=
 is
>> a slight guess from spending 5 minutes grepping and reading).
>
> Yeah, that looks correct, given the way how the other variables
> emitted with the same "print" like $descr and $owner are formed.

It looks like good solution to me too.

Nb. the problems with feed are mainly because it is generated
by hand even more than HTML (which uses CGI.pm).

--=20
Jakub Nar=EAbski

--=20
Jakub Narebski
