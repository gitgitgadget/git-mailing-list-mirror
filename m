From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2/GSoC/MICRO] revision: forbid combining --graph and --no-walk
Date: Sun, 08 Mar 2015 12:40:10 -0700
Message-ID: <xmqqwq2rqnvp.fsf@gitster.dls.corp.google.com>
References: <1425632110-31863-1-git-send-email-dongcan.jiang@gmail.com>
	<3de5837561c07fbf8d6187578fc37b3dbf2ea5f7.1425702676.git.dongcan.jiang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sunshine@sunshineco.com, l.s.r@web.de, git@vger.kernel.org
To: Dongcan Jiang <dongcan.jiang@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 20:40:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUh3k-0001yl-GE
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 20:40:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbbCHTkP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2015 15:40:15 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63400 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751576AbbCHTkN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Mar 2015 15:40:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D3EBE3E4A5;
	Sun,  8 Mar 2015 15:40:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bs1FV1q0/2F1
	+8EJQgZMRQ/j7Y4=; b=ltnX4R6E/awpcbOarSxki+NlQGPV00ylusXDDUwRVZQb
	Mh9q1TN6gsvB2p0OI6TU+ESWS+Jm2dHFaMp3JxPLgVZEaZ8x3bSDyRJWIh3eG5QO
	2wt5qMSnBeLuPM7E921ZSfg2gbe14vA184iD84KxsfMOXRnp+eXe1RXgMX/yF2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=uNkw6J
	AaFWBy92NHx22fcKLbQgrOTEBMgB3m2FQNTsM863npgtB2OSodjLkf18dib3O9Lj
	Uj/cBH57UAFa4Y3M3B+dlFuYs0u2WaNCtIUApjenhPVR+EClarpA8hkvTbg30l3K
	RxOrBHUOpOd/p10NCPffChbdzBB44cMV1Bw3I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CCFBE3E4A4;
	Sun,  8 Mar 2015 15:40:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4075D3E4A1;
	Sun,  8 Mar 2015 15:40:12 -0400 (EDT)
In-Reply-To: <3de5837561c07fbf8d6187578fc37b3dbf2ea5f7.1425702676.git.dongcan.jiang@gmail.com>
	(Dongcan Jiang's message of "Sat, 7 Mar 2015 12:56:47 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EFA7F880-C5CA-11E4-8F15-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265107>

Dongcan Jiang <dongcan.jiang@gmail.com> writes:

> Because --graph is about connected history while
> --no-walk is about discrete points. [1]

The convention around here is that the title of the patch on the
Subject line is *not* the beginning part of the first sentence, you
would need to phrase the above more like:

        Because "--graph" is about ... discrete points, it does not
        make sense to allow giving these two options at the same
        time.

to make it a complete sentence.

> It's a pity that git-show has to allow such combination
> in order to make t4052-stat-output.sh compatible. [2]

If you feel "It's a pity", it actually is OK to make a good argument
for "fixing" the test without adding the workaround.  A replacement
commit message for the above two lines for such an approach might
look like:

        This change makes a few calls to "show --graph" fail in
        t4052, but asking to show one commit _with_ graph is a
        nonsensical thing to do.  Correct these offending tests that
        expected "--graph" to be useful by removing "--graph" in
        their invocations (and adjusting the expected output, of
        course).

That way, people who do find it actually useful that "show --graph HEAD=
"
that shows something like this

        $ git show --graph -s 52d5bf778
        *   commit 52d5bf77875275bbfc1bf1d7b690f355d5c869e4
        |\  Merge: 36ab768 189c860
        | | Author: Junio C Hamano <gitster@pobox.com>
        | | Date:   Fri Mar 6 15:02:33 2015 -0800
        | |=20
        | |     Merge branch 'bw/kwset-use-unsigned'
        ...

can react and argue why it is useful to them. =20

It is important to notice that your "It's a pity" will no longer
apply, if we are keeping the feature because it is useful.  It would
be clear that we would be keeping the feature not because we are too
lazy to correct tests, but because it is actually useful.

> Signed-off-by: Dongcan Jiang <dongcan.jiang@gmail.com>
>
> Thanks-to: Eric Sunshine, Ren=C3=A9 Scharfe, Junio C Hamano

These look unusual for a few reasons: S-o-b is not at the end, we
usually say Helped-by: instead, and we do not use Thanks-to: with
multiple names on a single line.

Please do not try to be original without a good reason.  We may
start counting the number of times people appear on these footers to
see how much contribution those who do not directly author commits
(read: those who mentor others) are making.

> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 5f2b290..fed162e 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -887,4 +887,10 @@ test_expect_success GPG 'log --graph --show-sign=
ature for merged tag' '
>  	grep "^| | gpg: Good signature" actual
>  '
>
> +test_expect_success 'log --graph --no-walk is forbidden' '
> +	echo "fatal: cannot combine --no-walk with --graph" >expect-error &=
&
> +	test_must_fail git log --graph --no-walk 2>error &&
> +	test_cmp expect-error error
> +'

I do not think we want to check exact phrasing of the error
message here.  Just the second line (without the " 2>error &&"
at the end) should be sufficient.

> +test_expect_success 'rev-list --graph --no-walk is forbidden' '
> +	echo "fatal: cannot combine --no-walk with --graph" >expect-error &=
&
> +	test_must_fail git rev-list --graph --no-walk 2>error &&
> +	test_cmp expect-error error
> +'

The same comment (about preferring not to check the error message)
applies here, and more importantly, this is not a good test because
"git rev-list --graph" without the forbidden "--no-walk" would fail
for other reasons.  Perhaps

	test_must_fail git rev-list --graph --no-walk HEAD

or something, assuming that there is already a commit pointed by
HEAD at this point in the test (I didn't check).

Thanks.
