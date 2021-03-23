Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F72BC433E0
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 16:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62DFE619C6
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 16:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhCWQ16 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 12:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbhCWQ1a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 12:27:30 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11018C061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 09:27:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u21so10137908ejo.13
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZASMGZlddxvjtMgBhtL/L/0weEN62pes1S2Ay9JYkyw=;
        b=MIop8mdDHOdotB1duUt5YhAlqX/cfobNEnfCkGz6kR/PBzoJkXWBQWa5rkVl2MNVRR
         xrqgeWYePoPgXtOpo3g7pq0c8UySS/nRnhppDobDsQK4RmZKDsG7k01XgqtSwTz0xIfw
         /xqN8AD6BJj1LjDQL/xGn2StgLg8TREyX1DY0IQHTuiI/I2JHQ0V5hiGMhbkTB5lW8ou
         ZNC+F3vcLcig1a94GW0YKWLAbm2CkiHTu2+BoAJ2cNiljUDRE+Tu8DHvSIwTsUhnZYSe
         oe9bRBDYQm5h9LCABTdVHlJRgtIyogtOR03TRsn0VLBASp/wqWj+DQ7mBMnb0Q11NxNa
         xNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZASMGZlddxvjtMgBhtL/L/0weEN62pes1S2Ay9JYkyw=;
        b=d4AhRkuULdG8MdtE5mGARrs49+dHYUbG7lQZGNhuLCsXTzUHOkCsbMTD+LbKLv3t+/
         EsnRcIXl+sGKDytd/tY0DlCI6axdIu7mDVoxfqDqwrB0Z4PztfeMUJv+doCYUHDAqDSa
         Mdig8V2yoabv1QD5lw5viNyLJD5XMQg2KVAl2ttXhS+4B/qvnFF6GqTa9v2xvwAgVpfC
         CRzpXyXbh0jXhpy20dPuv7j/4wXoEOZLWrPQgXsISQZY6lxBmFxXifGIASYAmpG5uJ7u
         lZ+8hlXJEytqmk476mOXrLZzXH/gK3PI4P9+J5PBpCrjksDLp5vLWAuDpyOa0jVt+2C7
         Qk2A==
X-Gm-Message-State: AOAM533r8tKGKeeSVwaRdd8JTpg98+AKeJ2ea0kV96XC2pJUTzEzBjey
        O/Y2N1jzPlGRl3czuSUC9blJXA==
X-Google-Smtp-Source: ABdhPJwFBITk0OdEUX57XjSAoidATFd5npfpmFDPh9+c7He5RN/SujSMJqmaNn97YgTwf1h0/O/Bcg==
X-Received: by 2002:a17:907:2b03:: with SMTP id gc3mr5773542ejc.448.1616516848809;
        Tue, 23 Mar 2021 09:27:28 -0700 (PDT)
Received: from localhost.localdomain ([37.120.1.234])
        by smtp.gmail.com with ESMTPSA id o6sm13111070edw.24.2021.03.23.09.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 09:27:28 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Drew DeVault <sir@cmpwn.com>, Rafael Aquini <aquini@redhat.com>,
        =?UTF-8?q?Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>,
        Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v2] git-send-email: Respect core.hooksPath setting
Date:   Tue, 23 Mar 2021 17:27:18 +0100
Message-Id: <20210323162718.1143982-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.31.0.30.g398dba342d.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

get-send-email currently makes the assumption that the
'sendemail-validate' hook exists inside of the repository.

Since the introduction of 'core.hooksPath' configuration option in
v2.9, this is no longer true.

Instead of assuming a hardcoded repo relative path, query
git for the actual path of the hooks directory.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---

Changes since v1:
 - Ævar: Add unit test
 - Ævar: Add support for getting the hooks_path() from Git perl module
 - Ævar: Use new hooks_path() instread of issuing git rev-parse in
         git-send-email.perl


Note: The test currently leaves a file in a mktemp directory
in /tmp.

 git-send-email.perl   |  4 ++--
 perl/Git.pm           |  9 +++++++++
 t/t9001-send-email.sh | 16 ++++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 1f425c0809..c3dd825322 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1942,8 +1942,8 @@ sub validate_patch {
 	my ($fn, $xfer_encoding) = @_;
 
 	if ($repo) {
-		my $validate_hook = catfile(catdir($repo->repo_path(), 'hooks'),
-					    'sendemail-validate');
+		my $hook_path = $repo->hooks_path();
+		my $validate_hook = catfile($hook_path, 'sendemail-validate');
 		my $hook_error;
 		if (-x $validate_hook) {
 			my $target = abs_path($fn);
diff --git a/perl/Git.pm b/perl/Git.pm
index 02eacef0c2..ac1fabff28 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -226,6 +226,8 @@ sub repository {
 			$opts{Repository} = abs_path($dir);
 		}
 
+                $opts{HooksPath} = $search->command_oneline('rev-parse', '--git-path', 'hooks');
+
 		delete $opts{Directory};
 	}
 
@@ -619,6 +621,13 @@ sub _prompt {
 
 sub repo_path { $_[0]->{opts}->{Repository} }
 
+=item hooks_path ()
+
+Return path to the hooks directory. Must be called on a repository instance.
+
+=cut
+
+sub hooks_path { $_[0]->{opts}->{HooksPath} }
 
 =item wc_path ()
 
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 4eee9c3dcb..73b3bc1ce6 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -513,6 +513,22 @@ do
 
 done
 
+test_expect_success $PREREQ "--validate respects core.hooksPath setting" '
+	clean_fake_sendmail &&
+	tmp_dir=$(mktemp -d -t ci-XXXXXXXXXX) &&
+	printf "#!/bin/sh" >> $tmp_dir/sendemail-validate &&
+	printf "return 1" >> $tmp_dir/sendemail-validate &&
+	chmod a+x $tmp_dir/sendemail-validate &&
+	git -c core.hooksPath=$tmp_dir send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--validate \
+		longline.patch \
+		2>&1 >/dev/null | \
+	grep "rejected by sendemail-validate"
+'
+
 for enc in 7bit 8bit quoted-printable base64
 do
 	test_expect_success $PREREQ "--transfer-encoding=$enc produces correct header" '
-- 
2.31.0.30.g398dba342d.dirty

