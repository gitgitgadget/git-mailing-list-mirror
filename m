Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A9CC3F2CD
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008422146E
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="Wrs4EEDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgCDLsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:48:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38549 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729273AbgCDLsP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 06:48:15 -0500
Received: by mail-pf1-f196.google.com with SMTP id q9so854739pfs.5
        for <git@vger.kernel.org>; Wed, 04 Mar 2020 03:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yF0cS9rIchJo2bQN7i+M2cfuQjPFIQvxUrm4xxKO020=;
        b=Wrs4EEDw6YBHnpMilbsyBtZyK9i6DeUv+Qh0Vvv/ZC6C54wl3iVudpPGtrROkR20Hn
         tMVq6OAFaxTsa+ljS2bguT7hIHGJsN23gb1C48g8BSFQVyUvauF6YPGpceQBv2IYXWCc
         uAiPFz9jdMqMwnESTFbqNr5DjGWJ/ygpDdldWz0nb+Y0Hep/I9KoD+HX/IyW7HjKLXE+
         5xRmL9O0EEfO8nN3WGaFINsn+ooeHNb6QTYyL5oZmp/75OM6TyI0NgfdL7AFzu5msZAd
         2ywpYKcHk6x3u8oy+dnO8Jw4c1IldSj28wNCmxhh4S7s9+A25YZgvDfNyEfF8sREDI/l
         rxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yF0cS9rIchJo2bQN7i+M2cfuQjPFIQvxUrm4xxKO020=;
        b=YgLGdH9Jk/1cTLQsnHhH2hpWe9sjGi4P0Wk2fb+mIIP4aaOwzauZLx01s5OYcJuUhg
         6DHwNzsh0DZOdMv6k9sN3E6+9mXByyl8iUPjp4h0oq27D/QjTh3m97rz1180Nec+iu2A
         uuhAcn25+nDIK4ZJUbRlnXQ8bxsmEP9Nnb4iDxSKsg29kaC+K6BaaL4VdimQOrgZvdcF
         T19f62Mt49CPpxk6pxSKknqda2saIzXwu78kvk+5NSedGf6qQICcJavV9TGy60da6out
         QJQQNYOF5LNuXC1FtE8ffq0CLtOy7hhfRDzEZ9Plf1GO91cZRNnXPbezU7b1HCC4WhYE
         WMKA==
X-Gm-Message-State: ANhLgQ2qoI6vRfVg/wyaD6BdPld6cxAOj4h0Iy1voaRmbcSvIsMJg/Lt
        R4QQDX8rW9fRZGtYfZr57B7mfbR1Lcg=
X-Google-Smtp-Source: ADFU+vuraxJ80nPpZ+EAV4uW0Ol9jgZy4kaZU6omrCSDG4VgY5VMknSuLwm0FyB+GC76GSaOvgIlAQ==
X-Received: by 2002:a63:2701:: with SMTP id n1mr2276349pgn.332.1583322491793;
        Wed, 04 Mar 2020 03:48:11 -0800 (PST)
Received: from localhost ([203.144.74.196])
        by smtp.gmail.com with ESMTPSA id l12sm27285030pgj.16.2020.03.04.03.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 03:48:11 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH v1 1/2] t: increase test coverage of signature verification output
Date:   Wed,  4 Mar 2020 11:48:03 +0000
Message-Id: <20200304114804.19108-2-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304114804.19108-1-hji@dyntopia.com>
References: <20191127174821.5830-1-hji@dyntopia.com>
 <20200304114804.19108-1-hji@dyntopia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There weren't any tests for unsuccessful signature verification of
signed merge tags shown in 'git log'.  There also weren't any tests for
the GPG output from 'git fmt-merge-msg'.  This was noticed while
investigating a buggy refactor that slipped through the test suite; see
commit 72b006f4bfd30b7c5037c163efaf279ab65bea9c.

This commit adds signature verification tests to the 'log' and
'fmt-merge-msg' builtins.

