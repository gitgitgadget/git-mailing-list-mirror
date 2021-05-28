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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F74C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E77A9613D1
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbhE1JZ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 05:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbhE1JZt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 05:25:49 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BEBC06138E
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:24:06 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n2so2661315wrm.0
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gq6zEoXKs292L8hv6k3D9V64J/nM+XhRPtXaYczoB4k=;
        b=pqGQyKOzq2MZMvgEbAgDadJ+Z+JS/jj85Xegr8GguoZU7SjKxLo7mWzo7caP+sjeTJ
         A6LgAAdxah1uo/cmQN49xtUJa7WHVEvwW03oPCB+yvnLi8JYDYB4zMAMvTzrvxwd9AXW
         urgxrnEKdYZ3zan+2KG3l3Eabc0t/QjIOF/YVs3nP2kl9HaWxSVXWYaSqmhdBF8XIMDU
         eRNxSedDFV5gp435rlCMj5upGHafTIefwReC8VC5tnuLPAPtkyVu16Vwxw41/BAe9QIz
         AujkvpBgYINbgdqu3g1OINS0t672A80+5QXvUIADuYEVTlYMouAwiS87HQ6J6FbTumYi
         +yVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gq6zEoXKs292L8hv6k3D9V64J/nM+XhRPtXaYczoB4k=;
        b=OldxibOZ5Oz5CW39KilW/jhBnzFvVBM4AbHCuz92wQuUOmzUBKoo2Os14jwead1mc2
         Mvqn8Li8arAWMYVikKH1ulVWwe4kmkKt+k1FH5YooERhOVlfzW4nyZ0QS7fuSGSrlk8j
         B6/C3MYj16wBzj9mEWmUopjaUgSFjLkV6fDNhVUIemRBsGDk1oBlsAeIYRzmH3pS9cYH
         sB05erj+EiFG/HCLL09+mEeSBAB7vTbUdJQjFD3GSvJd3ezsoiKgBy9OGx+y91cbLbXt
         LHVOFP7bIItBlErVc4jsp1ZBVf2qKiVVizckyjrm6d89mVxYFSSrCu9DQtKQ30u3PGSK
         mxeQ==
X-Gm-Message-State: AOAM532ASYITBxL1KN/h+DKrxwBzq2o0rKt7ryNZdIyvRt2R3RRVNl2U
        W+Q9iECX6uQCtlePPSNMJWuIXOoL4CyUow==
X-Google-Smtp-Source: ABdhPJxiNUgd1j/IaPYkPBIUtAL3zq/lNtoHSK+7mr9tGe/obaMub4ULCny6UB0Ymp17iFkUPy1CFA==
X-Received: by 2002:adf:f341:: with SMTP id e1mr7844394wrp.352.1622193844907;
        Fri, 28 May 2021 02:24:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18sm5842009wmj.15.2021.05.28.02.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:24:04 -0700 (PDT)
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
Subject: [PATCH v5 12/13] send-email: move trivial config handling to Perl
Date:   Fri, 28 May 2021 11:23:51 +0200
Message-Id: <patch-12.13-f605b5ae49f-20210528T092228Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.458.gd885d4f985c
In-Reply-To: <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com> <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Optimize the startup time of git-send-email by using an amended
config_regexp() function to retrieve the list of config keys and
values we're interested in.

For boolean keys we can handle the [true|false] case ourselves, and
the "--get" case didn't need any parsing. Let's leave "--path" and
other "--bool" cases to "git config". I'm not bothering with the
"undef" or "" case (true and false, respectively), let's just punt on
those and others and have "git config --type=bool" handle it.

The "grep { defined } @values" here covers a rather subtle case. For
list values such as sendemail.to it is possible as with any other
config key to provide a plain "-c sendemail.to", i.e. to set the key
as a boolean true. In that case the Git::config() API will return an
empty string, but this new parser will correctly return "undef".

However, that means we can end up with "undef" in the middle of a
list. E.g. for sendemail.smtpserveroption in conjuction with
sendemail.smtpserver as a path this would have produce a warning. For
most of the other keys we'd behave the same despite the subtle change
in the value, e.g. sendemail.to would behave the same because
Mail::Address->parse() happens to return an empty list if fed
"undef". For the boolean values we were already prepared to handle
these variables being initialized as undef anyway.

This brings the runtime of "git send-email" from ~60-~70ms to a very
steady ~40ms on my test box. We now run just one "git config"
invocation on startup instead of 8, the exact number will differ based
on the local sendemail.* config. I happen to have 8 of those set.

This brings the runtime of t9001-send-email.sh from ~13s down to ~12s
for me. The change there is less impressive as many of those tests set
various config values, and we're also getting to the point of
diminishing returns for optimizing "git send-email" itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index a8949c9d313..57911386835 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -334,7 +334,11 @@ sub read_config {
 		my $target = $config_bool_settings{$setting};
 		my $key = "$prefix.$setting";
 		next unless exists $known_keys->{$key};
-		my $v = Git::config_bool(@repo, $key);
+		my $v = (@{$known_keys->{$key}} == 1 &&
+			 (defined $known_keys->{$key}->[0] &&
+			  $known_keys->{$key}->[0] =~ /^(?:true|false)$/s))
+			? $known_keys->{$key}->[0] eq 'true'
+			: Git::config_bool(@repo, $key);
 		next unless defined $v;
 		next if $configured->{$setting}++;
 		$$target = $v;
@@ -363,13 +367,13 @@ sub read_config {
 		my $key = "$prefix.$setting";
 		next unless exists $known_keys->{$key};
 		if (ref($target) eq "ARRAY") {
-			my @values = Git::config(@repo, $key);
-			next unless @values;
+			my @values = @{$known_keys->{$key}};
+			@values = grep { defined } @values;
 			next if $configured->{$setting}++;
 			@$target = @values;
 		}
 		else {
-			my $v = Git::config(@repo, $key);
+			my $v = $known_keys->{$key}->[0];
 			next unless defined $v;
 			next if $configured->{$setting}++;
 			$$target = $v;
@@ -381,12 +385,19 @@ sub config_regexp {
 	my ($regex) = @_;
 	my @ret;
 	eval {
-		@ret = Git::command(
+		my $ret = Git::command(
 			'config',
-			'--name-only',
+			'--null',
 			'--get-regexp',
 			$regex,
 		);
+		@ret = map {
+			# We must always return ($k, $v) here, since
+			# empty config values will be just "key\0",
+			# not "key\nvalue\0".
+			my ($k, $v) = split /\n/, $_, 2;
+			($k, $v);
+		} split /\0/, $ret;
 		1;
 	} or do {
 		# If we have no keys we're OK, otherwise re-throw
@@ -399,8 +410,10 @@ sub config_regexp {
 # parses 'bool' etc.) by only doing so for config keys that exist.
 my %known_config_keys;
 {
-	my @known_config_keys = config_regexp("^sende?mail[.]");
-	@known_config_keys{@known_config_keys} = ();
+	my @kv = config_regexp("^sende?mail[.]");
+	while (my ($k, $v) = splice @kv, 0, 2) {
+		push @{$known_config_keys{$k}} => $v;
+	}
 }
 
 # sendemail.identity yields to --identity. We must parse this
-- 
2.32.0.rc1.458.gd885d4f985c

