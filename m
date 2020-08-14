Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEA9C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 00:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A126520771
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 00:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN+OFHCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHNAXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 20:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgHNAXW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 20:23:22 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07015C061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 17:23:22 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d188so3690192pfd.2
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 17:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RRwTaJ4QOSsDiMn+zvf7m4cV1fp7oWDV2lGQzrdjkVA=;
        b=IN+OFHCY+ch+mt349JCPTMGSw4sF0q3NTP6zls5rTpcBFE1k8feF1po3r9dlfqAaBo
         9fX4lZa1XkytwZpgc20dj1YvACMqyYO0JJKxk0tCaaAOtJpI1wk48VG9aqhnBUhosqct
         3c7ZtZxbJaXqqDDS+zIOZN2eJapVLu3KttNyUkcY059LMN6HSMjcyfUC5BPfgEVBE8Kv
         8yZM8EJ7n9yHIS/oqQo6OAWj84wOskA5Rzgy11C4DeeIybbFFR2mUF/UI6sn+1dPMw+v
         Hn5rF0rY8pMbljRGPLC9qnU5hJgufFVsBgVg8x8NbxUGCOaTavH9O2rwJ3OKOZJd8EOr
         s81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RRwTaJ4QOSsDiMn+zvf7m4cV1fp7oWDV2lGQzrdjkVA=;
        b=OSrAxBRnHSyPosszFu2OPJP3IVdeKLoZ+bCx5ev1zUpZ9NJMRIwsvGkf99UNTXhBec
         wAFHOhiEj+4Wia5D/4VFd02yz1kJFjZbB4QZf/fq156Ilangv0VYwGlW2Bo2uY54tCVE
         jr27+7W+9Ii4jC+6r0mi0JYgPrLpkYiPND3y5sF3l2yvelo5PCAirMsYfzLyAu1EKb0F
         9EdVcXdntZARZtFnTTduDKoIcCQNr39jwICEkRLo3xakocgZSYX4eqzkYXOVZnIAjjy/
         AoNb1xfLcXgu5UfzsGKR3bJJVXJZo34Cbio3f2jGG50vHicjAdNrWjXk0Op89Yq78Mpa
         pNPQ==
X-Gm-Message-State: AOAM533wFqjRxZ0fjIcAHIeblIK8xMsbRPCgbda2OxQmPxD3Ii7Q8kqx
        EkETxyk2ZJSqUeIUFu0dnMJ2O2jq
X-Google-Smtp-Source: ABdhPJwihf6F//gvzOhBYuOUOHY8S4OE2mdl6SC+XfYmHGciQycM/sET7QJiHEandsyNBxj33r4yNA==
X-Received: by 2002:a63:7c9:: with SMTP id 192mr67986pgh.181.1597364601199;
        Thu, 13 Aug 2020 17:23:21 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:3f71:3e6:8db2:d7ba:5d94])
        by smtp.gmail.com with ESMTPSA id 203sm6435475pge.34.2020.08.13.17.23.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2020 17:23:20 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3 0/2] diff: index-line: respect --abbrev in object's name
Date:   Fri, 14 Aug 2020 07:23:08 +0700
Message-Id: <cover.1597364493.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.28.0.215.g32ffa52ee0
In-Reply-To: <cover.1596887883.git.congdanhqx@gmail.com>
References: <cover.1596887883.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For diff-family, Git supports 2 different options for 2 different
purposes, `--full-index' for showing diff-patch object's name in full,
and `--abbrev' to customize the length of object names in diff-raw and
diff-tree header lines, without any options to customise the length of
object names in diff-patch format. When working with diff-patch format,
we only have two options, either full index, or default abbrev length.

Although, that consistent is documented, it doesn't stop users from
trying to use `--abbrev' with the hope of customising diff-patch's
objects' name's abbreviation.

Let's resolve that inconsistency.

Đoàn Trần Công Danh (2):
  revision: differentiate if --no-abbrev asked explicitly
  diff: index-line: respect --abbrev in object's name

 Documentation/diff-options.txt                |  9 +++---
 diff.c                                        |  5 +++-
 revision.c                                    |  2 +-
 t/t4013-diff-various.sh                       |  3 ++
 ...ff.diff-tree_--root_-p_--abbrev=10_initial | 29 +++++++++++++++++++
 ...--root_-p_--full-index_--abbrev=10_initial | 29 +++++++++++++++++++
 ...f.diff-tree_--root_-p_--full-index_initial | 29 +++++++++++++++++++
 7 files changed, 100 insertions(+), 6 deletions(-)
 create mode 100644 t/t4013/diff.diff-tree_--root_-p_--abbrev=10_initial
 create mode 100644 t/t4013/diff.diff-tree_--root_-p_--full-index_--abbrev=10_initial
 create mode 100644 t/t4013/diff.diff-tree_--root_-p_--full-index_initial

Range-diff against v2:
1:  9daef7445c ! 1:  9a26c5b611 revision: differentiate if --no-abbrev asked explicitly
    @@ Metadata
      ## Commit message ##
         revision: differentiate if --no-abbrev asked explicitly
     
    -    When we see `--no-abbrev' in command's arguments, we reset `abbrev' of
    -    `diff_options` to 0, thus, on a later stage, the object id won't
    -    be shortened (by not set object_id[abbrev] to '\0').
    +    When we see --no-abbrev in command's arguments, we reset the 'abbrev'
    +    field in diff-options to 0 and this value will be looked at
    +    diff_abbrev_oid() to decide not to truncate the object name.
    +
    +    In a later change, we want to extend --abbrev support to diff-patch
    +    format. When --abbrev supporting diff-patch, we need to differentiate
    +    those below scenarios:
    +
    +    * None of those options --abbrev, --no-abbrev, and --full-index are
    +      asked. diff-patch should keep old behavior of using DEFAULT_ABBREV
    +      for the index length.
    +    * --no-abbrev is asked, diff-patch should treat this option as same as
    +      --full-index and show full object name in index line.
     
         While not doing anything is very effective way to show full object id,
         we couldn't differentiate if --no-abbrev or not.
     
    -    In a later change, we want to extend --abbrev support to diff-patch
    -    format.
    +    We can differentiate those above scenarios by either:
    +    * Add a new field in diff-options to mark if --no-abbrev was asked.
    +      With this option, we have a new field for a single purpose, and one
    +      more thing to worry about.
    +    * Treat --no-abbrev as same as --full-index. This option is problematic,
    +      since we want to allow --abbrev overwrite --no-abbrev again.
    +      On the other hand, we also need to keep our promises with scripter
    +      who uses --full-index to ask for full object names in index line,
    +      so, we need to respsect --full-index regardless of --abbrev.
    +    * Set 'abbrev' field in diff-options to the length of the hash we are
    +      using. With this option, we can differentiate if --no-abbrev was asked
    +      ('abbrev' is hash's length) or none of --[no-]abbrev was asked
    +      ('abbrev' is '0'), script with --full-index still works and our
    +      headache is kept as is.
     
    -    Let's ask for full object id if we see --no-abbrev instead.
    +    Let's ask for full object id if we see --no-abbrev.
     
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
2:  12acf1fe5d = 2:  760df7782d diff: index-line: respect --abbrev in object's name
-- 
2.28.0.215.g32ffa52ee0

