Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F830C43465
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08EB92076E
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3NHmAPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgIUKko (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgIUKkm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 06:40:42 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59E6C0613D4
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:34 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z9so12081197wmk.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=POyCC72EThbYV2wF217KCHzxwAmdyKiBzorI5YYzPGg=;
        b=g3NHmAPi0wXCNHXhb+EDdCi+hYe6iv+mDVmdfQaqYe4Zrg+4PPMeKpeKR/Oash1+6s
         aUr8lkptP+ZWXozQHg9NlOWDfiIug1RRKeS2r+vQpo7VCzTlKbHrEzCI9dd3I3rQI6lT
         4m+DGk2E1eN8Se53J6np/KUi3Ew8rO9JpN0hJNh8kMDdpD4olWULM/kXJuP/aoct9JSF
         cN4kHOSdv0PfijDgNJ5z8zeok70wc3tA8PpZwVVMyRmjKyyt8PXYiavNjdO75x+hq5wf
         d7CqnUhyStERSOQ/B9Z3NFNV/NyvxS3XeZj638kCJp0VtpIxMrwo7snd0qHkEhHcKi4A
         vEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=POyCC72EThbYV2wF217KCHzxwAmdyKiBzorI5YYzPGg=;
        b=QwuJInAIrFaLGdZa+mLbpRzrruNn0VcUAAboQhMTLjgUonbTKOpc9y03xDw0MDVFcJ
         XXv/Gqq30lM2iiI1SQOGnkNowJf/CKx5SAhjyxcs+GfaWkmDadWJ5Ut/CXOpc792PDJ9
         n2THwZM6nmO4r3uW4oeZZSII1uC4m9Wvy3f4rlJuUmJ2aL0qW1RMICNYZK8YDir3FPCF
         EEe2kOYHf7edIDvhobr6q+n+jMU89yjznzPyFGTeW6DDA7nySsA4qAhU9hzvGQ0cOPTm
         SoCRsKBwrPKBkUAbl/51wK+i6p6AS6LIywcv5UVH0xFdn9y76lP/omgbO1pkMlxS1fmb
         3t+g==
X-Gm-Message-State: AOAM532Q4aJ6jOmdG6FejZvPpkB8Jsjr4MGuyGAARQK81JWb7biWRex2
        XVsrqwDxuqTItlMyN3KYbylgjctesb+lTg==
X-Google-Smtp-Source: ABdhPJxXoOnh3MLIkHtqunBlxrBGZq9FCA1C3aWt+cyaqZ7Rp521ahEuYYfHIMqIMAOX2d5MlLmpCQ==
X-Received: by 2002:a1c:1f86:: with SMTP id f128mr17290731wmf.187.1600684833262;
        Mon, 21 Sep 2020 03:40:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 9sm18647833wmf.7.2020.09.21.03.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:40:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, imon Legner <Simon.Legner@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 18/18] remote-mediawiki: use "sh" to eliminate unquoted commands
Date:   Mon, 21 Sep 2020 12:40:00 +0200
Message-Id: <20200921104000.2304-19-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the use of run_git_unquoted() completely with a use of "sh -c"
suggested by Jeff King, i.e.:

    sh -c '"$@" 2>/dev/null' -- echo sneaky 'argument;id'

I don't think this is needed now for any potential RCE issue. The
$remotename argument is ultimately picked by the local user (and
similarly, the $local variable comes from a user-supplied
refspec).

But completely eliminating the use of unquoted shell arguments has a
value in and of itself, by making the code easier to review. As noted
in an earlier commit I think the use of IPC::Open3 would be too
verbose here, but this "sh -c" trick strikes the right balance between
readability and semantic sanity.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 24 +++++++--------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index d21c18df7b..a5624413dc 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -371,8 +371,8 @@ sub get_mw_pages {
 
 # usage: $out = run_git_quoted(["command", "args", ...]);
 #        $out = run_git_quoted(["command", "args", ...], "raw"); # don't interpret output as UTF-8.
-#        $out = run_git_unquoted(["command args"); # don't quote arguments
-#        $out = run_git_unquoted(["command args", "raw"); # ditto but raw instead of UTF-8 as above
+#        $out = run_git_quoted_nostderr(["command", "args", ...]); # discard stderr
+#        $out = run_git_quoted_nostderr(["command", "args", ...], "raw"); # ditto but raw instead of UTF-8 as above
 sub _run_git {
 	my $args = shift;
 	my $encoding = (shift || 'encoding(UTF-8)');
@@ -391,8 +391,8 @@ sub run_git_quoted {
     _run_git(["git", @{$_[0]}], $_[1]);
 }
 
-sub run_git_unquoted {
-    _run_git(["git $_[0]"], $_[1]);
+sub run_git_quoted_nostderr {
+    _run_git(['sh', '-c', 'git "$@" 2>/dev/null', '--', @{$_[0]}], $_[1]);
 }
 
 sub get_all_mediafiles {
@@ -521,10 +521,8 @@ sub download_mw_mediafile {
 
 sub get_last_local_revision {
 	# Get note regarding last mediawiki revision.
-	#
-	# It's OK to use run_git_unquoted() here because $remotename is
-	# supplied by the local git itself.
-	my $note = run_git_unquoted("notes --ref=${remotename}/mediawiki show refs/mediawiki/${remotename}/master 2>/dev/null");
+	my $note = run_git_quoted_nostderr(["notes", "--ref=${remotename}/mediawiki",
+					    "show", "refs/mediawiki/${remotename}/master"]);
 	my @note_info = split(/ /, $note);
 
 	my $lastrevision_number;
@@ -1189,16 +1187,10 @@ sub mw_push_revision {
 	my $mw_revision = $last_remote_revid;
 
 	# Get sha1 of commit pointed by local HEAD
-	#
-	# It's OK to use run_git_unquoted() because $local is supplied
-	# by the local git itself.
-	my $HEAD_sha1 = run_git_unquoted("rev-parse ${local} 2>/dev/null");
+	my $HEAD_sha1 = run_git_quoted_nostderr(["rev-parse", $local]);
 	chomp($HEAD_sha1);
 	# Get sha1 of commit pointed by remotes/$remotename/master
-	#
-	# It's OK to use run_git_unquoted() here because $remotename is
-	# supplied by the local git itself.
-	my $remoteorigin_sha1 = run_git_unquoted("rev-parse refs/remotes/${remotename}/master 2>/dev/null");
+	my $remoteorigin_sha1 = run_git_quoted_nostderr(["rev-parse", "refs/remotes/${remotename}/master"]);
 	chomp($remoteorigin_sha1);
 
 	if ($last_local_revid > 0 &&
-- 
2.28.0.297.g1956fa8f8d

