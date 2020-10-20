Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AD4C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 20:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87970222C8
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 20:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nNEDVIaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409646AbgJTUuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 16:50:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53398 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409643AbgJTUuL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 16:50:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D71E9FA8BE;
        Tue, 20 Oct 2020 16:50:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dW1s5u1mCrQFujlr7o2XHPWJjjU=; b=nNEDVI
        aZrepeMhC7xdyjkAOFsJ6F2qC00JkZB5nIzenw6KzIEORgllR+FmNfMXmme7zKFT
        d8CekHiVH0TU6i210fPBUN3Afzvrzkk/VCqSlsSWGwlvn38JU8tb2t+ijY+9bACJ
        hjQ6hH49fJjONKfA0xkTLeXu/A2L1ihdVtuls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Wz35Ql/ZnXVoCJTmE/nlbkFKQ44hlsjx
        a3pX59aI+OdDj5CKtBSpYm39pv0blkSb3eT/KSLcCfmLRZF+WzCgRjbxvTFUhzF8
        bHcgxukesfwIAzuQpSUTVX9r+Ylgt/w/N1+VLdrArr4OZKXRpblP/oWjM7+gmx5t
        GHVUNK5oOGk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D1742FA8BC;
        Tue, 20 Oct 2020 16:50:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 18D02FA8BB;
        Tue, 20 Oct 2020 16:50:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] apply: when -R, also reverse list of sections
References: <xmqqy2ktk11t.fsf@gitster.c.googlers.com>
        <20201020191206.104924-1-jonathantanmy@google.com>
        <xmqqeelsbr2c.fsf@gitster.c.googlers.com>
Date:   Tue, 20 Oct 2020 13:50:06 -0700
In-Reply-To: <xmqqeelsbr2c.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 20 Oct 2020 13:06:19 -0700")
Message-ID: <xmqqo8kwaagx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6A2BE12-1315-11EB-A309-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I wish you told that to those who added fn_table kludge to apply.c
> back when they did so.  They apparently wanted to have a patch that
> has more than one "diff --git a/hello.c b/hello.c" that talks about
> the same file applied with a single invocation of "git apply".
> Perhaps what they did is already broken with "apply -R", and blind
> reversal of everything magically makes it work?  Or what they did
> already works with "apply -R" and your blind reversal would break,
> unless you undo what they did?

;-)  It turns out that it was the former.

Without your "blindly reverse everything" patch, the attached patch
illustrates how the "touch the same path more than once" support
introduced in 7a07841c (git-apply: handle a patch that touches the
same path more than once better, 2008-06-27) is broken with respect
to "apply -R".

So, you should be able to sell the change to fix _two_ bugs ;-)

Thanks.

diff --git a/t/t4127-apply-same-fn.sh b/t/t4127-apply-same-fn.sh
index 972946c174..fa824ac09f 100755
--- a/t/t4127-apply-same-fn.sh
+++ b/t/t4127-apply-same-fn.sh
@@ -30,7 +30,7 @@ test_expect_success 'apply same filename with independent changes' '
 	test_cmp same_fn same_fn2
 '
 
-test_expect_success 'apply same filename with overlapping changes' '
+test_expect_failure 'apply same filename with overlapping changes' '
 	git reset --hard &&
 	modify "s/^d/z/" same_fn &&
 	git diff > patch0 &&
@@ -39,8 +39,13 @@ test_expect_success 'apply same filename with overlapping changes' '
 	git diff >> patch0 &&
 	cp same_fn same_fn2 &&
 	git reset --hard &&
+	cp same_fn same_fn1 &&
+
 	git apply patch0 &&
-	test_cmp same_fn same_fn2
+	test_cmp same_fn same_fn2 &&
+
+	git apply -R patch0 &&
+	test_cmp same_fn same_fn1
 '
 
 test_expect_success 'apply same new filename after rename' '
