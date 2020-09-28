Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60BEC4727C
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 23:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B51207D8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 23:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vE5SLJAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgI1Xnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgI1Xnn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 19:43:43 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1415FC0613E9
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 15:26:42 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id b18so1680103qto.4
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 15:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=eh11ckVZEpACLzZO8ykHDadXDOv44M2IJV3yQBrYqK4=;
        b=vE5SLJAAujlUvTtdJWNiz8QSot2sqcnH/NM7TtfTGng6hfx1/Hrv3NPQ245rfRmgEI
         Wli4wJZiASFGuhEYU6jOWAlMM/Bs939PUTVIAeYVQzuUVRP49bRFCpemhmBCxzMUCHgH
         h7NeS9RY8A6GWKw9soFp4sJIryCeyf5poj3eQQNZrKIc2SRb+zMA0KwEOxq8FRnZzYNp
         ZIytpBxelcLGr338gjg0kw3gAeQLOfi8bY9/FaRQ27HGPZAEGWwoidjmzjpUnbMhkziB
         pXgYpF6jKxsJ1GPe+GTS0b/dh0vCXaZkV1Q01HxR/G+hgAup/dnvk6drwJgvAOkqGQsB
         5PXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eh11ckVZEpACLzZO8ykHDadXDOv44M2IJV3yQBrYqK4=;
        b=Z+ugrBmY/8ZM2h+UMxVocj0C0D8H2EtHM4nZGy6yTg5TThIAEjePsijbXWdQeMW13M
         ENuW5GX2T+SH6wexFgEx74fF+oqiZD127wq368i0hTU/RAtL1/1Yx7Kxxpk945bE/yQV
         CUJf0JX00F98EX4ICT04YUTuArE41hZ8FWp3HPptiByrFNegoq0XVeotki6gjmDA9vqt
         W2KEwc5dBPGUnEiNX1dluekH427s4i6gmZBczuCGp6Vjg3ElnIUUgPw3z0ubx299CT4W
         eSDgk8Mf3RsAeVLyJWK9+S3JFv5QQPW+AhwFR4OpIoL5leE0XTMxhBMRdylxcz6c/i/8
         sbhA==
X-Gm-Message-State: AOAM532nj1dMngasKEefgdjn48EQfSBpx+1HJkedDL15qfW5u0M7vJa2
        MUB2OpWEiS6vVe9OhUANAMVeLiwrmTBMwgHsOw/gd5mnVZip4iFXHZ08SJCnCpX48F+Yd9Atg9z
        brTi0TLn3bpJS2p9lGORK+zbNW+6N0pctImNxxNF8/QxjMURp1eHKnBR9tGsXClU+0dKUNuqrl6
        gW
X-Google-Smtp-Source: ABdhPJzym9T1gmS07Pq/Ol49FxBYdpgXVX6rPKzJeIlPmAEGgC+z9synKM4ByWwRBZ6+fyRdm+VFcZ4MUSJLr73pUrOt
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:f30f:: with SMTP id
 j15mr1659930qvl.51.1601332000900; Mon, 28 Sep 2020 15:26:40 -0700 (PDT)
Date:   Mon, 28 Sep 2020 15:26:36 -0700
In-Reply-To: <cover.1600743698.git.jonathantanmy@google.com>
Message-Id: <cover.1601331788.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1600743698.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v2 0/2] Fix overriding of partial clone filter when lazy-fetching
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks everyone for your comments. Patch 1 is exactly the same, and in
patch 2, I've changed the config check to use test_cmp_config with
"--get-all", as requested.

Comment noted about saying "this" without informing the reader what
it's referring to - in this case, it was about the issue in patch 2.

Jonathan Tan (2):
  promisor-remote: remove unused variable
  fetch: do not override partial clone filter

 builtin/fetch.c               |  2 +-
 list-objects-filter-options.c | 10 +++++++++-
 promisor-remote.c             |  5 -----
 promisor-remote.h             |  2 +-
 t/t5601-clone.sh              |  3 ++-
 5 files changed, 13 insertions(+), 9 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  625e7f148e promisor-remote: remove unused variable
1:  af960f33b6 ! 2:  c3ced59875 fetch: do not override partial clone filter
    @@ list-objects-filter-options.c: void partial_clone_register(
      
     
      ## t/t5601-clone.sh ##
    -@@ t/t5601-clone.sh: test_expect_success 'partial clone with -o' '
    - 	git clone -o blah --filter=blob:limit=0 "file://$(pwd)/server" client
    +@@ t/t5601-clone.sh: test_expect_success 'partial clone' '
    + 
    + test_expect_success 'partial clone with -o' '
    + 	partial_clone_server server &&
    +-	git clone -o blah --filter=blob:limit=0 "file://$(pwd)/server" client
    ++	git clone -o blah --filter=blob:limit=0 "file://$(pwd)/server" client &&
    ++	test_cmp_config -C client "blob:limit=0" --get-all remote.blah.partialclonefilter
      '
      
    -+test_expect_success 'ensure that filter is written to config' '
    -+	FILTER=$(git -C client config --get remote.blah.partialclonefilter) &&
    -+	test "$FILTER" = "blob:limit=0"
    -+'
    -+
      test_expect_success 'partial clone: warn if server does not support object filtering' '
    - 	rm -rf server client &&
    - 	test_create_repo server &&
-- 
2.28.0.709.gb0816b6eb0-goog

