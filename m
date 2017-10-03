Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E6842036B
	for <e@80x24.org>; Tue,  3 Oct 2017 21:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbdJCVOO (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 17:14:14 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:48790 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbdJCVON (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 17:14:13 -0400
Received: by mail-pf0-f176.google.com with SMTP id n24so5203835pfk.5
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 14:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ud6Q2qKTK20DrPeKJdk+BcOlAG/QWHLBXJy4cYL3THk=;
        b=TScUTMpAoZFR1BobtL1vHCevIqB6gVE0W3O8wS3T9UVWpIBccL2RMsZt1kP8+FttCv
         d+IXEX3/gGr8p/OyfJ1TfKqP/l+AqkJRHsbIu/zTXKqntWyiquZ1RsoiiHWnYBZo89YY
         Le8xXSX1Qiw/FjgPaUQ0BcrMEI5dTIXJcitg+wJxw0JV6P80sW4z8BNSlegg4wG2wwTJ
         6W3DLFtpO8CUZeJuLciXTeoxFO+GF5R3l4W+WIs35nJ1neQuqQPHE2GHnU3WGssna43O
         tJ+KX1W8HcOy1bKMsalbngFgwFvhUyW4S9c4PviK13scVkl0SOk4HQdo+8vlfprDYYBU
         +Ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ud6Q2qKTK20DrPeKJdk+BcOlAG/QWHLBXJy4cYL3THk=;
        b=pLxbtKl+nPJFsS8lmleGViedORxjPkbJryprXcBWybz//KUtb+cmY+NSOjHKbOULh7
         OjBkH8xI3oEfGg6wVcpaHz++99tMe22xc/3yWQbrj0zw+WXT/4iLK0QS6uYMsS42jJFi
         GPEaGFiaVjSfxMjgpL6rulB3yz5jh99v9SqNk3AinV9WxxqacewZWx9BFi7x0Oirq8N6
         /Lld9CNax/aW5674TY5HpHsWHIDcKh9m/XRoU9XkHVnDhtzqCkfmNNVJzsgbCZ7VC0nd
         8TduIHtctGDGAsDNSsWMkzqs2DnAnESED6A6uBn4urjrh6VYeec/D671WE6bIl57mxVt
         gruw==
X-Gm-Message-State: AHPjjUhIOfKdawmePEV0jLL+ndCITeBSHY8PD/nImahrNelbVwi70voA
        DdJ1T5TTR6UH/sekifyk8lNslk383+M=
X-Google-Smtp-Source: AOwi7QBSUbUGriNwDIYttGNuXf2mh03gnHkV7dK6Im3yI8cljYYvE7zGro+eR/8QrvC+cPveYK0DeA==
X-Received: by 10.99.166.18 with SMTP id t18mr13343094pge.403.1507065252534;
        Tue, 03 Oct 2017 14:14:12 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ccd0:dc92:fe68:ce55])
        by smtp.gmail.com with ESMTPSA id u3sm4722752pfu.5.2017.10.03.14.14.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 Oct 2017 14:14:11 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH] branch: reset instead of release a strbuf
Date:   Tue,  3 Oct 2017 14:14:09 -0700
Message-Id: <20171003211409.16037-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our documentation advises to not re-use a strbuf, after strbuf_release
has been called on it. Use the proper reset instead.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Maybe one of the #leftoverbits is to remove the re-init call in release
and see what breaks? (And then fixing up more of such cases as presented
in this patch)

Thanks,
Stefan

 builtin/branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b998e16d0c..9758012390 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -217,7 +217,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		if (!head_rev)
 			die(_("Couldn't look up commit object for HEAD"));
 	}
-	for (i = 0; i < argc; i++, strbuf_release(&bname)) {
+	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
 		char *target = NULL;
 		int flags = 0;
 
-- 
2.14.0.rc0.3.g6c2e499285

