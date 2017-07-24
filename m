Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B8BC203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 17:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755991AbdGXRIk (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 13:08:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35924 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755364AbdGXRGp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 13:06:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id 184so13376529wmo.3
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 10:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PUabWm2ASyGNi7f3L09Fk0JPX1Q1xleZKFXZYmIV0z8=;
        b=p/T3tJZ4gLKXnhkPYD78a4rB2yRCFg3ORHMvbwwJC4fPMgj2S3mQXIqV9tL42Qg9Sc
         oTl+ukKq2JioQqJ1dRPiIbQZc8dCkKx/NHYEA5/YuKYQu7hmQSmIZ9aHOqK1CAkdfZTm
         ZKU+Bzhythw9DdpDhV3pkBzCWgLqj6Bt9/+LjgLvRkU6LKbtNCH/4hWVp1aYr+ycdwqO
         Q13nzJ2KoTRyaMoOMN8fMCgo3cxt+1lGvWJc1EB6M/Ir7d5zWvjCTEaKtWk2zZRsZM0g
         G5YKQ9UYEu/bmeBLg0yW4jY2mdXbk4MZVY7WMqfyd5GNIcFbyt589A6UPJv6eV9IsV85
         +K4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PUabWm2ASyGNi7f3L09Fk0JPX1Q1xleZKFXZYmIV0z8=;
        b=OwCq1zxahWEaO6PGuUH94mrvHRoOTUcuiimCpfHNsOS962gwANrFQmxEjf5Vp3pZRI
         fDP8Elrp9ew/CD7u9FMHw/iPP4nRbMeOXQATohAY39K8FwzleNl/LXYsno+9RHG5C9i4
         tIrEV43Ut16x83H97tr3v2ij59j879S8xNRCI2HAWdTB/PTuE8B6wQpd+IqXTddz+wx5
         CnuvD4Bo3GsLWVVfFcj5iCUN8RfAsCDIdHmletD0gzzgS8U0b64Vnm1ADWClRKoUi4WW
         vxN5r09RIF/1Ti868nkYTgsq0QKhBJdGWNfwX8JOH8DYSYYuASbNYXtAGowm7krnJvcI
         RYXA==
X-Gm-Message-State: AIVw113KDufH1VOtzIPx/wNXlMdGfH7fLOA4Lw5fQkThTnESZJ6ypVqF
        NPE9sUzFfCuxgw==
X-Received: by 10.28.23.195 with SMTP id 186mr5109567wmx.173.1500916003297;
        Mon, 24 Jul 2017 10:06:43 -0700 (PDT)
Received: from localhost.localdomain (x4db2767d.dyn.telefonica.de. [77.178.118.125])
        by smtp.gmail.com with ESMTPSA id r70sm8666373wmb.16.2017.07.24.10.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 10:06:42 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Smith <whydoubt@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] blame: fix memory corruption scrambling revision name in error message
Date:   Mon, 24 Jul 2017 19:06:20 +0200
Message-Id: <20170724170620.19745-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.14.0.rc0.88.ge338f4246
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When attempting to blame a non-existing path, git should show an error
message like this:

  $ git blame e83c51633 -- nonexisting-file
  fatal: no such path nonexisting-file in e83c51633

Since the recent commit 835c49f7d (blame: rework methods that
determine 'final' commit, 2017-05-24) the revision name is either
missing or some scrambled characters are shown instead.  The reason is
that the revision name must be duplicated, because it is invalidated
when the pending objects array is cleared in the meantime, but this
commit dropped the duplication.

Restore the duplication of the revision name in the affected functions
(find_single_final() and find_single_initial()).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 blame.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/blame.c b/blame.c
index 91e26e93e..9ee0a375f 100644
--- a/blame.c
+++ b/blame.c
@@ -1662,8 +1662,8 @@ static struct commit *find_single_final(struct rev_info *revs,
 		found = (struct commit *)obj;
 		name = revs->pending.objects[i].name;
 	}
-	if (name_p)
-		*name_p = name;
+	if (name_p && name)
+		*name_p = xstrdup(name);
 	return found;
 }
 
@@ -1735,7 +1735,7 @@ static struct commit *find_single_initial(struct rev_info *revs,
 		die("No commit to dig up from?");
 
 	if (name_p)
-		*name_p = name;
+		*name_p = xstrdup(name);
 	return found;
 }
 
@@ -1843,6 +1843,8 @@ void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blam
 
 	if (orig)
 		*orig = o;
+
+	free((char *)final_commit_name);
 }
 
 
-- 
2.14.0.rc0.88.ge338f4246

