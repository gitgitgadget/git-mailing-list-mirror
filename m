Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED861C001DC
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 05:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjGZFVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 01:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjGZFVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 01:21:16 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF56B212A
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 22:21:14 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C081518D170;
        Wed, 26 Jul 2023 01:21:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=feGVh5+VPKCNMdgjZrajPyz5wu8ot2dQ+x8tRA
        qV5YQ=; b=A9qdX+ZNKnSOL7pd1xEyjG3DIKyacWoVTFzLqmMisZNw04214ae/Hz
        flEm17AEDsYStwdBttLvaZ+G5YYy3BYP1nOI9G9ZTFPurYCbI0cb2z/BXoJBIigC
        JADYyLEVdzIkmyMUkhS19dt3nhiNtexisjtICjKdTTvY41v6upp+I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B80ED18D16F;
        Wed, 26 Jul 2023 01:21:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 26FD118D16E;
        Wed, 26 Jul 2023 01:21:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: [PATCH 8/5] SubmittingPatches: use of older maintenance tracks is
 an exception
References: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
        <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com>
Date:   Tue, 25 Jul 2023 22:21:12 -0700
In-Reply-To: <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com> (Linus Arver
        via GitGitGadget's message of "Wed, 26 Jul 2023 03:04:56 +0000")
Message-ID: <xmqq351bfdtj.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CD426C0-2B74-11EE-85C2-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While we could technically fix each and every bug on top of the
commit that introduced it, it is not necessarily practical.  For
trivial and low-value bugfixes, it often is simpler to just fix it
in the current maintenance track, leaving the bug unfixed in the
older maintenance tracks.

Demote the "use older maintenance track" as a side note, and explain
that the choice is used only in exceptional cases.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 559c02c90c..0d1b53d4e5 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -46,15 +46,22 @@ latest HEAD commit of `maint` or `master` based on the following cases:
 * If you are fixing bugs in the released version, use `maint` as the
   starting point (which may mean you have to fix things without using
   new API features on the cutting edge that recently appeared in
-  `master` but were not available in the released version). If the bug
-  exists in an older version (e.g., commit `X` introduced the bug, and
-  `git describe --containx X` says `v2.30.0-rc2-gXXXXXX` has it), then
-  use the tip of the maintenance branch for the 2.30.x versions in the
-  `maint-2.30` branch in https://github.com/gitster/git[the maintainer's
-  repo].
+  `master` but were not available in the released version).
 
 * Otherwise (such as if you are adding new features) use `master`.
 
+
+NOTE: In an exceptional case, a bug that was introduced in an old
+version may have to be fixed for users of releases that are much older
+than the recent releases.  `git describe --contains X` may describe
+`X` as `v2.30.0-rc2-gXXXXXX` for the commit `X` that introduced the
+bug, and the bug may be so high-impact that we may need to issue a new
+maintenance release for Git 2.30.x series, when "Git 2.41.0" is the
+current release.  In such a case, you may want to use the tip of the
+maintenance branch for the 2.30.x series, which may be available as
+`maint-2.30` branch in https://github.com/gitster/git[the maintainer's
+"broken out" repo].
+
 This also means that `next` or `seen` are inappropriate starting points
 for your work, if you want your work to have a realistic chance of
 graduating to `master`.  They are simply not designed to be used as a
-- 
2.41.0-450-ga80be15292

