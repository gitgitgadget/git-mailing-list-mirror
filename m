From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t2203,t4011: adjust to changed intent-to-add treatment
Date: Sun, 15 Mar 2015 00:07:44 -0700
Message-ID: <xmqqegoqviv3.fsf@gitster.dls.corp.google.com>
References: <1425910445-27383-1-git-send-email-pclouds@gmail.com>
	<40da6c2f97f836acbaa654f470a007e06a47a22e.1425915714.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Mar 15 08:07:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YX2eN-000347-Gj
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 08:07:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbbCOHHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 03:07:47 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751054AbbCOHHq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 03:07:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D94AA387C1;
	Sun, 15 Mar 2015 03:07:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NCYrCnP9OEWiXe1aH7jfybFnV1s=; b=lwj9Dw
	NbObaN9eXW+8JDQZOKgz2eQFYLQGRDH6RiVgKG12ZAuGiIegJ0FT4UTN3173v7OA
	QMHt0yMccLGFSkKgYCHsSXMoBGpAFBeLUlCDdRgokZqdBaCERdR/pxuxGjI7IkBQ
	JpI4Ck5ZNd25HAo+1uJKwzVrLzNtRw5ePtaCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BSLBtLlACExUCZKmeUbfHZ/HkOj/NKXF
	tme0R72QcRC3eNMT5cV5zfBm9i5OlTMVD2G4UOMwSVmmeuBHkFaAI6ptHnCoNcNA
	J/FSViiEnhgzaIrqsXq4v9PkbQHB0dzbVivQjiHJzdfcmHyxpzhU2XfVUayLzjQz
	U06t/P9xQqg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D0F88387BF;
	Sun, 15 Mar 2015 03:07:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 581D2387BE;
	Sun, 15 Mar 2015 03:07:45 -0400 (EDT)
In-Reply-To: <40da6c2f97f836acbaa654f470a007e06a47a22e.1425915714.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Mon, 9 Mar 2015 16:45:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FAE5CF58-CAE1-11E4-9FD1-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265483>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> For the record, the tests would need to change like this, and it makes
> a lot of sense. After the change, "i-t-a" is not a "change staged in
> the index" any more - and in fact in never was, as "git commit" shows.

Perhaps another follow-up patch can illustrate how these entries
should show "git status", both in the longform and -s output?



>
>  t/t2203-add-intent.sh   |  7 ++++---
>  t/t4011-diff-symlink.sh | 10 ++++++----
>  2 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
> index 2a4a749..1a9b3c4 100755
> --- a/t/t2203-add-intent.sh
> +++ b/t/t2203-add-intent.sh
> @@ -43,7 +43,8 @@ test_expect_success 'i-t-a entry is simply ignored' '
>  	git add -N nitfol &&
>  	git commit -m second &&
>  	test $(git ls-tree HEAD -- nitfol | wc -l) = 0 &&
> -	test $(git diff --name-only HEAD -- nitfol | wc -l) = 1
> +	test $(git diff --name-only HEAD -- nitfol | wc -l) = 0 &&
> +	test $(git diff --name-only -- nitfol | wc -l) = 1
>  '
>  
>  test_expect_success 'can commit with an unrelated i-t-a entry in index' '
> @@ -71,13 +72,13 @@ test_expect_success 'cache-tree invalidates i-t-a paths' '
>  
>  	: >dir/bar &&
>  	git add -N dir/bar &&
> -	git diff --cached --name-only >actual &&
> +	git diff --name-only >actual &&
>  	echo dir/bar >expect &&
>  	test_cmp expect actual &&
>  
>  	git write-tree >/dev/null &&
>  
> -	git diff --cached --name-only >actual &&
> +	git diff --name-only >actual &&
>  	echo dir/bar >expect &&
>  	test_cmp expect actual
>  '
> diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
> index 13e7f62..7452fce 100755
> --- a/t/t4011-diff-symlink.sh
> +++ b/t/t4011-diff-symlink.sh
> @@ -139,11 +139,13 @@ test_expect_success SYMLINKS 'setup symlinks with attributes' '
>  test_expect_success SYMLINKS 'symlinks do not respect userdiff config by path' '
>  	cat >expect <<-\EOF &&
>  	diff --git a/file.bin b/file.bin
> -	index e69de29..d95f3ad 100644
> -	Binary files a/file.bin and b/file.bin differ
> +	new file mode 100644
> +	index 0000000..d95f3ad
> +	Binary files /dev/null and b/file.bin differ
>  	diff --git a/link.bin b/link.bin
> -	index e69de29..dce41ec 120000
> -	--- a/link.bin
> +	new file mode 120000
> +	index 0000000..dce41ec
> +	--- /dev/null
>  	+++ b/link.bin
>  	@@ -0,0 +1 @@
>  	+file.bin
