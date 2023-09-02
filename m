Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925C2CA0FF7
	for <git@archiver.kernel.org>; Sat,  2 Sep 2023 09:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351906AbjIBJCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 05:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239062AbjIBJC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 05:02:29 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EEA1709
        for <git@vger.kernel.org>; Sat,  2 Sep 2023 02:02:26 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68a1af910e0so2149633b3a.2
        for <git@vger.kernel.org>; Sat, 02 Sep 2023 02:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693645346; x=1694250146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cX2vONle3g8VQP24LjpvKdELjikF1io2B4Gr3q9lrWQ=;
        b=ZOzBelz4/jp6vzkf4u74lCNdGu4q786VY41YDofDO5SmGTEok9wbH+doRaSp9WKkG0
         5HNVnL8zzUTsS7+N7gllJ6zg2+Gm/IAIgGMJ7ey0VR5MxT7v1FzcD559Dq2nnSAjZIfD
         8dt5bLe0kRoJTOQ2S+aWj9sUHAiQRnCOq+Du61HB59e58BT7+0FnEuTFrmj3O3BZHoUg
         2mAeTJPK0UFcpXONCSnW/wXjTWd1zt06RN+C2TCd3OqA2PVU9KuLNweQRqAeDyZWTYX/
         u3EPVMVjy37kZ9Qi1BDfrKuEFE+4MCzD0prkAt6XRaBjWfPFCQhjQgN5upnMxwlurM49
         Jw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693645346; x=1694250146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cX2vONle3g8VQP24LjpvKdELjikF1io2B4Gr3q9lrWQ=;
        b=JQPY5wF3eRjD2Pnehq/vnVEsNjOzas4m7Ts2kCY8xY28S1peDTmTE7ReJ7ChVqtFLT
         rWRb45hPkhaoVFuouSaCl9W+6HnA9h9SoFmqZR/UGbpUkBUs3F9GbCHsoz3RCzzgiZ4S
         M2jq/SEhLDyTTrKqnKKtJQXAFo1jlnzRP/EyhCHzzIZGx+rOFjiGqh00WiBlvR1fBcyY
         FvsQX/Ud7mADfmiEDpsT4bhQLAFgeV5u1+5Y4n4m4iddDfhLC/cUaDj2Ob7jJi5tprxO
         KciM/xYZvzkV/D4PE8UWLrtgCZEe7u8zn9yMj3n8POcyY5xjJRQnV3EaJEQ5mjoiXIVj
         sGLQ==
X-Gm-Message-State: AOJu0YxBBSpSP+jMGjIHhyNVWqlKTx9PRDDyfUzIRrk0G+Dk1ueUquNA
        NkRFF87fa4c1NNDy3NJuWRdG/yAd7HjnRA==
X-Google-Smtp-Source: AGHT+IHe1NcRaYN8TtwiMYWC1ddOfldQ1gcaY5xYoqmXG32jMp+eK60hn4DbWVXyvirt5m+I9Mk1QQ==
X-Received: by 2002:a17:902:c1ca:b0:1c0:b84d:3f73 with SMTP id c10-20020a170902c1ca00b001c0b84d3f73mr4969219plc.53.1693645345645;
        Sat, 02 Sep 2023 02:02:25 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.159.204])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d50500b001b53953f306sm4236952plg.178.2023.09.02.02.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 02:02:25 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2] ref-filter: sort numerically when ":size" is used
Date:   Sat,  2 Sep 2023 14:30:39 +0530
Message-ID: <20230902090155.8978-1-five231003@gmail.com>
X-Mailer: git-send-email 2.42.0.101.g9b561e429b.dirty
In-Reply-To: <20230901142624.12063-1-five231003@gmail.com>
References: <20230901142624.12063-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atoms like "raw" and "contents" have a ":size" option which can be used
to know the size of the data. Since these atoms have the cmp_type
FIELD_STR, they are sorted alphabetically from 'a' to 'z' and '0' to
'9'. Meaning, even when the ":size" option is used and what we
ultimatlely have is numbers, we still sort alphabetically.

For example, consider the the following case in a repo

refname			contents:size		raw:size
=======			=============		========
refs/heads/branch1	1130			1210
refs/heads/master	300			410
refs/tags/v1.0		140			260

Sorting with "--format="%(refname) %(contents:size) --sort=contents:size"
would give

refs/heads/branch1 1130
refs/tags/v1.0.0 140
refs/heads/master 300

which is an alphabetic sort, while what one might really expect is

refs/tags/v1.0.0 140
refs/heads/master 300
refs/heads/branch1 1130

