Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B7EEE49A3
	for <git@archiver.kernel.org>; Sat, 19 Aug 2023 00:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243070AbjHRX7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Aug 2023 19:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243139AbjHRX7r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2023 19:59:47 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AF72D65
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 16:59:46 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 018282002A;
        Fri, 18 Aug 2023 19:59:46 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=wk5IOMhHdk3rj/rcsPwntHaOQ
        Vw9km6+CyrejWNCzd8=; b=PSjuARCinoxnpsaBGJS8vjLdUCI9KsBrlqIy4yuOH
        fCfI/gA1ohHc78Bg0JlMRkWjzvbzx0WspuVrcnCKuNZTvEjT8CZPt5VrPROfignH
        Vf8UjB2bQTbjC9FtiG8kDEljlRjx340oh7UqfcDVOr5T6zoi+AJ7t/hTYwPqBksw
        QQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EEA1C20029;
        Fri, 18 Aug 2023 19:59:45 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AAFFD20028;
        Fri, 18 Aug 2023 19:59:42 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 4/5] t4040: remove test that succeeded for a wrong reason
Date:   Fri, 18 Aug 2023 16:59:31 -0700
Message-ID: <20230818235932.3253552-5-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-rc2-7-gf9972720e9
In-Reply-To: <20230818235932.3253552-1-gitster@pobox.com>
References: <20230817222949.3835424-1-gitster@pobox.com>
 <20230818235932.3253552-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 4CBACA32-3E23-11EE-9022-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"diff-tree -b --exit-code" without "--patch" exits with 0 status,
not because it finds that the two input files are equivalent while
ignoring whitespaces, but because the implied "--raw" mode always
exits with 0 when whitespace tweaking options like "-b" and "-w"
are given, which is a long-standing bug.

We are about to fix it so that "--raw" and friends report the
differences with the exit status (even though they ignore the
whitespace tweaking options when producing their output), which
will make this test, which succeeded for a wrong reason, start
failing.  Remove it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4040-whitespace-status.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t4040-whitespace-status.sh b/t/t4040-whitespace-status.sh
index e70e020ae9..eec3d73dc2 100755
--- a/t/t4040-whitespace-status.sh
+++ b/t/t4040-whitespace-status.sh
@@ -28,8 +28,7 @@ test_expect_success 'diff-tree --exit-code' '
=20
 test_expect_success 'diff-tree -b --exit-code' '
 	git diff -b --exit-code HEAD^ HEAD &&
-	git diff-tree -b -p --exit-code HEAD^ HEAD &&
-	git diff-tree -b --exit-code HEAD^ HEAD
+	git diff-tree -b -p --exit-code HEAD^ HEAD
 '
=20
 test_expect_success 'diff-index --cached --exit-code' '
--=20
2.42.0-rc2-7-gf9972720e9

