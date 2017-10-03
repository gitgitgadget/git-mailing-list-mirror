Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9075D2036B
	for <e@80x24.org>; Tue,  3 Oct 2017 22:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbdJCWRo (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 18:17:44 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:47101 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdJCWRn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 18:17:43 -0400
Received: by mail-pg0-f42.google.com with SMTP id k7so521831pga.3
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 15:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wY3NBVwf1g5Q2kKUYWE80nn0hWJdIFecY/u0QpuVt1E=;
        b=oitoyIJme8UDp0J8u/fLKtDTHsAHFHTZMJGIu+X1mB9moIyzZM6MwJhaVrf9c/w/1f
         96Z2ygjatL5MXtlCpIaByq7VjA69keiBZe9N+wa7BnEBd7AALDZulXpP3f19Z/AusFDL
         bmee6BbadH/+p2GMyTvm2XcUiFKsWM5AwzP6U2kGUBAnFlqaYQAjT7dqIe0ea+eU8yUi
         phaSbG0KSCf3u//eDEzOGpQDg1WxmrIu8D2hqf9ZZFC3CWDDtFyBB5CuOw/1xJNVPgLu
         aPUl+zdhWf072E+5pdxS+3Jyvri2kM9PvqZzxMLJA7P/XQKfq+KG5JZXypriikQQc0Ol
         Hgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wY3NBVwf1g5Q2kKUYWE80nn0hWJdIFecY/u0QpuVt1E=;
        b=pXlP8RBzm1Os55+URWtil35+t00vdG+GtbTuvj4n65rKTPK4QnQF6MWVp5RUFIWlPm
         356U/WkyJuK3S50GF23+LYcx126hPGx7u4r+BS2yGExnn0XKIX/3ty1YbJmRjCMZhkyb
         p5OFLUwgPcXdUOYqiRJRhOJzhFX2pmXyi5uRc40yWmg47TX+nQ0fN/GTkiUNBeNA+erH
         NubFFR4Vr9S9e/py4zk13AqV18x8mczD+NKJBvgKc+Ka1Q89MhRh1wZOnZ6zHh85fLEA
         ElN2oe+8C/hBplzSVFf4M1VvjeqrhuwCDJ37DLfP7u7CgOyd9ltnAhmGP7DfbmQPkksK
         NFfQ==
X-Gm-Message-State: AMCzsaVS9o43cfhOZZG8jvhle6JtT+7ySywpsvtufL/ZmpFnOscM6jrE
        Vn1x1Jargr1U52l9RFZ+hvO/CA==
X-Google-Smtp-Source: AOwi7QDGkZu9W0ldrn+PJWirOuIv5KJaSbPNuvcmpH9tThh5eK6F9LXPGCo3brf7WaceCp2MC4/Fpw==
X-Received: by 10.98.214.215 with SMTP id a84mr2322894pfl.27.1507069062742;
        Tue, 03 Oct 2017 15:17:42 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ccd0:dc92:fe68:ce55])
        by smtp.gmail.com with ESMTPSA id m9sm23261636pgt.49.2017.10.03.15.17.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 Oct 2017 15:17:42 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: [PATCH] branch: reset instead of release a strbuf
Date:   Tue,  3 Oct 2017 15:17:40 -0700
Message-Id: <20171003221740.26325-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <20171003214646.GZ19555@aiede.mtv.corp.google.com>
References: <20171003214646.GZ19555@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our documentation advises to not re-use a strbuf, after strbuf_release
has been called on it. Use the proper reset instead.

Currently 'strbuf_release' releases and re-initializes the strbuf, so it
is safe, but slow. 'strbuf_reset' only resets the internal length variable,
such that this could also be accounted for as a micro-optimization.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/branch.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b998e16d0c..71ed1c7036 100644
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
 
@@ -282,8 +282,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	}
 
 	free(name);
+	strbuf_release(&bname);
 
-	return(ret);
+	return ret;
 }
 
 static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
-- 
2.14.0.rc0.3.g6c2e499285