Thanks to Linus Torvalds for reporting and finding the (now reverted)
commit that introduced the regression.

Note that the "log --show-signature for merged tag with GPG failure"
test case is really hacky.  It relies on an implementation detail of
verify_signed_buffer() -- namely, it assumes that the signature is
written to a temporary file whose path is under TMPDIR.

The rationale for that test case is to check whether the code path that
yields the "No signature" message is reachable on failure.  The
functionality in log-tree.c that may show this message does some
pre-parsing of a possible signature that prevents the GPG interface from
being invoked if a signature is actually missing.  And I haven't been
able to construct a signature that both 1. satisfies that
pre-processing, and 2. causes GPG to fail without any sort of output on
stderr along the lines of "this is a bogus/corrupt/... signature" (the
"No signature" message should only be shown if GPG produce no output).

Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
---
 t/t4202-log.sh           | 106 +++++++++++++++++++++++++++++++++++++++
 t/t6200-fmt-merge-msg.sh |  23 +++++++++
 2 files changed, 129 insertions(+)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 0f766ba65f..1783c6f7d9 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1607,6 +1607,67 @@ test_expect_success GPG 'log --graph --show-signature for merged tag' '
 	grep "^| | gpg: Good signature" actual
 '
 
+test_expect_success GPG 'log --graph --show-signature for merged tag with missing key' '
+	test_when_finished "git reset --hard && git checkout master" &&
+	git checkout -b plain-nokey master &&
+	echo aaa >bar &&
+	git add bar &&
+	git commit -m bar_commit &&
+	git checkout -b tagged-nokey master &&
+	echo bbb >baz &&
+	git add baz &&
+	git commit -m baz_commit &&
+	git tag -s -m signed_tag_msg signed_tag_nokey &&
+	git checkout plain-nokey &&
+	git merge --no-ff -m msg signed_tag_nokey &&
+	GNUPGHOME=. git log --graph --show-signature -n1 plain-nokey >actual &&
+	grep "^|\\\  merged tag" actual &&
+	grep "^| | gpg: Signature made" actual &&
+	grep "^| | gpg: Can'"'"'t check signature: \(public key not found\|No public key\)" actual
+'
+
+test_expect_success GPG 'log --graph --show-signature for merged tag with bad signature' '
+	test_when_finished "git reset --hard && git checkout master" &&
+	git checkout -b plain-bad master &&
+	echo aaa >bar &&
+	git add bar &&
+	git commit -m bar_commit &&
+	git checkout -b tagged-bad master &&
+	echo bbb >baz &&
+	git add baz &&
+	git commit -m baz_commit &&
+	git tag -s -m signed_tag_msg signed_tag_bad &&
+	git cat-file tag signed_tag_bad >raw &&
+	sed -e "s/signed_tag_msg/forged/" raw >forged &&
+	git hash-object -w -t tag forged >forged.tag &&
+	git checkout plain-bad &&
+	git merge --no-ff -m msg "$(cat forged.tag)" &&
+	git log --graph --show-signature -n1 plain-bad >actual &&
+	grep "^|\\\  merged tag" actual &&
+	grep "^| | gpg: Signature made" actual &&
+	grep "^| | gpg: BAD signature from" actual
+'
+
+test_expect_success GPG 'log --show-signature for merged tag with GPG failure' '
+	test_when_finished "git reset --hard && git checkout master" &&
+	git checkout -b plain-fail master &&
+	echo aaa >bar &&
+	git add bar &&
+	git commit -m bar_commit &&
+	git checkout -b tagged-fail master &&
+	echo bbb >baz &&
+	git add baz &&
+	git commit -m baz_commit &&
+	git tag -s -m signed_tag_msg signed_tag_fail &&
+	git checkout plain-fail &&
+	git merge --no-ff -m msg signed_tag_fail &&
+	TMPDIR="$(pwd)/bogus" git log --show-signature -n1 plain-fail >actual &&
+	grep "^merged tag" actual &&
+	grep "^No signature" actual &&
+	! grep "^gpg: Signature made" actual
+'
+
+
 test_expect_success GPG 'log --graph --show-signature for merged tag in shallow clone' '
 	test_when_finished "git reset --hard && git checkout master" &&
 	git checkout -b plain-shallow master &&
