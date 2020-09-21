Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EC5C43464
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2EE620684
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbtN1bK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgIUKkn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgIUKka (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 06:40:30 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6067C0613CF
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:29 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a17so12173363wrn.6
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZUGgYiXbI+kwOXhbioUSqfAvb5eTbe245oPLj6OI7V8=;
        b=TbtN1bK3/YLXlighyvj8Dr3zpaXxyv6XFG/KfqxAR9uDpq7gaRjiDwVckLrb0l/umZ
         lXHwkJv5m6XGZCqWfoRiZzcQ0GjvS++szBOPdafmQLKjmgbUz0BCUis2VtxCG68hmJGb
         +5KgHhbZkxNO5pIYXj0FxQYc1ZmARTv3XeFV8z9XENcgKVUBwB6xpMSoqwiBn7TpSbjt
         m2UGExUFUDJ688egVoAsy8ztjAnC2Fe5JWOHvMqvFabBf2W6r6YxflnNRu1xQ4buJhma
         PI9yKAeE90qMvki6Zvg37RwgvoOfzBQfuagCkIxr+gQzuPlte0M/2L6WLNNqske5YOhw
         6t2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZUGgYiXbI+kwOXhbioUSqfAvb5eTbe245oPLj6OI7V8=;
        b=GGO1Nfi3Y4d3c3y1+4yQhDA58nyYy4T8TmyDHSOV+QJVhztYPypcAgTeMfkGdpPT8J
         4wfDsBPpn5lY1hWpkshBHG+E7lNvySyqhJWzocOmHajMVbV2TT5IxWqPAjqZzdpGZowt
         tHWqYdU+AImg8wOH2tfDaUrdakQij7BVd1hJZZ1cQWy8HzHUNxEHVhGs0ppNi996mFz+
         Rqamaxbi1L7p8YZOeHNOsZzlWY2s+OsJkbQuvYzgLCtTuWlOiCFx3WBXPOQIAG8IArv7
         28TJkiCUXYtDKd2Zcuird7qknI/aUUO/GkHJZK5m14kK5gneYypxxmxd9yZsHcrvE3XM
         Fxqg==
X-Gm-Message-State: AOAM531rSaqW3NRe910fjkH+T1HMcTfM0kVSJIMfdf7kw4X0xaOfd0nx
        pUF4eqyGJe3alVK87iwMD+brDrruRSo1tA==
X-Google-Smtp-Source: ABdhPJwxTbvJzMqV7pVpWrcR30r9/sBn+lRmlkDDSkefTGKL/kojFCoGu5HHOCm9OWWMmuPCTR7G8Q==
X-Received: by 2002:adf:d0cb:: with SMTP id z11mr49931538wrh.192.1600684828264;
        Mon, 21 Sep 2020 03:40:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 9sm18647833wmf.7.2020.09.21.03.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:40:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, imon Legner <Simon.Legner@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 13/18] remote-mediawiki: fix duplicate revisions being imported
Date:   Mon, 21 Sep 2020 12:39:55 +0200
Message-Id: <20200921104000.2304-14-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Simon Legner <Simon.Legner@gmail.com>

Fix a bug with revisions being imported twice. This commit is being
backported from Git-Mediawiki.git's e41ee9b ("All revisions imported
twice", 2018-02-02) to git.git. See [1] for the original commit and
[2] and [3] for the upstream PR and issue.

1. https://github.com/Git-Mediawiki/Git-Mediawiki/commit/e41ee9b3a32416df381cdc79f63350665c84151e
2. https://github.com/Git-Mediawiki/Git-Mediawiki/pull/61
3. https://github.com/Git-Mediawiki/Git-Mediawiki/issues/29

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index 08190e23e1..26d5e1a174 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -807,7 +807,10 @@ sub get_more_refs {
 sub mw_import {
 	# multiple import commands can follow each other.
 	my @refs = (shift, get_more_refs('import'));
+	my $processedRefs;
 	foreach my $ref (@refs) {
+		next if $processedRefs->{$ref}; # skip duplicates: "import refs/heads/master" being issued twice; TODO: why?
+		$processedRefs->{$ref} = 1;
 		mw_import_ref($ref);
 	}
 	print {*STDOUT} "done\n";
-- 
2.28.0.297.g1956fa8f8d

