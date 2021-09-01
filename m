Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE9CC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 09:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6314A60462
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 09:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243614AbhIAJVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 05:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243594AbhIAJVW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 05:21:22 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F08C0613D9
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 02:20:25 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso2600809ott.13
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 02:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yVJZuC17BKtlaR5d/Zy24mhHmdtHe8oYZq8ZMLahvxs=;
        b=JH9KPOYP8LfigeIi9fvRTprzfN73NKER9VBrZoJBxbHyUs/q9OaSnz8wdVwdnrhw+s
         TF99C66Nelf74u3DzLBPZbUut/ldoEzJoEzkOKfuyfut4IBn+SoTkPu6N0qxgxvC0kPC
         A78kFmFzPWlQ9tDJ5FE4/T0s6yDxOOsBE/UKod7TMsBqHTRQZ2UFO9QovrWrVx73QBPd
         G9j9fLXBAo2qOh0RD0A0UiH6/omX4UT1z/0aO1biq+4tbY8AqCYMFu89KwEAnDwrrXJv
         Fq5NsF+pNZfVJIEcDKsv/JAAegSZOymtLwU8TOnm1IDhm+hZdAWP4NYkFOUXn5ulIlDk
         kfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yVJZuC17BKtlaR5d/Zy24mhHmdtHe8oYZq8ZMLahvxs=;
        b=Eyg0pqlaUWs9KYMDoLAIMnwrf5Amjr2gCIswEWyDEjC8b519QMQmCehyraPXfmI8VE
         PywSQYuCxpWVsXpUmA+bVZV6bAgjKTmBZuGfNl9Rv9BugROy/TJVUwYw1FsDMShyrcHg
         92E2yxTP6Buqld3qTJ+gllVVSGTbH4PbLdCLjSnKDfxjoZmIA34ZhFXg2PFaL/1HxX5H
         zgBM9Tt+O/pp4cdneNTR9O5G/pwv7TH67j3prA4ZL4QmagCxWFSLFW5fUesx6n+8US23
         Go6uKFSARBMLMFHOSoMguX9IRcFt0v7lm+JpOQMOSgZSGqsnhOrzFwRtEDKyX3wolVRt
         OjXw==
X-Gm-Message-State: AOAM532cuP4RMirLif5S5bEeM8TSZEYA9EjZJek491gn3TiWZt63cyUr
        qyD7jncTvihCSkLK/frarPw8NcTOqxc=
X-Google-Smtp-Source: ABdhPJzo2zGMb8YeEnuAf5kk7KAdLHKxkeTh5bpvZ58RDdU0dz3H8A8ZfAkUgx4LblHn/XEoSFY8cg==
X-Received: by 2002:a05:6830:911:: with SMTP id v17mr28405704ott.133.1630488024666;
        Wed, 01 Sep 2021 02:20:24 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id s206sm4161597oif.44.2021.09.01.02.20.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Sep 2021 02:20:24 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, phillip.wood@dunelm.org.uk,
        gitster@pobox.com, mackyle@gmail.com, sunshine@sunshineco.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH v2 3/4] developer: add an alternative script for detecting broken N_()
Date:   Wed,  1 Sep 2021 02:19:40 -0700
Message-Id: <20210901091941.34886-4-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210901091941.34886-1-carenas@gmail.com>
References: <20210809013833.58110-4-carenas@gmail.com>
 <20210901091941.34886-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

obviously incomplete and buggy (ex: won't detect two overlapping matches)

it could be added to some makefile target or documented better as an
alternative to the compilation errors the previous implementation did,
but I have to admit, I haven't found any place in the codebase where
a valid concatenation could take place, so at least the tracking of
exceptions might not be worthy, even if it might be the best part.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 .../find_accidentally_concat_i18n_strings.pl  | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100755 devtools/find_accidentally_concat_i18n_strings.pl

diff --git a/devtools/find_accidentally_concat_i18n_strings.pl b/devtools/find_accidentally_concat_i18n_strings.pl
new file mode 100755
index 0000000000..82bffb2477
--- /dev/null
+++ b/devtools/find_accidentally_concat_i18n_strings.pl
@@ -0,0 +1,69 @@
+#!/usr/bin/perl
+
+#
+# find .. \( -name "*.c" -o -name "*.h" \) -exec ./find_accidentally_concat_i18n_strings.pl {} \;
+#
+# this will help find places in the code that might have strings that
+# are marked for translation but are not correctly separated, causing
+# problems like the one reported in :
+#
+#   https://lore.kernel.org/git/ecb18f9d6ac56da0a61c3b98f8f2236@74d39fa044aa309eaea14b9f57fe79c/
+# 
+
+use strict;
+use warnings;
+
+my $myself = $0;
+my $file = $ARGV[0];
+my $errors = 0;
+my $key;
+
+chomp(my @exceptions = <DATA>);
+
+sub ask {
+	local $| = 1;
+	print "possible bug found in $key:\n";
+	print "\n$&\n";
+	print "\nadd exception (y/N): ";
+	chomp(my $answer = <STDIN>);
+	if (lc($answer) ne 'y') {
+		++$errors;
+		return;
+	}
+	return 1;
+}
+
+sub process_file {
+	my $content;
+	open(my $fh, '<', $file) or die;
+	{
+		local $/;
+		$content = <$fh>;
+	}
+	close($fh);
+	while ($content =~ /N_\(.*?\)[ \t\n]+N_\(.*?\)/g) {
+		my $index = length($`);
+		$key = "$file:$index";
+		if (!grep {/^$key$/} @exceptions) {
+			push @exceptions, $key if ask();
+		}
+	}
+}
+
+&process_file;
+
+{
+	local *MYSELF;
+	local $/ = "\n__END__";
+	open (MYSELF, $myself);
+	chomp(my $file = <MYSELF>);
+	close MYSELF;
+	open (MYSELF, ">$myself") || die "can't update myself";
+	print MYSELF $file, "\n__END__\n";
+	foreach (@exceptions) {
+		print MYSELF "$_\n";
+	}
+	close MYSELF;
+}
+exit($errors);
+__END__
-- 
2.33.0.481.g26d3bed244

