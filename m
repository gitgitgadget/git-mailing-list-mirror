Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553C0C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 09:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEDF42310A
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 09:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbhAFJCr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 04:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbhAFJCq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 04:02:46 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C518C06134C
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 01:02:06 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id e2so1217172plt.12
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 01:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cKGEAFYDPh3A2c/VTwwvpylKd33hF7oRFpzFDKwB9eo=;
        b=WAF6dqY1MofEhY2R90iyWGg+TH+l8u554kNFL9rolVFMqE6MeEmJcYmN6zURo+SOwk
         kuF8dSuDDxgJ1OmKXtAvOcABi2jSytGddN9qCVoZal23pDQgp5lYw3+KX8tow043jLFg
         x6iI3QGmf36xmXP5I1oFVqFKfIEVJDZQaaEAXG+LuJECg/F2ois1AkIQhs9+wtu6TM3B
         SNDiMS0bIgLMseklSrqwxcVimG1MUSRkRo1MlOgLWl1vk9lUCsWhCsz9H4WCJhQY1W/r
         MtfMx8gQgjWoa27gy9j7EGPwsjgslGWr71KaC7NuACKgw0PA2N60AuLZkqW8YNAslsjz
         0/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cKGEAFYDPh3A2c/VTwwvpylKd33hF7oRFpzFDKwB9eo=;
        b=c2BV06ExBT3DW1ne7p80aL4upu9pmY+ExzZf/+iS0PEBR8SAhh/R1MhKgza1ETR4gA
         C84TUwptOT7ixgYccQejpjsAzLfQAVOBjbfZwhvxDmqmYPr9wusKih0Zxq4IZU3mxxKc
         ZrP9BIH6VkSX7nofDXBRfDscnZTT8yK4i9Xb5plquyRlpths1It9GpGafqApASU74+lj
         O5T96/C2nbDwIsoY06VOxbYQh6ri4FQs78QUr/Ob1bXUcFoCW4x1gkpSuuK6bRRIr6af
         bbMIQgDdsGIsgw+vXGHNi4qK/7YzbjCxTTlP0/Z2PqgX75nqbkFn2poKap9br18gyqQ5
         nqYA==
X-Gm-Message-State: AOAM532/mR5lS6du4cGwzZRAntBKMXrfFKdpXWpqVnzrJwWo/4S8/brq
        8FvZyp4cOFKjCUmpZmIoDewqwTjctbc=
X-Google-Smtp-Source: ABdhPJx92a8CpPXYUp/Has7HsLVU0CK9+aI/AdnlVMK5r5r8WGzILSlxz4zkhKwDFCTLrfQebz07IQ==
X-Received: by 2002:a17:90a:a487:: with SMTP id z7mr3323352pjp.102.1609923725642;
        Wed, 06 Jan 2021 01:02:05 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id m10sm1561919pjn.53.2021.01.06.01.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 01:02:05 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] refs: allow @{n} to work with n-sized reflog
Date:   Wed,  6 Jan 2021 01:01:52 -0800
Message-Id: <cover.1609923643.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <0c6885f15f5ce0be28142d9c69724362e72481a9.1609551262.git.liu.denton@gmail.com>
References: <0c6885f15f5ce0be28142d9c69724362e72481a9.1609551262.git.liu.denton@gmail.com>
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

Denton Liu (2):
  refs: factor out set_read_ref_cutoffs()
  refs: allow @{n} to work with n-sized reflog

 refs.c                      | 118 ++++++++++++++++++++----------------
 t/t1503-rev-parse-verify.sh |   4 +-
 t/t1508-at-combinations.sh  |  16 +++++
 3 files changed, 84 insertions(+), 54 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  8f14ec3997 refs: factor out set_read_ref_cutoffs()
