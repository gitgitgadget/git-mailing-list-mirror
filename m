Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068DBC432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE23D20855
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2iWsNkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfKUAp5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:45:57 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40504 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfKUAp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 19:45:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id r4so691864pfl.7
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 16:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uy6X0TnRvRyKWmpUmBzpPYlnpMezkJJG9AX7PhO8iB0=;
        b=e2iWsNkZqaZyoW7HLpkoJTOwKeHTJWu9/Lyo4tXaVKqhpmGwytqHOAi6HpAtmpzmm3
         G9XLOL59NdpoMbnt/GFOkqE3Gemat88XQHGm6s1Dz8Py9Ku0Y/NXEcjfodQuzO1aoeRc
         XsiEqguQad5n/Gd8Gosw5H8bBoo954+0Y3rUm6xvAqWscMg9+NYyQ4pj8+LYtbHlGZcp
         og6E5HhMQTBjnO1AXEfGc1yVsYzk4VMkoRFyA2RKsVYd5m8yvy95vrfDBDAFqvOzRFKs
         Efjbnp3J8PBx7nvY8Q488tRYzCqO92a69RznopO1KiXEbmN9Fvc9ByKHH9bDM4BnrXSd
         jwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uy6X0TnRvRyKWmpUmBzpPYlnpMezkJJG9AX7PhO8iB0=;
        b=uYGIgC02k5bkUFO73HvT9sX7XbZYv/BmVVgI2OtlYoCG6ZqMwkfiHhJ/NUks0QEFmR
         Ut8eele9atIsjPEFJcnwQE5QqB9mGueoIojJDOJpwzALmCyd9DKpHMgcp/spicIKT9EX
         r3TLpB6BJie/OIrd8IWPPNMCWGT7Jwzu+T6yZH4SPHnkZPrxH9BImKidhaIo2i2f+fNj
         VW6WmD8Et4g/ntOQmjI1lRKR11MoVkqCBoBJ3525BmwZ6Pwz4pM7R4YwbhzXU0Gg0TdZ
         Jx0P1fmt7T8hUuyPO/Uyc2PoJAnAeM+K2K0bzwnEOgxnDAqiejoIoQKphBV1M4AzsFlK
         6Duw==
X-Gm-Message-State: APjAAAU5Ml7ofaWZD4meuT2T5/porOjIlkKg/wI+o+jW1+gcz4QdQ2Fw
        gQZAfm49HZLG+zLsFGObVEnDq2gX
X-Google-Smtp-Source: APXvYqyyiYfGg2t04wldPGPWGFVFhQwdHfprJiqJJep68RVroKlYRCkQ77M1sDYHHkgG6y5SQ2OlTw==
X-Received: by 2002:a63:e407:: with SMTP id a7mr6135582pgi.92.1574297155466;
        Wed, 20 Nov 2019 16:45:55 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id r4sm611552pfl.61.2019.11.20.16.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:45:54 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:45:53 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 03/21] t0090: stop losing return codes of git commands
Message-ID: <52d8933ac9daabcb7c2693e338c11f6c6d335ecf.1574296987.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
 <cover.1574296987.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574296987.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In generate_expected_cache_tree_rec(), there are currently two instances
of `git ls-files` in the upstream of a pipe. In the case where the
upstream git command fails, its return code will be lost. Extract the
`git ls-files` into its own call so that if it ever fails, its return
code is not lost.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t0090-cache-tree.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index ce9a4a5f32..5a633690bf 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -21,9 +21,10 @@ generate_expected_cache_tree_rec () {
 	parent="$2" &&
 	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
 	# We want to count only foo because it's the only direct child
-	subtrees=$(git ls-files|grep /|cut -d / -f 1|uniq) &&
+	git ls-files >files &&
+	subtrees=$(grep / files|cut -d / -f 1|uniq) &&
 	subtree_count=$(echo "$subtrees"|awk -v c=0 '$1 != "" {++c} END {print c}') &&
-	entries=$(git ls-files|wc -l) &&
+	entries=$(wc -l <files) &&
 	printf "SHA $dir (%d entries, %d subtrees)\n" "$entries" "$subtree_count" &&
 	for subtree in $subtrees
 	do
-- 
2.24.0.450.g7a9a4598a9

