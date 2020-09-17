Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CB9C433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B57204EC
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="knIpAw/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgIQSf1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 14:35:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54998 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgIQSfX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 14:35:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27B27F0CB5;
        Thu, 17 Sep 2020 14:35:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UV5legH+3Ha6W6FHYr4mvfb2M6c=; b=knIpAw
        /5KMTFjdM5biLon6geo5SlyyDo9SVF5aAq4pbDkmEz7IU/k9HfgGENoazCHWxJjM
        HLB9tu+Hz51PSjy+jG3D4nk+ffkt0z/z7dkbC2NXJkzmDYFmwoCzar+jpSahimMq
        G0DcGsxP1VVgRw/orLEixIMkv1hPoxbfRdy8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ntzFLj9+dx+KWxqvQ4VVLkV3D3R+nOHl
        pOU1n78jutO3FcWHWCBrtxWPu81/aYmfAugZRmKuFGVF7QPLNckMitqN1ZVXv7UR
        f6c9VSv09brnd2IBHAoaUKkdywuQlc1eIro+5VcsB+wSeHSOFG3oCPPGXY2Qgpa3
        Q9viRLHIIo4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2027CF0CB4;
        Thu, 17 Sep 2020 14:35:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 55336F0CAF;
        Thu, 17 Sep 2020 14:35:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v5 00/11] Maintenance I: Command, gc and commit-graph tasks
References: <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
        <pull.695.v5.git.1600366313.gitgitgadget@gmail.com>
Date:   Thu, 17 Sep 2020 11:35:15 -0700
In-Reply-To: <pull.695.v5.git.1600366313.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Thu, 17 Sep 2020 18:11:41
        +0000")
Message-ID: <xmqqtuvwqmjg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 888A2F78-F914-11EA-947D-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Update in v4
> ============
>
> A segfault when running just "git maintenance" is fixed.

The net change is just a single liner below, and is obviously
correct.

I propagated it through to part #2 and part #3 locally, and
hopefully this makes part #1 ready to go.

Thanks.



diff --git a/builtin/gc.c b/builtin/gc.c
index c3bcdc1167..090959350e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1027,7 +1027,8 @@ static const char builtin_maintenance_usage[] = N_("git maintenance run [<option
 
 int cmd_maintenance(int argc, const char **argv, const char *prefix)
 {
-	if (argc == 2 && !strcmp(argv[1], "-h"))
+	if (argc < 2 ||
+	    (argc == 2 && !strcmp(argv[1], "-h")))
 		usage(builtin_maintenance_usage);
 
 	if (!strcmp(argv[1], "run"))
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 4f6a04ddb1..53c883531e 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -10,7 +10,9 @@ test_expect_success 'help text' '
 	test_expect_code 129 git maintenance -h 2>err &&
 	test_i18ngrep "usage: git maintenance run" err &&
 	test_expect_code 128 git maintenance barf 2>err &&
-	test_i18ngrep "invalid subcommand: barf" err
+	test_i18ngrep "invalid subcommand: barf" err &&
+	test_expect_code 129 git maintenance 2>err &&
+	test_i18ngrep "usage: git maintenance" err
 '
 
 test_expect_success 'run [--auto|--quiet]' '
