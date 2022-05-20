Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EF5C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 19:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353142AbiETTB4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 15:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353111AbiETTBx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 15:01:53 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11529185402
        for <git@vger.kernel.org>; Fri, 20 May 2022 12:01:52 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id n10so7483944qvi.5
        for <git@vger.kernel.org>; Fri, 20 May 2022 12:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bU1K3fg22Xd2affdrK5307jLaNbTlMOx/5lP00CuVZc=;
        b=4O4IlFBRrO73b3ba3Px3Oys+TH4qT5DG76Zt8Xq01q5m7QUZbCLdHOe3RIELtVSugL
         tRWRzL3FkBfoxkYwjrBDkugYfT4Zu5TXj8fQR6CHUsVJONz5IayPrx/B/VST2YB5B9wp
         yYSjdVxOSo6PJiPsxHZo480xFUa4JWXo3RU/fVtkMGBRL/tQYzq9qosgXkZROQcYllow
         SIne0lor0OCundPRPS3WByYBXyLredmMQPPK6PJyshWEGQfkk2BnqVQ5zHIJAp+Z/vkn
         at/r2wrtO3l7/ocgeOJWMvEynkTJtgW7yO0vWRCFoilG3CVGGznEYqdlMSET7uhaDQk2
         pZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bU1K3fg22Xd2affdrK5307jLaNbTlMOx/5lP00CuVZc=;
        b=KewkFnqXwF0DoohdJ+lPAE8E8kQVFq936naOFmncDpksXsXsKx/+Zk+RrowpiDmpTh
         lFatWDT8FRoXqR5GprL27J2xi7uj8FyNqOmuE14X738e0HoD3X+PW1WNQ6NLVUS1uZ12
         4qRi6EOufjktx546FF8lJVGNqeXvH0C5JlS47hxX4HmQQ65mtBj2LflJScdsYooWyqZ3
         55tEOXYaYT+h9tx7JbO+ktY7sTSrFD1ZmfhzxKjkEnR14FJz2pzk1ydf+nqsqPiNZMQx
         6Z154NxK+c+dIClkSxvzuHjdpWn5oMEb6ptqTUgmdazcirlB3YDeB7ebpywMfFzDMIwg
         3Cgw==
X-Gm-Message-State: AOAM530QSrHHWuKEsJpd+Vcw7nCVxAVhvr/b3bVsWMYxNfuYOR3pTr7C
        KVAYf35yOJZCk0eJm6wrMJM70V3EV5Npp1JD
X-Google-Smtp-Source: ABdhPJw0rx9yewO6N8nDlaSuEyRRqU6bxsMNmr/NKL2yaetMUViEfjk8fEqKJnezaP4fW6WMGnvRLg==
X-Received: by 2002:a05:6214:27ce:b0:461:dec4:1bb6 with SMTP id ge14-20020a05621427ce00b00461dec41bb6mr9106197qvb.46.1653073310330;
        Fri, 20 May 2022 12:01:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v15-20020ac8748f000000b002f9114d2ebcsm154692qtq.17.2022.05.20.12.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 12:01:49 -0700 (PDT)
Date:   Fri, 20 May 2022 15:01:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com
Subject: [PATCH 2/3] t7703: demonstrate object corruption with
 pack.packSizeLimit
Message-ID: <08da02fa74c211ae1019cb0a9f4e30cc239e1ab9.1653073280.git.me@ttaylorr.com>
References: <cover.1653073280.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1653073280.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When doing a `--geometric=<d>` repack, `git repack` determines a
splitting point among packs ordered by their object count such that:

  - each pack above the split has at least `<d>` times as many objects
    as the next-largest pack by object count, and
  - the first pack above the split has at least `<d>` times as many
    object as the sum of all packs below the split line combined

`git repack` then creates a pack containing all of the objects contained
in packs below the split line by running `git pack-objects
--stdin-packs` underneath. Once packs are moved into place, then any
packs below the split line are removed, since their objects were just
combined into a new pack.

But `git repack` tries to be careful to avoid removing a pack that it
just wrote, by checking:

    struct packed_git *p = geometry->pack[i];
    if (string_list_has_string(&names, hash_to_hex(p->hash)))
      continue;

in the `delete_redundant` and `geometric` conditional towards the end of
`cmd_repack`.

But it's possible to trick `git repack` into not recognizing a pack that
it just wrote when `names` is out-of-order (which violates
`string_list_has_string()`'s assumption that the list is sorted and thus
binary search-able).

When this happens in just the right circumstances, it is possible to
remove a pack that we just wrote, leading to object corruption.

Luckily, this is quite difficult to provoke in practice (for a couple of
reasons):

  - we ordinarily write just one pack, so `names` usually contains just
    one entry, and is thus sorted
  - when we do write more than one pack (e.g., due to `--max-pack-size`)
    we have to: (a) write a pack identical to one that already
    exists, (b) have that pack be below the split line, and (c) have
    the set of packs written by `pack-objects` occur in an order which
    tricks `string_list_has_string()`.

Demonstrate the above scenario in a failing test, which causes `git
repack --geometric` to write a pack which occurs below the split line,
_and_ fail to recognize that it wrote that pack.

The following patch will fix this bug.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t7703-repack-geometric.sh | 47 +++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 91bb2b37a8..2cd1de7295 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -7,6 +7,7 @@ test_description='git repack --geometric works correctly'
 GIT_TEST_MULTI_PACK_INDEX=0
 
 objdir=.git/objects
+packdir=$objdir/pack
 midx=$objdir/pack/multi-pack-index
 
 test_expect_success '--geometric with no packs' '
@@ -230,4 +231,50 @@ test_expect_success '--geometric chooses largest MIDX preferred pack' '
 	)
 '
 
+test_expect_failure '--geometric with pack.packSizeLimit' '
+	git init pack-rewrite &&
+	test_when_finished "rm -fr pack-rewrite" &&
+	(
+		cd pack-rewrite &&
+
+		test-tool genrandom foo 1048576 >foo &&
+		test-tool genrandom bar 1048576 >bar &&
+
+		git add foo bar &&
+		test_tick &&
+		git commit -m base &&
+
+		git rev-parse HEAD:foo HEAD:bar >p1.objects &&
+		git rev-parse HEAD HEAD^{tree} >p2.objects &&
+
+		# These two packs each contain two objects, so the following
+		# `--geometric` repack will try to combine them.
+		p1="$(git pack-objects $packdir/pack <p1.objects)" &&
+		p2="$(git pack-objects $packdir/pack <p2.objects)" &&
+
+		# Remove any loose objects in packs, since we do not want extra
+		# copies around (which would mask over potential object
+		# corruption issues).
+		git prune-packed &&
+
+		# Both p1 and p2 will be rolled up, but pack-objects will write
+		# three packs:
+		#
+		#   - one containing object "foo",
+		#   - another containing object "bar",
+		#   - a final pack containing the commit and tree objects
+		#     (identical to p2 above)
+		git repack --geometric 2 -d --max-pack-size=1048576 &&
+
+		# Ensure `repack` can detect that the third pack it wrote
+		# (containing just the tree and commit objects) was identical to
+		# one that was below the geometric split, so that we can save it
+		# from deletion.
+		#
+		# If `repack` fails to do that, we will incorrectly delete p2,
+		# causing object corruption.
+		git fsck
+	)
+'
+
 test_done
-- 
2.36.1.94.gb0d54bedca

