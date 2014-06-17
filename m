From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 1/4] commit test: Use test_config instead of git-config
Date: Tue, 17 Jun 2014 14:31:29 -0700
Message-ID: <xmqq8uovkytq.fsf@gitster.dls.corp.google.com>
References: <cover.1403033723.git.caleb@calebthompson.io>
	<a7aa2efcb6a2beba973c389f5c7afbce79ec9747.1403033723.git.caleb@calebthompson.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jeremiah Mahler <jmmahler@gmail.com>
To: Caleb Thompson <caleb@calebthompson.io>
X-From: git-owner@vger.kernel.org Tue Jun 17 23:31:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wx0yk-0000JM-9M
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 23:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbaFQVbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 17:31:36 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56593 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964852AbaFQVbg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 17:31:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3D9451F731;
	Tue, 17 Jun 2014 17:31:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mjn2QiHfDQMPLrIV3436CNZZ0k4=; b=WPGS2a
	iFq7J2WvBXzMc/9lncZ5bS6pHN+0q4Ff4BfOQ/bZDTe6b2O0/vB44p3P+kSKlWqG
	hus7BMYUgbA+DNmB38w1vbWp9aFKm9LBfYS4gUxqtAcEYMXNsNALmrAmhjhqEJDO
	hPwbMvJVmSPNKyswG5ctEdhEBZxxoaUO04EaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FhCMWAYBW5RO7jjLtR22LLGVWLcf5Cyn
	iOKUcNx+FKS26QVBKBD4MYGGkkmErS/fhWXcoZfLqeQYZuD+bflj5xxSUXE8r048
	t6h2KF/AAnFjjOADoFEV4B758dZ8CWlclhfgoGzLVZ91B/FUX/Ibp+/ErN/p7bzy
	ka7q7hjfQl0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3071E1F730;
	Tue, 17 Jun 2014 17:31:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E6C221F728;
	Tue, 17 Jun 2014 17:31:28 -0400 (EDT)
In-Reply-To: <a7aa2efcb6a2beba973c389f5c7afbce79ec9747.1403033723.git.caleb@calebthompson.io>
	(Caleb Thompson's message of "Tue, 17 Jun 2014 14:38:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BE365F32-F666-11E3-86AD-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251954>

Caleb Thompson <caleb@calebthompson.io> writes:

> Some of the tests in t/t7507-commit-verbose.sh were still using
> git-config to set configuration. Change them to use the test_config
> helper.

"were still using" is only a half of the story, and we need to be
more careful than that, though.

> Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
> Reviewed-by: Jeremiah Mahler <jmmahler@gmail.com>
> ---
>  t/t7507-commit-verbose.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> index 2ddf28c..6d778ed 100755
> --- a/t/t7507-commit-verbose.sh
> +++ b/t/t7507-commit-verbose.sh
> @@ -43,7 +43,7 @@ test_expect_success 'verbose diff is stripped out' '
>  '
>  
>  test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
> -	git config diff.mnemonicprefix true &&
> +	test_config diff.mnemonicprefix true &&

By switching to test_config, you unconfigure the diff.mnemonicprefix
configuration after this test piece is done.  The next one, "diff in
message is retained with -v", used to show the change using c/ and
i/ as prefixes in the log editor, but now it should be showing a/
and b/.

Have you thought about the reason why the log message used in that
test uses c/ and i/ prefixes as a sample patch to be retained,
instead of a/ and b/ prefixes?  It is to make sure that this
in-message patch looks similar to the diff for "--verbose" option,
and we used to do the latter under mnemonicprefix.  That way, we
would be more sure that an incorrect implementation that cuts the
result given from the editor at "diff --git $srcprefix/" will fail
the test.

This is the kind of thing I mean by "we need to be more careful".

If somebody who is doing "git config to test_config" conversion
understands what he is doing, I would have expected to see that
these c/ and i/ prefixes in the sample log message are replaced
to use a/ and b/ prefixes.

>  	git commit --amend -v &&
>  	check_message message
>  '
> @@ -71,7 +71,7 @@ test_expect_success 'diff in message is retained with -v' '
>  '
>  
>  test_expect_success 'submodule log is stripped out too with -v' '
> -	git config diff.submodule log &&
> +	test_config diff.submodule log &&
>  	git submodule add ./. sub &&
>  	git commit -m "sub added" &&
>  	(

Can we make a similar reasoning on possible fallout from this
change?  An expected answer would be something like:

    The remaining test pieces after this one does not make any
    change before running "commit -a -v", so having diff.submodule
    set to log or unset does not make any difference to them.
