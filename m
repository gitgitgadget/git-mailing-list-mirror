Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B664FC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbiGMNKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbiGMNKp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:10:45 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69479BF61
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:10:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v16so15412156wrd.13
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SqaW0++fRWukVUKGvS3tyrR5kP/KTsmJWbZGYXwObO8=;
        b=jGIV1r7CHYgqV6/QPxY0lG7NrZs5OrhmPBjxAdGwtTo0q96+mgBtiArcPdNMlTcXt+
         51iKstIJk/LLYzkH0vwD/dVaQIaC7+Q38a82P2vBTlGa78rjYde9azSCSc2ksN3OxebQ
         Pd6t7GcsxTwgNa0nS55CyQuFrvaW+pHMJFKhvjQu2jA9l2A+9RMUl8UdNS762Q0ga93J
         D03z64LvM72uU5Y6UxiPV07LsrWRWCd4DOyknaEXbOLSa/2dHIUP6BQIibj89CJZgV20
         pMKCW2UtKtgpc0nNkMkZVmba+pRGFy3H4261eudmBG4kaZpyKjdDA4uJeYeypcam++WJ
         d7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SqaW0++fRWukVUKGvS3tyrR5kP/KTsmJWbZGYXwObO8=;
        b=39t+7QEzFJSQR4n3AiHfQh7pKyW5r3WgSFpgB/fbbKfoIJzkcq/8e+KnLDXu4aa4JZ
         696geBJN1+ZR+wYZwxltDNuOy/72BQRNJqiTUxlqN6+vhNO9dAicLx3R0VFPF5Zkeehm
         aWlQRsxo8i9JwreJlaDPjLeBWZ5IRYbJJY9yiQXM3bzqLgDcK8/DQaWl8JypzXADhHBK
         5n6AgpnBr2Qsc/nr47pASUkPrii0PsxvSkAlqNmExKNquLQ+JjwN1QgOX1LJO1UynDfQ
         sVu7fMEzcJWoouGivoiQDHlRM7hm6sM7DhiXazYtMMi5cOO10z6BhomV6PXfemKE4T/n
         3vAg==
X-Gm-Message-State: AJIora/Tazww3QqYyk7ThJ64lV+Ag/i+secd2x3zFk08DEJHcCuCNbCm
        2hSEerH623egeXPaPeoqLhKnG3vKVLh8xA==
X-Google-Smtp-Source: AGRyM1thVFP1dNKw17fBbLUlZo0HwwIxH30O8XO0xYSuE39Km+ZpVtXm8Iw8/5rgbKtsl7TbKO8Dmw==
X-Received: by 2002:a05:6000:185:b0:21d:7ffc:4916 with SMTP id p5-20020a056000018500b0021d7ffc4916mr3281289wrx.692.1657717842692;
        Wed, 13 Jul 2022 06:10:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d15-20020a05600c34cf00b0039c4d022a44sm2183653wmq.1.2022.07.13.06.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:10:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/6] test-fast-rebase helper: use release_revisions() (again)
Date:   Wed, 13 Jul 2022 15:10:31 +0200
Message-Id: <patch-2.6-325d05ce406-20220713T130511Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.932.g7b7031e73bc
In-Reply-To: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in 0139c58ab95 (revisions API users: add "goto cleanup" for
release_revisions(), 2022-04-13), in that commit a release_revisions()
call was added to this function, but it never did anything due to this
TODO memset() added in fe1a21d5267 (fast-rebase: demonstrate
merge-ort's API via new test-tool command, 2020-10-29).

Simply removing the memset() will fix the "cmdline" which can be seen
when running t5520-pull.sh.

This sort of thing could be detected automatically with a rule similar
to the unused.cocci merged in 7fa60d2a5b6 (Merge branch
'ab/cocci-unused' into next, 2022-07-11). The following rule on top
would catch the case being fixed here:

	@@
	type T;
	identifier I;
	identifier REL1 =~ "^[a-z_]*_(release|reset|clear|free)$";
	identifier REL2 =~ "^(release|clear|free)_[a-z_]*$";
	@@

	- memset(\( I \| &I \), 0, ...);
	  ... when != \( I \| &I \)
	(
	  \( REL1 \| REL2 \)( \( I \| &I \), ...);
	|
	  \( REL1 \| REL2 \)( \( &I \| I \) );
	)
	  ... when != \( I \| &I \)

That rule should arguably use only &I, not I (as we might be passed a
pointer). He distinction would matter if anyone cared about the
side-effects of a memset() followed by release() of a pointer to a
variable passed into the function.

As such a pattern would be at best very confusing, and most likely
point to buggy code as in this case, the above rule is probably fine
as-is.

But as this rule only found one such bug in the entire codebase let's
not add it to contrib/coccinelle/unused.cocci for now, we can always
dig it up in the future if it's deemed useful.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-fast-rebase.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index 4e5553e2024..45665ec19a5 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -184,8 +184,6 @@ int cmd__fast_rebase(int argc, const char **argv)
 		last_picked_commit = commit;
 		last_commit = create_commit(result.tree, commit, last_commit);
 	}
-	/* TODO: There should be some kind of rev_info_free(&revs) call... */
-	memset(&revs, 0, sizeof(revs));
 
 	merge_switch_to_result(&merge_opt, head_tree, &result, 1, !result.clean);
 
-- 
2.37.0.932.g7b7031e73bc

