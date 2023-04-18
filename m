Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC787C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 20:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjDRUlN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 16:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjDRUlA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 16:41:00 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CDDB77D
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 13:40:56 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-555bc7f6746so29773397b3.6
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 13:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681850455; x=1684442455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Znitps7bkYZ+IufIXRXGt7XWOPXXw9/MsW2Wk7xDbyo=;
        b=GszwfOrmVveNexlGOMPIqP8DWYmuDchKIPinxZg0HP3APSHCf7N7+6p7Niz/UtAhS2
         YwIvxTdQC5rRrn9BtcXuQ2jk5QVQJ+oJVypX160SuAD8/ZiuaciWIsMZqJW7tbJ+K+cM
         A7rtqMzXLdemGUoQX+k78pZeyZ+YQlQ9wNCVMJiRQdg012ahBMXXDrwwDOly5a3Cwj8w
         j3sLc8HimN+wX6QW5ffLGSM96CALpoQx1LYv+RkIpz6l9+iog1L9ANBy3ADhbK+7arKs
         w/CKgRyeMiyUgGOdti7IMWXtEMEStiaZVnWOKPEQ/tqzJFUOu6aLwNxjXF2O65f5IyEW
         0iaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681850455; x=1684442455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Znitps7bkYZ+IufIXRXGt7XWOPXXw9/MsW2Wk7xDbyo=;
        b=FBHTrKvUzIJjnmoP66CIocZT8Ovmme9WX/SRjxce0aAVa5Ju1VuWtxcyuuGuWzF0IY
         b/Xx44PpbJbB5ZI2whDDKnvjz6fvdcia8SMKytRPgUzdiWfrda4EaE63KN6sdaIhvqgF
         qbJxVEEdyowApKdomJq8AGQcarKaFc59j6AStn82x+gpcggcHIQvulFIUUs3an9HBqTM
         nQQ0vthE98sjCNF1m7WXJLK3UphBgsKttQwfuspi7Jb0KKsbqH8y8ooLHFDp/ZzjAmmR
         PcJzbvdvz1vMRCIXLD0j0ItzKCGAWUkGYlntrPqDRW4bZBgCPhHOATnzqZpdSgDJWO6b
         hMGw==
X-Gm-Message-State: AAQBX9dp6QU2ggzM6uJjrT1pOqOcp556qoJN2V5Gltkm3WacYNd2Bv1g
        X5/rmQrUafzYcvzwIfpXZVWXbNVYDXyjfMxorVSRXg==
X-Google-Smtp-Source: AKy350ac6X8La5pjmCvqXCI6VjpsBlCd+PCoinaR9QBf9jhfLWoRa8P2Dj7k0WgYhE5Uy3pOFeNyOQ==
X-Received: by 2002:a0d:d203:0:b0:54f:cf3a:2604 with SMTP id u3-20020a0dd203000000b0054fcf3a2604mr1056835ywd.41.1681850455653;
        Tue, 18 Apr 2023 13:40:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t22-20020a817816000000b00545a0818494sm4100020ywc.36.2023.04.18.13.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 13:40:53 -0700 (PDT)
Date:   Tue, 18 Apr 2023 16:40:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/10] t/t9300-fast-import.sh: prepare for `gc --cruft` by
 default
Message-ID: <894cf176ea8911e615cb59857b93a2765ca6ba9d.1681850424.git.me@ttaylorr.com>
References: <cover.1681764848.git.me@ttaylorr.com>
 <cover.1681850424.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681850424.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar fashion as previous commits, adjust the fast-import tests
to prepare for "git gc" generating a cruft pack by default.

This adjustment is slightly different, however. Instead of relying on us
writing out the objects loose, and then calling `git prune` to remove
them, t9300 needs to be prepared to drop objects that would be moved
into cruft packs.

To do this, we can combine the `git gc` invocation with `git prune` into
one `git gc --prune`, which handles pruning both loose objects, and
objects that would otherwise be written to a cruft pack.

Likely this pattern of "git gc && git prune" started all the way back in
03db4525d3 (Support gitlinks in fast-import., 2008-07-19), which
happened after deprecating `git gc --prune` in 9e7d501990 (builtin-gc.c:
deprecate --prune, it now really has no effect, 2008-05-09).

After `--prune` was un-deprecated in 58e9d9d472 (gc: make --prune useful
again by accepting an optional parameter, 2009-02-14), this script got a
handful of new "git gc && git prune" instances via via 4cedb78cb5
(fast-import: add input format tests, 2011-08-11). These could have been
`git gc --prune`, but weren't (likely taking after 03db4525d3).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t9300-fast-import.sh | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index aa55b41b9a..ac237a1f90 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -388,9 +388,7 @@ test_expect_success 'B: accept branch name "TEMP_TAG"' '
 
 	INPUT_END
 
-	test_when_finished "rm -f .git/TEMP_TAG
-		git gc
-		git prune" &&
+	test_when_finished "rm -f .git/TEMP_TAG && git gc --prune=now" &&
 	git fast-import <input &&
 	test $(test-tool ref-store main resolve-ref TEMP_TAG 0 | cut -f1 -d " " ) != "$ZERO_OID" &&
 	test $(git rev-parse main) = $(git rev-parse TEMP_TAG^)
@@ -406,8 +404,7 @@ test_expect_success 'B: accept empty committer' '
 	INPUT_END
 
 	test_when_finished "git update-ref -d refs/heads/empty-committer-1
-		git gc
-		git prune" &&
+		git gc --prune=now" &&
 	git fast-import <input &&
 	out=$(git fsck) &&
 	echo "$out" &&
@@ -452,8 +449,7 @@ test_expect_success 'B: accept and fixup committer with no name' '
 	INPUT_END
 
 	test_when_finished "git update-ref -d refs/heads/empty-committer-2
-		git gc
-		git prune" &&
+		git gc --prune=now" &&
 	git fast-import <input &&
 	out=$(git fsck) &&
 	echo "$out" &&
@@ -1778,8 +1774,7 @@ test_expect_success 'P: verbatim SHA gitlinks' '
 	INPUT_END
 
 	git branch -D sub &&
-	git gc &&
-	git prune &&
+	git gc --prune=now &&
 	git fast-import <input &&
 	test $(git rev-parse --verify subuse2) = $(git rev-parse --verify subuse1)
 '
-- 
2.40.0.362.gc67ee7c2ff

