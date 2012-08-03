From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: Introduce test_seq
Date: Fri, 03 Aug 2012 15:48:19 -0700
Message-ID: <7vr4rna8y4.fsf@alter.siamese.dyndns.org>
References: <7v3943bsuc.fsf@alter.siamese.dyndns.org>
 <1344032464-14104-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 00:48:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxQfU-000498-Vd
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 00:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604Ab2HCWsX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Aug 2012 18:48:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61539 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753516Ab2HCWsW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2012 18:48:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 691468161;
	Fri,  3 Aug 2012 18:48:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=l2ucqEX2EDAR
	IouVMUN/42wSSTs=; b=U5N4y4eVC9zjKI/MImztCVy0wRPdSaCuxgpkYLf8ay4K
	k6ROmSafikRd64b8AMej+jHacVSVduoes5W8I1INlGUhT21Zp9RpKL+YZEU/XWyx
	4/Gce5/yZNVQAob+4H31fUEFFp3lixoL1lrctkMuy9wTr9N4QeScZlef5wQ+NyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xqHNCR
	tIxIkvo2RVkNP5M+AUut/Ch59URquaihPRxODno73NevMMPOUcHNSrtLK6CoMbTM
	E4LzCQuzmZ+hwnD5TnPW5N+5uvuxNxFwlQuRnSGmhDxLIY1rE26fCWPMOZ/kmZWy
	08e+ONXVCidgENAqsDb+KKDFTBJZecI4ObGJ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56CFC8160;
	Fri,  3 Aug 2012 18:48:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 830AB815F; Fri,  3 Aug 2012
 18:48:20 -0400 (EDT)
In-Reply-To: <1344032464-14104-1-git-send-email-michal.kiedrowicz@gmail.com>
 (=?utf-8?Q?=22Micha=C5=82?= Kiedrowicz"'s message of "Sat, 4 Aug 2012
 00:21:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 52CB8E02-DDBD-11E1-BF4B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202868>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> Jeff King wrote:
>
> 	The seq command is GNU-ism, and is missing at least in older BSD
> 	releases and their derivatives, not to mention antique
> 	commercial Unixes.
>
> 	We already purged it in b3431bc (Don't use seq in tests, not
> 	everyone has it, 2007-05-02), but a few new instances have crept
> 	in. They went unnoticed because they are in scripts that are not
> 	run by default.
>
> Replace them with test_seq that is implemented with a Perl snippet
> (proposed by Jeff).  This is better than inlining this snippet
> everywhere it's needed because it's easier to read and it's easier to
> change the implementation (e.g. to C) if we ever decide to remove Per=
l
> from the test suite.
>
> Note that test_seq is not a complete replacement for seq(1).  It just
> has what we need now.
>
> There are also many places that do `for i in 1 2 3 ...` but I'm not s=
ure
> if it's worth converting them to test_seq.  That would introduce runn=
ing
> more processes of Perl.
>
> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> ---

Thanks; Jeff, ack?

I have one minor nit that I am tempted to fix while queuing---see
below.

> Changes since previous version:
>
> 	* Removed "This commit replaces" from commit message
> 	* Reworded test_seq description
> 	* Now $first and $last are passed to Perl as arguments
>
>  t/perf/perf-lib.sh      |  2 +-
>  t/t5551-http-fetch.sh   |  2 +-
>  t/test-lib-functions.sh | 20 ++++++++++++++++++++
>  3 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index 5580c22..a1361e5 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -163,7 +163,7 @@ test_perf () {
>  		else
>  			echo "perf $test_count - $1:"
>  		fi
> -		for i in $(seq 1 $GIT_PERF_REPEAT_COUNT); do
> +		for i in $(test_seq 1 $GIT_PERF_REPEAT_COUNT); do
>  			say >&3 "running: $2"
>  			if test_run_perf_ "$2"
>  			then
> diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
> index fadf2f2..91eaf53 100755
> --- a/t/t5551-http-fetch.sh
> +++ b/t/t5551-http-fetch.sh
> @@ -114,7 +114,7 @@ test -n "$GIT_TEST_LONG" && test_set_prereq EXPEN=
SIVE
>  test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
>  	(
>  	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> -	for i in `seq 50000`
> +	for i in `test_seq 50000`
>  	do
>  		echo "commit refs/heads/too-many-refs"
>  		echo "mark :$i"
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 80daaca..c8b4ae3 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -530,6 +530,26 @@ test_cmp() {
>  	$GIT_TEST_CMP "$@"
>  }
> =20
> +# Print a sequence of numbers or letters in increasing order.  This =
is
> +# similar to GNU seq(1), but the latter might not be available
> +# everywhere.  It may be used like:
> +#
> +#	for i in `test_seq 100`; do
> +#		for j in `test_seq 10 20`; do
> +#			for k in `test_seq a z`; do
> +#				echo $i-$j-$k
> +#			done
> +#		done
> +#	done
> +
> +test_seq () {
> +	test $# =3D 2 && { first=3D$1; shift; } || first=3D1
> +	test $# =3D 1 ||
> +	error "bug in the test script: not 1 or 2 parameters to test_seq"
> +	last=3D$1
> +	"$PERL_PATH" -le 'print for "$ARGV[0]".."$ARGV[1]"' "$first" "$last=
"

I'd prefer not to have dq around $ARGV[]; is there a reason to have
one around these?

> +}
> +
>  # This function can be used to schedule some commands to be run
>  # unconditionally at the end of the test to restore sanity:
>  #
