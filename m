From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda conditions
Date: Tue, 3 Sep 2013 08:39:54 -0500
Message-ID: <CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
References: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
	<1378103439-3225-4-git-send-email-felipe.contreras@gmail.com>
	<20130903071256.GD3608@sigill.intra.peff.net>
	<20130903075107.GA25540@goldbirke>
	<20130903080358.GA30158@sigill.intra.peff.net>
	<CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
	<20130903111006.GJ29840@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Sep 03 15:40:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGqpt-00054A-TA
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 15:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932877Ab3ICNj6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Sep 2013 09:39:58 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35076 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932823Ab3ICNj5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Sep 2013 09:39:57 -0400
Received: by mail-lb0-f173.google.com with SMTP id o14so4787698lbi.4
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 06:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=c+VPD5vAD0xIZgLMVy3HvtLblog4e6uVtAleIpHqN74=;
        b=EqaUDb98fSsJ77xfHL5YUWCJ5NtvH1+J2fBvo6vYgoNlzXtcuIC2eNaaeG+/eW1Etg
         tGnoMnOyVOgclMPLv/qgtZTyV/E9V/AABJ/wF2d0D+fizFEPtuZt5jHT8MKjnjd96vhY
         2WDhq9tFKgnu9DW/u0DsZP2cqweq52HYQJ5SXkXbGYaTj9712pEiC4X5gVUBx4zujreD
         UK/BiGNvMjF/hWKtLFWvy789L9OBuHhJ7zLKnAnokdV+x2705lCWNiL5rLpkjMi7E5o/
         IJnp67CND/LTq7wkf/lzrRceHuhEJ6PiMJBaNZy2JHp5m5Xwa52wzPuMetA2aTEz67IG
         JIkQ==
X-Received: by 10.112.50.72 with SMTP id a8mr1284746lbo.50.1378215594648; Tue,
 03 Sep 2013 06:39:54 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Tue, 3 Sep 2013 06:39:54 -0700 (PDT)
In-Reply-To: <20130903111006.GJ29840@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233724>

On Tue, Sep 3, 2013 at 6:10 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de> w=
rote:
> On Tue, Sep 03, 2013 at 05:45:06AM -0500, Felipe Contreras wrote:
>> On Tue, Sep 3, 2013 at 3:03 AM, Jeff King <peff@peff.net> wrote:
>> > On Tue, Sep 03, 2013 at 09:51:07AM +0200, SZEDER G=C3=A1bor wrote:
>> >
>> >> > I wonder if we should have a:
>> >> >
>> >> >   test_cmp_args () {
>> >> >           echo "$1" >expect &&
>> >> >           echo "$1" >actual &&
>> >> >           test_cmp expect actual
>> >> >   }
>> >> >
>> >> > to let these remain one-liners like:
>> >> >
>> >> >   test_cmp_args "$(git rev-parse start)" "$(git rev-parse final=
^1^1^1)"
>> >>
>> >> This idea come up before, but there is one flaw which makes this
>> >> function less useful: a non-zero exit code of the commands in the
>> >> command substitutions would be lost.
>> >
>> > Good point. You'd probably have to do something gross with eval, l=
ike:
>> >
>> >   test_cmp_args () {
>> >     eval "$1" >expect &&
>> >     eval "$2" >actual &&
>>
>> I don't see any reason to perpetuate these yoda comparisons.
>>
>> eval "$2" >expect &&
>> eval "$1" >actual &&
>
> I do.  Your proposal requires the arguments in the reverse order
> compared to test_cmp.  That inconsistency would be far worse than
> test_cmp_args "$expect" "$actual".

There are two ways to fix an inconsistency, the other way is to fix
test_cmp. But that would be a change, and change is not welcome in
Git.

=46or this reason alone I would prefer 'test "$actual" =3D expected', t=
han
the yodaish 'test_cmp_args "expected" "$actual"'.

--=20
=46elipe Contreras
