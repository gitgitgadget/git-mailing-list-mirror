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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE19C2B9F7
	for <git@archiver.kernel.org>; Wed, 26 May 2021 11:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB3E613C5
	for <git@archiver.kernel.org>; Wed, 26 May 2021 11:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbhEZLXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 07:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbhEZLXN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 07:23:13 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8F9C06175F
        for <git@vger.kernel.org>; Wed, 26 May 2021 04:21:17 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m18so740446wrv.2
        for <git@vger.kernel.org>; Wed, 26 May 2021 04:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gYDAVzMPp3o6fFzIuh7hqetTcCNtFwIhzvBTZxLVA5U=;
        b=TCZYy5OnfQ+duwumdEUQockLFqh6xigNJfVT4HV0FA3rGK1hVOAMrm5UaAe4jLgVzI
         9xVmv2/x0tyQrpvg6Gpn2LBHjD5qVa473wT29YeBkBXW70Pp4jlG6C0gkMZk9SuVSmAX
         1AYBdYM+nxYVj9epusjsS+xt+WXXGaq36ol9e5jtmXe4jly0yuVLE/1eiSRiVYv6l58l
         gHf8wP780If3S0F3bcx9yT09XS286Rg3HR96wd4S1FYSYlFARCRa4bAbUzddStHp9eBK
         TaXRgiLz7pEO+9fajzJDJsXSgyvYGdwEGbta+kY7NUgJw01jJg+LXrfuYpyOFMRYYRvf
         Eikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gYDAVzMPp3o6fFzIuh7hqetTcCNtFwIhzvBTZxLVA5U=;
        b=aS3lvZqJYgc07SywtLYvgygx/4OGdPhkalzzblmnIpTtlBlvJ5hy8yCRJmAY+UPkxT
         FdcdMnm7mIN5ZaiH7RJ9E7XkxEDygyEVvICyUKx4bI9AB6QHM0vVZM5ua6gHK3bDulfS
         JGVqIx7lZDBHhr9jF45O+OVc+L9p3lwdy3fojf9dRs/wvUYrE8kXok6HwxxQYAcFlJhH
         I2q7C1WlKB1bwaFFMb6HHhsJWDZnc3g30Rujg0vITYuu9r2GPo7hGl1LsSA216qH482S
         nOgNShj8ZW7CFjHk4k9mUk/Zhfoqua3/EqXfYTZHNLURj8JkNaig7nce4JAfZr0yf1Mz
         M2zA==
X-Gm-Message-State: AOAM5335RoF2cIKus757Q30ULHJ77LiJCjWAe5x13CJKQ3/+bQFO47E/
        j/eSoAI1OojRi1Vboe9E9IUzbRF3ogXH4A==
X-Google-Smtp-Source: ABdhPJzr6Fsi4PiwdW3sFeazwNPiIYaCZBtgc7Y2Z3/nwGVZRcS3HIuTiTMzk1EH7u+irGPJ0STotQ==
X-Received: by 2002:adf:ce02:: with SMTP id p2mr32468946wrn.156.1622028075661;
        Wed, 26 May 2021 04:21:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v15sm6163144wmj.39.2021.05.26.04.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 04:21:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Robert Foss <robert.foss@linaro.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] send-email: move "hooks_path" invocation to git-send-email.perl
Date:   Wed, 26 May 2021 13:21:07 +0200
Message-Id: <patch-2.2-cda41c36772-20210526T111558Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.400.g0a5a93401d3
In-Reply-To: <cover-0.2-00000000000-20210526T111558Z-avarab@gmail.com>
References: <xmqq5yz6ehpk.fsf@gitster.g> <cover-0.2-00000000000-20210526T111558Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the newly added "hooks_path" API in Git.pm to its only user in
git-send-email.perl. This was added in c8243933c74 (git-send-email:
Respect core.hooksPath setting, 2021-03-23), meaning that it hasn't
yet made it into a non-rc release of git.

The consensus with Git.pm is that we need to be considerate of
out-of-tree users who treat it as a public documented interface. We
should therefore be less willing to add new functionality to it, least
we be stuck supporting it after our own uses for it disappear.

In this case the git-send-email.perl hook invocation will probably be
replaced by a future "git hook run" command, and in the commit
preceding this one the "hooks_path" become nothing but a trivial
wrapper for "rev-parse --git-path hooks" anyway (with no
Cwd::abs_path() call), so let's just inline this command in
git-send-email.perl itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl |  3 ++-
 perl/Git.pm         | 12 ------------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 170f42fe210..25be2ebd2af 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1959,7 +1959,8 @@ sub validate_patch {
 	my ($fn, $xfer_encoding) = @_;
 
 	if ($repo) {
-		my $validate_hook = catfile($repo->hooks_path(),
+		my $hooks_path = $repo->command_oneline('rev-parse', '--git-path', 'hooks');
+		my $validate_hook = catfile($hooks_path,
 					    'sendemail-validate');
 		my $hook_error;
 		if (-x $validate_hook) {
diff --git a/perl/Git.pm b/perl/Git.pm
index df6280ebab5..02eacef0c2a 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -619,18 +619,6 @@ sub _prompt {
 
 sub repo_path { $_[0]->{opts}->{Repository} }
 
-=item hooks_path ()
-
-Return path to the hooks directory. Must be called on a repository instance.
-
-=cut
-
-sub hooks_path {
-	my ($self) = @_;
-
-	my $dir = $self->command_oneline('rev-parse', '--git-path', 'hooks');
-	return $dir;
-}
 
 =item wc_path ()
 
-- 
2.32.0.rc1.400.g0a5a93401d3

