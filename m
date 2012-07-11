From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] t4012: Make --shortstat more robust
Date: Wed, 11 Jul 2012 15:35:44 -0700
Message-ID: <7vr4sic4e7.fsf@alter.siamese.dyndns.org>
References: <20120711221327.GA21382@akuma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Alexander Strasser <eclipse7@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 00:35:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp5Vj-0004PM-SV
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 00:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447Ab2GKWfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 18:35:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43832 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030355Ab2GKWft (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 18:35:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3566E5854;
	Wed, 11 Jul 2012 18:35:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tMYXpAXsjvxlbG6zghoSfVpSJtw=; b=rvQMn0
	CeJuw+S2spbghpl723TSNvnfaimPQr75mLQM6HHmzZr/w6eyHl/cqCo0aapyTK/8
	S82SDgjUFJ9dNt3bCV1pWmwHWGF/q8M1QseNIo04c0FqSg1nIXtGXoKIH7xYFtM5
	ezJWCZsajhm5ku+bVLw8BXHRJ6rb9obc7ew5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FLIy2/Wp4PeeQidml7iP4uO+2ER8gvZI
	5StUqgdT0B2Sv5XUHoWIFjfDaBKxIklImNs0MYhutxTIWEX2h4Gth+VncOyPCpIQ
	i+p3yNH3E8BMyon0gAAbz3moqlPnvcYvfIp7YbO3vG2R320Zok/o//x6MZP7JV02
	9cAMoCp2VzY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C45D5853;
	Wed, 11 Jul 2012 18:35:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F2E85852; Wed, 11 Jul 2012
 18:35:45 -0400 (EDT)
In-Reply-To: <20120711221327.GA21382@akuma> (Alexander Strasser's message of
 "Thu, 12 Jul 2012 00:13:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C1598788-CBA8-11E1-9A3F-C3672E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201343>

Alexander Strasser <eclipse7@gmx.net> writes:

> The --shortstat test depends on the same scenario as the --stat
> test. Use the part of the same expected result for the --stat test
> to avoid duplicating it manually.

> diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
> index 81a9e8c..a3f6030 100755
> --- a/t/t4012-diff-binary.sh
> +++ b/t/t4012-diff-binary.sh
> @@ -38,9 +38,9 @@ test_expect_success 'apply --stat output for binary file change' '
>  '
>  
>  test_expect_success 'diff --shortstat output for binary file change' '
> -	echo " 4 files changed, 2 insertions(+), 2 deletions(-)" >expected &&
> +	tail -1 expected >expect &&

"(tail|head) -n 1" is preferred.  There are the same POSIX.1
violations in a handful of other scripts, 5526, 7502, 7800 and
9146.

>  	git diff --shortstat >current &&
> -	test_i18ncmp expected current
> +	test_i18ncmp expect current
>  '
>  
>  test_expect_success 'diff --shortstat output for binary file change only' '

Other than that, the series looked good.  Thanks.
