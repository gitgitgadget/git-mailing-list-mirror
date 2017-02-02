Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 386A620A78
	for <e@80x24.org>; Thu,  2 Feb 2017 03:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750878AbdBBDzc (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 22:55:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63083 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750828AbdBBDzc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 22:55:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6595D66123;
        Wed,  1 Feb 2017 22:55:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=4
        zOekNJ7x8/62QNDZDm4/vivgjE=; b=MYcJq6PV9kcRlUSgBuR2zO+tV/HMVvYgt
        DbPDOM6600CYaiJtwVLULLA8WPwJe6eY65H8KEha0xYlJ3woMiWOl47/I2uHNCrz
        dOQZiIMA9a1/GHDIeduan7RQkgV14UPYmRFby4f0yxr4xjDSkklEB1QWV77GNWoy
        q5HYckXc+I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5EC9866122;
        Wed,  1 Feb 2017 22:55:30 -0500 (EST)
Received: from localhost (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DE12F66121;
        Wed,  1 Feb 2017 22:55:29 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: init --separate-git-dir does not set core.worktree
Date:   Wed, 01 Feb 2017 22:55:25 -0500
Message-ID: <87h94d8cwi.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7042AFD0-E8FB-11E6-88E1-FE3F13518317-24757444!pb-smtp1.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:mime-version:content-type; s=mesmtp;
 bh=4zOekNJ7x8/62QNDZDm4/vivgjE=;
 b=jNptsIJwPsgdVzuOekXFd2HYdY3wcQmDbAvFx7N2lVoBy1waVPe4qGXsOGdPtVvnNj/0ZdcZ825jbtvx5abfnXvXc4/wRhQ8WUueY6SO68n27RUA6hRPZzXgfQ/6GlwCJ8OtAzMTnwHTdbSywr5CUQcTlba8Lk9oaE58L2VNvlc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

As of 6311cfaf9 (init: do not set unnecessary core.worktree,
2016-09-25), "git init --separate-git-dir" no longer sets core.worktree
(test below).  Based on the commit message and the corresponding thread
[1], I don't think this change in behavior was intentional, but I wasn't
able to understand things well enough to attempt a patch.

Thanks.

[1] https://public-inbox.org/git/CALqjkKZO_y0DNcRJjooyZ7Eso7yBMGhvZ6fE92oO4Su7JeCeng@mail.gmail.com/T/#u

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index b8fc588b1..444e75865 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -309,6 +309,7 @@ test_expect_success 'init with separate gitdir' '
 	git init --separate-git-dir realgitdir newdir &&
 	echo "gitdir: $(pwd)/realgitdir" >expected &&
 	test_cmp expected newdir/.git &&
+	check_config realgitdir false "$(pwd)/newdir" &&
 	test_path_is_dir realgitdir/refs
 '
 
