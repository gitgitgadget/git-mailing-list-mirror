Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01A9C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 17:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E502075A
	for <git@archiver.kernel.org>; Wed, 27 May 2020 17:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXnQpkdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390927AbgE0ReI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 13:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388017AbgE0ReH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 13:34:07 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644B2C03E97D
        for <git@vger.kernel.org>; Wed, 27 May 2020 10:34:07 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u188so257684wmu.1
        for <git@vger.kernel.org>; Wed, 27 May 2020 10:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=GIbcaVTCkdJunaftCAWINArafGwUNBRM+PG6FPDNfCc=;
        b=MXnQpkdAAtP2rAD6/LS8GUVDOettAr2qqQws7TTpRVGuXXRadtGju+f/tXBuispadJ
         6onmrl2ktH457ErVg1KrzTQkQoxgPP2ikXX98lkcBGdeaxsnETAduXhc3nyO4lip1lrj
         Rd8KnfT1dLxtfjARVgZLAZAUIrOJjo6NZVoBV8mVvokQfPK5IomfPTsVs3xhpDZIO/Jv
         ruCrN7LtH0GqYnzWoxIhRAoA9U2FM6bZhtXRV0iN4mh+pnvZvZ2mliv2O2Md68aQK2xE
         NQ8AQnYXUN6Lm67IIREajscKxVAz0+dfwGybvvi7Xs5a6nRtcm9tBwXOXUEX/xiIbY+y
         Ng8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=GIbcaVTCkdJunaftCAWINArafGwUNBRM+PG6FPDNfCc=;
        b=s92SAnhaNDtXH9ltCTbfoymbs8ajxwJEV7F3KBnuyNoF/obqSnE4pBQ+H2vevnjYGU
         2Rqjy0T0KJECuz05iPPFqUup7uGHxJ4wkvUu/HAdpqDO8JfYOb0ax4Rpal1JhLvjcoy/
         uzpvV4hg2BzKyyKC3U6KviiJo5MnNkIwn4DnD6rT+AxArNTOR347kmhg1a0pgKr8CWT+
         5+DrbbX8uj4zUW0a+NvpCHBAcz1qOX6tGCuN1UIJGYq51VTYgj/uryw7QW2fzhcerxIK
         Gl4CgQ7jCCMkWZPv+Tx7lOc91AdqV6ABu8XOMVDV9JLJMg3K9vFoVkUsurUzJk7e7cP7
         GyEg==
X-Gm-Message-State: AOAM533rhFOx+iqdtwXrs6t338RlGmHSGY40STkUWwsPLypml1kV6NGk
        zShZfOoieIeiVcTKiLRwKg4=
X-Google-Smtp-Source: ABdhPJxMzgyxyEvMX9gBCmnPeCIYJyk5FuhM6qDA+Ssm9BzucWo1bYwU/VGdNUlzLBGe+Kzw7C8rYA==
X-Received: by 2002:a1c:2943:: with SMTP id p64mr5132343wmp.42.1590600846119;
        Wed, 27 May 2020 10:34:06 -0700 (PDT)
Received: from localhost.localdomain (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id h196sm3524807wme.22.2020.05.27.10.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 10:34:05 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 0/5] cleanup ra/rebase-i-more-options
Date:   Wed, 27 May 2020 18:33:51 +0100
Message-Id: <20200527173356.47364-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200407141125.30872-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Thanks to Danh for the review, I've updated the tests accordingly.

Phillip Wood (2):
  rebase -i: support --committer-date-is-author-date
  rebase -i: support --ignore-date

Rohit Ashiwal (3):
  rebase -i: add --ignore-whitespace flag
  sequencer: rename amend_author to author_to_free
  rebase: add --reset-author-date

 Documentation/git-rebase.txt           |  33 +++-
 builtin/rebase.c                       |  46 ++++--
 sequencer.c                            | 111 ++++++++++++-
 sequencer.h                            |   2 +
 t/t3422-rebase-incompatible-options.sh |   2 -
 t/t3436-rebase-more-options.sh         | 209 +++++++++++++++++++++++++
 6 files changed, 379 insertions(+), 24 deletions(-)
 create mode 100755 t/t3436-rebase-more-options.sh

