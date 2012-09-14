From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 11/11] t7810-grep: test --all-match with multiple
 --grep and --author options
Date: Fri, 14 Sep 2012 11:01:09 -0700
Message-ID: <7vtxv04h7e.fsf@alter.siamese.dyndns.org>
References: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
 <cover.1347615361.git.git@drmicha.warpmail.net>
 <155f30ede8a788c599189af677936b15fabf041b.1347615361.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 14 20:01:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCaCh-0001uB-UX
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 20:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142Ab2INSBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 14:01:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55117 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751782Ab2INSBN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 14:01:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33B9D9B2D;
	Fri, 14 Sep 2012 14:01:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QEZywE3DjWvZSwZa/FL58dz/798=; b=Qo0w7P
	cBAPH7C58nm6aVMCuu5ATJjHw/HllyY1ai06VO4LhjSTa58iEwRcEJZbYg4QyT5l
	04ZNhvjq9gw3Fs1uxBKf6tvda7h7/OvzAvWS17Ru/Id1MAuB3gzWxU6JqF7ZVLT6
	mhP40HToc5rLE+k403yR2zdCv9ZjvQSbIWvtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cFMEgUalHfrIvnhY0Ocn1XPWQiSj3Ads
	/ChqQdrwpkZG/S2WERS3NrSo6cgqHQX0fMwhKiqrQOIM8XoiTtwysorgj/DBwuvi
	dNhLvtZcnjKStQkC5xpxBgfri0iBAILbFy5LYxCTOiUIgAtZ2leZwncMZan3DAYv
	3C4P7u6Hi1o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20EE89B2A;
	Fri, 14 Sep 2012 14:01:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AE549B28; Fri, 14 Sep 2012
 14:01:12 -0400 (EDT)
In-Reply-To: <155f30ede8a788c599189af677936b15fabf041b.1347615361.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri, 14 Sep 2012 11:46:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B6F6D02-FE96-11E1-AEBB-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205520>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> --all-match is ignored with multiple author options on purpose but
> requires all --grep to be matched on some line.

It is more like "the behaviour of --all-match to tie more than one --grep
used to be broken when --author or --committer is used".

>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  t/t7810-grep.sh | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index f6edb4d..b5c488e 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -531,6 +531,16 @@ test_expect_success 'log --grep --grep --author takes union of greps and interse
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'log ---all-match -grep --author --author still takes union of authors and intersects with grep' '
> +	# grep matches only initial and third
> +	# author matches all but second
> +	git log --all-match --author="Thor" --author="Night" --grep=i --format=%s >actual &&
> +	{
> +	    echo third && echo initial
> +	} >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'log --grep --author --author takes union of authors and intersects with grep' '
>  	# grep matches only initial and third
>  	# author matches all but second
> @@ -541,6 +551,16 @@ test_expect_success 'log --grep --author --author takes union of authors and int
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'log --all-match --grep --grep --author takes intersection' '
> +	# grep matches only third
> +	# author matches only initial and third
> +	git log --all-match --author="A U Thor" --grep=i --grep=r --format=%s >actual &&
> +	{
> +		echo third
> +	} >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'grep with CE_VALID file' '
>  	git update-index --assume-unchanged t/t &&
>  	rm t/t &&
