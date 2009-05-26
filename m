Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 12552 invoked by uid 107); 26 May 2009 21:46:35 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Tue, 26 May 2009 17:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755660AbZEZVqZ (ORCPT <rfc822;peff@peff.net>);
	Tue, 26 May 2009 17:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755555AbZEZVqY
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 17:46:24 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:57478 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753921AbZEZVqY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 17:46:24 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1046151fga.17
        for <git@vger.kernel.org>; Tue, 26 May 2009 14:46:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:to;
        bh=qob9otev29/pJkDGTckPjOHRvphNAG3BiXa0QZ2sZP8=;
        b=OBqWYDhZ5hzW4iPnYTaZuQudBplCDb91mzE5qmRWBlTlYAOIk/9qtRyhJJtPoiijaV
         eZl+zPUEUccgblEPg+/IAEXLNIlTDZZIWxGp5nKmTRyoGUVW0X3b2qP2Cy9TxYHLFBUB
         G5/dAX6unJpXg+XXKRgutTSH3pLVQ6iHFrIw4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=FHcVVqdvF3yZTnmkkIGlyn5NzTC8x3gHIfdWLx4ujB4/RTmIw2NTlkmoBaks3UONW4
         a+9O4gwUf6EyY44xHtobks3wxMmJwTjyaXWLMoyWnGjoX4WPPlVSwTVrbKhD+QYSdFh1
         t0xd71Nypgns9mEvUaE83HmF4K0JensVf7J0M=
Received: by 10.86.49.16 with SMTP id w16mr7453238fgw.4.1243374385146;
        Tue, 26 May 2009 14:46:25 -0700 (PDT)
Received: from localhost (drsd-4db3d3cf.pool.einsundeins.de [77.179.211.207])
        by mx.google.com with ESMTPS id l19sm647983fgb.12.2009.05.26.14.46.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 May 2009 14:46:23 -0700 (PDT)
From:	Bert Wesarg <bert.wesarg@googlemail.com>
To:	Petr Baudis <pasky@suse.cz>
Cc:	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Marc Weber <marco-oweber@gmx.de>
Subject: [TopGit PATCH] tg-push: don't accept non-tgish branches to push
Date:	Tue, 26 May 2009 23:46:22 +0200
Message-Id: <1243374382-14828-1-git-send-email-bert.wesarg@googlemail.com>
X-Mailer: git-send-email 1.6.2.2.463.g124d4
To:	Petr Baudis <pasky@suse.cz>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

tg push dies if you give it a non-tgish branch:

$ tg push -r push-test master
fatal: Not a valid object name refs/top-bases/master
fatal: ambiguous argument '^{tree}': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
fatal: Not a valid object name master:.topdeps

Fix this.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 tg-push.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/tg-push.sh b/tg-push.sh
index c813927..1d7a8a7 100644
--- a/tg-push.sh
+++ b/tg-push.sh
@@ -42,7 +42,8 @@ if [ -z "$branches" ]; then
 fi
 
 for name in $branches; do
-	ref_exists "$name" || die "detached HEAD? Can't push $name"
+	ref_exists "refs/top-bases/$name" ||
+		die "not a TopGit-controlled branch: $name"
 done
 
 _listfile="$(mktemp -t tg-push-listfile.XXXXXX)"
-- 
tg: (8ec0303..) bw/push-fixes-2 (depends on: bw/push-fixes)
