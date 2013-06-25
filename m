From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: fixup fixup! fixup!
Date: Tue, 25 Jun 2013 14:36:07 -0700
Message-ID: <7va9md27qw.fsf@alter.siamese.dyndns.org>
References: <20130611180530.GA18488@oinkpad.pimlott.net>
	<87obbc8otc.fsf@hexa.v.cablecom.net> <1371237209-sup-639@pimlott.net>
	<1371278908-sup-1930@pimlott.net>
	<7vk3lvlmat.fsf@alter.siamese.dyndns.org>
	<87ip1e2tzx.fsf@hexa.v.cablecom.net>
	<7v7ghtjwbb.fsf@alter.siamese.dyndns.org>
	<8738shi2ht.fsf@linux-k42r.v.cablecom.net>
	<7vwqpshkxj.fsf@alter.siamese.dyndns.org>
	<1372190294-sup-1398@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
To: Andrew Pimlott <andrew@pimlott.net>
X-From: git-owner@vger.kernel.org Tue Jun 25 23:36:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrauO-0006lr-66
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 23:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572Ab3FYVgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 17:36:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61563 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323Ab3FYVgK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 17:36:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D9472B2D6;
	Tue, 25 Jun 2013 21:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i7fWdg9FkLlpmUNthMGyo8oSf3I=; b=HOjGxK
	nYrL/kQ0W0LBUhXaXEUHkxq9piEAhX/CC8As8JpgvlULk/cgvbM+rcvC1rDgcI9l
	bGfj73So0SEUMss16Q94NzzObDrAgTV8PoWEHbhp/ort6hcUvDtB3XPDtVri7ZiX
	nl89quCiev7uzhtoUJCTNxOZ5Hm40QGoeIlLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uW+chOGM7pn0a1WPjW8CKyRLJwWPaSF5
	wahINx2VxWLwZxENnduZMFiVxPLYQDFHCls+cfrXp3/LQ15xN2GaDZfLNX4gTo40
	uAbG8vd3wx7DcjGn+DihTZ2idRHItETouotavvhb5VEtPQItFH2pG0vKX50zMwuD
	aWh1imO2OHs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11AF12B2D3;
	Tue, 25 Jun 2013 21:36:10 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 437D52B2CF;
	Tue, 25 Jun 2013 21:36:09 +0000 (UTC)
In-Reply-To: <1372190294-sup-1398@pimlott.net> (Andrew Pimlott's message of
	"Tue, 25 Jun 2013 13:41:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3FD434D4-DDDF-11E2-986A-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229001>

Andrew Pimlott <andrew@pimlott.net> writes:

> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index c84854a..6b2e1c8 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -389,7 +389,9 @@ squash/fixup series.
>  	the same ..., automatically modify the todo list of rebase -i
>  	so that the commit marked for squashing comes right after the
>  	commit to be modified, and change the action of the moved
> -	commit from `pick` to `squash` (or `fixup`).
> +	commit from `pick` to `squash` (or `fixup`).  Ignores subsequent
> +	"fixup! " or "squash! " after the first, in case you referred to an
> +	earlier fixup/squash with `git commit --fixup/--squash`.
>  +
>  This option is only valid when the '--interactive' option is used.
>  +
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index f953d8d..54ed4c3 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -689,7 +689,18 @@ rearrange_squash () {
>  		case "$message" in
>  		"squash! "*|"fixup! "*)
>  			action="${message%%!*}"
> -			rest="${message#*! }"
> +			rest=$message
> +			# ignore any squash! or fixup! after the first
> +			while : ; do

Style:

	while :
        do

> +				case "$rest" in
> +				"squash! "*|"fixup! "*)
> +					rest="${rest#*! }"
> +					;;
> +				*)
> +					break
> +					;;
> +				esac
> +			done
>  			echo "$sha1 $action $rest"
>  			# if it's a single word, try to resolve to a full sha1 and
>  			# emit a second copy. This allows us to match on both message
> diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
> index a1e86c4..1a3f40a 100755
> --- a/t/t3415-rebase-autosquash.sh
> +++ b/t/t3415-rebase-autosquash.sh
> @@ -193,4 +193,53 @@ test_expect_success 'use commit --squash' '
>  	test_auto_commit_flags squash 2
>  '
>  
> +test_auto_fixup_fixup () {
> +	git reset --hard base &&
> +	echo 1 >file1 &&
> +	git add -u &&
> +	test_tick &&
> +	git commit -m "$1! first" &&
> +	echo 2 >file1 &&
> +	git add -u &&
> +	test_tick &&
> +	git commit -m "$1! $2! first" &&
> +	git tag "final-$1-$2" &&
> +	test_tick &&
> +	git rebase --autosquash -i HEAD^^^^ &&
> +	git log --oneline >actual &&
> +	test_pause &&

This patch obviously hasn't been tested.  It breaks without -v.

> +	if [ "$1" = "fixup" ]; then
> +		test_line_count = 3 actual
> +	elif [ "$1" = "squash" ]; then
> +		test_line_count = 4 actual
> +	else
> +		false
> +	fi &&

Style

	if test "$1" = "fixup"
	then
        	...
	elif test "$1" = "squash"
	then
		...

(you got the idea).

> +	git diff --exit-code "final-$1-$2" &&
> +	test 2 = "$(git cat-file blob HEAD^:file1)" &&
> +	if [ "$1" = "fixup" ]; then
> +		test 1 = $(git cat-file commit HEAD^ | grep first | wc -l)
> +	elif [ "$1" = "squash" ]; then
> +		test 3 = $(git cat-file commit HEAD^ | grep first | wc -l)
> +	else
> +		false
> +	fi
> +}
> +
> +test_expect_success 'fixup! fixup!' '
> +	test_auto_fixup_fixup fixup fixup
> +'
> +
> +test_expect_success 'fixup! squash!' '
> +	test_auto_fixup_fixup fixup squash
> +'
> +
> +test_expect_success 'squash! squash!' '
> +	test_auto_fixup_fixup squash squash
> +'

This does not seem to pass for me.

> +test_expect_success 'squash! fixup!' '
> +	test_auto_fixup_fixup squash fixup
> +'
> +
>  test_done
