Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7736B1F461
	for <e@80x24.org>; Sat, 17 Aug 2019 21:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfHQVvK (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 17:51:10 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:34133 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbfHQVvK (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 17 Aug 2019 17:51:10 -0400
Received: from xeops.shiar.net ([83.161.198.138])
        by smtp-cloud9.xs4all.net with ESMTP
        id z6bLh9HtCzaKOz6bMhoPMV; Sat, 17 Aug 2019 23:51:08 +0200
Received: by xeops.shiar.net (Postfix, from userid 1000)
        id 64E4A6E649E; Sat, 17 Aug 2019 23:51:07 +0200 (CEST)
From:   Mischa POSLAWSKY <git@shiar.nl>
To:     git@vger.kernel.org,
        =?UTF-8?q?=D0=9E=D0=BB=D1=8F=20=D0=A2=D0=B5=D0=BB=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F?= 
        <olyatelezhnaya@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] ref-filter: initialize empty name or email fields
Date:   Sat, 17 Aug 2019 23:51:07 +0200
Message-Id: <20190817215107.13733-1-git@shiar.nl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOsj5bC0mvljmMnYntuSzfj7+Gk0HNiiXYnS10kNMcce1AKHfwGqFowHmEVrTg5C/LfnBHkg2XSTNGrRx1k8f3yFxAsm4kU2zk6ysFsU8OFTi8THOG2a
 3rjDpHpeI2v4iS4e6xbElvis2RZVyD/xbWnrHWepGWhqXgR4W26JpfgHcxBcx8lpLOKlwBc4gtEzQes3/L0Ei+fQ+BGgQpOkgjY8ZUeDwGAjfD7HEKps3JPT
 pvrazmC2c/VEPvxgKc+nbyG1OZ2GgFdzbCr2/VG+q4k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Formatting $(taggername) on headerless tags such as v0.99 in Git
causes a SIGABRT with error "munmap_chunk(): invalid pointer",
because of an oversight in commit f0062d3b74 (ref-filter: free
item->value and item->value->s, 2018-10-19).

Signed-off-by: Mischa POSLAWSKY <git@shiar.nl>
---
If I understand correctly, such tags cannot be produced normally anymore.
Therefore I'm unsure how to make tests, and if that is even warranted.

 ref-filter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index f27cfc8c3e..7338cfc671 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1028,7 +1028,7 @@ static const char *copy_name(const char *buf)
 		if (!strncmp(cp, " <", 2))
 			return xmemdupz(buf, cp - buf);
 	}
-	return "";
+	return xstrdup("");
 }
 
 static const char *copy_email(const char *buf)
@@ -1036,10 +1036,10 @@ static const char *copy_email(const char *buf)
 	const char *email = strchr(buf, '<');
 	const char *eoemail;
 	if (!email)
-		return "";
+		return xstrdup("");
 	eoemail = strchr(email, '>');
 	if (!eoemail)
-		return "";
+		return xstrdup("");
 	return xmemdupz(email, eoemail + 1 - email);
 }
 
-- 
2.23.0

