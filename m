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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D758C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 12:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45CC623A5B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 12:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgLRMtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 07:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgLRMtt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 07:49:49 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80FFC0617B0
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 04:49:09 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id l200so2644925oig.9
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 04:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mFP2MNZuWwFy/FWMQ10J1G6v6GsSdfk9Ajkx3tvcHf0=;
        b=QWqNmE9+Y3rXQBGjZiDPdlsU+lUbV5sU3Eq+VQiBxHhMkEWosxkYhrA7P6J4kHlRNp
         ZQGMgd6MwIo4VQXjFQD9a0yXxZnCnIR4CMHpL4W09DzCsqO82UYlxPWtBulaYYKRMVQ+
         54U4hB0ChW4gcKUP4Uz7/c2hvAH6OlNGtDT3OjBkylUVX3no3XuZgfxWtF1WhXgRmZnv
         UZTupUnACGHDxm55LYRofMlfd8yTQms0InnGzo6M90HSIlctW9p/7PT1B85iFgc6paKB
         FhP6nAI95RPNc4y4iZRN6sHOJpb8SRXc7nSBTq0YolIYS3L+Wa3oeJm3IY2PhANZ0nUH
         oA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mFP2MNZuWwFy/FWMQ10J1G6v6GsSdfk9Ajkx3tvcHf0=;
        b=VnEQnK/lpeS3etkU2WypAje+wMhx+9WgdCZTvxyAXJ/uzVJ2Sg/DrtBstqAc95FagZ
         Tbh/49G/Nkg6AhmcTKCYXFqMY9Huvyl6/1pQO6pgh4HcRZ3pIcIclZSujSwKlMBGdiMG
         bhPgkHZrvNCPfzD3/PrGfKS2wKJSRyXqP/+mZC5Vywd/pv1eCQJZO/WFHbBdE32KDpFz
         TCrQeM6+6HULPeHF4aomhPa6ghf2SdQAMo5yLjJFIPW90FgpC2+agqlKg9tPCaA1nRvW
         T782JF54YbBBvUS/8xmH6nYB33OLxM2AkwQldYYz03OdNJmYEu83DiigqAMUNo1mBmYx
         hs1Q==
X-Gm-Message-State: AOAM532ann0YZNAMoG0mXDN0Gl0bo17dMasLemhEQGYezAzYWq1b8CcK
        Ve3TNk3Ayuowp+A/rReba2vB2hhIfjlY5w==
X-Google-Smtp-Source: ABdhPJxhkOxDW3q8cVGqYDC1QhcSu6BhRPCnAuw6z8y8FdsOOGwjn3H9PPYBsb8cLL2pEtji1SgaeQ==
X-Received: by 2002:aca:d484:: with SMTP id l126mr2520203oig.151.1608295748971;
        Fri, 18 Dec 2020 04:49:08 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 186sm1713950oie.38.2020.12.18.04.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 04:49:08 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Seth House <seth@eseth.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 1/1] mergetool: add automerge configuration
Date:   Fri, 18 Dec 2020 06:49:05 -0600
Message-Id: <20201218124905.1072514-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
In-Reply-To: <20201218124905.1072514-1-felipe.contreras@gmail.com>
References: <20201218124905.1072514-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It doesn't make sense to display lines without conflicts in the
different views of all mergetools.

Only the lines that warrant conflict markers should be displayed.

Most people would want this behavior on, but in case some don't; add a
new configuration: mergetool.autoMerge.

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
2.30.0.rc0

