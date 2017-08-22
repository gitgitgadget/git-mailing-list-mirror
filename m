Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3F941F667
	for <e@80x24.org>; Tue, 22 Aug 2017 21:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbdHVVq6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 17:46:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60149 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752742AbdHVVq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 17:46:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54E4D90120;
        Tue, 22 Aug 2017 17:46:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=eugZ
        n9B3xdz46MOr9F2unTVnvhg=; b=rxp9/EleFBpQU35PRNOSaiughr+xQdToxls1
        k6BlJrw+bg94/jMxXLdurLN6UvhCMD9cMelXjGmKHnrwO8lHtynNTrSWFYoN2HsH
        8KWJUtXKIrgYC9IbOEjWBZJ04Q8JErhqqedSY/BA+ZGuGCAI8wAtt4qEK6SgNXr3
        p370TB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=e9Njmd
        xM49FGCH2Xk+HaRrmgSNCJUSSVkLlfKwOljGtC5muKrgygrDrMIRHdSAqMLa1Wix
        zfRvatpU8NRsWMu2Tn6Rm4QUjTjfkFUPiZhULyq4UeplUo8rKO3XhYf59HYDLBDs
        axOciLyu5URpkt1JhSCNtJGoMVQZOsCMvswaA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E1D39011E;
        Tue, 22 Aug 2017 17:46:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB72190119;
        Tue, 22 Aug 2017 17:46:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 1/6] t4200: give us a clean slate after "rerere gc" tests
Date:   Tue, 22 Aug 2017 14:46:47 -0700
Message-Id: <20170822214652.31626-2-gitster@pobox.com>
X-Mailer: git-send-email 2.14.1-427-g5711bb0564
In-Reply-To: <20170822214652.31626-1-gitster@pobox.com>
References: <20170819203013.3053-1-gitster@pobox.com>
 <20170822214652.31626-1-gitster@pobox.com>
X-Pobox-Relay-ID: 6A9C15D6-8783-11E7-B572-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "multiple identical conflicts" test counts the number of entries
in the rerere database after trying a handful of mergy operations
and recording their resolutions, but without initializing the rerere
database to a known state, allowing the state left by previous tests
to trigger a false failure.  Make it robust by cleaning the database
before it starts.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4200-rerere.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 1a080e7823..8f5f268baf 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -446,6 +446,8 @@ merge_conflict_resolve () {
 }
 
 test_expect_success 'multiple identical conflicts' '
+	rm -fr .git/rr-cache &&
+	mkdir .git/rr-cache &&
 	git reset --hard &&
 
 	test_seq 1 6 >early &&
-- 
2.14.1-427-g5711bb0564

