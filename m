Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CB3B1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 03:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfBADJi (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 22:09:38 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:36949 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfBADJh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 22:09:37 -0500
Received: by mail-qk1-f201.google.com with SMTP id i3so1169083qkk.4
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 19:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FRmIG7BcHvFimbLI3ygX6k/mBaMGV4IbWxyjNzRSgv4=;
        b=iK4O0bUesbDt3CIvqccEhnVasC4Mybc114OzxaiNJT9UlYIgtT4X2jxCeplz8lvtu8
         NEHq+1BtX9YHpWfiuyM2PF+npDUwGVVXD6mp45QZnCnA+LKDglj3O0znDTtaSRRiKYi6
         g8tOMAYC2Rnou/4padoLdFPHlZDj55ViBDac/U6mSjizwSv6+XueH9Zs4Tiu37aft+sk
         1fWqQvrHo8bnIX3MEOmN8qxDbZf/TNt8/9ScyxCWLn/eg6l3Fe16P3w3jXlMAd6sZ2CG
         qWvZUhl0FplhAmbM+JlZdO+BaB8NUmE19DTL0cbo4W/Rb9GhbOy+MUODjAcEtQTyY9Pt
         IxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FRmIG7BcHvFimbLI3ygX6k/mBaMGV4IbWxyjNzRSgv4=;
        b=PeKAe5B6auWKFoztiZuHZlFQPxAgsJG07sXW7fkPDqJkvoGtWwyRiS5MKANNPT/YVQ
         3MleAfq1xZJVeU1v9BozZIpTU8QGmejMWgV3NedAtLulpSs60XTfUYtHtirFObV115V8
         TTcm+P05exJpHIotaue9b7RuJ09mKpDeJX50kR5Mr14Kf2zYhd4XVcufTcNhGEwPzE4G
         3HPBTa9mBNJXxG9osL/TiTlRAkHcf05EPs/XAZZ3CEnhXqFipwiS/gOM4n90XsoIRENz
         r6O3uj0FXKV0Cm6r3NzD7IyNSRGMgltes6e0zV51sRYuC7E0G3ZLmGKWPP4S0WOtcUoA
         WxOA==
X-Gm-Message-State: AHQUAua6r/Y/5GwckcEQdfS06MnPNzh+PjTHTTBIkCPDaVHykY1PunGR
        DMPZqvJAvfYkXckH62mk79TuobQXzwpFnDSogIdKkammwrehoF6xU8QUxSC/q6f5Jdf+qDji+BZ
        gzgBQS3Yyy+BtVi2Re9E6dcttVNY8ZFXYwayovri293Une9fXS3Ah8zHNcw==
X-Google-Smtp-Source: AHgI3Ib2GkFYw1rSyKs45Qj4CkPHLg24cvbpnkOstkCVWGEXoYuKclbRYjaUfpjKPW11hDhd28gCbrRa+G0=
X-Received: by 2002:a0c:81f8:: with SMTP id 53mr11406667qve.33.1548990576496;
 Thu, 31 Jan 2019 19:09:36 -0800 (PST)
Date:   Thu, 31 Jan 2019 19:09:19 -0800
In-Reply-To: <20190201030925.177124-1-sxenos@google.com>
Message-Id: <20190201030925.177124-2-sxenos@google.com>
Mime-Version: 1.0
References: <20190201030925.177124-1-sxenos@google.com>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
Subject: [PATCH v4 2/8] sha1-array: implement oid_array_readonly_contains
From:   sxenos@google.com
To:     git@vger.kernel.org
Cc:     Stefan Xenos <sxenos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Xenos <sxenos@google.com>

Implement a "readonly_contains" function for oid_array that won't
sort the array if it is unsorted. This can be used to test containment in
the rare situations where the array order matters.

The function has intentionally been given a name that is more cumbersome
than the "lookup" function, which is what most callers will will want
in most situations.

Signed-off-by: Stefan Xenos <sxenos@google.com>
---
 sha1-array.c               | 13 +++++++++++++
 sha1-array.h               |  2 ++
 t/helper/test-sha1-array.c |  6 ++++++
 t/t0064-sha1-array.sh      | 22 ++++++++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/sha1-array.c b/sha1-array.c
index d922e94e3f..d1adcbfc8a 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -26,6 +26,19 @@ static const unsigned char *sha1_access(size_t index, void *table)
 	return array[index].hash;
 }
 
