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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1A1C0018C
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 02:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF0423741
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 02:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgLQCgT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 21:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgLQCgO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 21:36:14 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DD8C061794
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 18:35:34 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id o11so25715562ote.4
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 18:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CRoH8BYdDdvIhIp1wiqr3ddqUme/xBnraJ5blDmo2dw=;
        b=PFE9ONfDg1Vj7wyiLw9lVSMjspDDGVNG35fSI7RlXAtGf7PPrV92gZI2lW0I5rKYO0
         QsREJjpsocl3KHM2fwmRZX8NHcqWVAz7oXInh60qqNvAZE7lkbfPgRxJy/cVNPqKlJEF
         NacR8WBqe7E+NSYMQdawtthffCtxhMYyKrUzw48FNJGqQd9NAL27QzbgTWqFJAHJAUNz
         R43OiZN4d1hwIQe45fGboiV0rAtCokH/G1/VPGslin4vvqOJJSUa8Luu6H8T0C8E4uKv
         E3J2SE0C5nFH+VfhaA1ou3FqceI7vm6vkz/9u1YJ7k2vKVK4KDqUmRVyhyeR7Jn8TFGg
         vUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CRoH8BYdDdvIhIp1wiqr3ddqUme/xBnraJ5blDmo2dw=;
        b=AIZiLcQM4HdP8H4+OdT0IH+wQ6AIndvlheyW6J9xd9ePvwceFqMJLBUMcb7m4z6Lv5
         uYVTahlDJvYkUXTRsCVRU2VJXqSh7qGfSO83zp3rCI/9qbbnrPCdpgIAX2KaZcqtPYCY
         Ckvvd2dd4bzNTdkXWSIWW6yvI2DmySwAOcdjic+FzD0lI0MbzMjTsid4rMOikNRWpJqG
         59BGJrtguA4nmHe0Tv8RJf+HCvUgqRV2rbhOV7H9qz4Vd6enCgK3phpk5+jh9N9zzJfw
         iUgRMW8f97wBFKSijl4wdlOdw82rHY0v+yJUIJ/egVUgbYHL1EQmI+nM7Ou/MHJ34dn+
         4cSA==
X-Gm-Message-State: AOAM530n82uZDE8BZW03j6EUHe/Ttuwe8YxUZ2V+6QnoIJu/beIlEMre
        QrjbL4dOTAReTbvnIov7DNQnE96UPYQAxA==
X-Google-Smtp-Source: ABdhPJwE20yJQ9JI/MorAyltdLF7bdQOZgwDGcdJaAvansTjfTvYM+2CRfbhvfW08kQCoVYhnADeQQ==
X-Received: by 2002:a05:6830:1398:: with SMTP id d24mr29156584otq.199.1608172533006;
        Wed, 16 Dec 2020 18:35:33 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id j126sm850808oib.13.2020.12.16.18.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 18:35:32 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Seth House <seth@eseth.com>
Subject: [RFC/PATCH v2] mergetool: use resolved conflicts in all the views
Date:   Wed, 16 Dec 2020 20:35:31 -0600
Message-Id: <20201217023531.754464-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
In-Reply-To: <20201216174345.28146-1-felipe.contreras@gmail.com>
References: <20201216174345.28146-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It doesn't make sense to display easily-solvable conflicts in the
different views of all mergetools.

Only the chunks that warrant conflict markers should be displayed.

TODO: There should be a better way to get the BASE version (maybe add
--base to git mergetool). Or maybe a way to generate the three files in
one go.

See Seth House's blog post [1] for the idea and the rationale.

[1] https://www.eseth.org/2020/mergetools.html

Cc: Seth House <seth@eseth.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-mergetool.sh     | 11 +++++++++++
 t/t7610-mergetool.sh | 17 +++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index e3f6d543fb..2f71da4574 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -322,6 +322,17 @@ merge_file () {
 	checkout_staged_file 2 "$MERGED" "$LOCAL"
 	checkout_staged_file 3 "$MERGED" "$REMOTE"
 
+	# TODO Shouldn't merge-file have a --base option?
+	git merge-file --diff3 -q -p "$LOCAL" "$BASE" "$REMOTE" |
+		sed -e '/^<<<<<<< /,/^||||||| /d' -e '/^=======$/,/^>>>>>>> /d' \
+			>"${BASE}_resolved"
+	git merge-file --ours -q -p "$LOCAL" "$BASE" "$REMOTE" >"${LOCAL}_resolved"
+	git merge-file --theirs -q -p "$LOCAL" "$BASE" "$REMOTE" >"${REMOTE}_resolved"
+
+	mv -f "${BASE}_resolved" "$BASE"
+	mv -f "${LOCAL}_resolved" "$LOCAL"
+	mv -f "${REMOTE}_resolved" "$REMOTE"
+
 	if test -z "$local_mode" || test -z "$remote_mode"
 	then
 		echo "Deleted merge conflict for '$MERGED':"
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 70afdd06fa..69260c4a46 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -828,4 +828,21 @@ test_expect_success 'mergetool -Oorder-file is honored' '
 	test_cmp expect actual
 '
 
+test_expect_success 'skip unnecessary chunks' '
+	test_when_finished "git reset --hard" &&
+	git checkout -b test${test_count}_b master &&
+	echo -e "base\n\na" >file1 &&
+	git commit -a -m "base" &&
+	echo -e "base\n\nc" >file1 &&
+	git commit -a -m "remote update" &&
+	git checkout -b test${test_count}_a HEAD~ &&
+	echo -e "local\n\nb" >file1 &&
+	git commit -a -m "local update" &&
+	test_must_fail git merge test${test_count}_b &&
+	yes "" | git mergetool file1 &&
+	echo -e "local\n\nc" >expect &&
+	test_cmp expect file1 &&
+	git commit -m "test resolved with mergetool"
+'
+
 test_done
-- 
2.30.0.rc0