which is a numeric sort (that is, a "$ sort -n file" as opposed to a
"$ sort file", where "file" contains only the "contents:size" or
"raw:size" info, each of which is on a newline).

Same is the case with "--sort=raw:size".

So, sort numerically whenever the sort is done with "contents:size" or
"raw:size" and do it the normal alphabetic way when "contents" or "raw"
are used with some other option (they are FIELD_STR anyways).

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 ref-filter.c            | 21 +++++++++++++--------
 t/t6300-for-each-ref.sh | 15 +++++++++++++--
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 1bfaf20fbf..9dbc4f71bd 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -582,9 +582,10 @@ static int contents_atom_parser(struct ref_format *format, struct used_atom *ato
 		atom->u.contents.option = C_BARE;
 	else if (!strcmp(arg, "body"))
 		atom->u.contents.option = C_BODY;
-	else if (!strcmp(arg, "size"))
+	else if (!strcmp(arg, "size")) {
+		atom->type = FIELD_ULONG;
 		atom->u.contents.option = C_LENGTH;
-	else if (!strcmp(arg, "signature"))
+	} else if (!strcmp(arg, "signature"))
 		atom->u.contents.option = C_SIG;
 	else if (!strcmp(arg, "subject"))
 		atom->u.contents.option = C_SUB;
@@ -690,9 +691,10 @@ static int raw_atom_parser(struct ref_format *format UNUSED,
 {
 	if (!arg)
 		atom->u.raw_data.option = RAW_BARE;
-	else if (!strcmp(arg, "size"))
+	else if (!strcmp(arg, "size")) {
+		atom->type = FIELD_ULONG;
 		atom->u.raw_data.option = RAW_LENGTH;
-	else
+	} else
 		return err_bad_arg(err, "raw", arg);
 	return 0;
 }
@@ -1857,7 +1859,8 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
 				v->s = xmemdupz(buf, buf_size);
 				v->s_size = buf_size;
 			} else if (atom->u.raw_data.option == RAW_LENGTH) {
-				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)buf_size);
+				v->value = buf_size;
+				v->s = xstrfmt("%"PRIuMAX, v->value);
 			}
 			continue;
 		}
@@ -1883,9 +1886,10 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
 			v->s = strbuf_detach(&sb, NULL);
 		} else if (atom->u.contents.option == C_BODY_DEP)
 			v->s = xmemdupz(bodypos, bodylen);
-		else if (atom->u.contents.option == C_LENGTH)
-			v->s = xstrfmt("%"PRIuMAX, (uintmax_t)strlen(subpos));
-		else if (atom->u.contents.option == C_BODY)
+		else if (atom->u.contents.option == C_LENGTH) {
+			v->value = strlen(subpos);
+			v->s = xstrfmt("%"PRIuMAX, v->value);
+		} else if (atom->u.contents.option == C_BODY)
 			v->s = xmemdupz(bodypos, nonsiglen);
 		else if (atom->u.contents.option == C_SIG)
 			v->s = xmemdupz(sigpos, siglen);
@@ -2265,6 +2269,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 
 		v->s_size = ATOM_SIZE_UNSPECIFIED;
 		v->handler = append_atom;
+		v->value = 0;
 		v->atom = atom;
 
 		if (*name == '*') {
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index aa3c7c03c4..7b943fd34c 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1017,16 +1017,16 @@ test_expect_success 'Verify sorts with raw' '
 test_expect_success 'Verify sorts with raw:size' '
 	cat >expected <<-EOF &&
 	refs/myblobs/blob8
-	refs/myblobs/first
 	refs/myblobs/blob7
-	refs/heads/main
 	refs/myblobs/blob4
 	refs/myblobs/blob1
 	refs/myblobs/blob2
 	refs/myblobs/blob3
 	refs/myblobs/blob5
 	refs/myblobs/blob6
+	refs/myblobs/first
 	refs/mytrees/first
+	refs/heads/main
 	EOF
 	git for-each-ref --format="%(refname)" --sort=raw:size \
 		refs/heads/main refs/myblobs/ refs/mytrees/first >actual &&
@@ -1138,6 +1138,17 @@ test_expect_success 'for-each-ref --format compare with cat-file --batch' '
 	test_cmp expected actual
 '
 
+test_expect_success 'verify sorts with contents:size' '
+	cat >expect <<-\EOF &&
+	refs/heads/main
+	refs/heads/newtag
+	refs/heads/ambiguous
+	EOF
+	git for-each-ref --format="%(refname)" \
+		--sort=contents:size refs/heads/ >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'set up multiple-sort tags' '
 	for when in 100000 200000
 	do
-- 
2.42.0.101.g9b561e429b.dirty

