Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9ADC4727E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 18:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1ABA20878
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 18:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BdHDRCQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbgIYSio (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 14:38:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54071 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgIYSio (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 14:38:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0EE94F33E1;
        Fri, 25 Sep 2020 14:38:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=muMFpFRvqyxgs88DVrV8/IWkul4=; b=BdHDRC
        QLn0TpeOjQyUeuTxQEPxj7fyoesZPqVO290NIIlCaCiSquBM44NXh871QCkSPYFF
        t4ypKrUGEKnUxpFIfCGPp1fqB1GP3apRUYN0wck+0vZ/wtkzVeo1cIRZ8/H/PSdT
        c9GKsKHYpxIWGtB1UH91vvTFHPRyI3c8jVvRg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ta88lssaa0CjQKBY3kg5B3f3dgvqlKsr
        0jwICVzc1UoWNTUxULMmg8MaS+4HmWVzdt2rD54sR2v5Wm/djLLXSXcZcz5HXCD4
        Y9XycSxuW9omPSh0y2NBqtL8t6dvOOYvmwCmmTlXM5yAQd68+5Bg3cxb3GP7D/0M
        8w8L1N5gUIA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0636BF33E0;
        Fri, 25 Sep 2020 14:38:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7568EF33DE;
        Fri, 25 Sep 2020 14:38:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?= =?utf-8?B?Zw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 10/10] hashmap_for_each_entry(): work around MSVC's
 run-time check failure #3
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>
        <dc46d39611df4ebd90d9308364d887e638c1bc30.1601044119.git.gitgitgadget@gmail.com>
Date:   Fri, 25 Sep 2020 11:38:35 -0700
In-Reply-To: <dc46d39611df4ebd90d9308364d887e638c1bc30.1601044119.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 25 Sep 2020
        14:28:38 +0000")
Message-ID: <xmqq8scxln10.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5321AABE-FF5E-11EA-BE8B-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When compiling Git in Visual C, we do not have the luxury of
> support for `typeof()`, and therefore `OFFSETOF_VAR()` unfortunately
> has to fall back to pointer arithmetic.

Sigh.

Short of changing the signature of hashmap_put_entry() and friends
to also take the type of these variables, I do not see any kosher
way to reimplement the users of OFFSETOF_VAR() to help compilers
without typeof() offhand.  As a one-time annotation, the unfortunate
noise we see in this patch may be tolerable, but what may make this
approach unsustainable is that average programmers would not know,
without compiling with that particular compiler, if their new
variable that points at a hash_entry needs to have an oterwise
unnecessary initialization.  Also the variables that are left
uninitialized by this patch may later require such an initialization.

Of course, it does not help that this workaround relies on an
undefined behaviour, as you pointed out.

> When compiling code using the `hashmap_for_each_entry()` macro in Debug
> mode, this leads to the "run-time check failure #3" because the variable
> passed as `var` are not initialized, yet we calculate the pointer
> difference `&(var->member)-var`.

Whoa, wait.  If it is just that macro, can we perhaps do something
like the attached patch?

>
> This "run-time check failure" causes a scary dialog to pop up.
>
> Work around this by initializing the respective variables.
>
> Note: according to the C standard, performing pointer arithmetic
> with `NULL` is not exactly well-defined, but it seems to work
> here, and it is at least better than performing pointer arithmetic
> with an uninitialized pointer.

 hashmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hashmap.h b/hashmap.h
index ef220de4c6..49cd8a8e92 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -449,7 +449,7 @@ static inline struct hashmap_entry *hashmap_iter_first(struct hashmap *map,
  * containing a @member which is a "struct hashmap_entry"
  */
 #define hashmap_for_each_entry(map, iter, var, member) \
-	for (var = hashmap_iter_first_entry_offset(map, iter, \
+	for (var = NULL, var = hashmap_iter_first_entry_offset(map, iter, \
 						OFFSETOF_VAR(var, member)); \
 		var; \
 		var = hashmap_iter_next_entry_offset(iter, \
