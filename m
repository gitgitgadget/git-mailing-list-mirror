From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix 'No newline...' annotation in rewrite diffs.
Date: Fri, 03 Aug 2012 09:46:22 -0700
Message-ID: <7vobmrc49t.fsf@alter.siamese.dyndns.org>
References: <85f291cec03411c61ddf8808e53621ae@imap.force9.net>
 <20120802213346.GA575@sigill.intra.peff.net>
 <7vipd1c66f.fsf@alter.siamese.dyndns.org>
 <20120802221404.GA1682@sigill.intra.peff.net>
 <loom.20120803T094115-721@post.gmane.org>
 <20120803160229.GA13094@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 03 18:46:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxL1D-0008MO-Ij
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 18:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407Ab2HCQq0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Aug 2012 12:46:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56064 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432Ab2HCQqZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2012 12:46:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43D0B73A7;
	Fri,  3 Aug 2012 12:46:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mxos/0Bn0HXv
	zkWDonwbUeAxB4c=; b=H65msUtp4Dvw4/roFYDHPDuWn0Gut7MQrhCSIDpNb+Hs
	OYUG/i0hvUiDo2Tp0dXRc6x19yXS8yw5NNHReKoHlxQ+O/xCbGIHKVx99oNMw+vo
	sJSSbkkXSYQqFNUqi1oINyhWOMKPARb82ZEeavzKKFiJgKCR4DbzHAwEnk9JzN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=uGNeeV
	oBksZW8W+N3FoqI5dvmyX9qCG7zqkxgh8HCTQJiHjS/Nedd58rIB3NJuqrRaMQwV
	H+Lr2ecBASb5A+NVIHHog/6g5b71rTCbwGhPwperb+kvf/Q43eCrDqG8Qjh0uXh8
	PvGwwfX5PGPBnQSl9F9zwvhcKjAOyR1+pU49I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31D9573A6;
	Fri,  3 Aug 2012 12:46:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A56B7739C; Fri,  3 Aug 2012
 12:46:23 -0400 (EDT)
In-Reply-To: <20120803160229.GA13094@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 3 Aug 2012 12:02:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C289B918-DD8A-11E1-B016-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202843>

Jeff King <peff@peff.net> writes:

> On Fri, Aug 03, 2012 at 07:49:47AM +0000, Micha=C5=82 Kiedrowicz wrot=
e:
>
>> Jeff King <peff <at> peff.net> writes:
>>=20
>> > -		for i in $(seq 1 $GIT_PERF_REPEAT_COUNT); do
>> > +		for i in $("$PERL_PATH" -le "print for 1..$GIT_PERF_REPEAT_COUN=
T"); do
>>=20
>> Maybe you could introduce "test_seq" instead.
>
> I don't have a strong preference, as there are only two callsites. Do
> you want to make a patch?

If you run "for . in . . ." in t/, we see quite a many hits, so
"only two callsites" might be undercounting the candidates.
