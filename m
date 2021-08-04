Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664BCC432BE
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4731C610CC
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbhHDXGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 19:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbhHDXGE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 19:06:04 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F4CC0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 16:05:50 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l4-20020a05600c1d04b02902506f89ad2dso4466038wms.1
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 16:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VVGGn5oBssU4MIxzgZMUifWlh+X6hj+OB/B28m6eop8=;
        b=GP19Jv4vZd6wog6FEajBd5GlSQKYXjw7nX9tVOiPq0iAbCg5Yhz/PWPumyZei7E0Fa
         UvzywycMF8o5NbdR3SwSWiTVopsZTNvBlbkQDhmOW+cEdt0o1zaFGkwZ4J91H48anAPf
         9LjiMIiRjLOdVFF+BB+kXgKC5MQh8kWGaS40uT+DPCOLBY2SFbRYnOt45YmEKcH/I7e8
         L/NIl24W3H6JDWQBdPvPW3kq+Z5TL6qVs+PNTzpukUQrcyPyNgXWleGVX8w59fXM14cq
         OgVgwfSVFbFECyoc/MkkU9D+jPArkIkpzulNz+7C0gb0zCSwB5c4HezJGheIjktnmmEq
         9Y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VVGGn5oBssU4MIxzgZMUifWlh+X6hj+OB/B28m6eop8=;
        b=My8N5931kLR/sZtorGzBkvcn5ykKmz3xzJRVflnmWqpnLwlOySFGaaExp2jVBbZ9Hr
         qxlkBSVdTP240/OkK4U0jRUg4WtynhsoPzucyZ3T+Ydpnvm0TNmC93sIJrnF61YkVP01
         ntqsFI22BNYhDkJqeYC78TfwFqWXNS3nwv8EIGtFPrRjjunRSgp8YU+cA0Pd9ezkwx9j
         8dy7Wbs2Oja+BUtVk79o5l71Bt22adwCIkWBBEOONpH6LL1AaGBW8K9EK1oWuFaxvVJs
         jNuguaz+dOEWX26VT8tipfmsV6cOIzL0OseZZvPdE+XVclROClBDpQt35y9TD34fYuEN
         BmdA==
X-Gm-Message-State: AOAM531PhdvQRzI5RUji+XjAKbilb6lrK/A5ddAgvp2UZcLKalcUzLym
        L0TCtSG7d1TL0Ech7Nzn9X/CtjHXOXVRMQ==
X-Google-Smtp-Source: ABdhPJwwBOGARqfiCowTGw0OLsd2HZcHbeTDT8J+uSMffAWpRGsN+AYo6boDvmBDX4VyqHIX9waMBQ==
X-Received: by 2002:a7b:c452:: with SMTP id l18mr11910555wmi.22.1628118348833;
        Wed, 04 Aug 2021 16:05:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f2sm3994917wrq.69.2021.08.04.16.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 16:05:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Fabian Stelzer <fabian.stelzer@campoint.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/3] test-lib.sh: use GIT_TEST_COLUMNS over COLUMNS
Date:   Thu,  5 Aug 2021 01:05:43 +0200
Message-Id: <cover-v3-0.3-00000000000-20210804T230335Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.597.gc569a812f0a
In-Reply-To: <cover-v2-0.3-00000000000-20210802T134610Z-avarab@gmail.com>
References: <cover-v2-0.3-00000000000-20210802T134610Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This v3 addresses SZEDER's note in <20210802171429.GC23408@szeder.dev>
that we were missing redirection. The "is_git_command_name" check has
also been moved one commit earlier, as it should.

Ævar Arnfjörð Bjarmason (3):
  test-lib-functions.sh: rename test_must_fail_acceptable()
  test-lib-functions.sh: add a test_with_columns function
  test-lib.sh: use GIT_TEST_COLUMNS over COLUMNS

 pager.c                       |  7 +++++++
 t/t3200-branch.sh             |  8 ++++----
 t/t4052-stat-output.sh        | 22 +++++++++++-----------
 t/t4205-log-pretty-formats.sh |  6 +++---
 t/t7004-tag.sh                |  6 +++---
 t/t7006-pager.sh              |  2 +-
 t/t7508-status.sh             |  4 ++--
 t/t9002-column.sh             | 23 ++++++++++-------------
 t/test-lib-functions.sh       | 21 ++++++++++++++++++---
 t/test-lib.sh                 | 13 +++++++++++--
 10 files changed, 70 insertions(+), 42 deletions(-)

Range-diff against v2:
1:  739457b992f = 1:  f45590a76d5 test-lib-functions.sh: rename test_must_fail_acceptable()
2:  36c57178c55 ! 2:  53e6e25ece6 test-lib-functions.sh: add a test_with_columns function
    @@ t/test-lib-functions.sh: test_region () {
     +	local columns=$1
     +	shift
     +
    -+	COLUMNS=$columns "$@"
    -+}
    ++	if ! is_git_command_name "$@"
    ++	then
    ++		echo >&7 "test_with_columns: only 'git' is allowed: $*"
    ++		return 1
    ++	fi
    ++
    ++	COLUMNS=$columns "$@" 2>&7
    ++} 7>&2 2>&4
3:  6cbbb955e9a ! 3:  74acba0f9ca test-lib.sh: use GIT_TEST_COLUMNS over COLUMNS
    @@ pager.c: int term_columns(void)
     
      ## t/test-lib-functions.sh ##
     @@ t/test-lib-functions.sh: test_with_columns () {
    - 	local columns=$1
    - 	shift
    + 		return 1
    + 	fi
      
    -+	if ! is_git_command_name "$@"
    -+	then
    -+		echo >&7 "test_with_columns: only 'git' is allowed: $*"
    -+		return 1
    -+	fi
    -+
     +	GIT_TEST_COLUMNS= \
    - 	COLUMNS=$columns "$@"
    - }
    + 	COLUMNS=$columns "$@" 2>&7
    + } 7>&2 2>&4
     
      ## t/test-lib.sh ##
     @@ t/test-lib.sh: LANG=C
-- 
2.33.0.rc0.597.gc569a812f0a

