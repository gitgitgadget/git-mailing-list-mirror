Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E86CC433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 15:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F51561947
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 15:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhCSPlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 11:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhCSPk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 11:40:57 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5671BC06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 08:40:55 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id r193so6544329ior.9
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=4/ObmzHRnXVM27Fu17uK7sCt4rfi9J1GDUEveuEzrK4=;
        b=Vp8y2Rj3aAmDGZniu4YOQ8S18h3WpB5+OMB0UdviH5eDuKKTFtxpQgqYS3OQLwJduX
         H/GaZtwlRC6Ym4rexrQI81z1fBwoysnVSdWimTdSEtWN7dqIl7xLOmqDCPi6+8iD5aEM
         4JwUh9XoCMPqavwPpnUu/02jd/ioor3y/IkNdDitsSjOAgVx/nvgX/Z9BMw88GBHdokF
         OsWYi/PMMIjeXa3g5Vg2gOrLeKQauvjgVhPA0hLs+qTvhzyxmOqNP/yyjKRn8Pu6Sdv0
         6HH3zXP9FW4uYem+tFjWMLkSsd0GZ/8geybCWsvHSos8vaofRcOBBn8C7ocYged9D+sd
         wLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4/ObmzHRnXVM27Fu17uK7sCt4rfi9J1GDUEveuEzrK4=;
        b=oKc0WgaXVA658Et8LFu9+XwY6/5eGMEtkTWGMMauB+eLNU0H7+UFOWr0Is0Sgj0q4k
         Qlw3U55mPN4JAueLJpkGoArBu8KiHsSaTlKwA5AptcvTD54uZOLObBTMaC7qpLnSUapq
         I/zgQsML7pabvlWBO0aD5c7wilCMzJfEHehRPbNNQZmu3Kc8DzhiejtQuK/8l1dBznbm
         yOwOn/creDWHgltjIFt2h4QmRY3DDiQH6zwoD+oj3Yo/eQpNtCywk8EfAQ4mAtF7S+GZ
         gT3fIf+vDpa51TMni+evHtrxhklU6zIQSWeTTBKnY9ZmM5F2XlKZLMyJstrrzAoy3pQU
         fi1Q==
X-Gm-Message-State: AOAM530b8mXM510amh4vAHsXemms/SS58jkIF1+NB+ZD7IHGraV91bUs
        QdtaF8zJqVoIVpAlzD9chZOwzSxVTY+PAQ==
X-Google-Smtp-Source: ABdhPJzimz9ByDIWQ8cUajiADWEUmVpgFCK2c+elD8RDPTRICtVO1tl8AGbtsUtiCkzN8MreBRAICA==
X-Received: by 2002:a05:6638:238c:: with SMTP id q12mr1910105jat.114.1616168454381;
        Fri, 19 Mar 2021 08:40:54 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:baa3:618e:2b0f:2498])
        by smtp.gmail.com with ESMTPSA id k7sm2063572ils.35.2021.03.19.08.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 08:40:53 -0700 (PDT)
Date:   Fri, 19 Mar 2021 11:40:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Subject: [PATCH v1] builtin/pack-objects.c: ignore missing links with
 --stdin-packs
Message-ID: <815623da67d283e8509fc4ac67e939c6140fc39a.1616168441.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 'git pack-objects --stdin-packs' encounters a commit in a pack, it
marks it as a starting point of a best-effort reachability traversal
that is used to populate the name-hash of the objects listed in the
given packs.

The traversal expects that it should be able to walk the ancestors of
all commits in a pack without issue. Ordinarily this is the case, but it
is possible to having missing parents from an unreachable part of the
repository. In that case, we'd consider any missing objects in the
unreachable portion of the graph to be junk.

This should be handled gracefully: since the traversal is best-effort
(i.e., we don't strictly need to fill in all of the name-hash fields),
we should simply ignore any missing links.

This patch does that (by setting the 'ignore_missing_links' bit on the
rev_info struct), and ensures we don't regress in the future by adding a
test which demonstrates this case.

It is a little over-eager, since it will also ignore missing links in
reachable parts of the packs (which would indicate a corrupted
repository), but '--stdin-packs' is explicitly *not* about reachability.
So this step isn't making anything worse for a repository which contains
packs missing reachable objects (since we never drop objects with
'--stdin-packs').

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
I noticed a small number of repositories using geometric repacks
complained about missing links when doing the best-effort traversal to
fill in missing namehash fields with 'git pack-objects --stdin-packs'.

This patch takes care to handle that situation gracefully. It is based
on tb/geometric-repack, which is on 'next'.

 builtin/pack-objects.c |  1 +
 t/t5300-pack-object.sh | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8cb32763b7..f513138513 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3122,6 +3122,7 @@ static void read_packs_list_from_stdin(void)
 	revs.blob_objects = 1;
 	revs.tree_objects = 1;
 	revs.tag_objects = 1;
+	revs.ignore_missing_links = 1;

 	while (strbuf_getline(&buf, stdin) != EOF) {
 		if (!buf.len)
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 7138a54595..ab509e8c38 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -629,4 +629,42 @@ test_expect_success '--stdin-packs with loose objects' '
 	)
 '

+test_expect_success '--stdin-packs with broken links' '
+	(
+		cd stdin-packs &&
+
+		# make an unreachable object with a bogus parent
+		git cat-file -p HEAD >commit &&
+		sed "s/$(git rev-parse HEAD^)/$(test_oid zero)/" <commit |
+		git hash-object -w -t commit --stdin >in &&
+
+		git pack-objects .git/objects/pack/pack-D <in &&
+
+		PACK_A="$(basename .git/objects/pack/pack-A-*.pack)" &&
+		PACK_B="$(basename .git/objects/pack/pack-B-*.pack)" &&
+		PACK_C="$(basename .git/objects/pack/pack-C-*.pack)" &&
+		PACK_D="$(basename .git/objects/pack/pack-D-*.pack)" &&
+
+		git pack-objects test3 --stdin-packs --unpacked <<-EOF &&
+		$PACK_A
+		^$PACK_B
+		$PACK_C
+		$PACK_D
+		EOF
+
+		(
+			git show-index <$(ls .git/objects/pack/pack-A-*.idx) &&
+			git show-index <$(ls .git/objects/pack/pack-C-*.idx) &&
+			git show-index <$(ls .git/objects/pack/pack-D-*.idx) &&
+			git rev-list --objects --no-object-names \
+				refs/tags/C..refs/tags/D
+		) >expect.raw &&
+		git show-index <$(ls test3-*.idx) >actual.raw &&
+
+		cut -d" " -f2 <expect.raw | sort >expect &&
+		cut -d" " -f2 <actual.raw | sort >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
--
2.30.0.667.g81c0cbc6fd
