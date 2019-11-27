Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8C2C43215
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BDF2082D
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1nP2d+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfK0Txf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:53:35 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38805 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfK0Txe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:53:34 -0500
Received: by mail-pj1-f65.google.com with SMTP id f7so10551876pjw.5
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hPjOtMuhVEA7iflpjkkJ1vyj/H80ZOpy/zTnsTLGS+g=;
        b=r1nP2d+D6XtOZKvgz95He6ztB/FTLlSBekkwtSnR2RTUAJokBDSeyoMERZGpSzaDQd
         Uu3avs6YRiQt1PSMe5MkOOotsS8MSAC5PeaQa+LXO4+KQZy4Hiq4AftLUyr8fDDsl9yU
         wUawlbghb2yyKoo5190IibAduY5X+me4ODllzcGBg1l8H6cJiSE6jzsWz7iH7IrTF4/k
         YyiZENk6QmKhlXjFpl4qPRvY46aCPVw4qhe8pLdf3f722jI+sSLDJORTX9H87aJQrVSG
         fOhEOW3pcFQetlHSh7ONgxk6Urx1MWgN4yFameI3D1Bde8Dpkq/ODuesjUpJ9fws3v4X
         eXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hPjOtMuhVEA7iflpjkkJ1vyj/H80ZOpy/zTnsTLGS+g=;
        b=ng+2IecG741efyo32ewwIjSFkhioCs1mCwoWMHk5JpmmIXZwIHd0nYoYmWUcfN+Olb
         1TrdDLeQ8DW9N77DKYZ4C42Ua7ZXL5rpi9IqClUxe7EhWMx7/OGDO6E+A8GrrRNjUlxT
         a/vIFahpybFdt07BlhrPuaB60t84cNYx6YbuyAGbw0gS3SbF3Yjvg7YAejIt3BQGrpPk
         LQe63ofszmHTOXc0he+slPJPcG1HEMonMy63D1Az0FsOzqslc9sd1LiRRsNpKZLJCfkn
         62tvJP8GtF6Ex9k6ZtrgGez3hO3JLrWPTKVXtLR+tKwZpZb4dSVOjc9VIOtYUtXoU/Hk
         1+6g==
X-Gm-Message-State: APjAAAWYCwjlKm3A29QHdjhPe1qNsC78R+TRm0UwHim796Lcgs7B46mT
        /xHJdeHJTmpYIyIH0Q+Cgmumqqk8
X-Google-Smtp-Source: APXvYqxNwpMInDILdQw/K/ufY2ryRhUpVwp/5c3CXUUpkXJjnd3hVxKcgjbEx+Sqx1v/jH+u33a2IQ==
X-Received: by 2002:a17:90a:e90:: with SMTP id 16mr8090068pjx.65.1574884413653;
        Wed, 27 Nov 2019 11:53:33 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id w62sm17862877pfb.15.2019.11.27.11.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:53:32 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:53:31 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 12/26] t5317: stop losing return codes of git commands
Message-ID: <1e08c2b68ba041f5bc94695481ddbd106e9bb4f4.1574884302.git.liu.denton@gmail.com>
References: <cover.1574731022.git.liu.denton@gmail.com>
 <cover.1574884302.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574884302.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, there are two ways where the return codes of git commands are
lost. The first way is when a command is in the upstream of a pipe. In a
pipe, only the return code of the last command is used. Thus, all other
commands will have their return codes masked. Rewrite pipes so that
there are no git commands upstream.

The other way is when a command is in a non-assignment command
substitution. The return code will be lost in favour of the surrounding
command's. Rewrite instances of this such that git commands output to a
file and surrounding commands only call command substitutions with
non-git commands.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5317-pack-objects-filter-objects.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 2d2f5d0229..a8bbad74e2 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -72,7 +72,8 @@ test_expect_success 'get an error for missing tree object' '
 	echo foo >r5/foo &&
 	git -C r5 add foo &&
 	git -C r5 commit -m "foo" &&
-	del=$(git -C r5 rev-parse HEAD^{tree} | sed "s|..|&/|") &&
+	git -C r5 rev-parse HEAD^{tree} >tree &&
+	del=$(sed "s|..|&/|" tree) &&
 	rm r5/.git/objects/$del &&
 	test_must_fail git -C r5 pack-objects --revs --stdout 2>bad_tree <<-EOF &&
 	HEAD
@@ -230,10 +231,9 @@ test_expect_success 'verify explicitly specifying oversized blob in input' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1k >filter.pack <<-EOF &&
-	HEAD
-	$(git -C r2 rev-parse HEAD:large.10000)
-	EOF
+	echo HEAD >objects &&
+	git -C r2 rev-parse HEAD:large.10000 >>objects &&
+	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1k <objects >filter.pack &&
 	git -C r2 index-pack ../filter.pack &&
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
@@ -377,7 +377,8 @@ test_expect_success 'verify sparse:oid=OID' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	oid=$(git -C r4 ls-files -s pattern | awk -f print_2.awk) &&
+	git -C r4 ls-files -s pattern >staged &&
+	oid=$(awk -f print_2.awk staged) &&
 	git -C r4 pack-objects --revs --stdout --filter=sparse:oid=$oid >filter.pack <<-EOF &&
 	HEAD
 	EOF
-- 
2.24.0.504.g3cd56eb17d

