From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: Add tests for -L/start/,/end/
Date: Mon, 19 Jul 2010 14:09:29 -0700
Message-ID: <7voce3nppy.fsf@alter.siamese.dyndns.org>
References: <1279294507-9238-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 19 23:09:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oaxap-0006AS-Hl
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 23:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966795Ab0GSVJi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jul 2010 17:09:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966783Ab0GSVJh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jul 2010 17:09:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D340C6B42;
	Mon, 19 Jul 2010 17:09:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8mbfPVVpMVz0
	Ry2/E1+gRWP1sjU=; b=oFDxqt1haweKIjN4tRC7YSOd8b2uBeGkmA6GJRLziR/8
	bE0vnwl9NQLINmZa6RHNzTWDS8lrd9tZNcqipdTKWfXJHdP79SjqLBokZRnURtA8
	+HCXHUfyzAXZNQcQxTlFBcDSEBIvHAiLfVrMqJpuUKpS03HI+9KYtSqM6dZaHDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ddH3aJ
	xARQujyf7OmTZyH/TscjjK944uhVT7aKI2hm8TXNBqDonukL4j5nW1nDmOfRl64C
	P+j0oPrgU36B7GcZB1m4l8EslcutXixWnG80udLPTQkHW7d3MkeDBYoARRSoYL32
	f8FoT4wxpeIVA4R24GkaaCPzQYlaPpmT7LT70=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AAACC6B41;
	Mon, 19 Jul 2010 17:09:34 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44D5AC6B40; Mon, 19 Jul
 2010 17:09:31 -0400 (EDT)
In-Reply-To: <1279294507-9238-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\, 16 Jul
 2010 15\:35\:07 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EE257998-9379-11DF-A929-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151282>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> git-pickaxe (later git-blame) gained support for the -L/start/,/end/
> form in 2006 (931233bc66 by Junio C Hamano), but nothing was added to
> test this functionality. Change that by adding more -L tests to
> t8003-blame.sh.

If we look at the existing tests carefully, there is no tests for the
range notation -L<start>,<end> in general, not just the regexp variant.=
  A
few existing uses are only to limit the output for testing other featur=
es
and take it granted that -L works correctly (meaning they may detect it=
 if
you break -L implementation but that is merely a side effect).

> +for comma in '' ','
> +do
> +	# The comma in -L/regex/, is optional

Is it just -L/regex/?  I thought -L<start> regardless of the shape of <=
start>
was equivalent to -L<start>,END-OF-FILE.

> +test_expect_success 'blame -LINT,/end/' '
> +	git blame -L3,/GH/ cow  >current 2>errors &&

This is somewhat an interesting one.  It asks for a range that begins a=
t
the third line in the file, extending to a line after that line that
matches the given expression.  Unfortunately the test vector does not h=
ave
a line that contains GH before the third line, nor more than one lines
that contain GH after the third line (we should stop at the first hit),=
 so
this test is not as effective as it could be.

> +test_expect_success 'blame -L,/end/' '
> +	git blame -L",/^X/" cow >current 2>errors &&

Missing <start> defaults to the beginning of file; the same as -L,INT a=
nd
not specific to the regex variant.

> +test_expect_success 'blame -L/invalid regex/' '
> +	# At least GNU, Solaris and FreeBSD (and by extension, Mac OS X)
> +	# complain about this
> +	! git blame -L/[b-a]/ cow >current 2>errors &&
> +	grep b-a errors &&

The b-a in the error message comes from us, not the regex library, so t=
his
test should be portable, I think, as long as the library detects the em=
pty
range correctly.
