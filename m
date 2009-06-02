Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 16029 invoked by uid 107); 2 Jun 2009 21:09:38 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Tue, 02 Jun 2009 17:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbZFBVJX (ORCPT <rfc822;peff@peff.net>);
	Tue, 2 Jun 2009 17:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752232AbZFBVJX
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 17:09:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:59341 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbZFBVJX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 17:09:23 -0400
Received: by fg-out-1718.google.com with SMTP id d23so956272fga.17
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 14:09:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:to;
        bh=cbNebgQOEC+7WEhLqhbtaCqQTfC2MjASjYphi9Z5m/Y=;
        b=PdURoxxvHx5FssfKxakcXgBJodBdt9GYw47t43y0iWvZGm4YU8GbEQeOqAxXKHZ3Sp
         e8aoM9iIRv3tuSlnhV0xlXgV3pbaygKlVmT8hyLFFN58iEVR7DgpzX67HiHkMInDc8gV
         9tec4ynOUDCMqbYPmX2rvT4V3ME5fTtl48y/w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kcFuCy0fQyDNUoYpQ8+xThLE6oCMBGDsqtlf+vslHnhl0AwkKhaVmx4coXuw4ve8Am
         PZ3h+BZPZqg8eAWyZ9PW0yV9up41es7r0s4H4HHrgau6AflxmUEsZRc3jbs8NK0nwZ8+
         DJVNXfOHgSmtdcPU2c7LvI9szNyVRgn3PB/rw=
Received: by 10.86.68.1 with SMTP id q1mr303476fga.34.1243976963899;
        Tue, 02 Jun 2009 14:09:23 -0700 (PDT)
Received: from localhost (drsd-4db365ef.pool.einsundeins.de [77.179.101.239])
        by mx.google.com with ESMTPS id 4sm12654970fge.28.2009.06.02.14.09.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Jun 2009 14:09:23 -0700 (PDT)
From:	Bert Wesarg <bert.wesarg@googlemail.com>
To:	Petr Baudis <pasky@suse.cz>
Cc:	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Subject: [TopGit PATCH] pre-commit: check .topdeps for valid branches
Date:	Tue,  2 Jun 2009 23:09:22 +0200
Message-Id: <1243976962-10486-1-git-send-email-bert.wesarg@googlemail.com>
X-Mailer: git-send-email 1.6.2.2.463.g124d4
In-Reply-To: <1243592316-10820-1-git-send-email-bert.wesarg@googlemail.com>
References: <1243592316-10820-1-git-send-email-bert.wesarg@googlemail.com>
To:	Petr Baudis <pasky@suse.cz>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 hooks/pre-commit.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/hooks/pre-commit.sh b/hooks/pre-commit.sh
index 8e05a4e..1eae2e8 100644
--- a/hooks/pre-commit.sh
+++ b/hooks/pre-commit.sh
@@ -52,6 +52,9 @@ BEGIN      { in_hunk = 0; }
 /^[^@ +-]/ { in_hunk = 0; }
 ' |
 	while read newly_added; do
+		ref_exists "$newly_added" ||
+			die "Invalid branch as dependent: $newly_added"
+
 		# deps can be non-tgish but we can't run recurse_deps() on them
 		ref_exists "refs/top-bases/$newly_added" ||
 			continue
-- 
tg: (0f8cd77..) bw/check-valid-deps (depends on: bw/check-for-dep-cycle)
