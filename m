From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: Introduce test_seq
Date: Fri, 03 Aug 2012 13:53:15 -0700
Message-ID: <7v3943bsuc.fsf@alter.siamese.dyndns.org>
References: <20120803160229.GA13094@sigill.intra.peff.net>
 <1344023835-8947-1-git-send-email-michal.kiedrowicz@gmail.com>
 <20120803200201.GA10344@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 03 22:54:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxOsi-0007EF-5X
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 22:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649Ab2HCUxS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Aug 2012 16:53:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42845 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753445Ab2HCUxS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2012 16:53:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A70F28351;
	Fri,  3 Aug 2012 16:53:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CeBXMP+6Lvdg
	CIFMqCcHnVH9pUo=; b=dduNXme0FL5ZBMQLgpHsmoaTwfS6z+99WYZIvhaDNHOJ
	w7kN3KTPvcpbKCCyVh7oqOIiT4PvkuD1xmn3sMrpLJz05Bjmaueb2xnVvRh+fzFA
	A8Wp3zdVzG2KnbFTEZtsYZWr+tpK8eGKNYfgJgp+sHsXbM1CuIHXaMDV2JpLdJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ReMKco
	lwjBcV76OQSr31qrKjb188BaIFHMBn8pDbxFgbje+EvI0baOv6CG0xNciYQ35x5M
	aGZg/coFhtWYlP3OMlJTuwQB2ym2CxR7aa6ME9bTf+US1S4LxeMo0hWzpN3u/Aww
	MKoHotooI6Yv3VoPTQq5DK66wqttzXKLsiBzM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 941718350;
	Fri,  3 Aug 2012 16:53:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE05D834F; Fri,  3 Aug 2012
 16:53:16 -0400 (EDT)
In-Reply-To: <20120803200201.GA10344@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 3 Aug 2012 16:02:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3FDF7836-DDAD-11E1-B45B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202863>

Jeff King <peff@peff.net> writes:

> On Fri, Aug 03, 2012 at 09:57:15PM +0200, Micha=C5=82 Kiedrowicz wrot=
e:
>
>> Jeff King wrote:
>>=20
>> 	The seq command is GNU-ism, and is missing at least in older BSD
>> 	releases and their derivatives, not to mention antique
>> 	commercial Unixes.
>>=20
>> 	We already purged it in b3431bc (Don't use seq in tests, not
>> 	everyone has it, 2007-05-02), but a few new instances have crept
>> 	in. They went unnoticed because they are in scripts that are not
>> 	run by default.
>>=20
>> This commit replaces them with test_seq that is implemented with a P=
erl
>> snippet (proposed by Jeff).

Just say "Replace them with test_seq...", without "This commit".

> Fine explanation, but...
>
>> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
>> index 5580c22..a1361e5 100644
>> --- a/t/perf/perf-lib.sh
>> +++ b/t/perf/perf-lib.sh
>> @@ -163,7 +163,7 @@ test_perf () {
>>  		else
>>  			echo "perf $test_count - $1:"
>>  		fi
>> -		for i in $(seq 1 $GIT_PERF_REPEAT_COUNT); do
>> +		for i in $(test_seq 1 $GIT_PERF_REPEAT_COUNT); do
>
> Two args to test_seq, but...
>
>> +# test_seq is a portable replacement for seq(1).
>> +# It may be used like:
>> +#
>> +#	for i in `test_seq 100`; do
>> +#		echo $i
>> +#	done
>> +
>> +test_seq () {
>> +	test $# =3D 1 ||
>> +	error "bug in the test script: not 1 parameter to test_seq"
>> +	last=3D$1
>> +	"$PERL_PATH" -le "print for 1..$last"
>> +}
>
> it wants only one.
>
> I think you would want:
>
>   test $# =3D 1 && set -- 1 "$@"
>   "$PERL_PATH" -le "print for $1..$2"
>
> It might also be worth quoting the parameters like this:
>
>   "$PERL_PATH" -le "print for '$1'..'$2'"
>
> so that "test_seq a f" works, too.

Yeah, I like that last one, but then unlike the claim in the comment
before the function definition, it is not "a portable replacement
for seq(1)" at all, but something a lot more suited for our purpose.
So at least the comment needs to be updated.  I do not have strong
opinion on calling this test_seq when it acts differently from seq;
it is not confusing enough to make me push something longer that is
different from "seq", e.g. test_sequence.

Wouldn't it be cleaner and readable to write it like this

	"$PERL_PATH" -le 'print for $ARGV[0]..$ARGV[1]' "$1" "$2"

by the way?
