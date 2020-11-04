Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683F5C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFFA220759
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RtaWuwbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbgKDRyG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 12:54:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50460 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730865AbgKDRyF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 12:54:05 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C3F6858CA;
        Wed,  4 Nov 2020 12:54:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s41z7GuHgaMMQOOzlyJ7SOAgWno=; b=RtaWuw
        bXG2KD9e7VCjscnAA6Gx52u8pdnKCRsF4IXMd/mJcBN6AWpoW4LjC0PZeoX+XF8e
        syd9N0+9ahlShsmtfI/aJTc2RUUg/6+FbTnOzHKhwhOXIMXIB8Y7mylme2mQTVYM
        09NwM+Fqxr4dc9egRt3iJ3qI3ygbQ+5yQOWhY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=etiT4Jvv7SSh7e3f12erOaLVl5HcjUGf
        RCNqfS3QZznOXfzY6TO6R0tvGsRpxGoE63IGSf1a6S59J9EoDyC10NC1DncwogF5
        JKLRuMdT9f6kdCJZOnkIYz/YjVwDjmW1nrVKORAtUxO/btO+sA0NaC19zgVlHrIT
        th37LLihY1w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FA84858C9;
        Wed,  4 Nov 2020 12:54:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8FDAA858C8;
        Wed,  4 Nov 2020 12:54:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sathyajith Bhat <sathya@sathyasays.com>, git@vger.kernel.org
Subject: Re*: Segfault in git when using git logs
References: <CAMsWJsyPVQWV++gc2YJriEOEWBELa_xj2G0NWFMSgNYt47swiQ@mail.gmail.com>
        <20201102144321.GA3962443@coredump.intra.peff.net>
        <20201103101553.GH24813@szeder.dev>
        <20201103182102.GA459792@coredump.intra.peff.net>
        <xmqq361qs31a.fsf@gitster.c.googlers.com>
        <20201103185711.GA461461@coredump.intra.peff.net>
        <xmqqimamqjhl.fsf@gitster.c.googlers.com>
Date:   Wed, 04 Nov 2020 09:54:01 -0800
In-Reply-To: <xmqqimamqjhl.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 03 Nov 2020 12:21:42 -0800")
Message-ID: <xmqq7dr1nh3a.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B94B998A-1EC6-11EB-A1E7-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>> +	if (rev->line_level_traverse) {
>>> +		if (rev->diffopt.filter)
>>> +			die(_("-L<range>:<file> cannot be used with pathspec"));
>>
>> Should this be checking rev->diffopt.pathspec.nr?
>
> Embarrassing but yes ;-).

I wonder if rev->prune_data.nr is what matters here, though.

The prune_data is often identical to diffopt.pathspec, but the
former affects the paths that participate in history simplification,
while the latter is used when deciding which paths to show
differences between the commit and its parent(s) and used to widen
the set independently from prune_data for the "--full-diff" option.

-- >8 --
Subject: [PATCH] log: diagnose -L used with pathspec as an error

The -L option is documented to accept no pathspec, but the
command line option parser has allowed the combination without
checking so far.  Ensure that there is no pathspec when the -L
option is in effect to fix this.

Incidentally, this change fixes another bug in the command line
option parser, which has allowed the -L option used together
with the --follow option.  Because the latter requires exactly
one path given, but the former takes no pathspec, they become
mutually incompatible automatically.  Because the -L option
follows renames on its own, there is no reason to give --follow
at the same time.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c       |  3 +++
 t/t4211-line-log.sh | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index 0a7ed4bef9..9d70f3e60b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -206,6 +206,9 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	if (argc > 1)
 		die(_("unrecognized argument: %s"), argv[1]);
 
+	if (rev->line_level_traverse && rev->prune_data.nr)
+		die(_("-L<range>:<file> cannot be used with pathspec"));
+
 	memset(&w, 0, sizeof(w));
 	userformat_find_requirements(NULL, &w);
 
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 2d1d7b5d19..3d1bd6ed80 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -8,6 +8,24 @@ test_expect_success 'setup (import history)' '
 	git reset --hard
 '
 
+# Basic command line option parsing
+test_expect_success '-L is incompatible with pathspec' '
+	# This may fail due to "no such path a.c in commit",
+	# or "-L is incompatible with pathspec". Either is acceptable.
+	test_must_fail git log -L1,1:a.c -- a.c &&
+
+	# This must fail due to "-L is incompatible with pathspec".
+	test_must_fail git log -L1,1:b.c -- b.c &&
+
+	# These must fail due to "follow requires one pathspec".
+	test_must_fail git log -L1,1:b.c --follow &&
+	test_must_fail git log --follow -L1,1:b.c &&
+
+	# This may fail due to "-L is incompatible with pathspec",
+	# or "-L is incompatible with pathspec". Either is acceptable.
+	test_must_fail git log --follow -L1,1:b.c -- b.c
+'
+
 canned_test_1 () {
 	test_expect_$1 "$2" "
 		git log $2 >actual &&
-- 
2.29.2-287-gba574db674

