Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076EDC4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 03:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D60921D43
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 03:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QiLg2pXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374953AbgJWDtN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 23:49:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64677 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2902436AbgJWDtN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 23:49:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E3C118E365;
        Thu, 22 Oct 2020 23:49:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=o
        S7vvuk4LV8Zdldz084lT2Tnhv8=; b=QiLg2pXcNftTGfKLH48+4YmT9r8+u1c8I
        MmME89QDQh3AbZ1+BOqlOXcSa24U8ICEmdSNMBNACNBpmomSLO00twJkpQaZPOeN
        zKFv+uVxFhfCKy75mSEgPwV1XqQ3xsyV202cCSjhLiUa3WZc3VMg08KaGn3QIQe+
        I+NBUQMRg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=X1z
        Rtoz8v3mMrj4oqK5F8NhetlLm0ffBHHY5Df67HdW78sk74V3qJGnJweerpjMRJyu
        qumRBTbY38UupShjp8pp8dlEhkyZV7KxIX65VvrWOsHfgAuD1GnzMfH+2h/u/5xg
        ke/5hCv4vM3JNIBNZqLJz1KPsXfV6AHL7Zf6sEkE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC7FA8E364;
        Thu, 22 Oct 2020 23:49:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 498EA8E362;
        Thu, 22 Oct 2020 23:49:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] apply: clarify description of --index
Date:   Thu, 22 Oct 2020 20:49:09 -0700
Message-ID: <xmqqzh4dk3ey.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B561C864-14E2-11EB-B2D5-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of explaining the requirement for the paths to be up-to-date,
as if it is an afterthought, state it upfront.

The updated description matches how the checks actually are
performed.  A path that is "dirty" stops the patch application from
being attempted to either working tree files or to the index.

Hopefully this change would help users to form a better mental
model.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Just noticed while reviewing how "apply" (and "am") are explained.

 Documentation/git-apply.txt | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 91d9a8601c..1be7751f58 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -61,13 +61,11 @@ OPTIONS
 	file and detects errors.  Turns off "apply".
 
 --index::
-	Apply the patch to both the index and the working tree (or
-	merely check that it would apply cleanly to both if `--check` is
-	in effect). Note that `--index` expects index entries and
-	working tree copies for relevant paths to be identical (their
-	contents and metadata such as file mode must match), and will
-	raise an error if they are not, even if the patch would apply
-	cleanly to both the index and the working tree in isolation.
+	After making sure the paths the patch touches in the working
+	tree have no modifications relative to their index entries,
+	apply the patch both to the index entries and to the working
+	tree files or see if it applies	cleanly, when `--check` is in
+	effect.
 
 --cached::
 	Apply the patch to just the index, without touching the working
-- 
2.28.0-462-gf84ddd074d

