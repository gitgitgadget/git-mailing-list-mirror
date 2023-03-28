Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76594C6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 13:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjC1N7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 09:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjC1N7O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 09:59:14 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E915710E0
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o32so7013950wms.1
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680011952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTg9l3pkjLM+aNV5Yt3feJA1wIzjFB8xX+MVcbsEomc=;
        b=QDxtRBJYboPtJp8hHonw9XSi3FZ0CzzNRPE6R9JffdrkT7+6UQUVwIZ5tOzp7tBOh+
         ywezS8chbCCfzJj1wzryN/ynlooHneF7QY4qSuBkvIF08LgIavh2kw/K6oZo5ZEoXom2
         ghfzSvMh7N4cobOzhdqZSlBMYNbFnk4Z2Qn7EuDfm5n9UWPV3/Nams4f2B/FGMVWRgQM
         HSs40dwEyFIm5sSotsODBFeoHn4YXmf9v3nEtmR9vtHrfBsy+gp4cUDiKWf81qaSqVMH
         rwfWdOAsDVJd7QJOS5Y3B4uROUoCQDbF549g00IOJspxRoy82hY4kiuDMIJ6KHJZUTxY
         seGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680011952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTg9l3pkjLM+aNV5Yt3feJA1wIzjFB8xX+MVcbsEomc=;
        b=IH4TuB3HzfUV90d3dGx4FaaMmC+s2WIdgv2VE0p8HGWWKlC3hgfoRaSGHKKSiyhXys
         qfJA6OkPc1k6S14s6hOG3MEaAq373fYHyS2w1SMmwc3VjeLo8+1LCIl/KBkFqEZfcjhg
         bV8hp7UdOhg5w9y+TJqPsMJOiGHwB5QxXlq09J1qqvO3vbq4mfVFo89wDfac4Rslv9In
         XKoquOfpbCmkQgrk8lQQzBZrnq5bBW9q39kxkJLl4d3pBAjTYpz9a6HhuzkPogYpn2NF
         Z/EPipiXYoL96IT/GEHJ5cKq7OxQHaOY8G3nXtOLS1VoMPxSz9t1g9Z7+3OP2SPhOBjL
         hqQA==
X-Gm-Message-State: AO0yUKWauxkt4FB76P63SPQrvFzegMBDjm68jD0IAeLaC7tYAd72tNr6
        5dWWJxgxPjmAPzCbePjQ99Ro1qC9e0la1g==
X-Google-Smtp-Source: AK7set93fSMItUJtJjpMWuuySIHpQDNWPaQB1aSUQT/l263Kjji/fSok0jFxR244jQNrCXntT/ROvQ==
X-Received: by 2002:a7b:ce08:0:b0:3ee:da1:135f with SMTP id m8-20020a7bce08000000b003ee0da1135fmr12435387wmc.7.1680011952092;
        Tue, 28 Mar 2023 06:59:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003ede2c59a54sm6252268wmo.37.2023.03.28.06.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:59:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/17] cocci: sort "the_repository" rules by header
Date:   Tue, 28 Mar 2023 15:58:44 +0200
Message-Id: <patch-v2-03.17-a3fcd19d744-20230328T110946Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sort the "the_repository.pending.cocci" file by which header the
macros are in, and add a comment to that effect in front of the
rules. This will make subsequent commits easier to follow, as we'll be
applying these rules on a header-by-header basis.

Once we've fully applied "the_repository.pending.cocci" we'll keep
this rules around for a while in "the_repository.cocci", to help any
outstanding topics and out-of-tree code to resolve textual or semantic
conflicts with these changes, but eventually we'll remove the
"the_repository.cocci" as a follow-up.

So even if some of these functions are subsequently moved and/or split
into other or new headers there's no risk of this becoming stale, if
and when that happens the we should be removing these rules anyway.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .../coccinelle/the_repository.pending.cocci   | 34 +++++++++++--------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 99e192736ee..84b79dce480 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -5,21 +5,7 @@
 @@
 @@
 (
-- read_object_file
-+ repo_read_object_file
-|
-- has_object_file
-+ repo_has_object_file
-|
-- has_object_file_with_flags
-+ repo_has_object_file_with_flags
-|
-- parse_commit_internal
-+ repo_parse_commit_internal
-|
-- parse_commit
-+ repo_parse_commit
-|
+// commit-reach.h
 - get_merge_bases
 + repo_get_merge_bases
 |
@@ -34,6 +20,13 @@
 |
 - in_merge_bases_many
 + repo_in_merge_bases_many
+// commit.h
+|
+- parse_commit_internal
++ repo_parse_commit_internal
+|
+- parse_commit
++ repo_parse_commit
 |
 - get_commit_buffer
 + repo_get_commit_buffer
@@ -43,6 +36,17 @@
 |
 - logmsg_reencode
 + repo_logmsg_reencode
+// object-store.h
+|
+- read_object_file
++ repo_read_object_file
+|
+- has_object_file
++ repo_has_object_file
+|
+- has_object_file_with_flags
++ repo_has_object_file_with_flags
+// pretty.h
 |
 - format_commit_message
 + repo_format_commit_message
-- 
2.40.0.rc1.1034.g5867a1b10c5

