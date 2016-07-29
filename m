Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1842C1F855
	for <e@80x24.org>; Fri, 29 Jul 2016 21:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbcG2V5a (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 17:57:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754058AbcG2V53 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2016 17:57:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8317E30F94;
	Fri, 29 Jul 2016 17:57:27 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1YHbNWxoi7G1
	Z4/SrNUYSlbbJ4w=; b=KW8FJza+CwijLGLFzR9YJjv6g7pZnwhQ1GVrfJzHlfkX
	wMkYG3caOIH1MkNhh1l/b0ukLHEalifRUXJuOBcwnxTeeBdeCw5FfIiv+zx7abTk
	nrnnWS8OC1pbV4Y844fBp1CC5+R+ppE81YW+/MObPpCCC2SZ5DFLVUZtemcZ9M4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qNxZKQ
	UevTcA3YOCF7wSDExRGUoREJoBx3iwv5pMs/IMyKC0FmNXBrq7cx/cdyNHZ2ejAu
	w73iCAcQWiIOs6spXbLVv69whzZcQ0cqGmqn03zb71PZa76YCJBh5Eco00Ccm1Cf
	thFv5yjws79/n3dDeG9f0VKnNq50Xgar8yP+Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C40130F93;
	Fri, 29 Jul 2016 17:57:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 00A5930F91;
	Fri, 29 Jul 2016 17:57:26 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Enhance test t3700-add.sh
References: <579bc6ca.10e2ad4d.bm000@wupperonline.de>
Date:	Fri, 29 Jul 2016 14:57:24 -0700
In-Reply-To: <579bc6ca.10e2ad4d.bm000@wupperonline.de> ("Ingo =?utf-8?Q?Br?=
 =?utf-8?Q?=C3=BCckl=22's?=
	message of "Fri, 29 Jul 2016 23:09:52 +0200")
Message-ID: <xmqq60rom7jv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 70338616-55D7-11E6-A65F-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ingo Brückl <ib@wupperonline.de> writes:

> Subject: Re: [PATCH v2 1/3] Enhance test t3700-add.sh
>
> The files to be tested may already exist and be links which will make
> the test fail. So ensure that we are working in a clean environment.

"Enhance", like "Update" or "Change", is a more-or-less useless
noiseword in a commit title; it does not say much about in what way
it was enhanced.

If we clarify the body of the explanation, a better word emerges, I
would think.  How about this instead?

	t3700: remove unwanted leftover files before running new tests

	When an earlier test that has prerequisite is skipped, files
	used by later tests may be left in the working tree in an
	unexpected state.  For example, a test runs this sequence:

		echo foo >xfoo1 && chmod 755 xfoo1

	to create an executable file xfoo1, expecting that xfoo1
	does not exist before it runs in the test sequence.
	However, the absense of this file depends on "git reset
	--hard" done in an earlier test, that is skipped when SANITY
	prerequisite is not met, and worse yet, xfoo1 originally is
	created as a symbolic link, which means the chmod does not
	affect the modes of xfoo1 as this test expects.

	Fix this by starting the test with "rm -f xfoo1" to make
	sure the file is created from scratch, and do the same to
	other similar tests.

>
> Signed-off-by: Ingo Brückl <ib@wupperonline.de>
> ---
>  t/t3700-add.sh | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index 4865304..494f5b8 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -333,6 +333,7 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file out
>  '
>
>  test_expect_success 'git add --chmod=+x stages a non-executable file with +x' '
> +	rm -f foo1 &&
>  	echo foo >foo1 &&
>  	git add --chmod=+x foo1 &&
>  	case "$(git ls-files --stage foo1)" in
> @@ -342,6 +343,7 @@ test_expect_success 'git add --chmod=+x stages a non-executable file with +x' '
>  '
>
>  test_expect_success 'git add --chmod=-x stages an executable file with -x' '
> +	rm -f xfoo1 &&
>  	echo foo >xfoo1 &&
>  	chmod 755 xfoo1 &&
>  	git add --chmod=-x xfoo1 &&
> @@ -354,6 +356,7 @@ test_expect_success 'git add --chmod=-x stages an executable file with -x' '
>  test_expect_success POSIXPERM,SYMLINKS 'git add --chmod=+x with symlinks' '
>  	git config core.filemode 1 &&
>  	git config core.symlinks 1 &&
> +	rm -f foo2 &&
>  	echo foo >foo2 &&
>  	git add --chmod=+x foo2 &&
>  	case "$(git ls-files --stage foo2)" in
> --
> 2.9.2
