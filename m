Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D9BA1F406
	for <e@80x24.org>; Wed, 16 May 2018 22:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeEPW7K (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:59:10 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:35317 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeEPW7H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:59:07 -0400
Received: by mail-yw0-f201.google.com with SMTP id b85-v6so1090231ywa.2
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=3tCE2yiZmv5emjz5+xODrEsYmFN5QtPOIq5C/8MRY/g=;
        b=Pz1Ew4dspoCh5ynKecFvF6lEYamIu08SwKzQVDsv7iKZjB1uHkSXVxyuOxX0qpJ7Vj
         EH+5wJEZauT1t7x/kOLbK+ysSQvrkCS3O89b0N5Vx3iioeuZF6J7hvLikC8edfztacRQ
         X0dzQA++9er/aJ0QU3RVzyZHy0bX/6DLrknFqFueZS/rr9NWv/a02o7CDHicfRXCZX8U
         wOqFhI+8pYcow5H+0JGtomkK++OA63nuAg9VIpB0kwTJycOtjZtEgbzF13c9EQTB/rTm
         tlFSX32WTZeIlFOgRAIfaSPchA8L1zYKYppQWKVvcz+IYdsZnhtLpZ2DaUlXXkf9PcfJ
         6RVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=3tCE2yiZmv5emjz5+xODrEsYmFN5QtPOIq5C/8MRY/g=;
        b=XzE0picSX8zkz14/mgj9w+hUWA+vwYJvd+QwibqhSf1eCZ4gqTz2RjFM1oqaqlc8Lx
         bmi0srF+PHygVScgmJwAr/MFzC0qTFJlO1QVV3teVD8sCs1nRyDYPJI5GFp5OvQiOo2B
         n5skeHQ4bVUIFRRQymV+35Ju8x2FOyTqbgvbqPu4jc7zZ07KQl9B5kaA06doZTWcKBXf
         /aOeiv6+W2QYfE8cKvDGwoZm8Xj/f2eb/ezy+ZAdbM+vjNTWds+rW2t53qEPLukBiO0I
         58Zg65uAFI0qgiRQkmpYzjBANXcBR9h8W1is8ulmN76fdG7lV3m9wM1tEtC77awUTr8T
         McKg==
X-Gm-Message-State: ALKqPwfZXGEcebZPc+zCx5nzi+YufwXqtZSHqdXWS3NqYAx2lixhKw+j
        J57XWr/Nd2xPp9VI7IKK7ZXZVN6gv2qnN7EF7nhmydN2lPYN37gHgpsIdBLoBsfG1EWeJGctczR
        LmginPp9muSHLjNtcX8ddFkpQNm8WYURPw+xsy/ouqhl8CvGdCfHnZWEN3w==
X-Google-Smtp-Source: AB8JxZpxbNa548NPX4LlhYU5wixYj6dcLL6v4fl4C8ZqORKTk/BtRT/SURR6xT878sFtv1eDr39a5o3KkCY=
MIME-Version: 1.0
X-Received: by 2002:a25:3623:: with SMTP id d35-v6mr1000316yba.78.1526511546908;
 Wed, 16 May 2018 15:59:06 -0700 (PDT)
Date:   Wed, 16 May 2018 15:57:59 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-13-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 12/36] fast-export: convert to use struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert fast-export to use 'struct refspec' instead of using a list of
refspec_item's.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fast-export.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 6f105dc79..143999738 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -36,8 +36,7 @@ static int use_done_feature;
 static int no_data;
 static int full_tree;
 static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
-static struct refspec_item *refspecs;
-static int refspecs_nr;
+static struct refspec refspecs = REFSPEC_INIT_FETCH;
 static int anonymize;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
@@ -830,9 +829,9 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 		if (dwim_ref(e->name, strlen(e->name), &oid, &full_name) != 1)
 			continue;
 
-		if (refspecs) {
+		if (refspecs.nr) {
 			char *private;
-			private = apply_refspecs(refspecs, refspecs_nr, full_name);
+			private = apply_refspecs(refspecs.items, refspecs.nr, full_name);
 			if (private) {
 				free(full_name);
 				full_name = private;
@@ -978,8 +977,8 @@ static void import_marks(char *input_file)
 static void handle_deletes(void)
 {
 	int i;
-	for (i = 0; i < refspecs_nr; i++) {
-		struct refspec_item *refspec = &refspecs[i];
+	for (i = 0; i < refspecs.nr; i++) {
+		struct refspec_item *refspec = &refspecs.items[i];
 		if (*refspec->src)
 			continue;
 
@@ -1040,18 +1039,12 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		usage_with_options (fast_export_usage, options);
 
 	if (refspecs_list.nr) {
-		const char **refspecs_str;
 		int i;
 
-		ALLOC_ARRAY(refspecs_str, refspecs_list.nr);
 		for (i = 0; i < refspecs_list.nr; i++)
-			refspecs_str[i] = refspecs_list.items[i].string;
-
-		refspecs_nr = refspecs_list.nr;
-		refspecs = parse_fetch_refspec(refspecs_nr, refspecs_str);
+			refspec_append(&refspecs, refspecs_list.items[i].string);
 
 		string_list_clear(&refspecs_list, 1);
-		free(refspecs_str);
 	}
 
 	if (use_done_feature)
@@ -1090,7 +1083,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	if (use_done_feature)
 		printf("done\n");
 
-	free_refspec(refspecs_nr, refspecs);
+	refspec_clear(&refspecs);
 
 	return 0;
 }
-- 
2.17.0.441.gb46fe60e1d-goog

