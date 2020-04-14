Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD273C2BBFD
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 04:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98F71206E9
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 04:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="vnNWnOLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405075AbgDNEE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 00:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405073AbgDNEEZ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 00:04:25 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC25C0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 21:04:24 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h11so4182452plr.11
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 21:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p04prpl1Jzam3H9T+aaVfeoigWnxDl1R7+i/o5tR4aA=;
        b=vnNWnOLA0b/k/TuJeSzCZ6MCEFR8aW22B8YzMnyrD2EH4nWLGmuFg8Dgn1s+rSlgeN
         Z6HMSbKbexnMEwZgaDqlee1/mnitutEvWeebef416518kVkOQYsD7H+mDZK3PruF3Dxn
         XteyRapF8zsCHr1KfJ4b5/SPdH1WRalanvod+thrJtTqZ7ewHCyp6r8o4cM6Q2FVbjlX
         MP0jmGSq/w9+SbM3Zes5DLAfYInv6fypiqOEEtCL6+3medoux17FHea897g+ToAf1Qb6
         aqu88y4xxlh5l4a2OrjpOTvA7zngabF1WpaUGyLbqcHo8jhOeJUzmaxf+p+XJVAWf1nW
         C3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p04prpl1Jzam3H9T+aaVfeoigWnxDl1R7+i/o5tR4aA=;
        b=pDfU4y2HSCgz0g5UzbXllLHqwHa5xC/nFxYe615xL+emE8TZRxDsvEXs6/+9zl+2SE
         kHJTKjttdmnPxuIyooIDbPTLYmw2E6hBTOGYCpO3fFN3O1I+jGlbwcm6qcKswItF4w1k
         vo+cWwowfl17Sar7+6DZrrUkPfqLIivKkEHvvjBFGQuo00FFpy+SQtpGqry2iuBhZRwd
         mcFOVbpmfunuvPFC3TwU2vQ1OWITKveV/NUSsAc5IpEjIP7Fvm7gLCyOprvx7c1WJ0fj
         a+kUsqb4jF8uqpIYk/fpF/NAtgKBV569dZvQbCJCJCCksai/U0nEtkR5+9pHUq9/7DvM
         hx+Q==
X-Gm-Message-State: AGi0PuatX6mrT/7tpV9E0N//f7QNILHK7G/kJjivCSGfmwUbtXRs69ca
        7T/W+JSsTqnU8qsBvR5iWwn4r+BU1ojTKKcu
X-Google-Smtp-Source: APiQypL6BjudZtA4n7Ud2hOfprhemdfrSeMGp2YuK/qMWjjzeu2Sn5lQ/w62ApPLd/Jz5WvAH8VeCA==
X-Received: by 2002:a17:90a:8c10:: with SMTP id a16mr16478567pjo.78.1586837063843;
        Mon, 13 Apr 2020 21:04:23 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id q201sm10063759pfq.32.2020.04.13.21.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 21:04:23 -0700 (PDT)
Date:   Mon, 13 Apr 2020 22:04:22 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Subject: [PATCH 5/7] oidset: introduce 'oidset_size'
Message-ID: <4a9798ba6f3aab081dff5e40e1d91568cf4ba23b.1586836700.git.me@ttaylorr.com>
References: <cover.1586836700.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1586836700.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Occasionally, it may be useful for callers to know the number of object
IDs in an oidset. Right now, the only way to compute this is to call
'kh_size' on the internal 'kh_set_oid_t'.

Similar to how we wrap other 'kh_*' functions over the 'oidset' type,
let's allow callers to compute this value by introducing 'oidset_size'.

We will add its first caller in the subsequent commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 oidset.c | 5 +++++
 oidset.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/oidset.c b/oidset.c
index f63ce818f6..15d4e18c37 100644
--- a/oidset.c
+++ b/oidset.c
@@ -36,6 +36,11 @@ void oidset_clear(struct oidset *set)
 	oidset_init(set, 0);
 }
 
+int oidset_size(struct oidset *set)
+{
+	return kh_size(&set->set);
+}
+
 void oidset_parse_file(struct oidset *set, const char *path)
 {
 	FILE *fp;
diff --git a/oidset.h b/oidset.h
index d8a106b127..8261c36b91 100644
--- a/oidset.h
+++ b/oidset.h
@@ -54,6 +54,11 @@ int oidset_insert(struct oidset *set, const struct object_id *oid);
  */
 int oidset_remove(struct oidset *set, const struct object_id *oid);
 
+/**
+ * Returns the number of oids in the set.
+ */
+int oidset_size(struct oidset *set);
+
 /**
  * Remove all entries from the oidset, freeing any resources associated with
  * it.
-- 
2.26.0.106.g9fadedd637

