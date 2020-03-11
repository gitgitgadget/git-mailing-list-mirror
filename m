Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5381C0044D
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 22:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3B2206E7
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 22:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vlYBrGZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbgCKWG3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:06:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56863 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbgCKWG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 18:06:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE3CF4896E;
        Wed, 11 Mar 2020 18:06:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vlmR8bye30ar
        5fA5SeABPtX7h6U=; b=vlYBrGZg/jPlfwajSN6jjKkd+tgvKDalaVrnlYzqfZ0i
        zG0b75/C2ZeFxI79FKZR/1kyZNKMS02Ro/J4jncHv3pjrb3FPza+VXXFksxTSCgE
        ePnhYG+NYox/WVgshnakSMJSHZr+r7/YaIfLYk+J7s3Mck5mUEcc7HBfYkZQGRY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vfCJpO
        rP3EvE65zvdEGLmYqxz9hzlip6bchyZa4GWsE59ZD4NEEVLLFgjGRspdUbExhHRx
        0wKmjO/4jk6qzxXrceUsmZ2cVgWdApWu/q8cwbYlCq5d1DifU2DgeYy59qbP4tL5
        nO4Dl9A/+lZzAA9JGj2VE6wauYm5IyHBEATio=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B4C364896D;
        Wed, 11 Mar 2020 18:06:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B3284896C;
        Wed, 11 Mar 2020 18:06:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Git'" <git@vger.kernel.org>
Subject: Re: [Test] t1901 - sparse checkout file when lock is taken fails (subtest 19)
References: <011401d5f6e9$de7eea50$9b7cbef0$@nexbridge.com>
Date:   Wed, 11 Mar 2020 15:06:25 -0700
In-Reply-To: <011401d5f6e9$de7eea50$9b7cbef0$@nexbridge.com> (Randall
        S. Becker's message of "Tue, 10 Mar 2020 10:40:34 -0400")
Message-ID: <xmqqwo7qfswu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8D4D9506-63E4-11EA-8172-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> This situation still occurs at 2.26.0-rc0. As above, this results from =
a
> text compare to a platform-specific message that should not be used. To=
 hack
> around it, a possible fix (which I don't like) could be as follows:

Martin's fix 4605a730 (t1091: don't grep for `strerror()` string,
2020-03-08) was merged to 'next' on the 9th and then down to
'master' today, and will be in the final (unless there is some
issues with it, which I do not think will be the case).

Thanks.

-- >8 --
From: Martin =C3=85gren <martin.agren@gmail.com>
Subject: [PATCH] t1091: don't grep for `strerror()` string

We grep for "File exists" in stderr of the failing `git sparse-checkout`
to make sure that it failed for the right reason. We expect the string
to show up there since we call `strerror(errno)` in
`unable_to_lock_message()` in lockfile.c.

On the NonStop platform, this fails because the error string is "File
already exists", which doesn't match our grepping.

See 9042140097 ("test-dir-iterator: do not assume errno values",
2019-07-30) for a somewhat similar fix. There, we patched a test helper,
which meant we had access to `errno` and could investigate it better in
the test helper instead of just outputting the numerical value and
evaluating it in the test script. The current situation is different,
since (short of modifying the lockfile machinery, e.g., to be more
verbose) we don't have more than the output from `strerror()` available.

Except we do: We prefix `strerror(errno)` with `_("Unable to create
'%s.lock': ")`. Let's grep for that part instead. It verifies that we
were indeed unable to create the lock file. (If that fails for some
other reason than the file existing, we really really should expect
other tests to fail as well.)

An alternative fix would be to loosen the expression a bit and grep for
"File.* exists" instead. There would be no guarantee that some other
implementation couldn't come up with another error string, That is, that
could be the first move in an endless game of whack-a-mole. Of course,
it could also take us from "99" to "100" percent of the platforms and
we'd never have this problem again. But since we have another way of
addressing this, let's not even try the "loosen it up a bit" strategy.

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
Acked-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1091-sparse-checkout-builtin.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout=
-builtin.sh
index b4c9c32a03..44a91205d6 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -305,7 +305,7 @@ test_expect_success 'fail when lock is taken' '
 	test_when_finished rm -rf repo/.git/info/sparse-checkout.lock &&
 	touch repo/.git/info/sparse-checkout.lock &&
 	test_must_fail git -C repo sparse-checkout set deep 2>err &&
-	test_i18ngrep "File exists" err
+	test_i18ngrep "Unable to create .*\.lock" err
 '
=20
 test_expect_success '.gitignore should not warn about cone mode' '
--=20
2.26.0-rc1-6-ga56d361f66

