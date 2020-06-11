Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8360CC433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5178620747
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQqmkOFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgFKMjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbgFKMjE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 08:39:04 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3787AC08C5C3
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:39:04 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k26so4886907wmi.4
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C6EvRzFuBwJOflnK1URyl96o6TiJfkCCV21wO3xyhnk=;
        b=nQqmkOFlLcy9ZvOX7LKCE5XPNUnDHtwiPKQE55Wd/EbQdBoHmLF77bJPY57KT4CBCd
         tjsPuQiNhT8ZFLp36Rzywq0EqxFSxOhcRk6Ku9e6CnEpG4aln3dd7voNFjewQ83McIkW
         zxaXvqeLU2W8aaQ4mJ3pLBjbAkawpM1PAHNOxSu3uKtjgjjUOw8FooLDvgKuvfwmiQvm
         ytQBv3ATVWC9QOzK9mkrEu7VyRXEEx4mWPINHxxGH5yZTkzd4+sN6Y6OtWqO7gqYbJWN
         GCaTWAJkuYondRtzqB1g7EcshK2ihKWR6PPKZ2ZyI4j1tf2v+sU1zV4+FVkRdw3YBlE3
         f1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C6EvRzFuBwJOflnK1URyl96o6TiJfkCCV21wO3xyhnk=;
        b=gs7jRaH2io/7CNFVO9Nm0e3Zn22ysoogzaHLaHAr6ZbDN/K1hfkugfskmh4GY0rrFl
         fZxBKEYOXIpvQKjYG/XbJZGpLxxQ1gWOTP81cySta4mSaezAJo6vO+Q7kIL9HA96UK1C
         abo4VrGlR2UCRGgzODJ9gXB1nKW/K7c9lCMQHFhN216Bpiro3trUFEbZNjEuhARIGMlw
         F4ZWMxWWFzeBEQItPVEXxK+7h4PJ4TzUbNA5ncSEBa07JriyEoiss7KkVE9bc4lqTrpX
         b9ZhnYPs/RdG0y4YKN3Vhsh2u/97/QM3VQW4ZHArFlMTBOLF8oEOGai/0nvlLQPIWLoO
         BA7w==
X-Gm-Message-State: AOAM530N5sKci+wKzd7P58X6GVBBUZoRbcLFBTf56mwqYHnWOgR6gVr7
        Opi1IP8NJgMcWGDcUYWVOo5rGbuE
X-Google-Smtp-Source: ABdhPJyWPLMWPClidrPJw1ERK3AMB9zzPXP9YHzKmyYQyUYBWqMBAjvN2kFQOWuj6IUKH88EpXZZbQ==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr7939768wmb.90.1591879142656;
        Thu, 11 Jun 2020 05:39:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e12sm4896269wro.52.2020.06.11.05.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:39:02 -0700 (PDT)
Message-Id: <6d423928512e62c91ef1ae9b469aa8cc361ed080.1591879139.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.654.git.1591879139.gitgitgadget@gmail.com>
References: <pull.654.git.1591879139.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Jun 2020 12:38:58 +0000
Subject: [PATCH 2/3] diff-files --raw: handle intent-to-add files correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In `run_diff_files()`, files that have been staged with the intention to
add are queued without a valid OID in the `diff_filepair`.

When the output mode is, say, `DIFF_FORMAT_PATCH`, the
`diff_fill_oid_info()` function, called from `run_diff()`, will remedy
that situation by reading the file contents from disk.

However, when the output mode is `DIFF_FORMAT_RAW`, that does not hold
true, and the output will contain a bogus OID (and the flag `M` for
"modified" instead of the correct `A` for "added").

As a consequence, `git difftool -d` (which relies on `git diff-files
--raw`'s output) does not work correctly.

Let's fix this specifically by imitating `diff_fill_oid_info()`.

Note: we can only do that for diff formats that do not actually need the
file contents, such as `DIFF_FORMAT_PATCH`: `run_diff()` would try to
read the blob contents, but that blob might not have been written to
Git's object database.

This fixes https://github.com/git-for-windows/git/issues/2677

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff-lib.c             | 14 ++++++++++++++
 t/t4000-diff-format.sh | 10 ++++++++++
 2 files changed, 24 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index 15bb45776e4..4af8f811ae8 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -223,6 +223,20 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 					       the_hash_algo->empty_blob, 0,
 					       ce->name, 0);
 				continue;
+			} else if (ce_intent_to_add(ce) &&
+				   !(revs->diffopt.output_format &
+				     ~(DIFF_FORMAT_RAW | DIFF_FORMAT_NAME_STATUS))) {
+				struct object_id oid;
+				int ret = lstat(ce->name, &st);
+
+				if (ret < 0)
+					oidclr(&oid);
+				else
+					ret = index_path(istate, &oid,
+						 ce->name, &st, 0);
+				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
+					       &oid, ret >= 0, ce->name, 0);
+				continue;
 			}
 
 			changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
index e5116a76a1c..48ff4e250b5 100755
--- a/t/t4000-diff-format.sh
+++ b/t/t4000-diff-format.sh
@@ -89,4 +89,14 @@ test_expect_success 'git diff-files --patch --no-patch does not show the patch'
 	test_must_be_empty err
 '
 
+test_expect_success 'git diff-files --raw handles intent-to-add files correctly' '
+	echo 123 >ita &&
+	git add -N ita &&
+	printf ":000000 100644 %s %s A\\tita\n" \
+		$ZERO_OID $(git hash-object --stdin <ita) >expect &&
+	git diff-files --raw ita >actual &&
+	test_cmp expect actual
+'
+
+
 test_done
-- 
gitgitgadget

