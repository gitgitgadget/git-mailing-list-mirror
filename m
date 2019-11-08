Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 605B01F4C0
	for <e@80x24.org>; Fri,  8 Nov 2019 09:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbfKHJoO (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 04:44:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39135 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730308AbfKHJoO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 04:44:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id x28so4210360pfo.6
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 01:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yKnLgcZe0BdMrQUXufyDk7d3i1eZPKwHaujDWgWewzo=;
        b=mufSRlh8+Xzlai/4oMa3agBxzMm9NV4iWaaTBGpi4rCJPz5FtIHACVGb01g0eX5XCT
         SDHyqYp9nWB/FeLMgp5ivW712s98+qCUMIvrorFBgdbxl1rXuWHESDTEL9+S8ugOzG6F
         KHruSnpngasM2oSBmM9v37e2q+nwLBwTeoss3jMfT3jlB7dp9olhrHBjhO2ppk65temH
         5ZU8j0hq+kq4JbpZFaIaOj6ejplR1jZryipkJJE4cRM2aqY0NdckBFfrrte3jfkDeW2J
         GKDML3X9HDwNIKPdn8egZjOo03KkXmWTf+j2JeTfSS+K0dOhDUjzDHxOLE972JoWfber
         /GPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yKnLgcZe0BdMrQUXufyDk7d3i1eZPKwHaujDWgWewzo=;
        b=UKAj5RkEEyP8JBvbquvGEZvUonL0JhD/Y2gmy7umu5toRZ5FeMzH6iLtQhu7HfgcJZ
         cwV3jrlIin7qbp3suWNJOMy20nL21aaC6430Rm81MSSw3A6wd8CP4oLnNZFOqiPZdmlU
         /eYlUIbm8SkK/OB0ijYdIy9ttRrhdMAH/uyjP/zXP2EHkEEeT+v1tfTUzZ/pN38o97bM
         pf795yChWYMOFqzFy0xdm1O6Je6Y6B0rwR1xN2q2OpjQ+LOv1GrBXDtwE/U2rSQsLYLE
         2soAi1RmQ6slRW/FccEly79eVLD1CvDd/Q4fVspc2W0dPfvWj0VMgJxkmpHN94vshWjy
         Hsjw==
X-Gm-Message-State: APjAAAWilJLsV+asAudlHn3y4xIm8/oHDyfT2jxfZcFPMOEl7aPqsnSN
        jV0lhBNODDge0SCWuGHhO5yViXSV
X-Google-Smtp-Source: APXvYqyRNek4Fug/wWrSV5+F45+z9Ot64ozHTTxJQ0oYGg7gcORIh/i/BqcunettILOFEnA3VlYsYg==
X-Received: by 2002:a63:a055:: with SMTP id u21mr11012662pgn.0.1573206253106;
        Fri, 08 Nov 2019 01:44:13 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id e198sm6995821pfh.83.2019.11.08.01.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 01:44:12 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v5 8/9] sequencer: reencode commit message for am/rebase --show-current-patch
Date:   Fri,  8 Nov 2019 16:43:50 +0700
Message-Id: <2e95ca57d2f701752fdc46d72c0ea1af031f8d53.1573205699.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.8.g2e95ca57d2.dirty
In-Reply-To: <cover.1573205699.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573205699.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The message file will be used as commit message for the
git-{am,rebase} --continue.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---

Notes:
	ISO8859-1.txt is copied from t3900

 sequencer.c            |   3 ++-
 t/t3433-rebase-i18n.sh |  27 +++++++++++++++++++++++++++
 t/t3433/ISO8859-1.txt  | Bin 0 -> 15 bytes
 3 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 t/t3433/ISO8859-1.txt

diff --git a/sequencer.c b/sequencer.c
index d735d09f98..4d12ad3cc6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2972,7 +2972,8 @@ static int make_patch(struct repository *r,
 
 	strbuf_addf(&buf, "%s/message", get_dir(opts));
 	if (!file_exists(buf.buf)) {
-		const char *commit_buffer = get_commit_buffer(commit, NULL);
+		const char *encoding = get_commit_output_encoding();
+		const char *commit_buffer = logmsg_reencode(commit, NULL, encoding);
 		find_commit_subject(commit_buffer, &subject);
 		res |= write_message(subject, strlen(subject), buf.buf, 1);
 		unuse_commit_buffer(commit, commit_buffer);
diff --git a/t/t3433-rebase-i18n.sh b/t/t3433-rebase-i18n.sh
index bff5a68d25..537d18c330 100755
--- a/t/t3433-rebase-i18n.sh
+++ b/t/t3433-rebase-i18n.sh
@@ -54,4 +54,31 @@ test_expect_failure 'rebase --rebase-merges update encoding eucJP to ISO-2022-JP
 	compare_msg eucJP.txt eucJP ISO-2022-JP
 '
 
+test_rebase_continue_update_encode () {
+	old=$1
+	new=$2
+	msgfile=$3
+	test_expect_success "rebase --continue update from $old to $new" '
+		(git rebase --abort || : abort current git-rebase failure) &&
+		git switch -c conflict-$old-$new one &&
+		echo for-conflict >two.t &&
+		git add two.t &&
+		git config i18n.commitencoding $old &&
+		git commit -F "$TEST_DIRECTORY/t3433/$msgfile" &&
+		git config i18n.commitencoding $new &&
+		test_must_fail git rebase -m master &&
+		test -f .git/rebase-merge/message &&
+		git stripspace <.git/rebase-merge/message >two.t &&
+		git add two.t &&
+		git rebase --continue &&
+		compare_msg $msgfile $old $new &&
+		: git-commit assume invalid utf-8 is latin1 &&
+		test_cmp expect two.t
+	'
+}
+
+test_rebase_continue_update_encode ISO-8859-1 UTF-8 ISO8859-1.txt
+test_rebase_continue_update_encode eucJP UTF-8 eucJP.txt
+test_rebase_continue_update_encode eucJP ISO-2022-JP eucJP.txt
+
 test_done
diff --git a/t/t3433/ISO8859-1.txt b/t/t3433/ISO8859-1.txt
new file mode 100644
index 0000000000000000000000000000000000000000..7cbef0ee6f430c611134a06a6dd6c12fbea589d5
GIT binary patch
literal 15
XcmX?d`r`R(TwDi}o~OJ>OXmUrN~8!!

literal 0
HcmV?d00001

-- 
2.24.0.8.g2e95ca57d2.dirty

