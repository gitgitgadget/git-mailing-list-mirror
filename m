Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17974C54E94
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 23:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjAYXLW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 18:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjAYXLV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 18:11:21 -0500
X-Greylist: delayed 480 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Jan 2023 15:11:15 PST
Received: from tilde.club (tilde.club [142.44.150.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2322442E0
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 15:11:15 -0800 (PST)
Received: from tilde.club (tor-exit-relay-7.anonymizing-proxy.digitalcourage.de [185.220.102.253])
        by tilde.club (Postfix) with ESMTPSA id D2BDA220182D2;
        Wed, 25 Jan 2023 23:03:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 tilde.club D2BDA220182D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tilde.club; s=mail;
        t=1674687790; bh=M/wm+THxuuaXNs7vWXnfMaclbQ6SWFbe33XezE16VBE=;
        h=From:To:Cc:Subject:Date:From;
        b=vkiTlhPe8cg2lSKL3hBxqWN5fbEJedHJk59/3WwZjHORB8/KYl2ecJOFTWxPpUjGG
         +wXbQqAqGwRYSp3xxmDMAxBTgbKD3NW3yN1TS5uD5hNhnwviCK94zPWoYwliMe//Bu
         4jzBmle5IvXQo3cDl8h8UN6mkGcD3cHWQE11us1s=
From:   Gwyneth Morgan <gwymor@tilde.club>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gwyneth Morgan <gwymor@tilde.club>
Subject: [PATCH] request-pull: filter out SSH/X.509 tag signatures
Date:   Wed, 25 Jan 2023 23:01:17 +0000
Message-Id: <20230125230117.3915827-1-gwymor@tilde.club>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git request-pull filters PGP signatures out of the tag message, but not
SSH or X.509 signatures.
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
