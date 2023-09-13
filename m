Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C57CEE020A
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 19:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjIMTRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 15:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjIMTRj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 15:17:39 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C830170F
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 12:17:35 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d7f1bc4ece3so186997276.1
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 12:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1694632654; x=1695237454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=93JezqBtArFvTPHMPrrSHt8Mv4HqXIC/d2MGmjAGdOw=;
        b=q2ju8U76bXWH3xcXalNJ595hM5jdD7KFqChxMnqyeB8lQKDdJt/7hzPsQkJkboQymQ
         vH4y+yPWSbp3aXr2lJpjDc0MMlvA9pg2/ArSlIWU0rCRx35VZc5RDlHSleXZZYFdg1Sk
         FUkH1Zk826LdFbV4nzDvq5n9HvGAOiA87I0BVJuNNcvd46eLiOVP96fkB180n46KxjDb
         qLojt692562+32DyAAhnfcZ20jGMMJLpim0qOr9CKMaNdgrAPrdhN0BWsdvtXMYNOSQl
         PpWahoa/si0gLQz5tAqQOnq2c/hOOKJPAoJLBadAUVEvVselDy6dd6owfQ/y0xOKMN0J
         X/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694632654; x=1695237454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93JezqBtArFvTPHMPrrSHt8Mv4HqXIC/d2MGmjAGdOw=;
        b=pKOHySdectOToCb/VGeJxoe4sLfQ6EamwmtoTow6p2QijCiAqubwdxT/fwAjDuO4PO
         +WWKld11yRot/Rywah/CktMwM9TY3cVXj19EDe3MvSRcfZNsDB74VfQLFj2L3uiMRj/y
         EvUD1Eox7vM7mNfVMrk2LYs76pskpn36qQ/fYAlMoooj3VAwWJBlN6pWMYIHOrRk//L3
         O7ZbBuxoboFDh2/YxyQVk750PlrqKCPxxSTfR8F+rjdnXoIOZR6PDpuxWrFRhylr0qC5
         CDN1mybgLXXTuZpEpuYeX47phY0HEgTBU+Gucpya0yseLhyRrjcxGKAqvTkb/zJEnAjd
         yJgw==
X-Gm-Message-State: AOJu0YzhEHSLG+aFihv16tLLK79Whaqx/yNkrO11HfE55X6PXAcdyN+S
        nddFRAgaMwKvYw9/tSXbtGHaCY1Brjy/yqY3gBGBrg==
X-Google-Smtp-Source: AGHT+IE1DK/cguQJrSbdQjHKoRRUyG8jptFO6vQt/I8LOsA6Tm2scVTJXK48IdyeYXbiO9MsnxKfWw==
X-Received: by 2002:a25:2354:0:b0:d81:97c:c01c with SMTP id j81-20020a252354000000b00d81097cc01cmr3131288ybj.23.1694632653981;
        Wed, 13 Sep 2023 12:17:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d11-20020a25888b000000b00d7823cc7d62sm2771493ybl.19.2023.09.13.12.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 12:17:33 -0700 (PDT)
Date:   Wed, 13 Sep 2023 15:17:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/8] repack: refactor pack snapshot-ing logic
Message-ID: <cover.1694632644.git.me@ttaylorr.com>
References: <cover.1693946195.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1693946195.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a small reroll of my series to clean up some of the internals of
'git repack' used to track the set of existing packs.

Much is unchanged from the last round, save for some additional clean-up
on how we handle the '->util' field for each pack's string_list_item in
response to very helpful review from those CC'd.

As usual, a range-diff is available below for convenience. Thanks in
advance for your review!

Taylor Blau (8):
  builtin/repack.c: extract structure to store existing packs
  builtin/repack.c: extract marking packs for deletion
  builtin/repack.c: extract redundant pack cleanup for --geometric
  builtin/repack.c: extract redundant pack cleanup for existing packs
  builtin/repack.c: extract `has_existing_non_kept_packs()`
  builtin/repack.c: store existing cruft packs separately
  builtin/repack.c: avoid directly inspecting "util"
  builtin/repack.c: extract common cruft pack loop

 builtin/repack.c | 293 +++++++++++++++++++++++++++++------------------
 1 file changed, 180 insertions(+), 113 deletions(-)

