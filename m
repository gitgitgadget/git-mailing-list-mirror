Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E81C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83152245C
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvOSePtc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfLDWDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:03:35 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36409 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLDWDf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 17:03:35 -0500
Received: by mail-pj1-f65.google.com with SMTP id n96so371047pjc.3
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 14:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C7rwZbuP+3Q6dplwJ5UCWsl4aV9yuCVSpFmhOGqQ4bU=;
        b=nvOSePtc3UK0peKRTvMoGwOaKS+SGniI+pQgVHQqYsUxl69I6yJTrdNnylBSaipQBR
         xlXc6lMYRcl1SxdxPigpCNxBrI4fGt2RDFz8FBZDFS2JsFU9smIzv0+VnNuNW4nkEWh1
         L4Mjz8xIMWC0e8aiMkBO/r9gWPTtEp5lwe4EHl5j56txVkkmjQusTey7z6qWbvci4SG+
         DtlNWfmhSxDD8kSrvCtBGUYHc8iL1OHe0ufeisQ45eyQ8kegcH75mxCiWj4AZkcb+mrY
         bJIDk4OKINBKBXnTOii7PMgxtMFVltZ3mAdD8wKAgdyWUjgtoUUJdek7hh6D7TDS2j2B
         1Xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C7rwZbuP+3Q6dplwJ5UCWsl4aV9yuCVSpFmhOGqQ4bU=;
        b=ENEhOV/oRmz4dqCA6ysvI6AaLro8dP6LY8l8DlF3D6AjOw4K9LZPGd+6IfN7/EMxKz
         AiPl4+OkuiipmqjRBk1scPyCPB4jJpatk/NTgsNYfoXLEf0UFjBR1dzNZrYG8BcqyN9a
         T3PQGCUhdwoHhfn46iGI/VbXy5WgGqLcV2cVri9eepc67j3cKb56eEkTaGojkaq+pk4T
         ZhCxdVLME/ifK4w1QtxTDxtNdb4Wm3yne7QvhANOBNL3Ael2tyfRXmrfwyyJw/uqkZse
         swenJRBx8EqPpIG0689X22K/ka8MYt/Jzv+cINpt+zoBrRu0TwXv0z9CiiZcCcjewE3c
         IiWA==
X-Gm-Message-State: APjAAAXxc12HagERb1GrIIZKqANoGjuIcABhw6gFVsBvIG/ZpZ4exGdJ
        ymgXi/1iu434nfe0qyheUH8So9gv
X-Google-Smtp-Source: APXvYqyIHuacrtHPhl+fEapHbQOdS8iuTnT4PkT1ZSQhbgLoroR0kh49fgTEpPQzGOHHdznyf0SwSA==
X-Received: by 2002:a17:90a:c08c:: with SMTP id o12mr5526073pjs.68.1575497014688;
        Wed, 04 Dec 2019 14:03:34 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id u26sm8641220pfn.46.2019.12.04.14.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 14:03:34 -0800 (PST)
Date:   Wed, 4 Dec 2019 14:03:30 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v6 5/5] t7700: stop losing return codes of git commands
Message-ID: <ab653bd76fd3a20c2831ed8af6aa69c6d3abb47d.1575496684.git.liu.denton@gmail.com>
References: <xmqq1rtk557e.fsf@gitster-ct.c.googlers.com>
 <cover.1575496683.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575496683.git.liu.denton@gmail.com>
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
index 5229999d77..25b235c063 100755
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
-	packid=$(git rev-list --objects --all | grep file2 |
-		git pack-objects pack) &&
+	packid=$(grep file2 objs | git pack-objects pack) &&
 	>pack-$packid.keep &&
-	oid=$(git verify-pack -v pack-$packid.idx | head -n 1 |
-		sed -e "s/^\($OID_REGEX\).*/\1/") &&
+	git verify-pack -v pack-$packid.idx >packlist &&
+	oid=$(head -n 1 packlist | sed -e "s/^\($OID_REGEX\).*/\1/") &&
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
2.24.0.578.g4820254054

