Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A08CC1F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 21:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755823AbdKMVUL (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 16:20:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62202 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755570AbdKMVUK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 16:20:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 418DEA659D;
        Mon, 13 Nov 2017 16:20:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=hXLeNNemlpZxaUqDC6ofj7+FNDI
        =; b=X3JxNpKXkKV9w3ny5XDDfcV4nq9OKRiblNoObqoCu6uUYQ7HlEr8vIfY2me
        WyRzk+fIpINlfGLjS6mzKZhbSsRp+xQAypRdx73rHnoJcVHRBxHYV4Z2cGpSweb6
        ItXcTFh0jZuwqsZjq8bx8+sdWZZeymISJMBzlTi+BWw0wrRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id; q=dns; s=sasl; b=xCRutNJKTYkB2bzy6tY3r
        ESYLNFY3cuToap0UoQlR8mfAuByLMHBYxzZpwKRcrvOIauSrPsTb5K8ao/QidJoX
        N/iXRCHGDhnm3324M9XtU6FMgSvRAy1a7ztbO6tjPNTWnZQICWCr2OpZJhvZsKe0
        0r8FQnKO+I9TE7ey7vuSWQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A73BA659C;
        Mon, 13 Nov 2017 16:20:10 -0500 (EST)
Received: from morphine.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C2B84A659B;
        Mon, 13 Nov 2017 16:20:09 -0500 (EST)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] rebase: fix stderr redirect in apply_autostash()
Date:   Mon, 13 Nov 2017 16:20:09 -0500
Message-Id: <20171113212009.26835-1-tmz@pobox.com>
X-Mailer: git-send-email 2.15.0
X-Pobox-Relay-ID: 6DB8E8C2-C8B8-11E7-8F78-575F0C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The intention is to ignore all output from the 'git stash apply' call.
Adjust the order of the redirection to ensure that both stdout and
stderr are redirected to /dev/null.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 git-rebase.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 6344e8d5e3..aabbf6b69e 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -166,7 +166,7 @@ apply_autostash () {
 	if test -f "$state_dir/autostash"
 	then
 		stash_sha1=$(cat "$state_dir/autostash")
-		if git stash apply $stash_sha1 2>&1 >/dev/null
+		if git stash apply $stash_sha1 >/dev/null 2>&1
 		then
 			echo "$(gettext 'Applied autostash.')" >&2
 		else
-- 
2.15.0

