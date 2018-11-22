Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 440871F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 21:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438933AbeKWHyN (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 02:54:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37983 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438808AbeKWHyN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 02:54:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id k198so10319909wmd.3
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 13:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uzQ4gDqjkCHkLOKzqNNwzMilN7RF1xKrUumEdElOjQY=;
        b=NyZ1IED91AQFlHJt7aulAmwjVHcv5HZj3iluo+gHjFTkIRQiQDpvt+HB11uH9lCiLe
         zrE7UW7WOGIGTrkUUNHPm+WrqWfE7kwZQaZ9NJjVw2BYx0AtDdF/psUyrDMjSbSVt4ga
         gX47JKFOa9dR7fBEVVEYCttk2RH4HPPvQqQBeQbgzBmiGgmngxnNE3CyUqZuMhpECdlm
         0xK09ei6+j86EFu9YGV0c7DWlDsNywqZqJsR8nN/6JasZ+DXRAyvtvBpRWyzPmz801IX
         RwxTYOQ6oEo7f7qi+qEHWskbNHb2vlFHU3wYGR6QPv3MYKz6D1UVTaWkQp75c0WvQJ1+
         4lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uzQ4gDqjkCHkLOKzqNNwzMilN7RF1xKrUumEdElOjQY=;
        b=cvMPutmeg65LGKzF4X5oxUPQ0om1GWINNc+IhxUvQ0D8ERBKDbpykvqeSBc2w1CWFp
         6K8BI2vew2JjhBl2A41SV3eWt2d8U5pK89agbB3eK7S3BFqmyD8FRYEEQh23/KRLSjEf
         QGoh0wh6sUI0kWJlh65td9kFBLUiRRMMhbJrxMBKdscAJWQm5/xXg2nagkAv6b26MlCg
         I7HRKtLAqlMmTZQ8NRpPSZodk0sUJxtS1V6wkTbtv3TI38q0sYcsrG/+LMT6jVwRRANu
         2Q+3Ar5sESpgYZJCIBA0Yt5W8jS+EjgANBAJm7baJkMigy6eugqEn61krMP7OKQVD9MD
         syiQ==
X-Gm-Message-State: AGRZ1gIGZBjAjqXKMc9fp2v85mv5kMROVMwJAB1PTuld7Wkrso44V3CB
        cLZ2zJdOYUvTPG81eFwoGonODjx2Cx8=
X-Google-Smtp-Source: AFSGD/U1Oo3B4UU5tKN8dfqapqr2B5ySTE8CuGc92V1Q8l+nQQzSSB0PkViTNnp+lTOt8csWabBZeA==
X-Received: by 2002:a7b:c397:: with SMTP id s23mr10730991wmj.127.1542921182510;
        Thu, 22 Nov 2018 13:13:02 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 5sm8775229wmw.8.2018.11.22.13.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 13:13:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] format-patch: don't include --stat with --range-diff output
Date:   Thu, 22 Nov 2018 21:12:48 +0000
Message-Id: <20181122211248.24546-3-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <CAPig+cSzyT5N5=YeX+VgRq1t0VbWqXLHSB=g=V=O-nLdCWrE9g@mail.gmail.com>
References: <CAPig+cSzyT5N5=YeX+VgRq1t0VbWqXLHSB=g=V=O-nLdCWrE9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression introduced in my a48e12ef7a ("range-diff: make diff
option behavior (e.g. --stat) consistent", 2018-11-13). Since the
format-patch setup code implicitly sets --stat --summary by default,
we started emitting the --stat output in the cover letter's
range-diff.

As noted in df569c3f31 ("range-diff doc: add a section about output
stability", 2018-11-09) the --stat output is currently rather useless,
and just adds noise.

Perhaps we should detect if --stat or --summary were implicitly passed
to format-patch, and then pass them along, but I think fixing it this
way is fine. If our --stat output ever becomes useful in range-diff we
can revisit this.

There's still cases like e.g. --numstat triggering rather useless
range-diff output, but I think it's OK to just handle the default
case. Users are unlikely to produce a formatted patch with the likes
of --numstat, or indeed any other custom diff option except -U<n> or
maybe -W. If they need weirder combinations of options they can always
manually produce the range-diff.

This whole situation comes about because we're assuming that when the
user passes along e.g. -U10 that they want that some 10-line context
for the range-diff as for the patches themselves. As noted in [1] I
think it's worth re-visiting this and making -U10 just apply to the
patches, and e.g. --range-diff-U10 to the range-diff. But that's left
as a topic for another series less close to a rc2.

1. https://public-inbox.org/git/87d0ri7gbs.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/log.c         |  7 ++++++-
 t/t3206-range-diff.sh | 12 ------------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 0fe6f9ba1e..7cd2db0be9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1094,9 +1094,13 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	}
 
 	if (rev->rdiff1) {
+		struct diff_options opts;
+		memcpy(&opts, &rev->diffopt, sizeof(opts));
+		opts.output_format &= ~(DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY);
+
 		fprintf_ln(rev->diffopt.file, "%s", rev->rdiff_title);
 		show_range_diff(rev->rdiff1, rev->rdiff2,
-				rev->creation_factor, 1, &rev->diffopt);
+				rev->creation_factor, 1, &opts);
 	}
 }
 
@@ -1697,6 +1701,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (!use_patch_format &&
 		(!rev.diffopt.output_format ||
 		 rev.diffopt.output_format == DIFF_FORMAT_PATCH))
+		/* Needs to be mirrored in show_range_diff() invocation */
 		rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY;
 	if (!rev.diffopt.stat_width)
 		rev.diffopt.stat_width = MAIL_DEFAULT_WRAP;
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 0235c038be..90def330bd 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -252,21 +252,9 @@ do
 			master..unmodified >actual.raw &&
 		sed -e "s|^:||" -e "s|:$||" >expect <<-\EOF &&
 		:1:  4de457d = 1:  35b9b25 s/5/A/
-		:     a => b | 0
-		:     1 file changed, 0 insertions(+), 0 deletions(-)
-		:    :
 		:2:  fccce22 = 2:  de345ab s/4/A/
-		:     a => b | 0
-		:     1 file changed, 0 insertions(+), 0 deletions(-)
-		:    :
 		:3:  147e64e = 3:  9af6654 s/11/B/
-		:     a => b | 0
-		:     1 file changed, 0 insertions(+), 0 deletions(-)
-		:    :
 		:4:  a63e992 = 4:  2901f77 s/12/B/
-		:     a => b | 0
-		:     1 file changed, 0 insertions(+), 0 deletions(-)
-		:    :
 		:-- :
 		EOF
 		sed -ne "/^1:/,/^--/p" <actual.raw >actual &&
-- 
2.20.0.rc0.387.gc7a69e6b6c

