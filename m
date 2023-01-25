Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4716EC54E94
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 23:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbjAYXs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 18:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjAYXsv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 18:48:51 -0500
Received: from tilde.club (tilde.club [142.44.150.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B81456EFE
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 15:48:50 -0800 (PST)
Received: from tilde.club (tor-exit-relay-3.anonymizing-proxy.digitalcourage.de [185.220.102.249])
        by tilde.club (Postfix) with ESMTPSA id 903D5220182E7;
        Wed, 25 Jan 2023 23:48:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 tilde.club 903D5220182E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tilde.club; s=mail;
        t=1674690530; bh=+IIG1hA8s3lXHcVoHQgk9nNFvCA/vrbyFHC4k8/Fd/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aBh+FqPjhQAj5ODNAGthuN/bPjmGCrO1fk3D/7VwhflTEyCA3oHyV91oXwjk48mzr
         PcvSwSBRZf9nLDLtr69p1MTGwTuaDnDQd61u18B1piyI2vgwF5LfbRWj9NF2m5R8xL
         pERYT5LFrVOolBlQOoeFYsCx4IrQXkkMZ84cLP6Q=
From:   Gwyneth Morgan <gwymor@tilde.club>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gwyneth Morgan <gwymor@tilde.club>
Subject: [PATCH v2] request-pull: filter out SSH/X.509 tag signatures
Date:   Wed, 25 Jan 2023 23:47:27 +0000
Message-Id: <20230125234725.3918563-1-gwymor@tilde.club>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125230117.3915827-1-gwymor@tilde.club>
References: <20230125230117.3915827-1-gwymor@tilde.club>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git request-pull filters PGP signatures out of the tag message, but not
SSH or X.509 signatures.

Signed-off-by: Gwyneth Morgan <gwymor@tilde.club>
---
 git-request-pull.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 2d0e44656c..01640a044b 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -153,7 +153,7 @@ for you to fetch changes up to %H:
 if test $(git cat-file -t "$head") = tag
 then
 	git cat-file tag "$head" |
-	sed -n -e '1,/^$/d' -e '/^-----BEGIN PGP /q' -e p
+	sed -n -e '1,/^$/d' -e '/^-----BEGIN \(PGP\|SSH\|SIGNED\) /q' -e p
 	echo
 	echo "----------------------------------------------------------------"
 fi &&
