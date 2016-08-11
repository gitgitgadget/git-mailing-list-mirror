Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F25320193
	for <e@80x24.org>; Thu, 11 Aug 2016 18:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbcHKSgv (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 14:36:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52332 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750818AbcHKSgt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 14:36:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 68E863389E;
	Thu, 11 Aug 2016 14:36:48 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LO7UBf1jQ+Or3U24QyvfLlaw3t4=; b=EMZS/B
	0RauaTMIIeVJcbR2CDGIiYji1zVO6crS9fIbhfCCoxEQYfE/0eqZo9L5frZ3Rcmr
	jDUvL5v9YyM0OU5PvAXCjHpJNk/U+Nasufs1zkCfrSdKU1hJa9ltufXbuPLZf3Lq
	w8vKEfhDhbEEE7Cy7EuMBUa5V+naGnFUb+Nr0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k4uH/QZ5KFbS90/r9Ybhq1KchQtRm1QY
	4JBiFDoqCP2r6Jgm7iE706hk5srV2sypT/GP7GefxKWt+4vX+pE286GA9N2GDlm3
	+iY+GHa1pDawjJWkIt96oSzXuLWIU9EeYXlqsneduyX3euDNMyjn4mw43WKeJLEY
	FXk3z+ErX5w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F6433389D;
	Thu, 11 Aug 2016 14:36:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C516D3389C;
	Thu, 11 Aug 2016 14:36:47 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff Hostetler <git@jeffhostetler.com>
Cc:	git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 9/9] status: unit tests for --porcelain=v2
References: <1470926762-25394-1-git-send-email-git@jeffhostetler.com>
	<1470926762-25394-10-git-send-email-git@jeffhostetler.com>
Date:	Thu, 11 Aug 2016 11:36:45 -0700
In-Reply-To: <1470926762-25394-10-git-send-email-git@jeffhostetler.com> (Jeff
	Hostetler's message of "Thu, 11 Aug 2016 10:46:02 -0400")
Message-ID: <xmqqtwer17b6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FA6B6B0-5FF2-11E6-AE72-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Test porcelain v2 status format.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  t/t7064-wtstatus-pv2.sh | 576 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 576 insertions(+)
>  create mode 100755 t/t7064-wtstatus-pv2.sh
>
> diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
> new file mode 100755
> index 0000000..44a8671
> --- /dev/null
> +++ b/t/t7064-wtstatus-pv2.sh
> @@ -0,0 +1,576 @@
> +#!/bin/sh
> +
> +test_description='git status --porcelain=v2
> +
> +This test exercises porcelain V2 output for git status.'

A general comment on the titles; with retitling of individual tests,
the result has become a lot easier to understand.  I know coming up
with a short and to-the-point description for them is hard, but that
is effort and time well spent and it shows in the result.  Thanks.

> +. ./test-lib.sh
> +
> +OID_EMPTY=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391

It seems that test-lib.sh these days has EMPTY_BLOB defined for your
use.  You can remove this and replace its use (just two lines) with
$EMPTY_BLOB down in the "add -N" test.

> +test_expect_success setup '
> +	test_tick &&
> +	git config --local core.autocrlf false &&

I'd suggest removing "--local".

Existing use of "git config" in the test suite, unless their use is
about testing "git config" itself to validate the operation of the
--local/--global/--system options, do not seem to explicitly say
"--local", which is the default anyway.

> +test_expect_success 'after first commit, make dirt, confirm unstaged changes' '

Did you mean s/dirt/dirty/?  "make and confirm unstaged changes"
would be sufficient.  Because "confirming" is implicit (as these
are all tests), "after the first commit, modify working tree files"
might even be better, perhaps?

> +	echo x >>file_x &&
> +	OID_X1=$(git hash-object -t blob -- file_x) &&
> +	rm file_z &&
> +	H0=$(git rev-parse HEAD) &&
> + ...

> +test_expect_success 'after first commit, stage dirt, confirm staged changes' '

What you "git add" is meant to be good changes, so they are no
longer dirt ;-)  More importantly, because I never heard of "dirt"
used in Git context, it is unclear if it is an untracked file, a
modification that is not meant to be committed immediately, or what.

"after the first commit, fully add changes to the index"?

> +	git add file_x &&
> +	git rm file_z &&
> +	H0=$(git rev-parse HEAD) &&
> +
> +	cat >expect <<-EOF &&
> +	# branch.oid $H0
> +	# branch.head master
> +	1 M. N... 100644 100644 100644 $OID_X $OID_X1 file_x
> +	1 D. N... 100644 000000 000000 $OID_Z $_z40 file_z
> +	? actual
> +	? expect
> +	EOF

> +test_expect_success 'after first commit, also stage rename, confirm 2 path line format' '
> +	git mv file_y renamed_y &&
> +	H0=$(git rev-parse HEAD) &&
> +
> +	q_to_tab >expect <<-EOF &&
> +	# branch.oid $H0
> +	# branch.head master
> +	1 M. N... 100644 100644 100644 $OID_X $OID_X1 file_x
> +	1 D. N... 100644 000000 000000 $OID_Z $_z40 file_z
> +	2 R. N... 100644 100644 100644 $OID_Y $OID_Y R100 renamed_yQfile_y
> +	? actual
> +	? expect
> +	EOF
> +
> +	git status --porcelain=v2 --branch --untracked-files=all >actual &&
> +	test_cmp expect actual
> +'

Do we want to test -z format on this, too?

> ...
> +test_expect_success 'create ignored files, confirm they are not printed' '
> +test_expect_success 'create ignored files, confirm --ignored prints them' '
> ...

These are all good and readably titled. 

> +test_expect_success 'verify upstream fields in branch header' '
> +	git checkout master &&
> +	test_when_finished rm -rf sub_repo &&

Forgot to quote?
