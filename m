Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB1ED1F406
	for <e@80x24.org>; Mon, 14 May 2018 21:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbeENV5V (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:57:21 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:33978 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeENV5U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:57:20 -0400
Received: by mail-yw0-f202.google.com with SMTP id t18-v6so5821161ywg.1
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Ivs+w4770XrCNBDOGrZWyTLnVOEXvnoKEGSEDGR7hD8=;
        b=dqqlsfgNQYEx2GZPhp27LAf2pXyjYUjfzPTQawZH8+98vwExRSB2QpnXIh82QdbsqV
         l/7PoPc2KbZ1CJTXsNGzXg2fGxzHVEXxaobffcIUJ2jo6oLOUNrWye5Ao0c4/0N2puHJ
         w+qYTJd4Recx3YH0bipAC1zKkCP0hlbHnwbPQLKR8BnfawNo80J3JLIIflZRuD0gjLgD
         XRt5mwFl3OFGvjLQPMRq6rT/D35ibvb/tz3GeMXMByYXqhmfoEv+Fl3eY7V6QiPCcfez
         tv2lYrxv3ez7tOhS5KRG3ih8RAj2LIs+Jo96VkRTd/LuIfRU7rAH72zbQOpNlOdtGlGw
         2iGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Ivs+w4770XrCNBDOGrZWyTLnVOEXvnoKEGSEDGR7hD8=;
        b=AKy/VoXZEZvpM5RyQl902JLDk2i94XXN0GPHXfQwkOaN2Jf/1mbZvLEnaPxsPYFuc7
         jELQqcTNPvPj0yQjaSErAZ1jd6K404BuW3HjrOojl/rVDMmlIe/TWe7fUI2uuLoJh6Qx
         TpFjnodkUWw31O8+z+Ko8tMguT7e2fnw+pP4Yh/XOIfPoVljDslmLyuDZ0fE/4BIpq94
         16eqvO2qMXRSgmAZQYLMAjRbJ60pc9OqvJpuYMA4PS51aJoaapXT7/u91FLb1YlUzt40
         fQ/wf4jK5+iyul0BRu6PAImc5v8KB8aIfatIvt1Fv7TgS9zAdj+ovzXzW87oQm0d0buT
         srcw==
X-Gm-Message-State: ALKqPwfITn673iq9D6Lep3Bo7Hj69glwcPKF6Pkkc1HITdL/7h8MYDtB
        oitKOV/137Xw+5ptyg8f+uc6jCmkCiG2V+cBrA86HxUjUiM9/GGKRZubENtTO0eopMgUC9aHkbg
        hU2sth5IqVEOLX58wSSLX875QF7oG68U8uYpWenQG1RPTupRCpGER6UP2cw==
X-Google-Smtp-Source: AB8JxZo9A+RTvMHqIFsm8sSpNPDXqrz7DlpjTu6SGWEeuStDD25SA34ZlWlWPUS/gv1O8idlUovsYeuWraE=
MIME-Version: 1.0
X-Received: by 2002:a25:26d0:: with SMTP id m199-v6mr5182177ybm.2.1526335039508;
 Mon, 14 May 2018 14:57:19 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:08 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-18-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 17/35] fetch: convert refmap to use struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the refmap in builtin/fetch.c to be stored in a
'struct refspec'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 769f9d2be..e2f2f290e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -60,8 +60,7 @@ static const char *submodule_prefix = "";
 static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int recurse_submodules_default = RECURSE_SUBMODULES_ON_DEMAND;
 static int shown_url = 0;
-static int refmap_alloc, refmap_nr;
-static const char **refmap_array;
+static struct refspec refmap = REFSPEC_INIT_FETCH;
 static struct list_objects_filter_options filter_options;
 
 static int git_fetch_config(const char *k, const char *v, void *cb)
@@ -108,14 +107,12 @@ static int gitmodules_fetch_config(const char *var, const char *value, void *cb)
 
 static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
 {
-	ALLOC_GROW(refmap_array, refmap_nr + 1, refmap_alloc);
-
 	/*
 	 * "git fetch --refmap='' origin foo"
 	 * can be used to tell the command not to store anywhere
 	 */
-	if (*arg)
-		refmap_array[refmap_nr++] = arg;
+	refspec_append(&refmap, arg);
+
 	return 0;
 }
 
@@ -403,9 +400,9 @@ static struct ref *get_ref_map(struct transport *transport,
 		 * by ref_remove_duplicates() in favor of one of these
 		 * opportunistic entries with FETCH_HEAD_IGNORE.
 		 */
-		if (refmap_array) {
-			fetch_refspec = parse_fetch_refspec(refmap_nr, refmap_array);
-			fetch_refspec_nr = refmap_nr;
+		if (refmap.nr) {
+			fetch_refspec = refmap.items;
+			fetch_refspec_nr = refmap.nr;
 		} else {
 			fetch_refspec = transport->remote->fetch.items;
 			fetch_refspec_nr = transport->remote->fetch.nr;
@@ -413,7 +410,7 @@ static struct ref *get_ref_map(struct transport *transport,
 
 		for (i = 0; i < fetch_refspec_nr; i++)
 			get_fetch_map(ref_map, &fetch_refspec[i], &oref_tail, 1);
-	} else if (refmap_array) {
+	} else if (refmap.nr) {
 		die("--refmap option is only meaningful with command-line refspec(s).");
 	} else {
 		/* Use the defaults */
-- 
2.17.0.441.gb46fe60e1d-goog

