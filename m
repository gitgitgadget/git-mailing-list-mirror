From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: A new test prereq for testing chmod -w as root
Date: Wed, 04 Aug 2010 12:13:05 -0700
Message-ID: <7veieefaym.fsf@alter.siamese.dyndns.org>
References: <1280934026-25658-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 21:13:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgjOx-0007Qu-Pk
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 21:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725Ab0HDTNO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Aug 2010 15:13:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57616 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757165Ab0HDTNN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Aug 2010 15:13:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CC3DCA940;
	Wed,  4 Aug 2010 15:13:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WwO8WPWPN1OG
	S9oVWo2O1hEQZio=; b=GZkIDjInE1nIob3fNkHLve0SLl/Sk+gNT7r7vglO4bi8
	6Pt6P0eCTNjCTSWWEB3B8dFWj0mxzsqKk9k41T/YCUTeNRvynYVrPVUhMXuOcg5f
	UvuXZCLmykgsdtoUTMg8R5w1XHT2+4gjTUH2Yfe1uTar4xO3kadH+Lo3gQvef10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=esfvCT
	tGRs1lrtChoHgbFkB5+NkctRgxYY437AD7KI27NOB6cTF1vq6ZFz1Qc01o46NjHZ
	VL5pIItDLUN/VJ9pdAoYomwzIwJXVEQYeJbfdvMkZhcm03q3o6Ps2j7TwcdZXsN6
	bovSrkdEXMhBgcRslOumR2zZxXMErgouFV1Xs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 399A8CA93E;
	Wed,  4 Aug 2010 15:13:10 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B984CA939; Wed,  4 Aug
 2010 15:13:07 -0400 (EDT)
In-Reply-To: <1280934026-25658-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed\,  4 Aug
 2010 15\:00\:26 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 521484A6-9FFC-11DF-8A7E-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152596>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Some tests depend on not being able to read files after chmod -w. Thi=
s
> doesn't work when running the tests as root.

Obviously you meant s/read/write/ or "chmod -r" ;-)

We discussed this prerequisite in the past as "SANITY", in the dual sen=
se
that (1) nobody sane should be running tests as root and (2) for root m=
any
normal assumptions programs make do not hold.  If we throw out the form=
er
by saying that it is safe to run tests under fakeroot, we would need
something like this patch to cover the latter.  The patch is a step in =
the
right direction.

Having said that.

I wonder if we want to be so specific, as your patch does, to single ou=
t
"you can write even to a-w file" aspect of rootness, or just want to co=
ver
the rootness more broadly so that other rooty conditions like "if you c=
an
read even an a-r file, then the assumptions the test makes will not hol=
d"
and "if you can kill other's processes, ...ditto..." can also be covere=
d
with a single prerequisite token.

Also I think there was a discussion and proposed patch to support more
than one prerequisite tokens, concatenated with "," or something, like:

    test_expect_success POSIXPERM,SANITY 'notice unwritable repo' '
        ... test that depends on posixperm and not running
        ... as root comes here
    '

so that you don't have to invent permutations of prerequisite tokens.

Thanks.
