From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/7] t4030: demonstrate behavior of show with textconv
Date: Tue, 23 Apr 2013 08:11:42 -0700
Message-ID: <7vehe1l1sh.fsf@alter.siamese.dyndns.org>
References: <517298D4.3030802@drmicha.warpmail.net>
	<8a6cbd3ca4e2cb1e5376262c3efa8e3a222767de.1366718624.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	jeremy.rosen@openwide.fr, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 23 17:11:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUeso-0005EP-Gj
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 17:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730Ab3DWPLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 11:11:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46176 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755310Ab3DWPLp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 11:11:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09B2319128;
	Tue, 23 Apr 2013 15:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5ijb5KvHOifrUOSJwTi3cDbRWvA=; b=a0F1Iw
	um2FG56yVXQxKyMQkQR9HtyrkepBlFSQS9nU3oJA6/fJ4GrD90m3PtEA5JtOj3lI
	3kOzH5J9s4b/o+a7WeIlPJ/vs77MNnGxHk1Q9Ir6laI/J+V8ZAxqfDtp7YgRXUwp
	RW4ps37qs2D7iUtLxshQB3onRxYqgQ3rhUR68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A8sh127u3iMdXIYPO3y6xfjIsZsIihl0
	ALCerMZ05VNFZIOjyqzXrM5B5agLg0XkxgirQfHF8NNjc9aZRsb2uBdzOhNbD/VJ
	7tkBCL1fsMnhrWSUVtXLaSsgY2FzqJyOezJcSsYuD24GwA2Mu1pt5QlFh8wAbN4K
	umraRexhjgc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F212319127;
	Tue, 23 Apr 2013 15:11:44 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5706A19126;
	Tue, 23 Apr 2013 15:11:44 +0000 (UTC)
In-Reply-To: <8a6cbd3ca4e2cb1e5376262c3efa8e3a222767de.1366718624.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Tue, 23 Apr 2013 14:11:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C0AC768-AC28-11E2-967F-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222173>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> "git show <commit>" honors the textconv setting while "git show <blob>"
> does not. Demonstrate this in the test.

Should "git show <blob>" run textconv by default?  I somehow had an
impression that people were against it during the discussion on the
previous round.

>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  t/t4030-diff-textconv.sh | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
> index 53ec330..260ea92 100755
> --- a/t/t4030-diff-textconv.sh
> +++ b/t/t4030-diff-textconv.sh
> @@ -58,6 +58,12 @@ test_expect_success 'diff produces text' '
>  	test_cmp expect.text actual
>  '
>  
> +test_expect_success 'show commit produces text' '
> +	git show HEAD >diff &&
> +	find_diff <diff >actual &&
> +	test_cmp expect.text actual
> +'
> +
>  test_expect_success 'diff-tree produces binary' '
>  	git diff-tree -p HEAD^ HEAD >diff &&
>  	find_diff <diff >actual &&
> @@ -84,6 +90,12 @@ test_expect_success 'status -v produces text' '
>  	git reset --soft HEAD@{1}
>  '
>  
> +test_expect_failure 'show blob produces text' '
> +	git show HEAD:file >actual &&
> +	printf "0\\n1\\n" >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'grep-diff (-G) operates on textconv data (add)' '
>  	echo one >expect &&
>  	git log --root --format=%s -G0 >actual &&
