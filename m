Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5C4E94134
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 22:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbjJFWCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 18:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbjJFWCA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 18:02:00 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F52CE
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 15:01:58 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7740cf93901so155894385a.2
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 15:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696629717; x=1697234517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+mW8hc27WncfN/IxezQKjo6JZB6oeTpfnoy0nHgvO/A=;
        b=oC1foAKlbf4CJXUyzifElT6sQp083KBHo75PyQoGDY/eDZvrjgiNeuIIpIEKVjXf0K
         GrfjvBMTTfUNLvyxb20GEEMqt+D5ZSj6R16c1jUId3H6oCzTMWgq8G9Wzf+wooNcEYaU
         RxKqW01o7pVLL8WHp3TKnS8M6cSK8TkHZPh2tk+y2qap8xt+aQ8fqWUGe8i+mCZ1cjMO
         gi2pYYCJcVotq3iP4h5SktlQnhk+HuacvlHw1CZi7lnQJhNTwxfW6lpowT41cpBEaXmc
         o28BSmo2oTBoAIoSDf/Xda1fLF44tMkDcDcEjrk9bWrSocnKK6olsWTUk+pl4iPoNDkW
         stZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696629717; x=1697234517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mW8hc27WncfN/IxezQKjo6JZB6oeTpfnoy0nHgvO/A=;
        b=bZfAzBcTHzJcMHfmyLQ9IthlwSr6EqB830ol/9bYdanZP7ECq0dpYiKoGgX2+5fz71
         ZIUWqB1vXx6a62JHAuOI83hk1DDWW85LwPWSlovT4BMuQZEsWkBLHqhAPVJSNzrqcEK+
         zo4K+6KoqYBuRvxTz2qDNn+8jZ6we+eMS0qT/Mli15+a7N3qB/mNR+bGxh0l7g8DFzup
         8uLj3GqGtNV3URbbzeb4DlN25f4SI+S6LQNf3IgdvuN0SfX2HNRZ07T0JDSNuKRY9HSi
         jCH8mnlcNG4gFOXrw7SfVCsJIInRbn8y1RWDmbMMrbMrTuxxygmZmvncVuqZCh0esUcj
         efdA==
X-Gm-Message-State: AOJu0YxwnSdepdA+VKJsF/toJo20uzip2mkhqrU/RuhctLV+9wqj8vyA
        ENBnWAV6EfZ6KGfUG+MqXGAq3ppIaNO+i2GKC43w3w==
X-Google-Smtp-Source: AGHT+IGGozNCBk5COK95F+HFuw+s8OR1reqdUWDQCaqUJqIXPQXWvAfbsJ5W8GeCQcj1i/SuH0Mvig==
X-Received: by 2002:a05:620a:3949:b0:772:4706:99c0 with SMTP id qs9-20020a05620a394900b00772470699c0mr10181212qkn.26.1696629717138;
        Fri, 06 Oct 2023 15:01:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o24-20020a05620a111800b0075ca4cd03d4sm1611094qkk.64.2023.10.06.15.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 15:01:56 -0700 (PDT)
Date:   Fri, 6 Oct 2023 18:01:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        "Eric W. Biederman" <ebiederm@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/7] bulk-checkin: factor out `truncate_checkpoint()`
Message-ID: <f392ed2211d6d0d2dc99941f7fb44dcd978affb5.1696629697.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696629697.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as previous commits, factor our the routine to
truncate a bulk-checkin packfile when writing past the pack size limit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bulk-checkin.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 377c41f3ad..2dae8be461 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -273,6 +273,22 @@ static void prepare_checkpoint(struct bulk_checkin_packfile *state,
 	}
 }
 
+static void truncate_checkpoint(struct bulk_checkin_packfile *state,
+				struct hashfile_checkpoint *checkpoint,
+				struct pack_idx_entry *idx)
+{
+	/*
+	 * Writing this object to the current pack will make
+	 * it too big; we need to truncate it, start a new
+	 * pack, and write into it.
+	 */
+	if (!idx)
+		BUG("should not happen");
+	hashfile_truncate(state->f, checkpoint);
+	state->offset = checkpoint->offset;
+	flush_bulk_checkin_packfile(state);
+}
+
 static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 				struct object_id *result_oid,
 				int fd, size_t size,
@@ -300,16 +316,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
 					 fd, size, path, flags))
 			break;
-		/*
-		 * Writing this object to the current pack will make
-		 * it too big; we need to truncate it, start a new
-		 * pack, and write into it.
-		 */
-		if (!idx)
-			BUG("should not happen");
-		hashfile_truncate(state->f, &checkpoint);
-		state->offset = checkpoint.offset;
-		flush_bulk_checkin_packfile(state);
+		truncate_checkpoint(state, &checkpoint, idx);
 		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
 			return error("cannot seek back");
 	}
-- 
2.42.0.8.g7a7e1e881e.dirty

