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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A19C47083
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4176161151
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhEXHyq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 03:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbhEXHyi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 03:54:38 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D82C06138A
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:53:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u133so14400097wmg.1
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dTN/s2phJJug/whbzoAGub3ykTCtikWBaAvewwao3XE=;
        b=eS4U5S9pULANoWDRsrmoCwbWdlMf+nJYCix6TAJ5KCEdQcuj30oUPoFGJnZGfRBmoB
         wxv3pkcpvmOvJOxY1ulC3VexukPPsAkL0oiTVWm/Wd6CtBZfsYkYb1krF31JZJ8rIjz9
         49wBwx2CMy0lRgiiTz1DFE1Xnu5yLjNtvrmRBKe19MAKc512J2QigPxug2wivlNcc0IQ
         nkIYF1oioFvMvk/sFV2UxMdcAslkiVceIyp1QFf2w2prL4iherIE+pFP+6XP0Dg+ypBi
         Ly7NQEGb0SDYw+yHWYfsTYyPTmAZtXlRCELHLc4qhP+XppcCaNtYs2oten1C3jrSV95L
         RX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dTN/s2phJJug/whbzoAGub3ykTCtikWBaAvewwao3XE=;
        b=MUPzjz6Eq96YdE3yW+KCcp7v1WSOnSpB4mKsnZsl2mtNKFQ7qgJQI4qmi82jjNsml0
         wcofOk+oAZm/P0RY7C8BWhReNbPoQKhqX1VPrFVv4Wqpvfwq0dtzDLN6wx/7vWFiClXR
         Plp1wOvgUfZK1vAjMnjbomFaPrRXA1COvcpciRaZx+jKAplmYlyesatfCDhw6YRBdm9K
         d5NJjG+48CSU/KRaAyn9uaV45NS16oRlxT9IZXr64Y9UGqxi6DB4QjD4oa4oPcDZrA/9
         etOc+/6RDrfs+Ie7vcU9Qb3awHo/tTiExWmnMaHXP+phj6CWI6Z1OwtmSifLOvMwye2+
         5zNQ==
X-Gm-Message-State: AOAM531gtrGvxYpibh6jPMnIcOpj5++uMYZt5T8KBfvpXRo1Ke1j89N/
        j+H2CVZ5kBiFPfx2pKSk1m3y4qJNxwtDCbuP
X-Google-Smtp-Source: ABdhPJxIYWtw0fiG873n1OKCJhv7b/DN8wiV099FhofB6b6kuQV9QzE58ogXdI/6mQTbkW8tQJDY7w==
X-Received: by 2002:a1c:4043:: with SMTP id n64mr18771175wma.9.1621842788370;
        Mon, 24 May 2021 00:53:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u126sm8540459wmb.9.2021.05.24.00.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 00:53:08 -0700 (PDT)
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
Subject: [PATCH v4 03/13] send-email: remove non-working support for "sendemail.smtpssl"
Date:   Mon, 24 May 2021 09:52:52 +0200
Message-Id: <patch-03.13-a7a21b75f2e-20210524T074932Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.385.g46e826f1e55
In-Reply-To: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
References: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com> <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
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
index cffdfdacfb9..24d73df5a3e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -383,11 +383,7 @@ sub read_config {
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
2.32.0.rc1.385.g46e826f1e55

