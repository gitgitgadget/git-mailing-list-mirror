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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC4AC2B9F8
	for <git@archiver.kernel.org>; Mon, 24 May 2021 23:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB616140B
	for <git@archiver.kernel.org>; Mon, 24 May 2021 23:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhEXXQF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 19:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhEXXQE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 19:16:04 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A209C06138A
        for <git@vger.kernel.org>; Mon, 24 May 2021 16:14:34 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id b7so15082291wmh.5
        for <git@vger.kernel.org>; Mon, 24 May 2021 16:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kVXzwJG4Z6VIDWjTgt8AYwn+gFSIBYCUGr/xkh20JBc=;
        b=IbPPqgTPoDx0+FZLUo80JgS2LMyc3WXUsaieDfkZehVWCbO/ySZbW8oM6x57EqtVNR
         vgg6qjHen5d8PO8Dk09ulb9HeJkHhSlVQRGncErHT607zpIuEtYG614qN892U8f3SLLP
         FMQhlC3T4FLCtnrXsEY4Feuov6cT62MbJaSKH1hDa0sHbqK/EcnRm7vk0PQy6VwjIMPu
         p+iy1jjurEhiY0VdSX+n6ZXQekkIuykk2YdJBdxsAs/ax9+E9c5Pn0wy3+pHAUp9GI6d
         X25y3MPfX/9iL1E5heStS9zfm5JQ56RxozURpjYd6OWX7yoGnM8jiMFFCzS5sYc1VK4M
         qweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kVXzwJG4Z6VIDWjTgt8AYwn+gFSIBYCUGr/xkh20JBc=;
        b=NwjruOLEovLwlaeBUuSUrOYXHgK1Nom/qXlIZ0bcmspOmVZPqHoZ+Zyyk+jlEw6a34
         8f/6HtgU/9vm0j/z2zajLFCL6bKf8z4N6exTrFd6L6Bbbz4XSXVkSDlHpZ/NfUtJBT97
         GUFu35TwP5sDINu9WnpPIR7G0Ligm0D27kmtpRXJygtXI81JqEgEAfPQqoqDolvLchwI
         6eOV3+iqFZjmsXjZOc1WNlM1w+zpltjPdP9S9n6EX2jLMd9sHhwCl/bixv1aeeR7fF/G
         c6XXbZuMFucvhW+zj8+dqEdYYoSbe5c52OOhut7O3glmssBs1XBaAhWRD6x1RB1IZdcL
         05XQ==
X-Gm-Message-State: AOAM532BlmEuOwKbQHmm9IN5Qw1bG9CzVGKXMoLgUTI9jdd4ebeRJ3Rb
        wxYagNnfHdooVYsYmnKi1xHp9i9svIrhCQ==
X-Google-Smtp-Source: ABdhPJxnfEFu573Dxky3FE7EWJmgC6pAtvWXVCKlA4edfLCFFbukaZvFpHRMu9a7PUJAH3Bnpyc+VQ==
X-Received: by 2002:a7b:ce0d:: with SMTP id m13mr1048054wmc.90.1621898072383;
        Mon, 24 May 2021 16:14:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v12sm14067264wrv.76.2021.05.24.16.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 16:14:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Robert Foss <robert.foss@linaro.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] send-email: don't needlessly abs_path() the core.hooksPath
Date:   Tue, 25 May 2021 01:14:25 +0200
Message-Id: <patch-2.2-d097e7b0b81-20210524T231047Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.388.g81c17cd8439
In-Reply-To: <cover-0.2-00000000000-20210524T231047Z-avarab@gmail.com>
References: <bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org> <cover-0.2-00000000000-20210524T231047Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In c8243933c74 (git-send-email: Respect core.hooksPath setting,
2021-03-23) we started supporting core.hooksPath in "send-email". It's
been reported that on Windows[1] doing this by calling abs_path()
results in different canonicalizations of the absolute path.

This wasn't an issue in c8243933c74 itself, but was revealed by my
ea7811b37e0 (git-send-email: improve --validate error output,
2021-04-06) when we started emitting the path to the hook, which was
previously only internal to git-send-email.perl.

I think this change should let us have our cake and eat it too. We now
emit a relative path for the common case where the hook is in the
.git/hooks directory, but in the case it's an absolute path (there's
another test for that, not seen here) we'll prefix it with $(pwd).

I hope that unlike the current implementation that $(pwd) v.s. $PWD
difference won't matter on Windows, since now the absolute path is the
one we get from rev-parse, not the one that's been passed through
Perl's Cwd::abs_path().

1. http://lore.kernel.org/git/bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 perl/Git.pm           | 3 +--
 t/t9001-send-email.sh | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 73ebbf80cc6..df6280ebab5 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -629,8 +629,7 @@ sub hooks_path {
 	my ($self) = @_;
 
 	my $dir = $self->command_oneline('rev-parse', '--git-path', 'hooks');
-	my $abs = abs_path($dir);
-	return $abs;
+	return $dir;
 }
 
 =item wc_path ()
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 2acf389837c..3b7540050ca 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -539,7 +539,7 @@ test_expect_success $PREREQ "--validate respects relative core.hooksPath path" '
 	test_path_is_file my-hooks.ran &&
 	cat >expect <<-EOF &&
 	fatal: longline.patch: rejected by sendemail-validate hook
-	fatal: command '"'"'$(pwd)/my-hooks/sendemail-validate'"'"' died with exit code 1
+	fatal: command '"'"'my-hooks/sendemail-validate'"'"' died with exit code 1
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
-- 
2.32.0.rc1.385.g9db524b96f7

