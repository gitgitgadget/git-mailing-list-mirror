From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git_mkstemps: correctly test return value of open()
Date: Thu, 18 Jul 2013 16:23:05 -0700
Message-ID: <7vhafr1mhy.fsf@alter.siamese.dyndns.org>
References: <cover.1373618940.git.trast@inf.ethz.ch>
	<9af38018d55c95a6807d305bb3a088e48916baac.1373618940.git.trast@inf.ethz.ch>
	<878v16kfqy.fsf@linux-k42r.v.cablecom.net>
	<7v38rd6l3j.fsf@alter.siamese.dyndns.org> <51E7E05E.4000201@gmail.com>
	<7v4nbr4v7m.fsf@alter.siamese.dyndns.org>
	<201307182032.r6IKWtWC016218@freeze.ariadne.com>
	<CAPc5daVVDCHqjyDV3zYVV33EFYjea7ge84+CE=M=QXagxnHd-A@mail.gmail.com>
	<201307182246.r6IMkDiW021930@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: n1xim.email@gmail.com, trast@inf.ethz.ch, git@vger.kernel.org,
	fonseca@diku.dk
To: worley@alum.mit.edu (Dale R. Worley)
X-From: git-owner@vger.kernel.org Fri Jul 19 01:23:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzxXZ-0004s9-OS
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 01:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934837Ab3GRXXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 19:23:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53003 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934805Ab3GRXXI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 19:23:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C873E32AB2;
	Thu, 18 Jul 2013 23:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yIJbgwKnSGuXXVRjEE55hDlCj9g=; b=fjs7WO
	zYWuZLrd7eI0SjNZmx5nJi2OWdVnkoWjOMhvGINLe/5hlKZjBSnVosQdw8THqAMI
	erAIffY0hG5pV23DGzDWwT8dMkxDWWnlIVV0NsiA/pjB1yELanM9hwuexwK/5tka
	AmjiobMZzceA2bGwuJ42v6lpnDNBLeQxeJb3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D6LOgG3GWEFISX1SiqzAVhccxfb+dqLb
	DC7ogbANvvNZghGRa+iRCtYB2t4dOVWXspcRHuuQQsKjaxdFHC71XTSxhPDmt7dY
	Gwn4ymZ9Hc+TZVRBq1fYjmi4pkuZWbh/X45tidtQ2U/uZtuL7dr4ZvEiGz/RRf6z
	PP8Jhqsdqxo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBC1E32AB1;
	Thu, 18 Jul 2013 23:23:07 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09FEF32AB0;
	Thu, 18 Jul 2013 23:23:06 +0000 (UTC)
In-Reply-To: <201307182246.r6IMkDiW021930@freeze.ariadne.com> (Dale
	R. Worley's message of "Thu, 18 Jul 2013 18:46:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 009E0F5E-F001-11E2-A227-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230764>

worley@alum.mit.edu (Dale R. Worley) writes:

>> From: Junio C Hamano <gitster@pobox.com>
>> 
>> That's just a plain-vanilla part of POSIX shell behaviour, no?
>> 
>> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_07_05
>
> "Close standard input" is so weird I never thought it was Posix.  In
> that case, we can eliminate the C helper program:
>
> diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
> index 986b2a8..d427f3a 100755
> --- a/t/t0070-fundamental.sh
> +++ b/t/t0070-fundamental.sh
> @@ -25,6 +25,13 @@ test_expect_success POSIXPERM,SANITY 'mktemp to unwritable directory prints file
>  	grep "cannotwrite/test" err
>  '
>  
> +test_expect_success 'git_mkstemps_mode does not fail if fd 0 is not open' '
> +	git init &&
> +	echo Test. >test-file &&
> +	git add test-file &&
> +	git commit -m Message. <&-
> +'
> +

Yup.  I wonder how it would fail without the fix, though ;-)

>  test_expect_success 'check for a bug in the regex routines' '
>  	# if this test fails, re-build git with NO_REGEX=1
>  	test-regex
> diff --git a/wrapper.c b/wrapper.c
> index dd7ecbb..6a015de 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -322,7 +322,7 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
>  		template[5] = letters[v % num_letters]; v /= num_letters;
>  
>  		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
> -		if (fd > 0)
> +		if (fd >= 0)
>  			return fd;
>  		/*
>  		 * Fatal error (EPERM, ENOSPC etc).
>
> Is this a sensible place to put this test?
>
> Dale
