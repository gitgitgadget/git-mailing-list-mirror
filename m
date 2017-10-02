Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E67C20281
	for <e@80x24.org>; Mon,  2 Oct 2017 16:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751849AbdJBQKk (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 12:10:40 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:51607 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbdJBQKj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 12:10:39 -0400
Received: by mail-pg0-f54.google.com with SMTP id u144so511750pgb.8
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 09:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sqwEKR++r7F8c9PQZr/Rd/qqQqukbHw53I3fr0TYavQ=;
        b=RYn5+08UpLqx++pb13fPABTmBhcbpN/Pq5kj3KdZ7SMb/IFj+swF6TkyenoJjhs+f8
         afpiJyAlHsUr3Id4EKT+Sb8UjX09uHohwefmlWYE3mvTajH77KgDJuTmUyB+2OsbFPPv
         y4d9CTkpPQ/tAroMeZp6AOo4Cld0TDem7fQQHokRFbshxjnfGVGgYqSUmoN0es7S/oCW
         Xz7QwIxKFu2/6Q/5Y98Jspd3Kn0+gA9Y1XdJEJzBfc17Xhideguzts1NPQ69DCUs92Uo
         3oz+r2GQwWbhG+kgDp8Xkn15Tv5RwgOJKyPXwJ7+l3g7HE/wMGXnAJp+7YWI6rwqiwrI
         GO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sqwEKR++r7F8c9PQZr/Rd/qqQqukbHw53I3fr0TYavQ=;
        b=ohwd9UgCXHzS+xyN8kyGsPXtDvAxKixIUYReoS39yiAP4I8uubJ2KGy8L4gfAL6CYx
         UwNNYXYSsHkHnEMfBEQIWCF7LO5k2RQ/nR+2oIetHpbTfgYU43q/rvH4DDZjhZRsp/1F
         cVBObuK1JGuohTmp2ZceCzVQ76KrlcGZg96B+gyUK4URmpWYUpYq/Qvim/a6e/ExTTNr
         1WdsjC43ft4/W1BDx6FS91zcjw/qsqGG46qhW0wOkOB2jmK3Mc4cXyDktumq3//ha1wS
         xJlv3+oTwdHC4ltL98NLeDHWzcczs4uaHT7wuiUo2mrORhcZrIyIOymBjAYAeZ8tLSRs
         JGBQ==
X-Gm-Message-State: AHPjjUgNdp5fELhUFBTE5XlgJMwguR7Ap/5jsvLkd25lcoNTQjLYXCdc
        JPb19o1cin+9rvM+Cmb0HFgY3YD4ZBo=
X-Google-Smtp-Source: AOwi7QC3xGM2SK4M3HDF9gfRU6YDnYRE0SyafznKg+yGNOIRjvurPoA3VnjePBnEo9vRq4XVtHHtqw==
X-Received: by 10.101.77.4 with SMTP id i4mr13072585pgt.119.1506960638743;
        Mon, 02 Oct 2017 09:10:38 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id d7sm4158919pgf.20.2017.10.02.09.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Oct 2017 09:10:37 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2] ref-filter.c: pass empty-string as NULL to atom parsers
Date:   Mon,  2 Oct 2017 09:10:34 -0700
Message-Id: <20171002161034.44867-1-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171002055052.GB10729@D-10-157-251-166.dhcp4.washington.edu>
References: <20171002055052.GB10729@D-10-157-251-166.dhcp4.washington.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peff points out that different atom parsers handle the empty
"sub-argument" list differently. An example of this is the format
"%(refname:)".

Since callers often use `string_list_split` (which splits the empty
string with any delimiter as a 1-ary string_list containing the empty
string), this makes handling empty sub-argument strings non-ergonomic.

Let's fix this by assuming that atom parser implementations don't care
about distinguishing between the empty string "%(refname:)" and no
sub-arguments "%(refname)".

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ref-filter.c            | 10 +++++++++-
 t/t6300-for-each-ref.sh |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index bc591f4f3..f3e53d444 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -415,8 +415,16 @@ static int parse_ref_filter_atom(const struct ref_format *format,
 	REALLOC_ARRAY(used_atom, used_atom_cnt);
 	used_atom[at].name = xmemdupz(atom, ep - atom);
 	used_atom[at].type = valid_atom[i].cmp_type;
-	if (arg)
+	if (arg) {
 		arg = used_atom[at].name + (arg - atom) + 1;
+		if (!*arg) {
+			/*
+			 * Treat empty sub-arguments list as NULL (i.e.,
+			 * "%(atom:)" is equivalent to "%(atom)").
+			 */
+			arg = NULL;
+		}
+	}
 	memset(&used_atom[at].u, 0, sizeof(used_atom[at].u));
 	if (valid_atom[i].parser)
 		valid_atom[i].parser(format, &used_atom[at], arg);
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 2274a4b73..edc1bd8ea 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -51,6 +51,7 @@ test_atom() {
 }
 
 test_atom head refname refs/heads/master
+test_atom head refname: refs/heads/master
 test_atom head refname:short master
 test_atom head refname:lstrip=1 heads/master
 test_atom head refname:lstrip=2 master
-- 
2.14.1.145.gb3622a4ee

