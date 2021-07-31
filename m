Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB046C4338F
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 06:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E2A60EE6
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 06:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhGaGXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 02:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhGaGXd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 02:23:33 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFA3C06175F
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 23:23:26 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so5063753wms.2
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 23:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=ifCBlaxBC4cdpVEDuQc1Kn6QJrgjcVTrsuISNeMEdq4=;
        b=m7Ed2xCBqz/HO6bpegxn3OI6CGj0LHm+BmCKKBX7jfcr1iNzVQ/39xBltcWhBGbWuQ
         395Lr4GizD+09RaxKLbo6sEb/OQ+cCv8XJL5Lj173t/K6Vi1HCuSfx6zmyDkkQkaN8RA
         4taY8hKthzmoPhu/uu96J6amrnDUSatYx/Hz7FXjOQ9M8Qjq60olh+KSIWG0v9ZK4qyO
         Pzt194UpYtXY62UuLjwnTU9NTbi2bo3jTfDaeiI+lU/50ds5iTrnspxQM0VPBqeBZjIr
         FqXdHe0O7tM1jYGGnJG9Qp6G4EFjL85vIMkpQIjQwz8B1tMEd40jwTauelNSreaBc9JI
         WKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=ifCBlaxBC4cdpVEDuQc1Kn6QJrgjcVTrsuISNeMEdq4=;
        b=IPs3sGmmjkW4JPex4OyFZk9KuEe1qHxbRf1qCF4+mXDPKRoGUbZHOch/L7YuOLgbwx
         BymOYaqueH4RTydEMQ2f+xYVJPIwjGP8cyvZK3ztk6urShHnTvaikpu4+vu30P0EEyuZ
         SeaDMhA8dgFlRJqm+fg6BQrzdO0uqHAnfxDRd6yxeuezIfY26UYmqA0FvzK2Zzkb9YKz
         UIrbClW4U4wfkFARt4uEnsL4IwSdXC++6S5w6ExTYWYgV6LYLP81DV45b0Ffxx1Qv6sw
         JyJRHNF2C+dDyGXU2PSnSVIy6zLi8K/LL3Rsvo12HI2oK4tK7JDDL/Ois6l4atOmhDPL
         pwSA==
X-Gm-Message-State: AOAM531AP28YGvVkVLFDsLJ76Grf++FqJqYwNzco3/ReP6O7Ai0ffoX9
        fou/duz8kVQnlrUl0iiaGvQ2JOAbtVE=
X-Google-Smtp-Source: ABdhPJw00XLE0k1E9cTII3MOLwO+lxA4RLQFtDxaGJTm+WPfhB4+XiYRwuPEzOgF4i0IikkZr+76eA==
X-Received: by 2002:a05:600c:1c13:: with SMTP id j19mr4785356wms.164.1627712604829;
        Fri, 30 Jul 2021 23:23:24 -0700 (PDT)
Received: from szeder.dev (78-131-14-245.pool.digikabel.hu. [78.131.14.245])
        by smtp.gmail.com with ESMTPSA id y192sm4126228wmy.1.2021.07.30.23.23.24
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 23:23:24 -0700 (PDT)
Date:   Sat, 31 Jul 2021 08:23:22 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Subject: [BUG] 'git rebase -i ---rebase-merges' can leave MERGE_MSG behind
Message-ID: <20210731062322.GB23408@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

'git rebase -i --rebase-merges' leaves a stray '.git/MERGE_MSG' file
behind after it re-created an unchanged merge commit.  The test script
below demonstrates this issue (it doesn't fail, but look at its
verbose output to see what the issue and its consequences are).

This issue is as old as --rebase-merges, I see the same output with
v2.18.0, the first release containing this feature.

I suspect that fixing this is merely a matter of adding a missing
unlink(".git/MERGE_MSG") to the right place, but I won't dive into the
sequencer machinery to figure out where that right place might be :)


  ---  >8  ---

#!/bin/sh

test_description='test'

. ./test-lib.sh
. "$TEST_DIRECTORY"/lib-rebase.sh

test_expect_success '--rebase-merges leaves MERGE_MSG behind' '
	# A-B-M-D-E-F
	#  \ /
	#   C
	test_commit A &&
	test_commit B &&
	git checkout -b branch HEAD^ &&
	test_commit C &&
	git checkout master &&
	git merge --log branch &&
	test_commit D &&
	test_commit E &&
	test_commit F &&

	# Rewrite a commit after the merge:
	write_script todo-editor <<-\EOF &&
	sed -i -e "/^pick .* E$/ s/^pick/edit/" "$1"
	EOF

	# No MERGE_MSG present before starting the rebase, good:
	test_path_is_missing .git/MERGE_MSG &&

	# Start rebasing before the merge, so the sequencer has to
	# re-create an identical merge commit.
	GIT_EDITOR=./todo-editor git rebase -i --rebase-merges A &&

	# Just to make sure that the history so far is unchanged:
	test_cmp_rev E HEAD &&

	# BUG: now there is a stray MERGE_MSG file:
	cat .git/MERGE_MSG &&

	# And it interferes with the next "git commit", because its
	# content is included in the commit message template:
	echo foo >>E.t &&
	GIT_EDITOR=cat git commit -a
'

test_done
