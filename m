Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23534C433E2
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 20:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E610E2151B
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 20:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgILUwO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Sep 2020 16:52:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58474 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbgILUwN (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 Sep 2020 16:52:13 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3004060756;
        Sat, 12 Sep 2020 20:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1599943901;
        bh=wXC2RcfHHv/YCZRaSLpV/xx31Ylw5A7Fgi4uuEQadEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=fTPosqXh3++JFjvx+aX+erD1xJpM8VD3vVvC4c0MKQ3Yt1shk08tFp45oV+47B1gA
         /VPevuC/nLvDS0edEuvHJipMDW8HyJGgKbCqDbS12yU3MkbCvaOeoMc8+HeYcL9OTw
         OllM+P04v4GZK1GTHdA2hL+VknIj9HxDLxvuaZu0xcMFlGILv5C/2Vr4YfDyMjJ/Q/
         lp+Rv2aX1chGDXUd2F1NhTG+f2W8/zxVJIBXrT4eLrbWxYyn6wt0lZxLzclF+9llAg
         t7ynvIFifXzUHeABdCnG7VX46u6x4JhIJN3rOMiX7ahUwVe0wa3u+rwXovMej+tdWR
         Ibk12jipAF0cZWXrcRxQipb3pvSOUAT4cMgeEw/3nfSgMWwmsJqR7pv2GbtuE7cs0F
         gzKvuaMFmrsd6pvYp77XJrXh8zuR9kwC1IaA2hrI/dOV0XEIuXsU6pA0oYMs+05MYJ
         gv+SNGsyFGYkeviPBQT5APbIe2/LnwSdBxhemRzewcVsNcvQfYu
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH 1/3] docs: explain why squash merges are broken with long-running branches
Date:   Sat, 12 Sep 2020 20:48:22 +0000
Message-Id: <20200912204824.2824106-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200912204824.2824106-1-sandals@crustytoothpaste.net>
References: <20200912204824.2824106-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In many projects, squash merges are commonly used, primarily to keep a
tidy history in the face of developers who do not use logically
independent, bisectable commits.  As common as this is, this tends to
cause significant problems when squash merges are used to merge
long-running branches due to the lack of any new merge bases.  Even very
experienced developers may make this mistakes, so let's add a FAQ entry
explaining why this is problematic and explaining that regular merge
commits should be used to merge two long-running branches.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitfaq.txt | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 9cd7a592ac..550f4e30d6 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -241,6 +241,39 @@ How do I know if I want to do a fetch or a pull?::
 	ignore the upstream changes.  A pull consists of a fetch followed
 	immediately by either a merge or rebase.  See linkgit:git-pull[1].
 
+Merging and Rebasing
+--------------------
+
+[[long-running-squash-merge]]
+What kinds of problems can occur when merging long-running branches with squash merges?::
+	In general, there are a variety of problems that can occur when using squash
+	merges with long-running branches.  These can include seeing extra commits in
+	`git log` output, with a GUI, or when using the `...` notation to express a
+	range, as well as the possibility of needing to re-resolve conflicts again and
+	again.
++
+When Git does a normal merge between two branches, it considers exactly three
+points: the two branches and a third commit, called the _merge base_, which is
+usually the common ancestor of the commits.  The result of the merge is the sum
+of the changes between the merge base and each head.  When you merge two
+long-running branches with a regular merge commit, this results in a new commit
+which will end up as a merge base when they're merged again, because there is
+now a new common ancestor.  Git doesn't have to consider changes that occurred
+before the merge base, so you don't have to re-resolve any conflicts you
+resolved before.
++
+When you perform a squash merge, a merge commit isn't created; instead, the
+changes from one side are applied as a regular commit to the other side.  This
+means that the merge base for these branches won't have changed, and so when Git
+goes to perform its next merge, it considers all of the changes that it
+considered the last time plus the new changes.  That means any conflicts may
+need to be re-resolved.  Similarly, anything using the `...` notation in `git
+diff`, `git log`, or a GUI will result in showing all of the changes since the
+original merge base.
++
+As a consequence, if you want to merge two long-running branches, it's best to
+always use a regular merge commit.
+
 Hooks
 -----
 
