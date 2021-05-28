Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3853AC4708D
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CFD36127A
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbhE1JZh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 05:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbhE1JZe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 05:25:34 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE892C061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:23:58 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so2003639wmf.1
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=buaQsRPXqAyBpxHx0C/x1vNTJBc8mxwyFQSYVkK46SI=;
        b=m289FLxElmcF/9wlCekL/oX151id1lYrUfEmIs8eGqQfDwmjC+NHtDSR3Fej9NmD9a
         ZCM5JgO8zHsFQz0iVKhBl2kfRxc7dIxtznyiJrBXA+fXyA62zmUm/bRmCTzc9Kj8fuAV
         xGIdSV1ZJiRXg2lN/cQcyvVdVok9eZpbok4UZi7/0tnovnpxX/XtWd01UUReCQc4gMpd
         EuXAdQM8zpw1sQ6gEtpNU1IBNMSz32CyhnJaG4BEwd0Q2On00VziD6Aw/PZGm8tLSuBh
         ecJm6ANS4XWvzEtipwz44/sJCUZyuN5nuDxcNB9Frt9UidScU+CFm+Qvt2jHClKK0hiD
         n+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=buaQsRPXqAyBpxHx0C/x1vNTJBc8mxwyFQSYVkK46SI=;
        b=rbFnD52wgfEYCyBdNjkz+IGfujHyCKEGu+4Z1Eba3aQGzMhgfM5+qPVcIyQluxfZHs
         HW1aGGqnrTdXDJnHlXV2SxKaan8or2O2bj1mnSCyoY9ndhxWLtBcwrW8/jVRzVIjUKrq
         AcwyBo1oFgRmHHBIaGuHYCNKUUQkeSfadutDLayt8v3OfPiUSfBlQmqiI0MVCYYs43eI
         x9+P6yqDympOIoUBEsla2IPbMtCoiT5H6Pp3DM9OXyePHELea850Cz5tI/XjFoGbvlIh
         9iH3nh3rxUIgUyZJF10FDdotly7qq1X/3GgU08Ytr0PsEO7fL+2YAx48qV7+8hnh1SWl
         7w2w==
X-Gm-Message-State: AOAM531DQP+c4/jkklu/i9iZx68J1VZtJzlzVuyka3pDLe+k6JACJUFd
        lZc3zplbWep33Mo42rylLlu/0LarG8OnZg==
X-Google-Smtp-Source: ABdhPJyUvI0U7RSS9WDAY02goa1fwS67uXNXDNfjoPDl5E2tPmLeXMtrS+2WA5YTX9/q7nl7vld5Tw==
X-Received: by 2002:a7b:cc88:: with SMTP id p8mr12682923wma.171.1622193837234;
        Fri, 28 May 2021 02:23:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18sm5842009wmj.15.2021.05.28.02.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:23:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 03/13] send-email: remove non-working support for "sendemail.smtpssl"
Date:   Fri, 28 May 2021 11:23:42 +0200
Message-Id: <patch-03.13-e3e3e6415d2-20210528T092228Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.458.gd885d4f985c
In-Reply-To: <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com> <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the already dead code to support "sendemail.smtpssl" by finally
removing the dead code supporting the configuration option.

In f6bebd121ac (git-send-email: add support for TLS via
Net::SMTP::SSL, 2008-06-25) the --smtp-ssl command-line option was
documented as deprecated, later in 65180c66186 (List send-email config
options in config.txt., 2009-07-22) the "sendemail.smtpssl"
configuration option was also documented as such.

Then in in 3ff15040e22 (send-email: fix regression in
sendemail.identity parsing, 2019-05-17) I unintentionally removed
support for it by introducing a bug in read_config().

As can be seen from the diff context we've already returned unless
$enc i defined, so it's not possible for us to reach the "elsif"
branch here. This code was therefore already dead since Git v2.23.0.

So let's just remove it. We were already 11 years into a stated
deprecation period of this variable when 3ff15040e22 landed, now it's
around 13. Since it hasn't worked anyway for around 2 years it looks
like we can safely remove it.

The --smtp-ssl option is still deprecated, if someone cares they can
follow-up and remove that too, but unlike the config option that one
could still be in use in the wild. I'm just removing this code that's
provably unused already.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/sendemail.txt | 3 ---
 git-send-email.perl                | 6 +-----
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/Documentation/config/sendemail.txt b/Documentation/config/sendemail.txt
index cbc5af42fdf..50baa5d6bfb 100644
--- a/Documentation/config/sendemail.txt
+++ b/Documentation/config/sendemail.txt
@@ -8,9 +8,6 @@ sendemail.smtpEncryption::
 	See linkgit:git-send-email[1] for description.  Note that this
 	setting is not subject to the 'identity' mechanism.
 
-sendemail.smtpssl (deprecated)::
-	Deprecated alias for 'sendemail.smtpEncryption = ssl'.
-
 sendemail.smtpsslcertpath::
 	Path to ca-certificates (either a directory or a single file).
 	Set it to an empty string to disable certificate verification.
diff --git a/git-send-email.perl b/git-send-email.perl
index 1630e87cd4d..9a1a4898e36 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -393,11 +393,7 @@ sub read_config {
 		my $enc = Git::config(@repo, $setting);
 		return unless defined $enc;
 		return if $configured->{$setting}++;
-		if (defined $enc) {
-			$smtp_encryption = $enc;
-		} elsif (Git::config_bool(@repo, "$prefix.smtpssl")) {
-			$smtp_encryption = 'ssl';
-		}
+		$smtp_encryption = $enc;
 	}
 }
 
-- 
2.32.0.rc1.458.gd885d4f985c

