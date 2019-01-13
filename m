Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6785E211B4
	for <e@80x24.org>; Sun, 13 Jan 2019 21:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfAMVCV (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Jan 2019 16:02:21 -0500
Received: from avasout04.plus.net ([212.159.14.19]:58585 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfAMVCV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jan 2019 16:02:21 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id imtegA1pxAOoyimtfg5eXV; Sun, 13 Jan 2019 21:02:19 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Rdm+9Wlv c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=dO-uwLZ0gb8jzQiHxUIA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] config.h: fix hdr-check warnings
Message-ID: <13179d3e-f1d5-55f7-3572-829b5ddc9827@ramsayjones.plus.com>
Date:   Sun, 13 Jan 2019 21:02:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFAihcLbNPkBUEDv7wcfJ+9yI4fIm+U5fff0sqr4J6mQ/weUoULL6p8xfMGIDIr42UEpPdlMp4RV59qMFIb2MjTmwJ4lxh/ZPnJzoC6VZrdIfgyg6X5g
 GlS9VuoSZ27ehv/9uHKk2AcD3hVgc5dD4I43OrI5wqzdKtr/IUkA5YHOPT0IA0QdUADi5PflJjofcw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


commit 8f7c7f5555 ("config.c: add repo_config_set_worktree_gently()",
2018-12-27) adds three function declarations that cause the hdr-check
make target to complain. The hdr-check complaint is caused by placing
the new declarations, which include 'struct repository *' parameters,
before the declaration of 'struct repository'. Move the struct
declaration to the top of the file.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Duy,

If you need to re-roll your 'nd/config-move-to' branch, could you please
squash this into the relevant patch (commit 8f7c7f5555).

BTW, none of the three new functions are called outside of config.c on
the 'pu' branch - I assume future patches will add some calls to these
functions (yes?).

Thanks!

ATB,
Ramsay Jones

 config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.h b/config.h
index 62204dc252..77c5b12873 100644
--- a/config.h
+++ b/config.h
@@ -5,6 +5,7 @@
 #include "string-list.h"
 
 struct object_id;
+struct repository;
 
 /* git_config_parse_key() returns these negated: */
 #define CONFIG_INVALID_KEY 1
@@ -215,7 +216,6 @@ extern int git_configset_get_maybe_bool(struct config_set *cs, const char *key,
 extern int git_configset_get_pathname(struct config_set *cs, const char *key, const char **dest);
 
 /* Functions for reading a repository's config */
-struct repository;
 extern void repo_config(struct repository *repo, config_fn_t fn, void *data);
 extern int repo_config_get_value(struct repository *repo,
 				 const char *key, const char **value);
-- 
2.20.0