@@ -1648,6 +1709,51 @@ test_expect_success GPGSM 'log --graph --show-signature for merged tag x509' '
 	grep "^| | gpgsm: Good signature" actual
 '
 
+test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 missing key' '
+	test_when_finished "git reset --hard && git checkout master" &&
+	test_config gpg.format x509 &&
+	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
+	git checkout -b plain-x509-nokey master &&
+	echo aaa >bar &&
+	git add bar &&
+	git commit -m bar_commit &&
+	git checkout -b tagged-x509-nokey master &&
+	echo bbb >baz &&
+	git add baz &&
+	git commit -m baz_commit &&
+	git tag -s -m signed_tag_msg signed_tag_x509_nokey &&
+	git checkout plain-x509-nokey &&
+	git merge --no-ff -m msg signed_tag_x509_nokey &&
+	GNUPGHOME=. git log --graph --show-signature -n1 plain-x509-nokey >actual &&
+	grep "^|\\\  merged tag" actual &&
+	grep "^| | gpgsm: certificate not found" actual
+'
+
+test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 bad signature' '
+	test_when_finished "git reset --hard && git checkout master" &&
+	test_config gpg.format x509 &&
+	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
+	git checkout -b plain-x509-bad master &&
+	echo aaa >bar &&
+	git add bar &&
+	git commit -m bar_commit &&
+	git checkout -b tagged-x509-bad master &&
+	echo bbb >baz &&
+	git add baz &&
+	git commit -m baz_commit &&
+	git tag -s -m signed_tag_msg signed_tag_x509_bad &&
+	git cat-file tag signed_tag_x509_bad >raw &&
+	sed -e "s/signed_tag_msg/forged/" raw >forged &&
+	git hash-object -w -t tag forged >forged.tag &&
+	git checkout plain-x509-bad &&
+	git merge --no-ff -m msg "$(cat forged.tag)" &&
+	git log --graph --show-signature -n1 plain-x509-bad >actual &&
+	grep "^|\\\  merged tag" actual &&
+	grep "^| | gpgsm: Signature made" actual &&
+	grep "^| | gpgsm: invalid signature" actual
+'
+
+
 test_expect_success GPG '--no-show-signature overrides --show-signature' '
 	git log -1 --show-signature --no-show-signature signed >actual &&
 	! grep "^gpg:" actual
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 8a72b4c43a..1922c1c42e 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -6,6 +6,7 @@
 test_description='fmt-merge-msg test'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
 
 test_expect_success setup '
 	echo one >one &&
@@ -73,6 +74,10 @@ test_expect_success setup '
 	apos="'\''"
 '
 
+test_expect_success GPG '
+	git tag -s -m signed-tag-msg signed-good-tag left
+'
+
 test_expect_success 'message for merging local branch' '
 	echo "Merge branch ${apos}left${apos}" >expected &&
 
@@ -83,6 +88,24 @@ test_expect_success 'message for merging local branch' '
 	test_cmp expected actual
 '
 
+test_expect_success GPG 'message for merging local tag signed by good key' '
+	git checkout master &&
+	git fetch . signed-good-tag &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
+	grep "^# gpg: Signature made" actual &&
+	grep "^# gpg: Good signature from" actual
+'
+
+test_expect_success GPG 'message for merging local tag signed by unknown key' '
+	git checkout master &&
+	git fetch . signed-good-tag &&
+	GNUPGHOME=. git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
+	grep "^# gpg: Signature made" actual &&
+	grep "^# gpg: Can${apos}t check signature: \(public key not found\|No public key\)" actual
+'
+
 test_expect_success 'message for merging external branch' '
 	echo "Merge branch ${apos}left${apos} of $(pwd)" >expected &&
 
-- 
2.25.1.709.g558d21736a

