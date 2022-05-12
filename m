Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64ABC433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 22:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359245AbiELWkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 18:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359239AbiELWjy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 18:39:54 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490B7282034
        for <git@vger.kernel.org>; Thu, 12 May 2022 15:39:53 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7B76219C376;
        Thu, 12 May 2022 18:39:52 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=qmgJLGSVV1JquWjv3gubf+XQL
        uMOIBzP9IEIXUdJT/0=; b=iezlKKQTugeoChLWSsLe/OVHPgtttmfZ3fc/G2AdD
        P0KliJIMKJTB8gkhetm9n8QPxAwssRu8jozcvMpWF6zZiTPr4yXYjNfy1LnRBWH3
        900JXrOWnK3O2ssrW4BSnM+p9O33eaA7Gk9XXFbuxKoHy4z3J7W2MmkqQQrthmNu
        z4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7412419C375;
        Thu, 12 May 2022 18:39:52 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2068919C372;
        Thu, 12 May 2022 18:39:49 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v4 3/4] ci: reintroduce prevention from perforce being quarantined in macOS
Date:   Thu, 12 May 2022 15:39:39 -0700
Message-Id: <20220512223940.238367-4-gitster@pobox.com>
X-Mailer: git-send-email 2.36.1-338-g1c7f76a54c
In-Reply-To: <20220512223940.238367-1-gitster@pobox.com>
References: <20220423142559.32507-1-carenas@gmail.com>
 <20220512223940.238367-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 6E485ABC-D244-11EC-BC36-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

5ed9fc3fc86 (ci: prevent `perforce` from being quarantined, 2020-02-27)
introduces this prevention for brew, but brew has been removed in a
previous commit, so reintroduce an equivalent option to avoid a possible
regression.

This doesn't affect github actions (as configure now) and is therefore
done silently to avoid any possible scary irrelevant messages.

Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/install-dependencies.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 8e796fa669..c150bce2d9 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -41,7 +41,8 @@ macos-latest)
 	(
 		cd $HOME/bin
 		wget -q "https://cdist2.perforce.com/perforce/r21.2/bin.macosx1015x86_=
64/helix-core-server.tgz" &&
-		tar -xf helix-core-server.tgz
+		tar -xf helix-core-server.tgz &&
+		sudo xattr -d com.apple.quarantine p4 p4d 2>/dev/null || true
 	)
 	PATH=3D"$PATH:${HOME}/bin"
 	export PATH
--=20
2.36.1-338-g1c7f76a54c

