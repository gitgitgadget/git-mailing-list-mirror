Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E00DC6377A
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 638F06100C
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhGUXM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 19:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhGUXM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 19:12:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA857C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:53:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t5so3901763wrw.12
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NQoPQb5y0qOZDAhbtEibF+aUQe3H0Bf9dQRwwHUsvas=;
        b=pSxkMNsjZ0aQsvYnAEiVcTNX2F09BZYrGAJkEHoyrR3MWjolDw92VWmNBy3BZR4nnH
         nlLRGQJVW9M1syuY73ocyrX89a6x9Z93hnbAnWNfzuNJB1/vhmRQK4K7cTOKqen48+oa
         pYYmEnncmRL45QgwzQF9A5s3rNwGkRISs6ksSGiv/feYV/WwSRjr46C2r2JdY1+vRGoH
         QCukVPrLx5NV77IITJlkWifSjN45Q1rVWeWkCDBI4/qMtIuJ1T0vzaXWA4juruF1++v6
         npNRbKY5CLl3FYJbGK++KdCkrDBK3UBWW4u/9znpU6f2I2OdRg/KaqtfmS6TMf7V9MGU
         iezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NQoPQb5y0qOZDAhbtEibF+aUQe3H0Bf9dQRwwHUsvas=;
        b=K/403gVjsqz7n0xyvR8q7WlieW6Gd7Zbuqvfsx40NWghe1kEjiWhAy6l70+KSPWOIr
         88Tq23XgIbk9r5TI8WIw6yuxebnjbw8GyzD/7jJhe14nLXbAyKu85vqBwQr8FLz9h5bP
         +Mh5tx9GnnrhQ1yGYF65DK7yNOl1xEKwfU7DwqlWlafOFKukWR9sUtqzoAh23BEfNfSx
         lbK+n47Sbgurj8/XLAKUsnDXu3AH2a9txHjltgLMxPXQYMSlJlnk5oB9fZbcjz3lqecU
         0+zzNIyRQ/WwNG9dAmYBmyxYWlABpQXX6//WRlG03li/FwtUF6vbTCN0U6vbdtkMZ5vn
         6MIg==
X-Gm-Message-State: AOAM533MyPf36x1Zdy60DnmWwVLpkg83SXdkXLgaDvUOtiz0g94Us7dd
        kdb7We8TtZa2aK/hs6lkMMJSn/0ZZ6kMXA==
X-Google-Smtp-Source: ABdhPJwNf8B+0DpXsCBD8Th6KulupPQa+9GLrSVBaivw6Lq4SfQJIxsbXhFL4dlFx28+FXvt23LUKQ==
X-Received: by 2002:a5d:4392:: with SMTP id i18mr44632700wrq.231.1626911612113;
        Wed, 21 Jul 2021 16:53:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y12sm11342674wmc.12.2021.07.21.16.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:53:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] bundle tests: modernize, fix missing coverage & test_cmp
Date:   Thu, 22 Jul 2021 01:53:27 +0200
Message-Id: <cover-0.2-00000000000-20210721T235251Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-0.2-00000000000-20210720T115052Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210720T115052Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A trivial series to improve the bundle tests a bit. This is split off
from some larger changes to "git bundle" I have cooking, where the
"test_cmp" in 2/2 helped assert & catch regressions.

Ævar Arnfjörð Bjarmason (2):
  bundle tests: use ">file" not ": >file"
  bundle tests: use test_cmp instead of grep

 t/t5607-clone-bundle.sh | 72 ++++++++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 16 deletions(-)

Range-diff against v1:
1:  746d727113b ! 1:  2a77f80725d bundle tests: use ">file" not ": >file"
    @@ Metadata
      ## Commit message ##
         bundle tests: use ">file" not ": >file"
     
    -    Change redundant uses of ":" on the LHS of a ">" to the more commonly
    -    use ">file" pattern.
    +    Change uses of ":" on the LHS of a ">" to the more commonly used
    +    ">file" pattern in t/t5607-clone-bundle.sh.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
2:  062f34abf1a ! 2:  d5504fd764c bundle tests: use test_cmp instead of grep
    @@ t/t5607-clone-bundle.sh: test_expect_success 'ridiculously long subject in bound
     -	sed -n "/^-/{p;q;}" long-subject-bundle.bdl >boundary &&
     -	grep "^-$OID_REGEX " boundary
     +
    -+	cat >expect.common <<-EOF &&
    ++	if ! test_have_prereq SHA1
    ++	then
    ++		echo "@object-format=sha256"
    ++	fi >expect &&
    ++	cat >>expect <<-EOF &&
     +	-$(git log --pretty=format:"%H %s" -1 HEAD^)
     +	$(git rev-parse HEAD) HEAD
     +	EOF
    ++
     +	if test_have_prereq SHA1
     +	then
    -+		cp expect.common expect
    -+	else
    -+		echo @object-format=sha256 >expect
    -+		cat expect.common >>expect
    -+	fi &&
    -+	if test_have_prereq SHA1
    -+	then
    -+		head -n 3 long-subject-bundle.bdl >bundle-header
    ++		head -n 3 long-subject-bundle.bdl
     +	else
    -+		head -n 4 long-subject-bundle.bdl >bundle-header
    -+	fi &&
    -+	grep -v "^#" bundle-header >actual &&
    ++		head -n 4 long-subject-bundle.bdl
    ++	fi | grep -v "^#" >actual &&
    ++
     +	test_cmp expect actual
      '
      
-- 
2.32.0.955.ge7c5360f7e7

