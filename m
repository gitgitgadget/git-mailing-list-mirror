Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EABC433E9
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 10:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BBD523142
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 10:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbhAGKhx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 05:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbhAGKhx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 05:37:53 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2A2C0612FB
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 02:37:09 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id i7so4556808pgc.8
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 02:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EU6PMD/cQVpy7gJt7uGtJNdOZFdhc9ezdXO/cCFPlyE=;
        b=Py+YjsSJonvy9e2TL6lH121WSfqz2/RpJdM0DoHQ5bxFjQoXz3RrBy5sjsKNdvlNSA
         KwP1gp6vSZWFbnAwcllqrrwQDzpEuKrXcSWYl8gM945uh2n9l3UfC0dsbFQZatxHFmLA
         aGit5gDnGuOK/9xOIHbBEeFCiP+dfzzPYKxnvKbQAA0oTDimtZAjni+FyYEhm/Z2Nlgk
         iCy3LH7LCdhxxOWLvZp+oqkq1hXcleciUc29UlMJt8dc4scn02/3HWQwtHihdG7XS2uu
         8ox5Ew5sUcY+/3gaPfxSe+t7y2lsxCTV7xwRpWQLnJdTiO7C9R/3mOl1e7kMekHmUXhu
         uMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EU6PMD/cQVpy7gJt7uGtJNdOZFdhc9ezdXO/cCFPlyE=;
        b=QkUVBjXxQY4Wn5R1PezhlQuUmgQWgHU400Y8NAbG5e7ea1v/dDjwxpRixFRbup1uXf
         uaMlp7hQKx6T3elbw4ZzGc1crsskRZGPCDutC2lk4JTJ57bdOXlFXo1rVzHx4l4Njgh/
         WY/H4Cf/0B7STK+iRZtd/OzmtN9yvn0rFDUU77CTN/paYoaJ3f42FMRs10kRSTpSyVyM
         98ZsnGVP6XdnNMWCc5V4bDVNvykKQf/z12BSIDT2yu3zjCdcL5m+8TsCK+8Ia+44snLb
         j3Pvf6Rz3+AqhLSuWB5mQRs/Dklk1fcTrg/LEvLZ+O7u1tIr9shNCmVJ8LtDqWfVvRi6
         z5FQ==
X-Gm-Message-State: AOAM533+pQOrqqDMkyyC5ZcVvlqZO44v9Taz2jzIv6y6sBGGvTycudxA
        HCdO1WxFuZcZtv5v7PCgrdbVcKfs6vU=
X-Google-Smtp-Source: ABdhPJxZlx+x1ot/IlSQqK2Y7kDlx7TwJHhfZblvpl1whgJBrD6kS/0JqwhbQw3K9tlTOuTAusdQgw==
X-Received: by 2002:a63:e108:: with SMTP id z8mr1193204pgh.363.1610015828305;
        Thu, 07 Jan 2021 02:37:08 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id bg20sm1777416pjb.6.2021.01.07.02.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 02:37:07 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/2] refs: allow @{n} to work with n-sized reflog
Date:   Thu,  7 Jan 2021 02:36:57 -0800
Message-Id: <cover.1610015769.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609923643.git.liu.denton@gmail.com>
References: <cover.1609923643.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When there is only one reflog entry (perhaps caused by expiring the
reflog and then making a single commit) @{1} errors out even though
there is technically enough information to do the lookup. Look at the
old side of the reflog instead of the new side so that this does not
fail. This is explained in more detail in the commit of the last patch.

This idea was given by Junio at [0].

[0]: https://lore.kernel.org/git/xmqqzh8zgcfp.fsf@gitster.c.googlers.com/

Changes since v1:

* Factor out set_read_ref_cutoffs()

* Check the output of rev-parse to ensure that the intended commit is
  returned

Changes since v2:

* Rename at_indexed_ent -> reached_count

* Add an in-code comment to document that cb->cnt can't be 0 in the first
  iteration of read_ref_at_ent()

* Make test cases use test_cmp_rev() for brevity and better errors

Denton Liu (2):
  refs: factor out set_read_ref_cutoffs()
  refs: allow @{n} to work with n-sized reflog

 refs.c                      | 122 +++++++++++++++++++++---------------
 t/t1503-rev-parse-verify.sh |   4 +-
 t/t1508-at-combinations.sh  |  12 ++++
 3 files changed, 84 insertions(+), 54 deletions(-)

Range-diff against v2:
1:  8f14ec3997 = 1:  8f14ec3997 refs: factor out set_read_ref_cutoffs()
2:  18a35506b8 ! 2:  c88c997eab refs: allow @{n} to work with n-sized reflog
    @@ refs.c: static int read_ref_at_ent(struct object_id *ooid, struct object_id *noi
      		const char *message, void *cb_data)
      {
      	struct read_ref_at_cb *cb = cb_data;
    -+	int at_indexed_ent;
    ++	int reached_count;
      
      	cb->tz = tz;
      	cb->date = timestamp;
      
     -	if (timestamp <= cb->at_time || cb->cnt == 0) {
    ++	/*
    ++	 * It is not possible for cb->cnt == 0 on the first itertion because
    ++	 * that special case is handled in read_ref_at().
    ++	 */
     +	if (cb->cnt > 0)
     +		cb->cnt--;
    -+	at_indexed_ent = cb->cnt == 0 && !is_null_oid(ooid);
    -+	if (timestamp <= cb->at_time || at_indexed_ent) {
    ++	reached_count = cb->cnt == 0 && !is_null_oid(ooid);
    ++	if (timestamp <= cb->at_time || reached_count) {
      		set_read_ref_cutoffs(cb, timestamp, tz, message);
      		/*
      		 * we have not yet updated cb->[n|o]oid so they still
    @@ refs.c: static int read_ref_at_ent(struct object_id *ooid, struct object_id *noi
      					cb->refname, show_date(cb->date, cb->tz, DATE_MODE(RFC2822)));
     -		}
     -		else if (cb->date == cb->at_time)
    -+		if (at_indexed_ent)
    ++		if (reached_count)
     +			oidcpy(cb->oid, ooid);
     +		else if (!is_null_oid(&cb->ooid) || cb->date == cb->at_time)
      			oidcpy(cb->oid, noid);
    @@ t/t1508-at-combinations.sh: test_expect_success 'create path with @' '
     +	git checkout -B newbranch master &&
     +	git reflog expire --expire=now refs/heads/newbranch &&
     +	git commit --allow-empty -m "first after expiration" &&
    -+	git rev-parse newbranch~ >expect &&
    -+	git rev-parse newbranch@{1} >actual &&
    -+	test_cmp expect actual
    ++	test_cmp_rev newbranch~ newbranch@{1}
     +'
     +
     +test_expect_success '@{0} works with empty reflog' '
     +	git checkout -B newbranch master &&
     +	git reflog expire --expire=now refs/heads/newbranch &&
    -+	git rev-parse newbranch >expect &&
    -+	git rev-parse newbranch@{0} >actual &&
    -+	test_cmp expect actual
    ++	test_cmp_rev newbranch newbranch@{0}
     +'
      test_done
-- 
2.30.0

