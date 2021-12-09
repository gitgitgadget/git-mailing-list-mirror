Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981B3C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhLIFPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhLIFPs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:15:48 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330B6C061B38
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:12:14 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id q72so5275497iod.12
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9qykvNIPX/AoQOAdJCvE0htCoEPYzxFjhwTs5wnys3Q=;
        b=PmMpIcB3ugj9MakjQ2XgkTOYznZ/bTmCTObf/wF7kj3HSVqHt6LVE2LuoaTVCi5aSu
         1HhQlyQ/L1eog+l7R4YgTomLgoAX5mFAo0FgxURpAAGaCQt/Ibg/uYQ6BooRCJo5SaN+
         DZgXEd3fF1qFxNSIM6rpP2E2D/aU3juQB2IP0u8p9aQS0yMLKuQQkLQaFA1Z3POj4TPp
         PCiZTDmY8GdmiITrItG4OUwHlyyRjY+tlReeT1MMbPwgHvOW/x4Ob9uojaAmJhslLE+Q
         7f/RYq1dP83mi/xrt1M8SlpAwyyRxdShzDM7PZUyJXiZa1gUukVxf3CzAdbJMDQL76vc
         Lo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9qykvNIPX/AoQOAdJCvE0htCoEPYzxFjhwTs5wnys3Q=;
        b=aTmIrjJEcnKSww7Clrwuyqnz7ezHXFHYwryQRvzV97ViWRzpSLzPe1GXtjBEpP5Xyy
         GbSQCmwSLPHiWl8DkqHJtT7NXkI+OhKTUQcwV4SIQ5T2OLQZ1MTpPHwwSCwsOn1M2NeX
         z/T6nuWEc48ckWt4KronheaRZ+EMNyY0Ahx282gHf/oDdqDNPg4EYBeV3fzvxMuA59Yg
         F4X0LGx2Ox2mhk2WB6MjqKR+8PYcLrWR6giDVw1OIy3JdX3rLxr5nS8dLwSLlY43c4b+
         h9r0SJG/uIW/b1M0PujNmRtkd3fk7du0niEgLOoNuRrzeZ804dDWzpBcS0LKy66kHcgT
         mpHA==
X-Gm-Message-State: AOAM5300oknZXzA1596UivLBeBgqzMtiRCOFSCPTOyKOYv3n3Ji/6KFa
        OzUXKNj6ZxLdqlrdn1d55VRHS8juX+G/og==
X-Google-Smtp-Source: ABdhPJyJWtkeTDzgHM4AizxYBd9tYREORzSaFJ+yDhPmLY4U/Mn46V3Xts7rndL70x2yp5ONeehgqA==
X-Received: by 2002:a05:6638:144f:: with SMTP id l15mr5958058jad.21.1639026733388;
        Wed, 08 Dec 2021 21:12:13 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id b8sm3127401iow.2.2021.12.08.21.12.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 21:12:12 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <ericsunshine@gmail.com>
Subject: [PATCH 07/19] t9107: use shell parameter expansion to avoid breaking &&-chain
Date:   Thu,  9 Dec 2021 00:11:03 -0500
Message-Id: <20211209051115.52629-8-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd
In-Reply-To: <20211209051115.52629-1-sunshine@sunshineco.com>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test intentionally breaks the &&-chain when using `expr` to parse
"[<path>]:<ref>" since the pattern matching operation will return 1
(failure) when <path> is empty even though an empty <path> is legitimate
in this test and should not cause the test to fail. However, it is
possible to parse the input without breaking the &&-chain by using shell
parameter expansion (i.e. `${i%%...}`). Other ways to avoid the problem
would be `{ expr $i : ... ||:; }` or test_might_fail(), however,
parameter expansion seems simplest.

IMPLEMENTATION NOTE

The rewritten `if` expression:

    if test "$ref" = "${ref#refs/remotes/}"`; then continue; fi

is perhaps a bit subtle. At first glance, it looks like it will
`continue` the loop if $ref starts with "refs/remotes/", but in fact
it's the opposite: the loop will `continue` if $ref does not start with
"refs/remotes/".

In the original, `expr` would only match if the ref started with
"refs/remotes/", and $ref would end up empty if it didn't, so `test -z`
would `continue` the loop if the ref did not start with "refs/remotes/".

With parameter expansion, ${ref#refs/remotes/} attempts to strip
"refs/remotes/" from $ref. If it fails, meaning that $ref does not start
with "refs/remotes/", then the expansion will just be $ref unchanged,
and it will `continue` the loop. On the other hand, if stripping
succeeds, meaning that $ref begins with "refs/remotes/", then the
expansion will be the value of $ref with "refs/remotes/" removed, hence
`continue` will not be taken.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t9107-git-svn-migrate.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index ceaa5bad10..aa908bbc2f 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -98,10 +98,10 @@ test_expect_success 'migrate --minimize on old inited layout' '
 	rm -rf "$GIT_DIR"/svn &&
 	for i in $(cat fetch.out)
 	do
-		path=$(expr $i : "\([^:]*\):.*$")
-		ref=$(expr $i : "[^:]*:\(refs/remotes/.*\)$")
-		if test -z "$ref"; then continue; fi
-		if test -n "$path"; then path="/$path"; fi
+		path=${i%%:*} &&
+		ref=${i#*:} &&
+		if test "$ref" = "${ref#refs/remotes/}"; then continue; fi &&
+		if test -n "$path"; then path="/$path"; fi &&
 		mkdir -p "$GIT_DIR"/svn/$ref/info/ &&
 		echo "$svnrepo"$path >"$GIT_DIR"/svn/$ref/info/url ||
 		return 1
-- 
2.34.1.307.g9b7440fafd

