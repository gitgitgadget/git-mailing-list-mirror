Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89390201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 20:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbdBXUnR (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 15:43:17 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33744 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbdBXUnP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 15:43:15 -0500
Received: by mail-pf0-f181.google.com with SMTP id o64so550799pfb.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 12:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2bB/8a3/GKDeghDAXutB2Svoene36IwJZiDn8KPidjw=;
        b=FS3Bj085xNVCa1hN/egIPo7xvPVt6TJEL5W3b3nmGnY3iKSLgp4IbQL9QdTBy5Y6Ll
         bgKdK55AZZb0f9ubzz+tnFRLvRh2ZRkb5arK5biqNYDvEvAEEVs7lTgoyYdGvnGZFAiU
         pfnLRcn7DRiFo6tsWbukaUmoGUsIMwF+ztSj7CsbNZpd99XTWG/0n/CtX2H19GjLr50X
         X8xud8aOgV8soqUo9FGa5VB6p8X5CsSrmrMAMWqphpXOTWu1W2MMndG4vMVS/Vy90S8g
         MttGKJzz7kf6UP4vFcPHCZNJDCWPP+93Krzqb0PmR1mIffOCOFzMyAOmo1sNe7mDXT6K
         +jOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2bB/8a3/GKDeghDAXutB2Svoene36IwJZiDn8KPidjw=;
        b=uW8AcQn0UxN/lnhwAoJ2B6j/Rq5xMNHebQobW5VcZRkQJahrVOY13RWLE0m/PPUdNZ
         2AIgrhHuQMRRoIfygcS4OL1HPggqjc7n31gLP/2iQzdL4yJBXXekJ8Sbj085su6XBATN
         YP/CZYbBWJGyg/q/DxmBc2XoA/mrx31ll6TcrWn8iXfwfWU2+z1bmgBf4/uJxCcBLYZU
         pmUuYgXmceSaPScUpc80t9mVgor45trPu1Qa+Go1mq8MSRVsOXChyrF0HxZeDWRMe1ST
         wd0VsSxuaTX1idRJiR37F+kRSoPfXTHN0NhYcKbIuN7Rxd7aMj9IY/CkLWlTUK6OfWJK
         MJvA==
X-Gm-Message-State: AMke39kinTvQRrFnVBl8f5O1ybXanu+Z9vKgyiCQw+A6l9/8+0c/mQlnWABiup/ixIwg86eX
X-Received: by 10.99.104.199 with SMTP id d190mr5846825pgc.59.1487968435099;
        Fri, 24 Feb 2017 12:33:55 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2d9e:d4fd:456:fee4])
        by smtp.gmail.com with ESMTPSA id r4sm16681807pgr.53.2017.02.24.12.33.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 12:33:54 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] refs: parse_hide_refs_config to use parse_config_key
Date:   Fri, 24 Feb 2017 12:33:35 -0800
Message-Id: <20170224203335.3762-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

parse_config_key was introduced in 1b86bbb0ade (config: add helper
function for parsing key names, 2013-01-22), the NEEDSWORK that is removed
in this patch was introduced at daebaa7813 (upload/receive-pack: allow
hiding ref hierarchies, 2013-01-18), which is only a couple days apart,
so presumably the code replaced in this patch was only introduced due
to not wanting to wait on the proper helper function being available.

Make the condition easier to read by using parse_config_key.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

  When investigating the state of the art for parsing config options, I saw
  opportunity for a small drive-by patch in an area that I did not look at for 
  a long time.
  
  The authors of the two mentioned commits are Jeff and Junio, so maybe you
  remember another reason for this NEEDSWORK here?
  
  Thanks,
  Stefan
  
 refs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index cd36b64ed9..c9e5f13630 100644
--- a/refs.c
+++ b/refs.c
@@ -1034,10 +1034,11 @@ static struct string_list *hide_refs;
 
 int parse_hide_refs_config(const char *var, const char *value, const char *section)
 {
+	const char *subsection, *key;
+	int subsection_len;
 	if (!strcmp("transfer.hiderefs", var) ||
-	    /* NEEDSWORK: use parse_config_key() once both are merged */
-	    (starts_with(var, section) && var[strlen(section)] == '.' &&
-	     !strcmp(var + strlen(section), ".hiderefs"))) {
+	    (!parse_config_key(var, section, &subsection, &subsection_len, &key)
+	    && !strcmp(key, "hiderefs"))) {
 		char *ref;
 		int len;
 
-- 
2.12.0.rc1.16.ge4278d41a0.dirty

