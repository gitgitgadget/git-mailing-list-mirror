From: =?utf-8?B?0KDQvtC80LDQvSDQlNC+0L3Rh9C10L3QutC+?= 
	<dpb@corrigendum.ru>
Subject: Re: [PATCH] send-email: handle adjacent RFC 2047-encoded words
 properly
Date: Mon, 24 Nov 2014 21:09:48 +0300
Message-ID: <op.xpucqml8nngjn5@freezie>
References: <1416786604-4988-1-git-send-email-dpb@corrigendum.ru>
 <CAPc5daVjNDg5CcWsMwfn=DZhwpCBdU2LYXOpFWZwhx2p8hLRww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>,
	=?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjar?= =?utf-8?Q?mason?= 
	<avarab@gmail.com>, "Jay Soffian" <jaysoffian@gmail.com>,
	"Jeff King" <peff@peff.net>, "Thomas Rast" <tr@thomasrast.ch>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 19:10:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xsy5M-0002FN-1S
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 19:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbaKXSJz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Nov 2014 13:09:55 -0500
Received: from forward3l.mail.yandex.net ([84.201.143.136]:43520 "EHLO
	forward3l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754429AbaKXSJy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Nov 2014 13:09:54 -0500
Received: from smtp1m.mail.yandex.net (smtp1m.mail.yandex.net [77.88.61.132])
	by forward3l.mail.yandex.net (Yandex) with ESMTP id 1C9D015011FA;
	Mon, 24 Nov 2014 21:09:50 +0300 (MSK)
Received: from smtp1m.mail.yandex.net (localhost [127.0.0.1])
	by smtp1m.mail.yandex.net (Yandex) with ESMTP id 33EC867403A8;
	Mon, 24 Nov 2014 21:09:49 +0300 (MSK)
Received: from cs7-mts-1-124.dialup.mts-nn.ru (cs7-mts-1-124.dialup.mts-nn.ru [82.208.71.124])
	by smtp1m.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id eDDTAsLzW9-9mtCrhtu;
	Mon, 24 Nov 2014 21:09:48 +0300
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 6f791190-97ff-424b-b7d1-7f2ef4e37b97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=corrigendum.ru; s=mail;
	t=1416852588; bh=k8+kquzchW/haG0ranizDt8M0SrWp+uXVbsyr0O59hk=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:
	 Content-Transfer-Encoding:From:Message-ID:In-Reply-To:User-Agent;
	b=Wz1sz225lPFAKyS2BIjBMntXZGGKJCdjbwgkZkxnb04hZiWF/yWx2m8MXTCzO4Uhh
	 OUqH6NJ+7jZlVRusoXAnQhN3tm48X9fWtYKwNtojU/XYggFb6/p+oAVF/LLUxvZOxk
	 AJXbMvwgKHo66UewARw3eHCvfD18pUA3FkaWJzwM=
Authentication-Results: smtp1m.mail.yandex.net; dkim=pass header.i=@corrigendum.ru
In-Reply-To: <CAPc5daVjNDg5CcWsMwfn=DZhwpCBdU2LYXOpFWZwhx2p8hLRww@mail.gmail.com>
User-Agent: Opera Mail/12.17 (Win64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260134>

Junio C Hamano <gitster@pobox.com> =D0=BF=D0=B8=D1=81=D0=B0=D0=BB =D0=B2=
 =D1=81=D0=B2=D0=BE=D1=91=D0=BC =D0=BF=D0=B8=D1=81=D1=8C=D0=BC=D0=B5 Mo=
n, 24 Nov 2014 =20
10:27:51 +0300:

> On Sun, Nov 23, 2014 at 3:50 PM, =D0=A0=D0=BE=D0=BC=D0=B0=D0=BD =D0=94=
=D0=BE=D0=BD=D1=87=D0=B5=D0=BD=D0=BA=D0=BE <dpb@corrigendum.ru> =20
> wrote:
>> The RFC says that they are to be concatenated after decoding (i.e. t=
he
>> intervening whitespace is ignored).
>>
>> I change the sender's name to an all-Cyrillic string in the tests so=
 =20
>> that
>> its encoded form goes over the 76 characters in a line limit, forcin=
g
>> format-patch to split it into multiple encoded words.
>>
>> Since I have to modify the regular expression for an encoded word =20
>> anyway,
>> I take the opportunity to bring it closer to the spec, most notably
>> disallowing embedded spaces and making it case-insensitive (thus =20
>> allowing
>> the encoding to be specified as both "q" and "Q").
>>
>> Signed-off-by: =D0=A0=D0=BE=D0=BC=D0=B0=D0=BD =D0=94=D0=BE=D0=BD=D1=87=
=D0=B5=D0=BD=D0=BA=D0=BE <dpb@corrigendum.ru>
>
> This sounds like a worthy thing to do in general.
>
> I wonder if the C implementation we have for mailinfo needs similar
> update, though. I vaguely recall that we have case-insensitive start =
for
> q/b segments, but do not remember the details offhand.

That's what git am uses, right? I think that already works correctly (o=
r =20
at least doesn't have the bug this patch fixes). I didn't do extensive =
=20
testing or look at the code, though.

>
> Was the change to the test to use Cyrillic really necessary, or did i=
t
> suffice if you simply extended the existsing "Funny Name" spelled wit=
h
> strange accents, but you substituted the whole string anyway?
>
> Until I found out what the new string says by running web-based
> translation on it, I felt somewhat uneasy. As I do not read
> Cyrillic/Russian, we may have been adding some profanity without
> knowing. It turns out that the string just says "Cyrillic Name", so I=
 am
> not against using the new string, but it simply looked odd to replace=
 the
> string whole-sale when you merely need a longer string. It made it lo=
ok
> as if a bug was specific to Cyrillic when it wasn't.

Ah, if only I had thought of including profanity beforehand. ;-)

Seriously though, I just needed to hit the 76 character limit, and =20
switching the keyboard layout is a lot easier than copypasting Latin =20
letters with diacritics (plus I had trouble coming up with a long enoug=
h =20
extension of "Funny Name"...). I can see how that's problematic, though=
; =20
I'll change it.

> As you may notice by reading "git log --no-merges" from recent histor=
y,
> we tend not to say "I did X, I did Y". If the tone of the above messa=
ge
> were more similar to them, it may have been easier to read.

Technically, I said "I do", not "I did"... but sure, point taken.

Roman.
