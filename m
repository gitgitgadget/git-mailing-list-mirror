Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D62C433EF
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 16:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbiDHQCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 12:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiDHQCh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 12:02:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D202AC6B
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 09:00:32 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m30so13644171wrb.1
        for <git@vger.kernel.org>; Fri, 08 Apr 2022 09:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zulv3Qmr/YnL3S5VuLp8emugzSHHfXNYE8BQJBGyY58=;
        b=n6XXRLWV5UL8XZXBYWYnzV9vXzwe7hJ6t1uqNMB59VKK7/FoBEcuX4RQTV9ErkYfAJ
         poZ1ijHtN9GqVBW0yw5obZchpFIFYMRhtSkjQJQz/D/4OzVfDdu0IEjUZYGMsukPqin4
         gDBFRlI6GKDSCT00wsTzt+NIDno6iPe+am7qYbPEh+bSmGw9tL1SmPG/AzIy42d3KSxA
         fjGfBxNOQRFUvOJ3h7v7D1bgMUHRehx4KHifEHYMpz7Cu2rD8CyZJsnEbDl+EabrqSuF
         n9xYPM6RZA+LRqFjx5WKItIf+lYKQnDwUjHuMy02grla+/g/hS7bvr7kyYo+tlvtZkqR
         cK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zulv3Qmr/YnL3S5VuLp8emugzSHHfXNYE8BQJBGyY58=;
        b=hzmwW8LISQ7OqEIsMaNHJHdTHWC9QttSCZzeTFtc5hOheiXqVTbxr7Wwq8RG1Fx1sD
         Va1ZUo3Hm90DoFeLgz1bRpiTnXRKGTY+T2JjvXbNm/zLiuYJzy5VteQIrT6m6zAy0W7R
         sBDVpmrZyEhYXQTYeXWGq3Dsr2Pf36U4rAN4PF5KJ8bwc7NCHrqu4pqKZ9FZ3mN2VKQM
         9zOoxXH8jaaBQiMWoWyXHsre6yYUNF0M8L4udVG9sUomcBEJI7KWK5qBbuBSOJAu11JW
         mjQAzICYi3LJMXZiQfRyUlKKT9Qj6SBfig6xdNKo1FcT9OfBoAsC7uQ+ZoFV9fLvwVlP
         XOkQ==
X-Gm-Message-State: AOAM5334MhdGob2oir2wc7uTT8Bx5ZJGacAOo/fQ+NpUyXSuFCzIZmpB
        s9+Du67s4RAcfTy0+TBnK6EScXH8Y0F/tQ==
X-Google-Smtp-Source: ABdhPJzmChjJd4xLFM4nCmw5niCSW+EZYsPy8TIVbITfJdSep4sRTwrVwM2kOM2EcZD2sSnf3+/PtQ==
X-Received: by 2002:a5d:6591:0:b0:206:1090:4044 with SMTP id q17-20020a5d6591000000b0020610904044mr15952701wru.171.1649433630765;
        Fri, 08 Apr 2022 09:00:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d64e7000000b00204a13925dcsm21514310wri.11.2022.04.08.09.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 09:00:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] ls-tree doc: document interaction with submodules
Date:   Fri,  8 Apr 2022 18:00:25 +0200
Message-Id: <patch-1.1-183b9639ae7-20220408T155704Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc0.836.g0771277f920
In-Reply-To: <20220407155231.2528221-1-martin.agren@gmail.com>
References: <20220407155231.2528221-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ls-tree documentation had never been updated after it learned to
interact with submodules to explicitly mention them. The initial
support was added in f35a6d3bce7 (Teach core object handling functions
about gitlinks, 2007-04-09). E.g. the discussion of --long added in
f35a6d3bce7 (Teach core object handling functions about gitlinks,
2007-04-09) didn't explicitly mention them.

But this documentation added in 455923e0a15 (ls-tree: introduce
"--format" option, 2022-03-23) had no such excuse, and was actively
misleading by providing an exhaustive but incomplete list of object
types we'd emit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Thu, Apr 07 2022, Martin Ågren wrote:

> Commit 455923e0a1 ("ls-tree: introduce "--format" option", 2022-03-23)
> introduced `--format` and the various placeholders it can take, such as
> %(objectname) and %(objectsize).
>
> At some point when that patch was being developed, those placeholders
> had shorter names, e.g., %(name) and %(size), which can be seen in the
> commit message of 455923e0a1. One instance of "%(size:padded)" also
> managed to enter the documentation in the final version of the patch.
> Correct it to "%(objectsize:padded)"

Thanks, perhaps this is also worth taking before the release, it's a
rather trivial inaccuracy in the docs, but something that's new since
v2.36.0.

I have some local patches to make "git ls-tree --recurse-submodules"
work, and noticed this again after it conflicted with your now-landed
fix.

 Documentation/git-ls-tree.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 8f31e2ee9d4..0240adb8eec 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -151,11 +151,11 @@ names can be used:
 objectmode::
 	The mode of the object.
 objecttype::
-	The type of the object (`blob` or `tree`).
+	The type of the object (`commit`, `blob` or `tree`).
 objectname::
 	The name of the object.
 objectsize[:padded]::
-	The size of the object ("-" if it's a tree).
+	The size of a `blob` object ("-" if it's a `commit` or `tree`).
 	It also supports a padded format of size with "%(objectsize:padded)".
 path::
 	The pathname of the object.
-- 
2.36.0.rc0.836.g0771277f920

