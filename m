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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BDCC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21BD2068F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6+yBzp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfKZBSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:18:40 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:45578 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfKZBSj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:18:39 -0500
Received: by mail-pf1-f175.google.com with SMTP id z4so8292639pfn.12
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Hu/LIm/VDUQszegUkq9qsUTerKLJT8Ea6zTzzQS+Xs=;
        b=K6+yBzp2XisMHyTG9JDsFti6obXHrjwZzrs03r3OOGMWiLp57BSf9xJ1IP26rT3XcN
         pTib8H/bLC8lR/8S6U8+xzKsQ/AN6py6S9ens+TWnpAgtxjX7uCITFn/AsVNmdLV/RZL
         r6J7agbApMZ6fbWp4x+R+FadqrN5tkx0zZtC4Q/gpt3/brRVTJrt3eqpcJQkWiDe3wwj
         BmbBMIv06DWE6tGqLdZVuM+j5Y2oQUkQ0IyxbAIvbSOCd9yCUgZYO0KiZpky8cs1gqTN
         8z3/c35+NNaR63yLJzn9GCho+k9QrWmdyI7sosFlSIsJHmJ9DlWh74lwEQHHCLjF0m0M
         /YcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Hu/LIm/VDUQszegUkq9qsUTerKLJT8Ea6zTzzQS+Xs=;
        b=YteWeudOAVjPxbhaP8D8L+7toEwg0gZpCXkbXxTmB9awR1s1+ttOqj9jEZzpV4RsYb
         /WyTXv8QzWbdl7IuEKbznmnmwNCkUOq0fPav4Yymed5JmVvfY8zkici7tzdqwhHkIU28
         9F1271uqHLszEgVZh/IROlQGfz24T+Nt46ItpTih57UntRlLg5nZKzLNrGqmcfoTC3r9
         bHILv/Bs/5+y8F7NhoXqv7CQHoUOUtS+ez3MrMhOoJKyT10g7JiWPNFrOIyMuWQ0Py86
         MTjnWIUUSKgupInjW0SE5BDYwwaTlXvviX9aEtdxi+Izr/7KtIAwJzx070Hebu00VFTA
         JV/A==
X-Gm-Message-State: APjAAAWUR4W2rl14hNprLAORwcp23Ane7BT/qNfctMdVZ0RBmqyjWwpy
        lDXSu3xfDTi3UnH/93UqYwAIYtZP
X-Google-Smtp-Source: APXvYqzTZ7fE7M8Yd6hqrS5VJHZ/EHyS5rg6zczaaJW6w+llmzrQZd9E2+mM7+jVzc+iL/oYcpC0Kw==
X-Received: by 2002:a63:204e:: with SMTP id r14mr36715779pgm.101.1574731117052;
        Mon, 25 Nov 2019 17:18:37 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id q4sm9943352pgp.30.2019.11.25.17.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:18:36 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:18:34 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 21/27] t7700: s/test -f/test_path_is_file/
Message-ID: <251de77677a9eda0d13c3f5668fa456ad4a52902.1574731022.git.liu.denton@gmail.com>
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

Since we have debugging-friendly alternatives to `test -f`, replace
instances of `test -f` with `test_path_is_file` so that if a command
ever fails, we get better debugging information.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index a96e876c4e..1d14ddcbdb 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -106,7 +106,7 @@ test_expect_success 'packed obs in alt ODB are repacked even when local repo is
 	mv .git/objects/pack/* alt_objects/pack &&
 	git repack -a &&
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
-	test -f "$myidx" &&
+	test_path_is_file "$myidx" &&
 	for p in alt_objects/pack/*.idx
 	do
 		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
@@ -129,7 +129,7 @@ test_expect_success 'packed obs in alt ODB are repacked when local repo has pack
 	git repack &&
 	git repack -a -d &&
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
-	test -f "$myidx" &&
+	test_path_is_file "$myidx" &&
 	for p in alt_objects/pack/*.idx
 	do
 		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
@@ -148,7 +148,7 @@ test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
 	for p in alt_objects/pack/*.pack
 	do
 		base_name=$(basename $p .pack) &&
-		if test -f alt_objects/pack/$base_name.keep
+		if test_path_is_file alt_objects/pack/$base_name.keep
 		then
 			rm alt_objects/pack/$base_name.keep
 		else
@@ -157,7 +157,7 @@ test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
 	done &&
 	git repack -a -d &&
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
-	test -f "$myidx" &&
+	test_path_is_file "$myidx" &&
 	for p in alt_objects/pack/*.idx
 	do
 		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
-- 
2.24.0.504.g3cd56eb17d

