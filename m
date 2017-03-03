Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 639C920133
	for <e@80x24.org>; Fri,  3 Mar 2017 20:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbdCCUsc (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 15:48:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61380 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752027AbdCCUs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 15:48:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CACB65A4B;
        Fri,  3 Mar 2017 15:43:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nn+m6XS/tYHN7U2voVR5Ju6Aaso=; b=Oor0vF
        hA+qhVUpdJ70KcwRKl8e9T+e5fDHmUDSJqhWR8kVDmHlJHqmzNvWIqP3DkKJcoar
        T2DWHuO6zjOK+LFbtMYYOI6d3XRjr3WbkRk+Fmyo/Gc1Kef7J2JykSx/Tkcb0oKq
        1R8F8nvK2phDEJUExNrObtyOQLPDN7q7adPTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TNBPCaAXuQQE9zNlAOOcJH9dkOgmCZmz
        ECRg5GB4EsfZOLVfT413d/YaLkWNCsTKU5lOAkDV9u/dbTvI4yKjHXZd7StMDMH2
        t9O3tuKogD4ul8K6IRw75Q6jIHummytc3nvOgE5qL5i7+fWwOvJ6h9cPM9fF9B5t
        3S07VtJoSYg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6552C65A49;
        Fri,  3 Mar 2017 15:43:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D10E065A48;
        Fri,  3 Mar 2017 15:43:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Devin J. Pohly" <djpohly@gmail.com>, Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] filter-branch: fix --prune-empty on parentless commits
References: <20170223082736.31283-1-djpohly@gmail.com>
        <20170223082736.31283-3-djpohly@gmail.com>
        <xmqqbmts7gjm.fsf@gitster.mtv.corp.google.com>
        <20170223213333.GA3490@prospect.localdomain>
        <xmqqshmvbhe5.fsf@gitster.mtv.corp.google.com>
        <20170303075535.rxij4knd7d4ayfev@sigill.intra.peff.net>
Date:   Fri, 03 Mar 2017 12:43:13 -0800
In-Reply-To: <20170303075535.rxij4knd7d4ayfev@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 3 Mar 2017 02:55:35 -0500")
Message-ID: <xmqq8tom8526.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0627B406-0052-11E7-824F-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The change to filter-branch itself looks obviously correct. The only
> objectionable thing I noticed in the test additions is that the early
> ones should be marked test_expect_failure until the fix from 3/4 flips
> them to "success". Otherwise it breaks bisectability.

I'll squash in the necessary changes to flip between expect_success
and expect_failure in the appropriate places and re-queue on 'pu'.

Thanks.


commit 07cac4a5fdfeeb3c1c8385e222100d575a4460b0
Author: Junio C Hamano <gitster@pobox.com>
Date:   Fri Mar 3 11:41:36 2017 -0800

    fixup! t7003: ensure --prune-empty can prune root commit

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 2dfe462501..45372a1cba 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -362,7 +362,7 @@ test_expect_success 'prune empty works even without index/tree filters' '
 	test_cmp expect actual
 '
 
-test_expect_success '--prune-empty is able to prune root commit' '
+test_expect_failure '--prune-empty is able to prune root commit' '
 	git rev-list branch-no-a >expect &&
 	git branch testing H &&
 	git filter-branch -f --prune-empty --index-filter "git update-index --remove A.t" testing &&


commit 562ed048c681686426ca95e0e550378b48aa4852
Author: Junio C Hamano <gitster@pobox.com>
Date:   Fri Mar 3 12:11:25 2017 -0800

    fixup! t7003: ensure --prune-empty removes entire branch when applicable

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index a774a8e4b3..40526d1716 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -371,7 +371,7 @@ test_expect_failure '--prune-empty is able to prune root commit' '
 	test_cmp expect actual
 '
 
-test_expect_success '--prune-empty is able to prune entire branch' '
+test_expect_failure '--prune-empty is able to prune entire branch' '
 	git branch prune-entire B &&
 	git filter-branch -f --prune-empty --index-filter "git update-index --remove A.t B.t" prune-entire &&
 	test_path_is_missing .git/refs/heads/prune-entire &&


commit 520534c4035a13c54229dab0320e745d18635ef3
Author: Junio C Hamano <gitster@pobox.com>
Date:   Fri Mar 3 12:39:58 2017 -0800

    fixup! filter-branch: fix --prune-empty on parentless commits

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 40526d1716..7cb60799be 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -362,7 +362,7 @@ test_expect_success 'prune empty works even without index/tree filters' '
 	test_cmp expect actual
 '
 
-test_expect_failure '--prune-empty is able to prune root commit' '
+test_expect_success '--prune-empty is able to prune root commit' '
 	git rev-list branch-no-a >expect &&
 	git branch testing H &&
 	git filter-branch -f --prune-empty --index-filter "git update-index --remove A.t" testing &&
@@ -371,7 +371,7 @@ test_expect_failure '--prune-empty is able to prune root commit' '
 	test_cmp expect actual
 '
 
-test_expect_failure '--prune-empty is able to prune entire branch' '
+test_expect_success '--prune-empty is able to prune entire branch' '
 	git branch prune-entire B &&
 	git filter-branch -f --prune-empty --index-filter "git update-index --remove A.t B.t" prune-entire &&
 	test_path_is_missing .git/refs/heads/prune-entire &&
