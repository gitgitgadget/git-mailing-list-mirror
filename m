From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/12] t5524: test --log=1 limits shortlog length
Date: Thu, 07 May 2015 10:28:25 -0700
Message-ID: <xmqqbnhwqoue.fsf@gitster.dls.corp.google.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-12-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 19:28:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqPb6-0000rc-T9
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 19:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbbEGR22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 13:28:28 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64266 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750780AbbEGR21 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 13:28:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 000944D076;
	Thu,  7 May 2015 13:28:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sc3j9nr2NgaO4jFNJvYrTZXMRF4=; b=NUPMBj
	rtFhK4QbG2ZscOSs+J6THpNvWg9ZGhuYI0wZLFW18n+H3b7kRfiLMqeth7Gx8JkT
	FuRznuV8YCn15QMn5wQSvtshrpyANFmgarlnYa+ENR460sKBX6zg1dbzMiqDYoCU
	g/XNc9t6u88wFxkgS9q0JCxwjZJY/67QKCbVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QT6JC09qyKljKLRYiXQ5d0jmrFOCcYIw
	9J6QjX31+oDORzzPb+TQrxrFsRnleS8Q0gbgKPKzGnX/eqE9caXjXMoa2I8oEgJm
	l19GTKAfSkO78BzHRtCkP7SOvmOmLg8ilX5uRUXXvfi/Icd4XgFitN5mVAViFyiv
	x254knn484Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA1D34D075;
	Thu,  7 May 2015 13:28:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 649BA4D06E;
	Thu,  7 May 2015 13:28:26 -0400 (EDT)
In-Reply-To: <1430988248-18285-12-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Thu, 7 May 2015 16:44:07 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 78301614-F4DE-11E4-977F-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268560>

Paul Tan <pyokagan@gmail.com> writes:

> While git-pull supports --log and passes the switch to git-merge, it
> does not support --log=<n>, ignoring the value <n>.
>
> This is not only at odds with the documentation of git-pull, it's also a
> undesirable limitation as <n> could simply be passed to git-merge as
> well.

A cleaner alternative may be to fix that while git-pull is still a
script, as you seem to already know what is broken and what in the
current code needs to be fixed in what way exactly.  Perhaps do that
at the earlier part of (or even as an independent patch outside)
this series and add this test to protect the fix from getting broken
later (with expect-failure flipped to expect-success)?

Thanks.

>
> Implement a failing test that demonstrates this.



>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>
> Notes:
>     * Added this test to the patch series
>
>  t/t5524-pull-msg.sh | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
> index 8cccecc..5b7af07 100755
> --- a/t/t5524-pull-msg.sh
> +++ b/t/t5524-pull-msg.sh
> @@ -17,6 +17,9 @@ test_expect_success setup '
>  		git commit -m "add bfile"
>  	) &&
>  	test_tick && test_tick &&
> +	echo "second" >afile &&
> +	git add afile &&
> +	git commit -m "second commit" &&
>  	echo "original $dollar" >afile &&
>  	git add afile &&
>  	git commit -m "do not clobber $dollar signs"
> @@ -32,4 +35,18 @@ test_expect_success pull '
>  )
>  '
>  
> +test_expect_failure '--log=1 limits shortlog length' '
> +(
> +	cd cloned &&
> +	git reset --hard HEAD^ &&
> +	test `cat afile` = original &&
> +	test `cat bfile` = added &&
> +	git pull --log &&
> +	git log -3 &&
> +	git cat-file commit HEAD >result &&
> +	grep Dollar result &&
> +	! grep "second commit" result
> +)
> +'
> +
>  test_done
