From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] completion: fix args of run_completion() test helper
Date: Fri, 28 Sep 2012 11:04:05 -0700
Message-ID: <7vehlmm3ca.fsf@alter.siamese.dyndns.org>
References: <20120928100530.GL10144@goldbirke>
 <1348826975-2225-1-git-send-email-szeder@ira.uka.de>
 <1348826975-2225-2-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Sep 28 20:04:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THevD-0007xC-0Z
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 20:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758695Ab2I1SEJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Sep 2012 14:04:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63329 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754952Ab2I1SEI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Sep 2012 14:04:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 901D38E8F;
	Fri, 28 Sep 2012 14:04:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+rs1aJV3mOq4
	Ai6Go46k7HZbxU4=; b=l5659xoSab2vmzJ9UVNEdBtHpTbp3Dgz56xTrZUJH/wi
	DRBcJNI1iOvx9ZPrwqZhlwnj7JJPdurQPpc1/fOemupCaQbDK7F1Eyd0xdoeBnkO
	BFf1ZAsOrVK7auS5hCFIqXXfr203/yN+mRHpqbNBffqEcjAwhZQ6brq6u9nxisA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gnpiyq
	yXseg47P/kp5fc34MGMTK9SqEcVna/UAw98obumfAklGHcZMlsO1782+gFmTERe7
	cQgpIQBbjUKznsQ0n5HcqIHNiAs0zvzHyz5YOLSXqQLaK25nzOcMk3YTh1ku+wo0
	RqeiOiHVocWA7njyyXeXfHfKHRDJv0fG0gy1Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B1EB8E8E;
	Fri, 28 Sep 2012 14:04:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C9AAD8E84; Fri, 28 Sep 2012
 14:04:06 -0400 (EDT)
In-Reply-To: <1348826975-2225-2-git-send-email-szeder@ira.uka.de> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?= message of "Fri, 28 Sep 2012 12:09:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E51FD06A-0996-11E2-8C7A-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206592>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> To simulate the the user hit 'git <TAB>, one of the completion tests
> sets up the rather strange command line
>
>   git ""
>
> i.e. the second word on the command line consists of two double
> quotes.  However, this is not what happens for real, because after
> 'git <TAB>' the second word on the command line is just an empty
> string.  Luckily, the test works nevertheless.
>
> Fix this by passing the command line to run_completion() as separate
> words.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
>  t/t9902-completion.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index e7657537..f5e68834 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -49,7 +49,7 @@ run_completion ()
>  {
>  	local -a COMPREPLY _words
>  	local _cword
> -	_words=3D( $1 )
> +	_words=3D( "$@" )
>  	(( _cword =3D ${#_words[@]} - 1 ))
>  	__git_wrap__git_main && print_comp
>  }
> @@ -57,7 +57,7 @@ run_completion ()
>  test_completion ()
>  {
>  	test $# -gt 1 && echo "$2" > expected
> -	run_completion "$@" &&
> +	run_completion $1 &&
>  	test_cmp expected out
>  }

I can understand the other three hunks, but this one is fishy.
Shouldn't "$1" be inside a pair of dq?  I.e.

	+	run_completion "$1" &&

> =20
> @@ -147,7 +147,7 @@ test_expect_success '__gitcomp - suffix' '
>  '
> =20
>  test_expect_success 'basic' '
> -	run_completion "git \"\"" &&
> +	run_completion git "" &&
>  	# built-in
>  	grep -q "^add \$" out &&
>  	# script
> @@ -155,7 +155,7 @@ test_expect_success 'basic' '
>  	# plumbing
>  	! grep -q "^ls-files \$" out &&
> =20
> -	run_completion "git f" &&
> +	run_completion git f &&
>  	! grep -q -v "^f" out
>  '
