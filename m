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
	by dcvr.yhbt.net (Postfix) with ESMTP id B56AC1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 06:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKKGE1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 01:04:27 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45182 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfKKGE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 01:04:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id w11so8737949pga.12
        for <git@vger.kernel.org>; Sun, 10 Nov 2019 22:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jDgigy07ZC3EVPgCgByrTqPm9h94h67nRw/DSpM5D9c=;
        b=mqaaT5CWup6qxZapjoYO720uftCU7OhTE+DSc/IjNF09ELGwOOX7M9x8cBrV4sXsAY
         mJ24X1W0xqLhjmeZ0sd94cIZpJOZ4wl64JWewheGIE/mNAYNsh6q4DS5z1obDnOxiYET
         hsBEv6XPVzvYFtYpgEQwNIbNlc+Qm1GT4egl/Y61iuie6qSa1G1u/jgOIlWjkzkp+7vK
         sADyCbQYjdEpqVHaTKdb7zYWfpJE77iK3fRkcu1J5CB/jwq0lnhDPLWAz32Lxt1hWSSx
         Wg6qMO/CiirtAqrDnYMcu0KopQ0nPZq3gXKcIt+lcdd1NwlzaD+CMR63oEzMamvjdfTc
         4qfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jDgigy07ZC3EVPgCgByrTqPm9h94h67nRw/DSpM5D9c=;
        b=nhad3J35+QpgdCbZpeZ+1lEDGltAHI4sFL5SDTZ7x9mU+cR8t5Z3H/4R85WPwnAW79
         PlXNSCUW2/PmA9zi07loiabJkwVd5kPSC89nc+NSFrleb4jnVrTICnJAaZLBYzmLFbAR
         ELURNrkCBzaAujXvg+XxJw6iCHZYRblL7iOEw5oMJ7dFLZCfBYhlhRL47P9+wsKyawAA
         hDmuMUpHbtYRdgxQlW6dlX0vb3cqwJJ5mPIBjXaglZGE4pwV/tcLjA6esKz24Ps6JXYa
         qobkOLwWyH2bTG46pELIAocvZvubxYa5h9XbJK4eu0HJFSaxIVFMbeeFjL89pI4fNfIw
         yNzA==
X-Gm-Message-State: APjAAAUScFALnjGcAX6SvpRVKV+W3C648cMrNHHOdCYNYJvKnooUpBIr
        oN5v9AXQDkPyYR1lP4/5wFseqD93
X-Google-Smtp-Source: APXvYqyv1YdJXj/sAyVx1HfuOFCzeAS+EID3KBajQ6eYSAssQnL8RZ+eoN4lsIrqEOSkOZ7sdawLZQ==
X-Received: by 2002:a65:46c1:: with SMTP id n1mr5081601pgr.257.1573452265844;
        Sun, 10 Nov 2019 22:04:25 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id v16sm15112315pje.1.2019.11.10.22.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 22:04:25 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com,
        Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v6 8/9] sequencer: reencode commit message for am/rebase --show-current-patch
Date:   Mon, 11 Nov 2019 13:03:41 +0700
Message-Id: <28e82d6394e4ec07d0b20f6004e1449febe9f4a6.1573452046.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.164.g78daf050de.dirty
In-Reply-To: <cover.1573452046.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573452046.git.congdanhqx@gmail.com>
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
 sequencer.c            |   3 ++-
 t/t3434-rebase-i18n.sh |  27 +++++++++++++++++++++++++++
 t/t3434/ISO8859-1.txt  | Bin 0 -> 15 bytes
 3 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 t/t3434/ISO8859-1.txt

diff --git a/sequencer.c b/sequencer.c
index 18bc4d515d..2f32b44f52 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2970,7 +2970,8 @@ static int make_patch(struct repository *r,
 
 	strbuf_addf(&buf, "%s/message", get_dir(opts));
 	if (!file_exists(buf.buf)) {
-		const char *commit_buffer = get_commit_buffer(commit, NULL);
+		const char *encoding = get_commit_output_encoding();
+		const char *commit_buffer = logmsg_reencode(commit, NULL, encoding);
 		find_commit_subject(commit_buffer, &subject);
 		res |= write_message(subject, strlen(subject), buf.buf, 1);
 		unuse_commit_buffer(commit, commit_buffer);
diff --git a/t/t3434-rebase-i18n.sh b/t/t3434-rebase-i18n.sh
index c6c16373eb..4b5b128cd6 100755
--- a/t/t3434-rebase-i18n.sh
+++ b/t/t3434-rebase-i18n.sh
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
+		git commit -F "$TEST_DIRECTORY/t3434/$msgfile" &&
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
diff --git a/t/t3434/ISO8859-1.txt b/t/t3434/ISO8859-1.txt
new file mode 100644
index 0000000000000000000000000000000000000000..7cbef0ee6f430c611134a06a6dd6c12fbea589d5
GIT binary patch
literal 15
XcmX?d`r`R(TwDi}o~OJ>OXmUrN~8!!

literal 0
HcmV?d00001

-- 
2.24.0.164.g78daf050de.dirty