Range-diff against v1:
1:  5b48b7e3cc = 1:  2e26beff22 builtin/repack.c: extract structure to store existing packs
2:  313537ef68 = 2:  62d916169d builtin/repack.c: extract marking packs for deletion
3:  5c25ef87c1 = 3:  7ed45804ea builtin/repack.c: extract redundant pack cleanup for --geometric
4:  7bb543fef8 = 4:  82057de4cf builtin/repack.c: extract redundant pack cleanup for existing packs
5:  e2cf87bb94 = 5:  f4f7b4c08f builtin/repack.c: extract `has_existing_non_kept_packs()`
6:  414a558883 = 6:  d68a88dbd5 builtin/repack.c: store existing cruft packs separately
7:  559b487e2a ! 7:  481a29599b builtin/repack.c: drop `DELETE_PACK` macro
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    builtin/repack.c: drop `DELETE_PACK` macro
    +    builtin/repack.c: avoid directly inspecting "util"
     
    +    The `->util` field corresponding to each string_list_item is used to
    +    track the existence of some pack at the beginning of a repack operation
    +    was originally intended to be used as a bitfield.
    +
    +    This bitfield tracked:
    +
    +      - (1 << 0): whether or not the pack should be deleted
    +      - (1 << 1): whether or not the pack is cruft
    +
    +    The previous commit removed the use of the second bit, but a future
    +    patch (from a different series than this one) will introduce a new use
    +    of it.
    +
    +    So we could stop treating the util pointer as a bitfield and instead
    +    start treating it as if it were a boolean. But this would require some
    +    backtracking when that later patch is applied.
    +
    +    Instead, let's avoid touching the ->util field directly, and instead
    +    introduce convenience functions like:
    +
    +      - pack_mark_for_deletion()
    +      - pack_is_marked_for_deletion()
    +
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
    +    Helped-by: Jeff King <peff@peff.net>
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## builtin/repack.c ##
    -@@
    - #define LOOSEN_UNREACHABLE 2
    - #define PACK_CRUFT 4
    +@@ builtin/repack.c: static int has_existing_non_kept_packs(const struct existing_packs *existing)
    + 	return existing->non_kept_packs.nr || existing->cruft_packs.nr;
    + }
      
    --#define DELETE_PACK 1
    --
    - static int pack_everything;
    - static int delta_base_offset = 1;
    - static int pack_kept_objects = -1;
    -@@ builtin/repack.c: static int repack_config(const char *var, const char *value,
    - 
    - struct existing_packs {
    - 	struct string_list kept_packs;
    -+	/*
    -+	 * for both non_kept_packs, and cruft_packs, a non-NULL
    -+	 * 'util' field indicates the pack should be deleted.
    -+	 */
    - 	struct string_list non_kept_packs;
    - 	struct string_list cruft_packs;
    - };
    ++static void pack_mark_for_deletion(struct string_list_item *item)
    ++{
    ++	item->util = (void*)((uintptr_t)item->util | DELETE_PACK);
    ++}
    ++
    ++static int pack_is_marked_for_deletion(struct string_list_item *item)
    ++{
    ++	return (uintptr_t)item->util & DELETE_PACK;
    ++}
    ++
    + static void mark_packs_for_deletion_1(struct string_list *names,
    + 				      struct string_list *list)
    + {
     @@ builtin/repack.c: static void mark_packs_for_deletion_1(struct string_list *names,
      		 * (if `-d` was given).
      		 */
      		if (!string_list_has_string(names, sha1))
     -			item->util = (void*)(uintptr_t)((size_t)item->util | DELETE_PACK);
    -+			item->util = (void*)1;
    ++			pack_mark_for_deletion(item);
      	}
      }
      
    @@ builtin/repack.c: static void remove_redundant_packs_1(struct string_list *packs
      	struct string_list_item *item;
      	for_each_string_list_item(item, packs) {
     -		if (!((uintptr_t)item->util & DELETE_PACK))
    -+		if (!item->util)
    ++		if (!pack_is_marked_for_deletion(item))
      			continue;
      		remove_redundant_pack(packdir, item->string);
      	}
     @@ builtin/repack.c: static void midx_included_packs(struct string_list *include,
    - 
    - 		for_each_string_list_item(item, &existing->cruft_packs) {
    - 			/*
    --			 * no need to check DELETE_PACK, since we're not
    --			 * doing an ALL_INTO_ONE repack
    -+			 * no need to check for deleted packs, since we're
    -+			 * not doing an ALL_INTO_ONE repack
    - 			 */
    - 			string_list_insert(include, xstrfmt("%s.idx", item->string));
      		}
      	} else {
      		for_each_string_list_item(item, &existing->non_kept_packs) {
     -			if ((uintptr_t)item->util & DELETE_PACK)
    -+			if (item->util)
    ++			if (pack_is_marked_for_deletion(item))
      				continue;
      			string_list_insert(include, xstrfmt("%s.idx", item->string));
      		}
      
      		for_each_string_list_item(item, &existing->cruft_packs) {
     -			if ((uintptr_t)item->util & DELETE_PACK)
    -+			if (item->util)
    ++			if (pack_is_marked_for_deletion(item))
      				continue;
      			string_list_insert(include, xstrfmt("%s.idx", item->string));
      		}
8:  ca7d13e7bf ! 8:  68748eb9c8 builtin/repack.c: extract common cruft pack loop
    @@ Commit message
     
      ## builtin/repack.c ##
     @@ builtin/repack.c: static void midx_included_packs(struct string_list *include,
    + 
      			string_list_insert(include, strbuf_detach(&buf, NULL));
      		}
    - 
    +-
     -		for_each_string_list_item(item, &existing->cruft_packs) {
     -			/*
    --			 * no need to check for deleted packs, since we're
    --			 * not doing an ALL_INTO_ONE repack
    +-			 * no need to check DELETE_PACK, since we're not
    +-			 * doing an ALL_INTO_ONE repack
     -			 */
     -			string_list_insert(include, xstrfmt("%s.idx", item->string));
     -		}
      	} else {
      		for_each_string_list_item(item, &existing->non_kept_packs) {
    - 			if (item->util)
    + 			if (pack_is_marked_for_deletion(item))
      				continue;
      			string_list_insert(include, xstrfmt("%s.idx", item->string));
      		}
     +	}
      
     -		for_each_string_list_item(item, &existing->cruft_packs) {
    --			if (item->util)
    +-			if (pack_is_marked_for_deletion(item))
     -				continue;
     -			string_list_insert(include, xstrfmt("%s.idx", item->string));
     -		}
    @@ builtin/repack.c: static void midx_included_packs(struct string_list *include,
     +		 * `mark_packs_for_deletion()` when doing an all-into-one
     +		 * repack).
     +		 */
    -+		if (item->util)
    ++		if (pack_is_marked_for_deletion(item))
     +			continue;
     +		string_list_insert(include, xstrfmt("%s.idx", item->string));
      	}
-- 
2.42.0.166.g68748eb9c8
