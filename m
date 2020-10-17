Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7E1C433E7
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 05:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F7D20714
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 05:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sd4BNz4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411631AbgJQFjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 01:39:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52148 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409775AbgJQFjF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 01:39:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9935DFF5E6;
        Fri, 16 Oct 2020 20:02:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1lK+JQTnUKq4JAYTpSQaOIyu4X0=; b=Sd4BNz
        4+4wd6Yg30qFyewMkv3hVHNgngHrnwHLutL50ueUGojBGGgGpTThcIgkmhiBH2OY
        wKNozSuCLlsQfzdDZEL+buDTjZ+vlAvMeK+SXN7jg5FFu4zFrJihiQaa0oXoJ8Ka
        F3SnsDwwWVMjMq0bVp3tvhnYMwWZn7RReGO0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O4Ks/0iXeJzJNV0tI+hU51/HT9rJyz9l
        03hVaQKFlzO1Y2SHK042rA47ZEl/+bld+41JAurA9cglPw+2QZS2WMn2inZTXWh9
        3LtWTYYgYHOVpuNRypnhViEmTU0kqdBPKxlNNfz6j4jLn2wPmyZgreccGzeiYdmy
        TR95WeilUhI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91BF1FF5E5;
        Fri, 16 Oct 2020 20:02:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D83F9FF5E4;
        Fri, 16 Oct 2020 20:02:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] t7518: fix flaky grep invocation
References: <pull.884.git.git.1602891594738.gitgitgadget@gmail.com>
Date:   Fri, 16 Oct 2020 17:02:07 -0700
In-Reply-To: <pull.884.git.git.1602891594738.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Fri, 16 Oct 2020 23:39:54
        +0000")
Message-ID: <xmqqr1px90u8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FFE7E476-100B-11EB-9EF5-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> output, but on one automatic CI run I observed the following output:
>
> fatal: empty ident name (for <runner@fv-az128-670.gcliasfzo2nullsdbrimjtbyhg.cx.internal.cloudapp.net>) not allowed
>
> Note that 'null' appears as a substring of the domain name, found
> within 'gcliasfzo2nullsdbrimjtbyhg'.  Tighten the test by searching for
> "(null)" rather than "null".

Why do we even need grep again?  If we were to segfault, wouldn't
test_must_fail catch it for us?

... ahh, OK, your libc may allow NULL left in email and that is what
we are trying to catch?

Honestly, I am not sure if it even makes sense to test it like this.
The code that the test tries to protect against future breakages
roughly look like this these days.

	if (!email) {
		... one way to assign non-NULL to email ...
	}
	if (!email) {
		... do other things to assign non-NULL to email or die ...
	}

	if (want_name) {
		... here we require email to be set because we show
		... it in an error message
	}

The original problem was that the code had "if (want_name)" part
first before email==NULL condition has been dealt with, and used
email==NULL in one of the error messages.  The fix was to move the
part that deals with email==NULL up, as it does not need any of the
effects that happen in "if (want_name)" block.

Now, what is this particular test protecting against?  We may again
move the "if (want_name)" block up and trigger the error message in
it that uses e-mail while having NULL in email again?  If so, would
it make more sense to do something along this line, lose the "grep"
and keep "test_must_fail"?  We expect and require at this point in
the code (the patch is inside that "if (want_name)" block) email
must have been set up already, so it would be a BUG() otherwise.

Hmm?

 ident.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git i/ident.c w/ident.c
index 6aba4b5cb6..9b71563d95 100644
--- i/ident.c
+++ w/ident.c
@@ -430,6 +430,8 @@ const char *fmt_ident(const char *name, const char *email,
 			if (strict) {
 				if (using_default)
 					ident_env_hint(whose_ident);
+				if (!email)
+					BUG("NULL email when we need to complain???");
 				die(_("empty ident name (for <%s>) not allowed"), email);
 			}
 			pw = xgetpwuid_self(NULL);
