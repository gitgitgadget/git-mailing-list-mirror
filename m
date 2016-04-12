From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/7] i18n: git-parse-remote.sh: mark strings for translation
Date: Tue, 12 Apr 2016 10:47:20 -0700
Message-ID: <xmqqk2k2ra6v.fsf@gitster.mtv.corp.google.com>
References: <1460234324-13506-1-git-send-email-vascomalmeida@sapo.pt>
	<1460234324-13506-3-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Tue Apr 12 19:47:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq2PP-0000uK-Ja
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 19:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934088AbcDLRrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 13:47:24 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51992 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932972AbcDLRrX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 13:47:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 16D3955F42;
	Tue, 12 Apr 2016 13:47:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XnSePIObZIFgZQ8s7sUy/ZKz+1o=; b=i2r57y
	r0olDg22tC5E6bm1Cd3qdQyYCHJLaDzEQ38WZKxmyv2Bu0+lGNbidNSpKcnbgWwv
	gBG+I9zVvjBtjVmW+RLXkrYwbxLLJn+DW0IyRSd/quJZmtaUSDjE4i+ncn5joas2
	iQ3ouIMR4kJHKCNKmk1aMA8udzg0gNqYgNOBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W6i5O7JdM0XBHuuVNFaEiQeT7bOwvEma
	V8r4AuSkbMNUM+uvg5HJBQoiFIl08TO93j8eEcdGNhFM0akd5DL+0MRr3xNbzPUm
	aKB4/XPGuoS7Rribm1mWJd0gW/x0fFIht/1aUjwK9MIjWx8qt1ezAEX9eYfjbjkv
	rqQ7gLJnyWc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0E4AE55F41;
	Tue, 12 Apr 2016 13:47:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 83A9A55F40;
	Tue, 12 Apr 2016 13:47:21 -0400 (EDT)
In-Reply-To: <1460234324-13506-3-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Sat, 9 Apr 2016 20:38:40 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9BA353A4-00D6-11E6-94F1-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291285>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> diff --git a/git-parse-remote.sh b/git-parse-remote.sh
> index 55fe8d5..c5e5840 100644
> --- a/git-parse-remote.sh
> +++ b/git-parse-remote.sh
> @@ -6,6 +6,9 @@
>  # this would fail in that case and would issue an error message.
>  GIT_DIR=$(git rev-parse -q --git-dir) || :;
>  
> +. git-sh-setup
> +. git-sh-i18n

This hunk should be dropped, I think.

The scriptlet is not meant to be used as a standalone command and is
designed to be always used with ". git-parse-remote".  The scripted
command that uses it would already have done the above two.

> @@ -68,22 +73,33 @@ error_on_missing_default_upstream () {
>  
>  	if test -z "$branch_name"
>  	then
> -		echo "You are not currently on a branch. Please specify which
> -branch you want to $op_type $op_prep. See git-${cmd}(1) for details.
> -
> -    $example
> -"
> +		gettextln "You are not currently on a branch."
> +		if test "$op_type" = rebase
> +		then
> +			gettextln "Please specify which branch you want to rebase against."
> +		else
> +			gettextln "Please specify which branch you want to merge with."
> +		fi

The original did not have to know $op_type can only be rebase or
merge, but this one hardcodes the assumption.  To make sure that
anybody who adds yet another way to rebase need to come up with a
phrasing that is suited for the new way, something like this would
be a good way to future-proof it.

	case "$op_type" in
        rebase)
        	... ;;
        merge)
        	... ;;
	*)
        	echo >&2 "BUG: ..."
                exit 1 ;;
	esac
