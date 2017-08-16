Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B82A31F667
	for <e@80x24.org>; Wed, 16 Aug 2017 18:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbdHPS3A (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 14:29:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59168 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752313AbdHPS27 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 14:28:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C749A3DDC;
        Wed, 16 Aug 2017 14:28:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=N/frROH1T/V/r16dOqVPAuP2DW4=; b=mwDrYsCFa0flFuDXnAzO
        hgMGijCyxQuyI84r0U04855JIHFt8adjlpjpR20yAIleCcOcb9ezFtAA8+uH9v1A
        m4fUHemrFKKsSnIhF0GNDDU9UzeglV+YgTk3DhyS6TWjO5AuYPEa7/MnS/exyxMT
        TqIcJunfjvzdOSEYkADrYzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=CT4SNT1C3cl7u++859gGXxCyMVzkkVm7oMMWQUQpKB6Kk9
        ixNm6qVdBBLNPmacwpFL3IZTk3hMGnNeMy+I/sdZU6U0wwl5q+X43F27SFhZ2kJY
        RhIFEk819CK0Dy1L/WBI5dFdF4qDlsBcnSD4AlCPyc2h1dnXa3EMAfc13AwXg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81572A3DDB;
        Wed, 16 Aug 2017 14:28:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C2974A3DD7;
        Wed, 16 Aug 2017 14:28:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, asottile@umich.edu
Subject: [PATCH/FIXUP 3/2] apply: remove unused member apply_state.flags
References: <xmqq4ltpsn42.fsf@gitster.mtv.corp.google.com>
        <20170813085106.1731-1-tboegi@web.de>
Date:   Wed, 16 Aug 2017 11:28:56 -0700
Message-ID: <xmqqwp63l63b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C459305E-82B0-11E7-AC1B-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous step added the "flags" member to apply_state, but it is
never used.  Remove it and move the bit assignment macro to apply.c
as that is just a private implementation detail.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 apply.c | 2 ++
 apply.h | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index 63455cd65f..7663e63df7 100644
--- a/apply.c
+++ b/apply.c
@@ -2282,6 +2282,8 @@ static void show_stats(struct apply_state *state, struct patch *patch)
 		add, pluses, del, minuses);
 }
 
+#define APPLY_FLAGS_CR_AT_EOL   (1<<0)
+
 static int read_old_data(struct stat *st, const char *path, struct strbuf *buf, int flags)
 {
 	enum safe_crlf safe_crlf = flags & APPLY_FLAGS_CR_AT_EOL ?
diff --git a/apply.h b/apply.h
index 192140280f..b3d6783d55 100644
--- a/apply.h
+++ b/apply.h
@@ -33,13 +33,9 @@ enum apply_verbosity {
 #define APPLY_SYMLINK_GOES_AWAY 01
 #define APPLY_SYMLINK_IN_RESULT 02
 
-
-#define APPLY_FLAGS_CR_AT_EOL   (1<<0)
-
 struct apply_state {
 	const char *prefix;
 	int prefix_length;
-	int flags;
 
 	/* These are lock_file related */
 	struct lock_file *lock_file;
-- 
2.14.1-331-g7631d96230