1:  0c6885f15f ! 2:  18a35506b8 refs: allow @{n} to work with n-sized reflog
    @@ refs.c: static int read_ref_at_ent(struct object_id *ooid, struct object_id *noi
      	struct read_ref_at_cb *cb = cb_data;
     +	int at_indexed_ent;
      
    - 	cb->reccnt++;
      	cb->tz = tz;
      	cb->date = timestamp;
      
    @@ refs.c: static int read_ref_at_ent(struct object_id *ooid, struct object_id *noi
     +		cb->cnt--;
     +	at_indexed_ent = cb->cnt == 0 && !is_null_oid(ooid);
     +	if (timestamp <= cb->at_time || at_indexed_ent) {
    - 		if (cb->msg)
    - 			*cb->msg = xstrdup(message);
    - 		if (cb->cutoff_time)
    -@@ refs.c: static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
    + 		set_read_ref_cutoffs(cb, timestamp, tz, message);
    + 		/*
      		 * we have not yet updated cb->[n|o]oid so they still
      		 * hold the values for the previous record.
      		 */
    @@ refs.c: static int read_ref_at_ent(struct object_id *ooid, struct object_id *noi
      			warning(_("log for ref %s unexpectedly ended on %s"),
      				cb->refname, show_date(cb->date, cb->tz,
      						       DATE_MODE(RFC2822)));
    +-		cb->reccnt++;
     -		oidcpy(&cb->ooid, ooid);
     -		oidcpy(&cb->noid, noid);
      		cb->found_it = 1;
     -		return 1;
      	}
    + 	cb->reccnt++;
      	oidcpy(&cb->ooid, ooid);
      	oidcpy(&cb->noid, noid);
     -	if (cb->cnt > 0)
    @@ refs.c: static int read_ref_at_ent(struct object_id *ooid, struct object_id *noi
     +{
     +	struct read_ref_at_cb *cb = cb_data;
     +
    -+	if (cb->msg)
    -+		*cb->msg = xstrdup(message);
    -+	if (cb->cutoff_time)
    -+		*cb->cutoff_time = timestamp;
    -+	if (cb->cutoff_tz)
    -+		*cb->cutoff_tz = tz;
    -+	if (cb->cutoff_cnt)
    -+		*cb->cutoff_cnt = cb->reccnt;
    ++	set_read_ref_cutoffs(cb, timestamp, tz, message);
     +	oidcpy(cb->oid, noid);
     +	/* We just want the first entry */
     +	return 1;
    @@ t/t1503-rev-parse-verify.sh: test_expect_success 'fails silently when using -q'
      	test_must_be_empty error
      '
      
    -@@ t/t1503-rev-parse-verify.sh: test_expect_success 'master@{n} for various n' '
    - 	test_must_fail git rev-parse --verify master@{$Np1}
    - '
    +
    + ## t/t1508-at-combinations.sh ##
    +@@ t/t1508-at-combinations.sh: test_expect_success 'create path with @' '
    + check "@:normal" blob content
    + check "@:fun@ny" blob content
      
     +test_expect_success '@{1} works with only one reflog entry' '
    -+	git checkout -B newbranch &&
    ++	git checkout -B newbranch master &&
     +	git reflog expire --expire=now refs/heads/newbranch &&
    -+	git commit --allow-empty -mexpired &&
    -+	git rev-parse --verify newbranch@{1}
    ++	git commit --allow-empty -m "first after expiration" &&
    ++	git rev-parse newbranch~ >expect &&
    ++	git rev-parse newbranch@{1} >actual &&
    ++	test_cmp expect actual
     +'
     +
     +test_expect_success '@{0} works with empty reflog' '
    -+	git checkout -B newbranch &&
    ++	git checkout -B newbranch master &&
     +	git reflog expire --expire=now refs/heads/newbranch &&
    -+	git rev-parse --verify newbranch@{0}
    ++	git rev-parse newbranch >expect &&
    ++	git rev-parse newbranch@{0} >actual &&
    ++	test_cmp expect actual
     +'
    -+
    - test_expect_success SYMLINKS 'ref resolution not confused by broken symlinks' '
    - 	ln -s does-not-exist .git/refs/heads/broken &&
    - 	test_must_fail git rev-parse --verify broken
    + test_done
-- 
2.30.0

