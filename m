From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH 1/2] sha1_name: try to use same abbrev length when
 core.abbrevguard is specified
Date: Thu, 10 Mar 2011 11:11:39 -0800
Message-ID: <7vwrk64wpg.fsf@alter.siamese.dyndns.org>
References: <1299581951-4670-1-git-send-email-namhyung@gmail.com>
 <7vipvsaz27.fsf@alter.siamese.dyndns.org>
 <7vbp1kayoe.fsf@alter.siamese.dyndns.org>
 <7vlj0n5o3n.fsf_-_@alter.siamese.dyndns.org>
 <1299757966.1499.34.camel@leonhard>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Namhyung Kim <namhyung@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 20:12:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxlHH-0001ZG-UV
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 20:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657Ab1CJTLz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2011 14:11:55 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51153 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753705Ab1CJTLs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 14:11:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5CC24330F;
	Thu, 10 Mar 2011 14:13:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rKAVQ/ZLzWG5
	CQMQSQ3ElsUdpF4=; b=VjRBVCXgYBbWRLcHJjaV8WJeZ7osTLfBU3do2YguTNm9
	fkU3UbYyBaq+Mfma6IoYrxCLXz/8yzARyinrX+AqeCJY1DryXYKm56DDRcMFj3vc
	ynnGQ/wxF5aCm52Ft7n5VAjLIulmPgUaebcA/2QyeMtMJjDA7YQP1Zsg38wGalQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kCMwlh
	dW+8bey7WvYtpv6RWHRtLZIQA0CKCcNgyS/hvocMJvVGcNb45enaX1Q09qXn9WSK
	fMrJLVV9fgksnVnLVVuiTgnLrKHaiu/LmHshEcy25JR1+72aGaQUuOS52tu9BKyd
	o1JQsmtlMQDcbDwn3RbiawlhYgA7LgAAiSPX0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3A9C1330E;
	Thu, 10 Mar 2011 14:13:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 24E7B330B; Thu, 10 Mar 2011
 14:13:08 -0500 (EST)
In-Reply-To: <1299757966.1499.34.camel@leonhard> (Namhyung Kim's message of
 "Thu, 10 Mar 2011 20:52:46 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 714C0D40-4B4A-11E0-B8ED-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168843>

Namhyung Kim <namhyung@gmail.com> writes:

> 2011-03-10 (=EB=AA=A9), 01:19 -0800, Junio C Hamano:
>> Junio C Hamano <gitster@pobox.com> writes:
>>=20
>> > I think what may be desirable is to honor the caller-supplied "len=
" a bit
>> > better.  If an object is uniquely identifiable with only 4-hexdigi=
t today,
>> > and if the caller gives 7 as len and the guard is set to 3, we ret=
urn 10
>> > hexdigits with the current code.  We should instead return 7 hexdi=
gits in
>> > such a case, as that is in line with the "use 3 extra to give the
>> > disambiguation we find today a better chance to survive".
>>=20
>> And here is an attempt to do so.  I have to admit that I didn't give=
 it
>> too much thought, though, so please be careful when reviewing the lo=
gic.
>>=20
>
> What if the unique length is greater than or equal to the given lengt=
h?
> For instance the unique length is 7 and the caller gives 7 and the gu=
ard
> is 3. What do you want to return, 7 or 10? How about the unique lengt=
h
> of 8?

Perhaps I didn't state it clearly enough.

Conceptually, f-u-a works in two stages.  First find out what the short=
est
prefix that can be used to uniquely identify the given object _now_.
Then make sure that the result it returns is at least "len" characters
long.  So if you code it naively, it would have looked like this:

	for (try =3D 0; try < 40; try++)
		if ("do first try characters name an object uniquely?")
			break; /* happy */
	if (try < len)
		return the first "len" characters;
	else
        	return the first "try" characters;

The original (before the abbrevguard patch) uses an obvious optimizatio=
n
to start the trial from "len" because it didn't matter if a prefix shor=
ter
than "len" is already unique---it will return "len" anyway.

The "guard" change was buggy.  At the conceptual level, it should have
changed the first phase of f-u-a, by dropping the "_now_" part. Given t=
hat
we will be adding more and more objects, only one extra character to ma=
ke
things unique is not sufficient and having "guard" extra characters wou=
ld
keep the result unique hopefully a little longer.  It should have done
this:

	for (try =3D 0; try < 40; try++)
		if ("do first try characters name an object uniquely?")
			break; /* happy */
       +/* try has only one extra character to make it unique */
       +if (guard)
       +	try +=3D (guard - 1); /* could be try +=3D guard */
	if (try < len)
		return the first "len" characters;
	else
        	return the first "try" characters;

Back to your original question, if the object needs 7 characters (iow, =
its
6-character prefix is shared with another object) to make it unique, an=
d
if the caller gives you 7 as length, without guard, you would get 7
because you are saying 1 extra character is sufficiently unique by not
setting the guard.  If you set the guard to 3, you are saying that 1 ex=
tra
character is not sufficient to guard it against future collisions and y=
ou
want 3 extra instead, so you should be getting either 9 (if you define
that "guard" overrides the default "1 more characters to make it minima=
lly
unique") or 10 (if you define that "guard" specifies how many extra
characters to use to make it safer).

If the object needs 8 characters to make it minimally unique and you gi=
ve
7 as "len", you should never get a 7-character string back.  f-u-a is n=
ot
"truncate to 'len'" function but its primary job is to ensure uniquenes=
s.
Without guard, you should get 8 (minimally unique), and with guard set =
to
3, you should get either 10 or 11 (again, depending on the definition o=
f
"guard").

> I think the meaning of the guard is somewhat vague. When this feature
> was considered in LKML at first, Linus just wanted to change the defa=
ult
> length of commit abbreviation to 12 by making it user-configurable. [=
1]

Linus's "Let's make the default 12 for our project by adding a way to
customize it" merely states "right now we know 7 is not enough and 12 i=
s
plenty for some time, and likely to be enough to give the same length".
It does not mean he suddenly start favoring uniform length over
uniqueness.  Uniqueness requirement is a given.

And that discussion is all about what "len" to be given when calling
f-u-a; it doesn't have anything to do with what the guard is about.

Setting "len" to 12 would make sure your output you get today would hav=
e
at least 12 characters, but it doesn't have any effect on how long an
abbreviated unique object name will stay unique in the future.

When you give the name of an object you have today to somebody else by
shortening it with f-u-a, you can ensure that the object name has a bet=
ter
chance of staying unique a bit longer by setting the guard to a non-zer=
o
value even if you use shorter "len".

The "len" and "guard" are different concepts, have different purposes, =
and
implemented as two different variables, of course.

> So I think it would be better to choose the output length using only
> caller-given length and the guard length if it guarantees the uniquen=
ess
> today. It'll be simple, consistent and expected behavior IMHO.

Sorry, but I see nothing consistent nor expected about what you are
saying. Perhaps it is "expected" if you don't understand what the guard=
 is
about. It is about the future viability of the output you produce today=
=2E

If you don't care about uniqueness tomorrow, you won't even need any
guard.  You just give an interface to specify "len" and be done with it=
=2E