Range-diff against v3:
1:  df8c4ed2e9 = 1:  df8c4ed2e9 rebase -i: add --ignore-whitespace flag
2:  df44a0bde6 ! 2:  ad21e5d8fb rebase -i: support --committer-date-is-author-date
    @@ t/t3436-rebase-more-options.sh: test_expect_success '--ignore-whitespace is reme
     +test_expect_success '--committer-date-is-author-date works with apply backend' '
     +	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
     +	git rebase --apply --committer-date-is-author-date HEAD^ &&
    -+	git log -1 --pretty="format:%ai" >authortime &&
    -+	git log -1 --pretty="format:%ci" >committertime &&
    ++	git log -1 --pretty=%ai >authortime &&
    ++	git log -1 --pretty=%ci >committertime &&
     +	test_cmp authortime committertime
     +'
     +
     +test_expect_success '--committer-date-is-author-date works with merge backend' '
     +	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
     +	git rebase -m --committer-date-is-author-date HEAD^ &&
    -+	git log -1 --pretty="format:%ai" >authortime &&
    -+	git log -1 --pretty="format:%ci" >committertime &&
    ++	git log -1 --pretty=%ai >authortime &&
    ++	git log -1 --pretty=%ci >committertime &&
     +	test_cmp authortime committertime
     +'
     +
     +test_expect_success '--committer-date-is-author-date works with rebase -r' '
     +	git checkout side &&
     +	GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
     +	git rebase -r --root --committer-date-is-author-date &&
    -+	git log --pretty="format:%ai" >authortime &&
    -+	git log --pretty="format:%ci" >committertime &&
    ++	git log --pretty=%ai >authortime &&
    ++	git log --pretty=%ci >committertime &&
     +	test_cmp authortime committertime
     +'
     +
     +test_expect_success '--committer-date-is-author-date works when forking merge' '
     +	git checkout side &&
     +	GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
     +	git rebase -r --root --strategy=resolve --committer-date-is-author-date &&
    -+	git log --pretty="format:%ai" >authortime &&
    -+	git log --pretty="format:%ci" >committertime &&
    ++	git log --pretty=%ai >authortime &&
    ++	git log --pretty=%ci >committertime &&
     +	test_cmp authortime committertime
     +
     +'
3:  fa3d4856b4 = 3:  af92e29cf9 sequencer: rename amend_author to author_to_free
4:  96657233d4 ! 4:  4399dc19b6 rebase -i: support --ignore-date
    @@ t/t3436-rebase-more-options.sh: test_expect_success '--committer-date-is-author-
     +test_expect_success '--ignore-date works with apply backend' '
     +	git commit --amend --date="$GIT_AUTHOR_DATE" &&
     +	git rebase --apply --ignore-date HEAD^ &&
    -+	git log -1 --pretty="format:%ai" >authortime &&
    ++	git log -1 --pretty=%ai >authortime &&
     +	grep "+0000" authortime
     +'
     +
     +test_expect_success '--ignore-date works with merge backend' '
     +	git commit --amend --date="$GIT_AUTHOR_DATE" &&
     +	git rebase --ignore-date -m HEAD^ &&
    -+	git log -1 --pretty="format:%ai" >authortime &&
    ++	git log -1 --pretty=%ai >authortime &&
     +	grep "+0000" authortime
     +'
     +
    @@ t/t3436-rebase-more-options.sh: test_expect_success '--committer-date-is-author-
     +	echo resolved >foo &&
     +	git add foo &&
     +	git rebase --continue &&
    -+	git log --pretty=%ai >authortime &&
    ++	git log -1 --pretty=%ai >authortime &&
     +	grep +0000 authortime
     +'
     +
5:  828155baba ! 5:  a11db78eb4 rebase: add --reset-author-date
    @@ t/t3436-rebase-more-options.sh: test_expect_success '--committer-date-is-author-
      	git commit --amend --date="$GIT_AUTHOR_DATE" &&
     -	git rebase --apply --ignore-date HEAD^ &&
     +	git rebase --apply --reset-author-date HEAD^ &&
    - 	git log -1 --pretty="format:%ai" >authortime &&
    + 	git log -1 --pretty=%ai >authortime &&
      	grep "+0000" authortime
      '
      
    @@ t/t3436-rebase-more-options.sh: test_expect_success '--committer-date-is-author-
      	git commit --amend --date="$GIT_AUTHOR_DATE" &&
     -	git rebase --ignore-date -m HEAD^ &&
     +	git rebase --reset-author-date -m HEAD^ &&
    - 	git log -1 --pretty="format:%ai" >authortime &&
    + 	git log -1 --pretty=%ai >authortime &&
      	grep "+0000" authortime
      '
      

-- 
2.25.1.551.gd3318bf0d3.dirty

