Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF22C2B9F7
	for <git@archiver.kernel.org>; Wed, 26 May 2021 11:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27974613C5
	for <git@archiver.kernel.org>; Wed, 26 May 2021 11:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhEZLXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 07:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbhEZLXC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 07:23:02 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF81C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 04:21:13 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j14so718310wrq.5
        for <git@vger.kernel.org>; Wed, 26 May 2021 04:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uC4B70S6bhjCjWnlSFQ2lfcZ8/QyoRubcCz4GghGGbg=;
        b=Jof0U3u+s3/nddAoPqfZsIviYXGRvKsM+GfGinqqqyT76fwSz1zkmGrHSoSs6OyDX8
         2ud0BoV61gtWRHZN7QBU5uI/9ZuupY/o5+FFg4gLpl0Mp15DadXOOUYDXFtXvdTbpaoQ
         M17auvM89Bqip2Id7/PQytXn1LjOf2DLinJOhf0kjvDu2oPB/1EqRcWsLbSmYzZbzP6f
         YI9R0PUAiRxF+hxPt7X0t+EBAg3DQXHsQNBFB4uLNkL31C62YtiVY5UqilHCKCgSVgNc
         YDxW6MZzGWwH+z3QZIVU8NngsqM4m99P7zOBxs+EQTMD4q3Ohv5xj39iHkfRWA8deoKr
         J7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uC4B70S6bhjCjWnlSFQ2lfcZ8/QyoRubcCz4GghGGbg=;
        b=ZzDH1/R1VLfXE8rh/cmPFn932Buiao4/YrKyy1+BFpdQ+mmjpgEvP+VRqoxL3tybws
         cAMdVV2kE5MsRFC2x8Hv1tr+m+nTxmVz0w2c+gNvJuDsZUXUaMJNW+TOl4CurB96Wjtd
         gZgBsKU3SyYCha+UhPMYePMrh3WEwq92qZxj0Rb43PxqSnUYzzQEhJbK5tFapvh+in1Z
         5/UcuqvF86t5d19oYa1rdTJ/6IpuT8n/N7CV8x5Ya24CVzkzqiPomQd+zYpMxA/9V54y
         ntTgSo2BQY1XutqkcS5BJtrVPpCpUvKZ2ucH3u2reT+shGUV+4AjxVcI3NFJyOQkFuyW
         SHXA==
X-Gm-Message-State: AOAM531QCQPjFRSvDuR4qTUIlyYLgkFpUHxVLzP2QpTU0zR+JkWl3hYj
        FyThZ5torpa4FAh6pfxzV5jfm5p6FZYF5A==
X-Google-Smtp-Source: ABdhPJzCXrUkDJxAS8bN0ESvlOERHbMMMANpHNywn4MNLxGXOIOVdX1a1Ks1JOpwIjfoJ/v6mCqyRw==
X-Received: by 2002:adf:ed47:: with SMTP id u7mr32473145wro.254.1622028072008;
        Wed, 26 May 2021 04:21:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v15sm6163144wmj.39.2021.05.26.04.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 04:21:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Robert Foss <robert.foss@linaro.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] send-email: don't needlessly abs_path() the core.hooksPath
Date:   Wed, 26 May 2021 13:21:05 +0200
Message-Id: <cover-0.2-00000000000-20210526T111558Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.400.g0a5a93401d3
In-Reply-To: <xmqq5yz6ehpk.fsf@gitster.g>
References: <xmqq5yz6ehpk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 26 2021, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> But I'll leave it to you, if you are convinced and do want to take this
>> 2/2 after all I'll submit another trivial patch on top to remove the new
>> (then unused) repo_path function, which we expect to go away anyway.
>
> Sounds good.

Here that is, now on top of the new "master" which has the
t9001-send-email.sh changes you'd already merged down.

Ævar Arnfjörð Bjarmason (2):
  send-email: don't needlessly abs_path() the core.hooksPath
  send-email: move "hooks_path" invocation to git-send-email.perl

 git-send-email.perl   |  3 ++-
 perl/Git.pm           | 13 -------------
 t/t9001-send-email.sh |  7 ++++---
 3 files changed, 6 insertions(+), 17 deletions(-)

Range-diff against v1:
1:  df3a2b8562d < -:  ----------- send-email: fix missing error message regression
2:  d097e7b0b81 ! 1:  ff01d4619ea send-email: don't needlessly abs_path() the core.hooksPath
    @@ Commit message
         2021-04-06) when we started emitting the path to the hook, which was
         previously only internal to git-send-email.perl.
     
    -    I think this change should let us have our cake and eat it too. We now
    -    emit a relative path for the common case where the hook is in the
    -    .git/hooks directory, but in the case it's an absolute path (there's
    -    another test for that, not seen here) we'll prefix it with $(pwd).
    +    The just-landed 53753a37d09 (t9001-send-email.sh: fix expected
    +    absolute paths on Windows, 2021-05-24) narrowly fixed this issue, but
    +    I believe we can do better here. We should not be relying on whatever
    +    changes Perl's abs_path() makes to the path "rev-parse --git-path
    +    hooks" hands to us. Let's instead trust it, and hand it to Perl's
    +    system() in git-send-email.perl. It will handle either a relative or
    +    absolute path.
     
    -    I hope that unlike the current implementation that $(pwd) v.s. $PWD
    -    difference won't matter on Windows, since now the absolute path is the
    -    one we get from rev-parse, not the one that's been passed through
    -    Perl's Cwd::abs_path().
    +    So let's revert most of 53753a37d09 and just have "hooks_path" return
    +    what we get from "rev-parse" directly without modification. This has
    +    the added benefit of making the error message friendlier in the common
    +    case, we'll no longer print an absolute path for repository-local hook
    +    errors.
     
         1. http://lore.kernel.org/git/bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org
     
    @@ t/t9001-send-email.sh: test_expect_success $PREREQ "--validate respects relative
      	test_path_is_file my-hooks.ran &&
      	cat >expect <<-EOF &&
      	fatal: longline.patch: rejected by sendemail-validate hook
    --	fatal: command '"'"'$(pwd)/my-hooks/sendemail-validate'"'"' died with exit code 1
    +-	fatal: command '"'"'$PWD/my-hooks/sendemail-validate'"'"' died with exit code 1
     +	fatal: command '"'"'my-hooks/sendemail-validate'"'"' died with exit code 1
      	warning: no patches were sent
      	EOF
      	test_cmp expect actual
    + '
    + 
    + test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
    +-	test_config core.hooksPath "$(pwd)/my-hooks" &&
    ++	hooks_path="$(pwd)/my-hooks" &&
    ++	test_config core.hooksPath "$hooks_path" &&
    + 	test_when_finished "rm my-hooks.ran" &&
    + 	test_must_fail git send-email \
    + 		--from="Example <nobody@example.com>" \
    +@@ t/t9001-send-email.sh: test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
    + 	test_path_is_file my-hooks.ran &&
    + 	cat >expect <<-EOF &&
    + 	fatal: longline.patch: rejected by sendemail-validate hook
    +-	fatal: command '"'"'$PWD/my-hooks/sendemail-validate'"'"' died with exit code 1
    ++	fatal: command '"'"'$hooks_path/sendemail-validate'"'"' died with exit code 1
    + 	warning: no patches were sent
    + 	EOF
    + 	test_cmp expect actual
-:  ----------- > 2:  cda41c36772 send-email: move "hooks_path" invocation to git-send-email.perl
-- 
2.32.0.rc1.400.g0a5a93401d3

