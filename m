Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9DFC432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 18:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53042071B
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 18:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtMiNHjj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfKVS75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:59:57 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35380 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfKVS74 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 13:59:56 -0500
Received: by mail-pg1-f195.google.com with SMTP id k32so3747200pgl.2
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 10:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Pz7vCfWUtWUdMvd46FoAS0DSLG63N1oGwR0s5ss3js=;
        b=KtMiNHjjOnCyZRdLeOQBfwycUUx3bPuEy0upwMBD5lUrzzV19ButiK/vLxCGR1tDPg
         Q6D6gieLznLPa0GnSHHIXb5uln+ObWNmujpO5q7PwUomrQJEvX01CfaQppd0EUbx6Fev
         YNhWEY69zosnVWKOSh+KjVRELwiM9Q+sQkXBqHhQ5H+0NriBfPAaFdTzJ0wYbYQoR80D
         FP5yiGyfGkbbIQypEYHEYAmfw+T7Q6TfVaJX37jyrhRkuscQA6Jac2aejAmAWLM7gI2h
         uSyZCNNANi8og3J/wH9XsiZDDkq3pP5OJhwV753lN6WosB5XYW9cAP9tjLBfcbh9yeAT
         aOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Pz7vCfWUtWUdMvd46FoAS0DSLG63N1oGwR0s5ss3js=;
        b=tya1JjcbAc4D5+8efYeULCPl8LQysiTXEkL/I8THbjyxAG1e9B3as4ElWzgHRj695N
         odQcQohYU+2pikioWn0N3ujc8q320DPBOR3sgKP1eztBmQ88kY+AJv0igFg9SVgIP4uX
         2qMrl34FmOmJzLduHbtlvKWEGRl/ay1BAWrsKLuK2DlPv854kC9gnHsx33gUdtJh7LUi
         CfpR1n6mjvZ1ubydE+K40Sxw2dGSqGmW9HlwxrLrpNqtwI1tGnRn3FllQ0TMYnoiASt8
         itb63eyu1IGnBhTJr/WvXpCbnkY0GYQ4h5bEFcnhrEZCkO2ijRCiLNU8LHwM96LmOto1
         fVgg==
X-Gm-Message-State: APjAAAUPSnPir7C6Ril0ZtLVq47vvTv1YbgTfoSVUf8F8r1eiVBGc8XV
        oPCXsAjH7D0eGQxgLr6kMTZzUxAl
X-Google-Smtp-Source: APXvYqwIU5DC61tAToKjrLWGFDyGQN+zpWFVmWYcnY+JLvldXPM2KBZ8ceB78JCIJOh36ZCfh6W3YA==
X-Received: by 2002:a63:de08:: with SMTP id f8mr17444039pgg.107.1574449194057;
        Fri, 22 Nov 2019 10:59:54 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id a16sm7299333pgb.7.2019.11.22.10.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 10:59:53 -0800 (PST)
Date:   Fri, 22 Nov 2019 10:59:51 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 04/22] t0090: stop losing return codes of git commands
Message-ID: <28ddc6c79d21b91de4f5ef3185612e7bb1c53651.1574449072.git.liu.denton@gmail.com>
References: <cover.1574296987.git.liu.denton@gmail.com>
 <cover.1574449072.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574449072.git.liu.denton@gmail.com>
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
2.24.0.497.g17aadd8971

