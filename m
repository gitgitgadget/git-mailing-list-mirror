Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B264F1F406
	for <e@80x24.org>; Tue, 19 Dec 2017 21:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752521AbdLSVBX (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 16:01:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55303 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751461AbdLSVBW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 16:01:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 90ECAAFD7E;
        Tue, 19 Dec 2017 16:01:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2bA3Ojh7p2+zxyEF6mAYiIEzopo=; b=uiEg4u
        eYTXe2Ir0UdFLH3ybLiMRxjzawtDpx6XZCGDM5UcvO5m+QL6v9wJQU0FVuK/YOHz
        ihEGKFYAusaqlC7ACs4UBLl5Ui+bR5xydAb5geLJesDOYEAnCBtA6oUKGVangiPU
        8zV4/XlZpsCi4iDDy1hXNdBhoKGQGXFDtoiD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=quzVG+QTxzXE4lhjaSk60QPtEnxvNDYD
        MrWyw3nEDYrcQKQC9N2tP9HAxzr+3qLqvksWc1IkmnfhMkFxBIQVSA+EQBIIt93b
        /LOB4cvhJb3xwFA+XhJR709co0bpp/MTaWATNIFohQS+wncIZjAok7KKR/76mDgs
        y41lS5ijh70=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 888E1AFD7D;
        Tue, 19 Dec 2017 16:01:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CF4B9AFD7B;
        Tue, 19 Dec 2017 16:01:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>
Subject: [PATCH v2 3/2] t5573, t7612: clean up after unexpected success of 'pull' and 'merge'
References: <20171209090530.6747-1-hji@dyntopia.com>
        <20171210065358.8156-1-hji@dyntopia.com>
        <20171210065358.8156-2-hji@dyntopia.com>
        <xmqqbmj33h0s.fsf@gitster.mtv.corp.google.com>
        <xmqqmv2jpyb6.fsf_-_@gitster.mtv.corp.google.com>
Date:   Tue, 19 Dec 2017 13:01:08 -0800
In-Reply-To: <xmqqmv2jpyb6.fsf_-_@gitster.mtv.corp.google.com> (Junio
        C. Hamano's message of "Fri, 15 Dec 2017 11:48:29 -0800")
Message-ID: <xmqqfu86v3e3.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0B08A18-E4FF-11E7-B5DF-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous steps added test_when_finished to tests that run 'git
pull' or 'git merge' with expectation of success, so that the test
after them can start from a known state even when their 'git pull'
invocation unexpectedly fails.  However, tests that run 'git pull'
or 'git merge' expecting it not to succeed forgot to protect later
tests the same way---if they unexpectedly succeed, the test after
them would start from an unexpected state.

Reset and checkout the initial commit after all these tests, whether
they expect their invocations to succeed or fail.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Let's do this and move the whole thing forward.

 t/t5573-pull-verify-signatures.sh  |  9 ++++++---
 t/t7612-merge-verify-signatures.sh | 16 +++++++++++-----
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/t/t5573-pull-verify-signatures.sh b/t/t5573-pull-verify-signatures.sh
index 8ae331f40e..9594e891f4 100755
--- a/t/t5573-pull-verify-signatures.sh
+++ b/t/t5573-pull-verify-signatures.sh
@@ -43,33 +43,36 @@ test_expect_success GPG 'create repositories with signed commits' '
 '
 
 test_expect_success GPG 'pull unsigned commit with --verify-signatures' '
+	test_when_finished "git reset --hard && git checkout initial" &&
 	test_must_fail git pull --ff-only --verify-signatures unsigned 2>pullerror &&
 	test_i18ngrep "does not have a GPG signature" pullerror
 '
 
 test_expect_success GPG 'pull commit with bad signature with --verify-signatures' '
+	test_when_finished "git reset --hard && git checkout initial" &&
 	test_must_fail git pull --ff-only --verify-signatures bad 2>pullerror &&
 	test_i18ngrep "has a bad GPG signature" pullerror
 '
 
 test_expect_success GPG 'pull commit with untrusted signature with --verify-signatures' '
+	test_when_finished "git reset --hard && git checkout initial" &&
 	test_must_fail git pull --ff-only --verify-signatures untrusted 2>pullerror &&
 	test_i18ngrep "has an untrusted GPG signature" pullerror
 '
 
 test_expect_success GPG 'pull signed commit with --verify-signatures' '
-	test_when_finished "git checkout initial" &&
+	test_when_finished "git reset --hard && git checkout initial" &&
 	git pull --verify-signatures signed >pulloutput &&
 	test_i18ngrep "has a good GPG signature" pulloutput
 '
 
 test_expect_success GPG 'pull commit with bad signature without verification' '
-	test_when_finished "git checkout initial" &&
+	test_when_finished "git reset --hard && git checkout initial" &&
 	git pull --ff-only bad 2>pullerror
 '
 
 test_expect_success GPG 'pull commit with bad signature with --no-verify-signatures' '
-	test_when_finished "git checkout initial" &&
+	test_when_finished "git reset --hard && git checkout initial" &&
 	test_config merge.verifySignatures true &&
 	test_config pull.verifySignatures true &&
 	git pull --ff-only --no-verify-signatures bad 2>pullerror
diff --git a/t/t7612-merge-verify-signatures.sh b/t/t7612-merge-verify-signatures.sh
index 2344995a11..e797c74112 100755
--- a/t/t7612-merge-verify-signatures.sh
+++ b/t/t7612-merge-verify-signatures.sh
@@ -35,64 +35,70 @@ test_expect_success GPG 'create signed commits' '
 '
 
 test_expect_success GPG 'merge unsigned commit with verification' '
+	test_when_finished "git reset --hard && git checkout initial" &&
 	test_must_fail git merge --ff-only --verify-signatures side-unsigned 2>mergeerror &&
 	test_i18ngrep "does not have a GPG signature" mergeerror
 '
 
 test_expect_success GPG 'merge unsigned commit with merge.verifySignatures=true' '
+	test_when_finished "git reset --hard && git checkout initial" &&
 	test_config merge.verifySignatures true &&
 	test_must_fail git merge --ff-only side-unsigned 2>mergeerror &&
 	test_i18ngrep "does not have a GPG signature" mergeerror
 '
 
 test_expect_success GPG 'merge commit with bad signature with verification' '
+	test_when_finished "git reset --hard && git checkout initial" &&
 	test_must_fail git merge --ff-only --verify-signatures $(cat forged.commit) 2>mergeerror &&
 	test_i18ngrep "has a bad GPG signature" mergeerror
 '
 
 test_expect_success GPG 'merge commit with bad signature with merge.verifySignatures=true' '
+	test_when_finished "git reset --hard && git checkout initial" &&
 	test_config merge.verifySignatures true &&
 	test_must_fail git merge --ff-only $(cat forged.commit) 2>mergeerror &&
 	test_i18ngrep "has a bad GPG signature" mergeerror
 '
 
 test_expect_success GPG 'merge commit with untrusted signature with verification' '
+	test_when_finished "git reset --hard && git checkout initial" &&
 	test_must_fail git merge --ff-only --verify-signatures side-untrusted 2>mergeerror &&
 	test_i18ngrep "has an untrusted GPG signature" mergeerror
 '
 
 test_expect_success GPG 'merge commit with untrusted signature with merge.verifySignatures=true' '
+	test_when_finished "git reset --hard && git checkout initial" &&
 	test_config merge.verifySignatures true &&
 	test_must_fail git merge --ff-only side-untrusted 2>mergeerror &&
 	test_i18ngrep "has an untrusted GPG signature" mergeerror
 '
 
 test_expect_success GPG 'merge signed commit with verification' '
-	test_when_finished "git checkout initial" &&
+	test_when_finished "git reset --hard && git checkout initial" &&
 	git merge --verbose --ff-only --verify-signatures side-signed >mergeoutput &&
 	test_i18ngrep "has a good GPG signature" mergeoutput
 '
 
 test_expect_success GPG 'merge signed commit with merge.verifySignatures=true' '
-	test_when_finished "git checkout initial" &&
+	test_when_finished "git reset --hard && git checkout initial" &&
 	test_config merge.verifySignatures true &&
 	git merge --verbose --ff-only side-signed >mergeoutput &&
 	test_i18ngrep "has a good GPG signature" mergeoutput
 '
 
 test_expect_success GPG 'merge commit with bad signature without verification' '
-	test_when_finished "git checkout initial" &&
+	test_when_finished "git reset --hard && git checkout initial" &&
 	git merge $(cat forged.commit)
 '
 
 test_expect_success GPG 'merge commit with bad signature with merge.verifySignatures=false' '
-	test_when_finished "git checkout initial" &&
+	test_when_finished "git reset --hard && git checkout initial" &&
 	test_config merge.verifySignatures false &&
 	git merge $(cat forged.commit)
 '
 
 test_expect_success GPG 'merge commit with bad signature with merge.verifySignatures=true and --no-verify-signatures' '
-	test_when_finished "git checkout initial" &&
+	test_when_finished "git reset --hard && git checkout initial" &&
 	test_config merge.verifySignatures true &&
 	git merge --no-verify-signatures $(cat forged.commit)
 '
-- 
2.15.1-574-g4ecdd25846