+int oid_array_readonly_contains(const struct oid_array* array,
+	const struct object_id* oid)
+{
+	int i;
+
+	if (array->sorted)
+		return sha1_pos(oid->hash, array->oid, array->nr, sha1_access) >= 0;
+	for (i = 0; i < array->nr; i++)
+		if (oideq(&array->oid[i], oid) == 0)
+			return 1;
+	return 0;
+}
+
 int oid_array_lookup(struct oid_array *array, const struct object_id *oid)
 {
 	if (!array->sorted)
diff --git a/sha1-array.h b/sha1-array.h
index 55d016c4bf..06d3ad2994 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -13,6 +13,8 @@ struct oid_array {
 void oid_array_append(struct oid_array *array, const struct object_id *oid);
 int oid_array_lookup(struct oid_array *array, const struct object_id *oid);
 void oid_array_clear(struct oid_array *array);
+int oid_array_readonly_contains(const struct oid_array* array,
+	const struct object_id* oid);
 
 typedef int (*for_each_oid_fn)(const struct object_id *oid,
 			       void *data);
diff --git a/t/helper/test-sha1-array.c b/t/helper/test-sha1-array.c
index ad5e69f9d3..fefb1c984f 100644
--- a/t/helper/test-sha1-array.c
+++ b/t/helper/test-sha1-array.c
@@ -25,10 +25,16 @@ int cmd__sha1_array(int argc, const char **argv)
 			if (get_oid_hex(arg, &oid))
 				die("not a hexadecimal SHA1: %s", arg);
 			printf("%d\n", oid_array_lookup(&array, &oid));
+		} else if (skip_prefix(line.buf, "readonly_contains ", &arg)) {
+			if (get_oid_hex(arg, &oid))
+				die("not a hexadecimal SHA1: %s", arg);
+			printf("%d\n", oid_array_readonly_contains(&array, &oid));
 		} else if (!strcmp(line.buf, "clear"))
 			oid_array_clear(&array);
 		else if (!strcmp(line.buf, "for_each_unique"))
 			oid_array_for_each_unique(&array, print_oid, NULL);
+		else if (!strcmp(line.buf, "for_each"))
+			oid_array_for_each(&array, print_oid, NULL);
 		else
 			die("unknown command: %s", line.buf);
 	}
diff --git a/t/t0064-sha1-array.sh b/t/t0064-sha1-array.sh
index 5dda570b9a..512dd0f56b 100755
--- a/t/t0064-sha1-array.sh
+++ b/t/t0064-sha1-array.sh
@@ -32,6 +32,28 @@ test_expect_success 'ordered enumeration with duplicate suppression' '
 	test_cmp expect actual
 '
 
+test_expect_success 'readonly_contains finds existing' '
+	echo 1 >expect &&
+	echoid "" 88 44 aa 55 >>expect &&
+	{
+		echoid append 88 44 aa 55 &&
+		echoid readonly_contains 55 &&
+		echo for_each
+	} | test-tool sha1-array >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'readonly_contains non-existing query' '
+	echo 0 >expect &&
+	echoid "" 88 44 aa 55 >>expect &&
+	{
+		echoid append 88 44 aa 55 &&
+		echoid readonly_contains 33 &&
+		echo for_each
+	} | test-tool sha1-array >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'lookup' '
 	{
 		echoid append 88 44 aa 55 &&
-- 
2.20.1.611.gfbb209baf1-goog

