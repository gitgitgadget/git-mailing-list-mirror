Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0C9EE020A
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 19:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjIMTSD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 15:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjIMTSA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 15:18:00 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F01D19A0
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 12:17:56 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-58caaedb20bso1845087b3.1
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 12:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1694632675; x=1695237475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0pkvMCa8t/uiE70KS12CZYizlDGkE14cjyVfvFeYCAk=;
        b=Ucce+UsiVUW5e2AIeEihTqrcDYPufI3J2epNLWZAN00U/dozudZSgsYInaHc1E4kZl
         i1hdvvZnemFI6HP7a7nnU9G89Pk5HgLo9VMqfsfk3F1QLA3BT96oR2Q/0gGoTyAU/mWZ
         BTRgog6v3QSq1ufRmmVkMriQk6STMvr+4/kHeoj8xCQmpR0mYD80NtsRmANMoH6H5eV+
         5BO1N8hqJF4DWn64aAV5pkKsm7daMM7fQTOJcxgElv2WwNAcqUITqFtXJAjBPF+N9gew
         oYe6XnkjLyw5X+Z9HUVmhnCq3FVw9SwCBT+QVxlYRFjuHAZpeotkkpM/jb3zWOTvKzA+
         WGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694632675; x=1695237475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pkvMCa8t/uiE70KS12CZYizlDGkE14cjyVfvFeYCAk=;
        b=QJ9QeOkXoZZT4KZUiaL97wPuDMbhXxj4h7nIFVT8OBTV5Q54f6o7pCb3Z2MFJS1iJ1
         niIv9lh1wPOpeSUN6NhSD9lf3M6djcfD1dCWShOrGgjoC38+fgVOix1OiwNeEk0fRtyt
         dd8yOi0mAhTGfwueilIHtj4A7Clc6p2rWjGwbdQLmtEpwOxhpXgIyinf3fZd/cBpNKr5
         1sUXBWHsN3vKYLzM2UMKF8WBa3lH+IsGrZG7lUv4ClFE1lH/O03jOFQ+4RxCoUlwdUUy
         trPopXm88sdBy19wY+DsOLtIG4CHgB+BZLDsmKPVCzprbbgWgOI2ozQWUFzYAWLtblp2
         Wl2Q==
X-Gm-Message-State: AOJu0YyoqIJEKaHV/qR9ZgIdRWuq/QYQrtaWqxIK0SwkVePI3SRU+i+O
        SrqjK+iZlfQnRkZMfSsPpyhovS6sMO0QZ+wfEFp/cg==
X-Google-Smtp-Source: AGHT+IHbXUs0qChBm9B2FskdIjruGSR428qIroSaMDNtLcFvN7mdoDRCitbiPkE5Tj4d+IGyuF2ejQ==
X-Received: by 2002:a25:b288:0:b0:d81:817c:580 with SMTP id k8-20020a25b288000000b00d81817c0580mr830708ybj.25.1694632675602;
        Wed, 13 Sep 2023 12:17:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 4-20020a251104000000b00d7ba4c5e31fsm2879661ybr.39.2023.09.13.12.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 12:17:55 -0700 (PDT)
Date:   Wed, 13 Sep 2023 15:17:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 5/8] builtin/repack.c: extract
 `has_existing_non_kept_packs()`
Message-ID: <f4f7b4c08f682b5ebca474e8c1d51d31a2da76b8.1694632644.git.me@ttaylorr.com>
References: <cover.1693946195.git.me@ttaylorr.com>
 <cover.1694632644.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1694632644.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When there is:

  - at least one pre-existing packfile (which is not marked as kept),
  - repacking with the `-d` flag, and
  - not doing a cruft repack

, then we pass a handful of additional options to the inner
`pack-objects` process, like `--unpack-unreachable`,
`--keep-unreachable`, and `--pack-loose-unreachable`, in addition to
marking any packs we just wrote for promisor remotes as kept in-core
(with `--keep-pack`, as opposed to the presence of a ".keep" file on
disk).

Because we store both cruft and non-cruft packs together in the same
`existing.non_kept_packs` list, it suffices to check its `nr` member to
see if it is zero or not.

But a following change will store cruft- and non-cruft packs separately,
meaning this check would break as a result. Prepare for this by
extracting this part of the check into a new helper function called
`has_existing_non_kept_packs()`.

This patch does not introduce any functional changes, but prepares us to
make a more isolated change in a subsequent patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index b5fb14c017..9ebc2e774b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -105,6 +105,11 @@ struct existing_packs {
 	.non_kept_packs = STRING_LIST_INIT_DUP, \
 }
 
+static int has_existing_non_kept_packs(const struct existing_packs *existing)
+{
+	return existing->non_kept_packs.nr;
+}
+
 static void mark_packs_for_deletion_1(struct string_list *names,
 				      struct string_list *list)
 {
@@ -1047,7 +1052,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (pack_everything & ALL_INTO_ONE) {
 		repack_promisor_objects(&po_args, &names);
 
-		if (existing.non_kept_packs.nr && delete_redundant &&
+		if (has_existing_non_kept_packs(&existing) &&
+		    delete_redundant &&
 		    !(pack_everything & PACK_CRUFT)) {
 			for_each_string_list_item(item, &names) {
 				strvec_pushf(&cmd.args, "--keep-pack=%s-%s.pack",
-- 
2.42.0.166.g68748eb9c8

