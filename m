Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D190C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC01C2075C
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/VFZ7iL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfKZBSw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:18:52 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:46683 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfKZBSw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:18:52 -0500
Received: by mail-pj1-f68.google.com with SMTP id a16so7449294pjs.13
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bxAaWwdJ+uHUX65XONtZk5nTRMzk1+z0+trqLsZ2ofk=;
        b=Q/VFZ7iL2R6U/Xqn4btn1lQZvWjzBQZJ37iqTlQlv3WDItNMfaeh4aKx55EmHBJILg
         RvQBBzikx1LIRFUE/mlradyipFct5jAOjVZ/9whO9GNAdvlw7U/sEEbfbLmUy14l/ss1
         ZuxLe6cCHu6cHY5lASUm3QCLzpp8rxIpTu3YbijIMfuS6NxnaC+y3MONG7Oo/tALkjLY
         LtzAlhkVEUpsOVyuOk0omXIIRFIhlMwNMsPeaxvTFxqiG5bfDgdwxdw4cT3AqlIvb7tC
         CKgmSlvH8PttNxWBNyqv4RLunTaq5LTYPHbNVq6zKA2cOg+OmH3eqMZJ2EhQGe/RuDs0
         YcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bxAaWwdJ+uHUX65XONtZk5nTRMzk1+z0+trqLsZ2ofk=;
        b=aWh24zpt6yE6khq0YDt4BfIzcv5fpIaBeUe8hRiiW0sJGSwlD5O2+jVusLfCuIagpb
         jzYwgN6VY4qnVMpvAIuNBTLxbnY0MrWeQL6RNRuibd+DewlZpaKwhJsf6DeDmzM94PXt
         O8M4E8xlNivwgZAqlI1pyjt2vK8b2jTIFiP1N7QCyLQwH5cuNP1I7NfPO0mvdyR3J6o5
         TsaHMe4jLf9y2VbvztZG3WmKTmXjb+BxVkdRkj4nhSBy4+e2otQ1XdIE5zFYiClcV2A+
         0/MxvVGk007T5PA1kMPghBZEXGggM7QW6mWHv0o7Bz2Qraj5FsbdvuZUEg9HRwdOd4gF
         PXtQ==
X-Gm-Message-State: APjAAAXq5eSiJApwGetcqLjP/waQd2yHkbHY1hHqKMm3ECCRCTnc2Sqc
        gm3VhO80Yatt/BSFc96nheYjnAaR
X-Google-Smtp-Source: APXvYqz6v7Ede8cigFSZmjb1R2n78dI1dKcDhCk5iU8HFcq4+8tv86cJWmiWs1G4/eF9ct/g3JCA4g==
X-Received: by 2002:a17:90a:77c9:: with SMTP id e9mr2901227pjs.70.1574731130910;
        Mon, 25 Nov 2019 17:18:50 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id d188sm9616657pfa.157.2019.11.25.17.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:18:50 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:18:48 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 27/27] t7700: stop losing return codes of git commands
Message-ID: <fb614f4385745c804aea36e0471dfc96c0b97cb9.1574731022.git.liu.denton@gmail.com>
References: <cover.1574449072.git.liu.denton@gmail.com>
 <cover.1574731022.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574731022.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a pipe, only the return code of the last command is used. Thus, all
other commands will have their return codes masked. Rewrite pipes so
that there are no git commands upstream so that we will know if a
command fails.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index d96b1a5949..93b20bb7a8 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -48,14 +48,13 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	git commit -m initial_commit &&
 	# Create two packs
 	# The first pack will contain all of the objects except one
-	git rev-list --objects --all | grep -v file2 |
-		git pack-objects pack &&
+	git rev-list --objects --all >objs &&
+	grep -v file2 objs | git pack-objects pack &&
 	# The second pack will contain the excluded object
-	packoid=$(git rev-list --objects --all | grep file2 |
-		git pack-objects pack) &&
+	packoid=$(grep file2 objs | git pack-objects pack) &&
 	>pack-$packoid.keep &&
-	objoid=$(git verify-pack -v pack-$packoid.idx | head -n 1 |
-		sed -e "s/^\($OID_REGEX\).*/\1/") &&
+	git verify-pack -v pack-$packoid.idx >packlist &&
+	objoid=$(head -n 1 packlist | sed -e "s/^\($OID_REGEX\).*/\1/") &&
 	mv pack-* .git/objects/pack/ &&
 	git repack -A -d -l &&
 	git prune-packed &&
@@ -134,8 +133,8 @@ test_expect_success 'packed unreachable obs in alternate ODB are not loosened' '
 	    --unpack-unreachable </dev/null pack &&
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
-	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
-		grep "^$coid " | sort | uniq | wc -l) &&
+	git verify-pack -v -- .git/objects/pack/*.idx >packlist &&
+	! grep "^$coid " packlist &&
 	echo >.git/objects/info/alternates &&
 	test_must_fail git show $coid
 '
@@ -151,8 +150,8 @@ test_expect_success 'local packed unreachable obs that exist in alternate ODB ar
 	    --unpack-unreachable </dev/null pack &&
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
-	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
-		grep "^$coid " | sort | uniq | wc -l) &&
+	git verify-pack -v -- .git/objects/pack/*.idx >packlist &&
+	! grep "^$coid " &&
 	echo >.git/objects/info/alternates &&
 	test_must_fail git show $coid
 '
-- 
2.24.0.504.g3cd56eb17d

