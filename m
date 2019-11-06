Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 845D91F454
	for <e@80x24.org>; Wed,  6 Nov 2019 09:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfKFJUu (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 04:20:50 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43369 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbfKFJUu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 04:20:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id 3so18384332pfb.10
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 01:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eGpMKk7j26ViX9lcLgxIo141ux5hnPMyrTwsb8dKnnU=;
        b=CIm7pIyqOIRu9GFKHIIncSmqiEhrtLGdChz0PnuSSCPUM68IytEUWJYKY4YeQcKUGO
         GbBcPpLTFwDJIeh07EBUMj9hJMo4zLTcep5Ymy8bB3/Ga6K5b2rnOObt2o3FV0mT/ivd
         hwSjedmBSBYiA9iVu/1wD0l3vTI/EPMz4UAEQUjuJo5umchFr3wRAWcTO6FkK+3K1aYa
         dcZTGjNeWIow13oqKwL108AOjt2qYyHenh33nG6fhnxxkcWPkqHEMGyLUgkJe03qyP5l
         Yx64ZgzZWJFoN7ZFPKoseEQ3sfrDkf1ytezAQp0A8uFkI0tB86EpPDG0jzDd16ABC2WG
         gsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eGpMKk7j26ViX9lcLgxIo141ux5hnPMyrTwsb8dKnnU=;
        b=hp7r/MuFt/8nyA8VjpDX89KTvRnkWlKP4uc2MTcXrJJ33ybHa9+Uuh3i68IoCNjdcy
         b849LDuf2zJCs3hlmQeQFf0xrH6SJQyGpZpxDu5czeMEdzUMN/LuSLuju6MjFIAB511c
         XKHqdK9AyBJH6v4Q4r+ur2Hun4zHWIHguFSEeYygYYh1s2iQFjiSPjbVP4n89V5ZU+sn
         bi+j4qMYA4ZdZw01d3TAonD1Jrhi2Z5T/MGYzXCSBEH6MhUBJaD8wdn9uPDZU0dhEHaV
         ygTupc+zugqcVhHWF/ctGWCVK3bna6qe7/8s+Wa+rSymcRLmRex+mInnVHe+p3dN8cD6
         usxQ==
X-Gm-Message-State: APjAAAXY4MNioi/9jsy3OKBLqwCa0EtVKvqk19tUzKRasSMfHWYLF1YR
        XQ2EdhxgPWst0UUK1efSXBZFl/Pd
X-Google-Smtp-Source: APXvYqxLVv+Yo8GYzcon7EE+sZU/u3oyc5zEtTBk6AGHUbgPRrq/CPVb/H4amUZNH1MRET9nDDLfRg==
X-Received: by 2002:a65:49c7:: with SMTP id t7mr1676971pgs.431.1573032049443;
        Wed, 06 Nov 2019 01:20:49 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:4ba:cb41:a2ec:2198:454b])
        by smtp.gmail.com with ESMTPSA id c1sm4696984pjc.23.2019.11.06.01.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 01:20:48 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v3 6/8] sequencer: reencode squashing commit's message
Date:   Wed,  6 Nov 2019 16:20:04 +0700
Message-Id: <340902eb67df7e9a5ecb9e085f5e3fcaa1fd6751.1573031848.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.4.g6a51fdd29c
In-Reply-To: <cover.1573031848.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573031848.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On fixup/squash-ing rebase, git will create new commit in
i18n.commitencoding, reencode the commit message to that said encode.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 sequencer.c            |  8 +++++---
 t/t3900-i18n-commit.sh | 14 +++++++++++++-
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a19954f2bf..833a928929 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1576,6 +1576,7 @@ static int update_squash_messages(struct repository *r,
 	struct strbuf buf = STRBUF_INIT;
 	int res;
 	const char *message, *body;
+	const char *encoding = get_commit_output_encoding();
 
 	if (opts->current_fixup_count > 0) {
 		struct strbuf header = STRBUF_INIT;
@@ -1602,7 +1603,7 @@ static int update_squash_messages(struct repository *r,
 			return error(_("need a HEAD to fixup"));
 		if (!(head_commit = lookup_commit_reference(r, &head)))
 			return error(_("could not read HEAD"));
-		if (!(head_message = get_commit_buffer(head_commit, NULL)))
+		if (!(head_message = logmsg_reencode(head_commit, NULL, encoding)))
 			return error(_("could not read HEAD's commit message"));
 
 		find_commit_subject(head_message, &body);
@@ -1623,7 +1624,7 @@ static int update_squash_messages(struct repository *r,
 		unuse_commit_buffer(head_commit, head_message);
 	}
 
-	if (!(message = get_commit_buffer(commit, NULL)))
+	if (!(message = logmsg_reencode(commit, NULL, encoding)))
 		return error(_("could not read commit message of %s"),
 			     oid_to_hex(&commit->object.oid));
 	find_commit_subject(message, &body);
@@ -4154,9 +4155,10 @@ static int commit_staged_changes(struct repository *r,
 				 */
 				struct commit *commit;
 				const char *path = rebase_path_squash_msg();
+				const char *encoding = get_commit_output_encoding();
 
 				if (parse_head(r, &commit) ||
-				    !(p = get_commit_buffer(commit, NULL)) ||
+				    !(p = logmsg_reencode(commit, NULL, encoding)) ||
 				    write_message(p, strlen(p), path, 0)) {
 					unuse_commit_buffer(commit, p);
 					return error(_("could not write file: "
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index 7501555c52..241bda1099 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -209,6 +209,13 @@ test_commit_autosquash_multi_encoding () {
 	old=$2
 	new=$3
 	msg=$4
+	squash_msg=
+	if test $flag = squash; then
+		squash_msg='
+		subject="squash! $(head -1 expect)" &&
+		printf "\n%s\n" "$subject" >> expect &&
+		'
+	fi
 	test_expect_success "commit --$flag into $old from $new" '
 		git checkout -b '$flag-$old-$new' C0 &&
 		git config i18n.commitencoding '$old' &&
@@ -225,7 +232,12 @@ test_commit_autosquash_multi_encoding () {
 		git config --unset-all i18n.commitencoding &&
 		git rebase --autosquash -i HEAD^^^ &&
 		git rev-list HEAD >actual &&
-		test_line_count = 3 actual
+		test_line_count = 3 actual &&
+		iconv -f '$old' -t utf-8 "$TEST_DIRECTORY/t3900/'$msg'" >expect &&
+		'"$squash_msg"'
+		git cat-file commit HEAD^ >raw &&
+		(sed "1,/^$/d" raw | iconv -f '$new' -t utf-8) >actual &&
+		test_cmp expect actual
 	'
 }
 
-- 
2.24.0.4.g6a51fdd29c

