Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D15C433E6
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 04:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC8EC222BB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 04:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgLWEyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 23:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgLWEyo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 23:54:44 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006ABC0613D6
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 20:54:03 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id n42so8093028ota.12
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 20:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dyvmaPCxLk5NQVePYe35ajFLiHM1EkOVf4XY4jRtgtA=;
        b=Nd3GpFXt5PPqI13YFKu+4zEVCYJt4jSXB5N/IYFN+UsnQX8WHkjBbOhbKD3rz/R/3b
         ecHb5BY0o0qJAHNAQqhimQ6aGnHIHhZ6S5+EQqZDtYPc9RhCfW0ZXETVkjtYJoYPM42t
         wpHJo7teVyRUQeeWZf+bsQ1DsZLzqg5uqNn+CGwNUOcMKW05tVYy/kihpHTWexP+T0Va
         zrZvw21rno0wD4rpAFWy7IX1TMProIYTHWoFRjJyElj99qXswIdtgHKN99knwfMlFe7j
         TeqZ9SpYAGK5QFr0aVqfjUZ2JRV8/dhD5672EfGlqtXQ/U9amgPu5IFkaag7QI0QRj9q
         9U4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dyvmaPCxLk5NQVePYe35ajFLiHM1EkOVf4XY4jRtgtA=;
        b=m+imkwQ9N/DWTGwQKKDhsFGjKClKRibroTsn2JAWCtCiKTIppmBhPD5WXzdJW6DcYI
         /wI/HZCInr1xEuFGM3wD6PFgjRZLBw7Iikrj065xyKOiqFsJmofO8izQVomgAyMiyzmE
         FrVAPObiLBXN61qJaolBq1YRqYU/Lm5GrF54EclAD19mXJehAqEkVJU5RJjvs+cfIspE
         1fvibp9k0FalbCLNK24QtL2ygQ/Jq1buzs6kl6PAOT7ISPZsU3rT8mYEAhfjbVJHfH/N
         cL+QKX6ZRQ09F/FSE7PRtwwqHyoOdyCnun9mIjjZuD2NLCJ2AVENlWNRIcdIYu/YDNoF
         ctVQ==
X-Gm-Message-State: AOAM532BcrVfxKfb7v/dZs6SZ23yTCFBD64RIG+m1hqleiwZcovFeKBZ
        wq/Sf07H180Oj/UrAcJb/yAblSrKLwXMjw==
X-Google-Smtp-Source: ABdhPJxtyCCWA5M9aAz2IoGiwQFsjrIF+3vr3IOQUsoWTI+UUvqij5zmFBtma8Fv8HQiG63KwZ2miQ==
X-Received: by 2002:a05:6830:916:: with SMTP id v22mr18647055ott.257.1608699242104;
        Tue, 22 Dec 2020 20:54:02 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s24sm1505779oij.20.2020.12.22.20.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 20:54:01 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Seth House <seth@eseth.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 1/1] mergetool: add automerge configuration
Date:   Tue, 22 Dec 2020 22:53:58 -0600
Message-Id: <20201223045358.100754-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc1
In-Reply-To: <20201223045358.100754-1-felipe.contreras@gmail.com>
References: <20201223045358.100754-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The purpose of mergetools is to resolve conflicts when git cannot
automatically do so.

In order to do that git has added markers in the specific areas that
need resolving, which the user must manually fix. The tool is supposed
to help with that.

However, by passing the original BASE, LOCAL, and REMOTE files, many
changes without conflict are presented to the user when in fact nothing
needs to be done for those.

We can fix that by propagating the final version of the file with the
automatic merge to all the panes of the mergetool (BASE, LOCAL, and
REMOTE), and only make them differ on the places where there are actual
conflicts.

As most people will want the new behavior, we enable it by default.
Users that do not want the new behavior can set the new configuration
mergetool.autoMerge to false.

See Seth House's blog post [1] for the idea, and the rationale.

[1] https://www.eseth.org/2020/mergetools.html

Original-idea-by: Seth House <seth@eseth.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/mergetool.txt |  3 +++
 git-mergetool.sh                   | 17 +++++++++++++++++
 t/t7610-mergetool.sh               | 18 ++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 16a27443a3..7ce6d0d3ac 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -61,3 +61,6 @@ mergetool.writeToTemp::
 
 mergetool.prompt::
 	Prompt before each invocation of the merge resolution program.
+
+mergetool.autoMerge::
+	Remove lines without conflicts from all the files. Defaults to `true`.
diff --git a/git-mergetool.sh b/git-mergetool.sh
index e3f6d543fb..f4db0cac8d 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -239,6 +239,17 @@ checkout_staged_file () {
 	fi
 }
 
+auto_merge () {
+	git merge-file --diff3 --marker-size=7 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"
+	if test -s "$DIFF3"
+	then
+		sed -e '/^<<<<<<< /,/^||||||| /d' -e '/^=======\r\?$/,/^>>>>>>> /d' "$DIFF3" >"$BASE"
+		sed -e '/^||||||| /,/^>>>>>>> /d' -e '/^<<<<<<< /d' "$DIFF3" >"$LOCAL"
+		sed -e '/^<<<<<<< /,/^=======\r\?$/d' -e '/^>>>>>>> /d' "$DIFF3" >"$REMOTE"
+	fi
+	rm -- "$DIFF3"
+}
+
 merge_file () {
 	MERGED="$1"
 
@@ -274,6 +285,7 @@ merge_file () {
 		BASE=${BASE##*/}
 	fi
 
+	DIFF3="$MERGETOOL_TMPDIR/${BASE}_DIFF3_$$$ext"
 	BACKUP="$MERGETOOL_TMPDIR/${BASE}_BACKUP_$$$ext"
 	LOCAL="$MERGETOOL_TMPDIR/${BASE}_LOCAL_$$$ext"
 	REMOTE="$MERGETOOL_TMPDIR/${BASE}_REMOTE_$$$ext"
@@ -322,6 +334,11 @@ merge_file () {
 	checkout_staged_file 2 "$MERGED" "$LOCAL"
 	checkout_staged_file 3 "$MERGED" "$REMOTE"
 
+	if test "$(git config --bool mergetool.autoMerge)" != "false"
+	then
+		auto_merge
+	fi
+
 	if test -z "$local_mode" || test -z "$remote_mode"
 	then
 		echo "Deleted merge conflict for '$MERGED':"
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 70afdd06fa..ccabd04823 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -828,4 +828,22 @@ test_expect_success 'mergetool -Oorder-file is honored' '
 	test_cmp expect actual
 '
 
+test_expect_success 'mergetool automerge' '
+	test_config mergetool.automerge true &&
+	test_when_finished "git reset --hard" &&
+	git checkout -b test${test_count}_b master &&
+	test_write_lines >file1 base "" a &&
+	git commit -a -m "base" &&
+	test_write_lines >file1 base "" c &&
+	git commit -a -m "remote update" &&
+	git checkout -b test${test_count}_a HEAD~ &&
+	test_write_lines >file1 local "" b &&
+	git commit -a -m "local update" &&
+	test_must_fail git merge test${test_count}_b &&
+	yes "" | git mergetool file1 &&
+	test_write_lines >expect local "" c &&
+	test_cmp expect file1 &&
+	git commit -m "test resolved with mergetool"
+'
+
 test_done
-- 
2.30.0.rc1

