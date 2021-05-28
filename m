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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E41C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D226127A
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbhE1JZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 05:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235672AbhE1JZb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 05:25:31 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B150C061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:23:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n5-20020a1c72050000b0290192e1f9a7e1so2002041wmc.2
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OSeIDmUV2AxehJfOew6pYUId/mcqM/08FC4ZCa6wK4k=;
        b=VHVVj2rtdQEjyinoI9IQEEHCGZC8LHcupbaCI0lJHGAcQwLgtYLgXxG2yiPYij8/Hq
         YcqzO0HWdK5t2jp0IVcF34i+iyyq5UkssIFTkRfNbsHGQGPYmA5c46GRMF6K3iJieFvu
         GLwUgc1nUtT8JJE9PqF3GL8spUpxJ95vM2KxzncWu/H8rg0CjoYEkhRIkxWO1+xxC5w4
         +DOaLeTNx7fT+bshw/hWTItb4fgnXSTGh1FftRa42B9hi4PMVXMYHqqgKbIHsbjZVB6L
         UsDErD/sZdN91UaZmoMJqr6cdEmIDBlMbguN2XddfcXZ2XfmcvSuvHcQedFAE9VVImkE
         1/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OSeIDmUV2AxehJfOew6pYUId/mcqM/08FC4ZCa6wK4k=;
        b=hZZ3FE+DROA/uFc+hUMTReP/NRu4oPjHzjxMuPu10DxKEE/HTteTrSTt+gvzz1qGMF
         HRY+0lXsUR1uce0a4tb85wGJWxBAAxoBYAcDlxkP/6WB1GyN6LZdLeUg+9woG2797195
         MCVTpbGFH6hO6WobbFqrzQPRSAWVIjnvUahnBnXAaoNk7I3aZP18zMAMI5qogvOK35mS
         zOz6fXL5HytXXwsqF/Nilpx9f02nEWzdvOUQXG2qj71BTgAHevXWcMc5BgFMQsDGKyAh
         fanqUdkayWAyhY9nCrm8R3nXpLGuP5e4ZP/1HBYVa4mpYM7GJXJbLBzwcYHze96hqwhy
         vW0w==
X-Gm-Message-State: AOAM531hFE6e3Rc4QVY188VcTQdVTaekzvEHFKgaiHBSZPaqXQ30OIvQ
        COQah/vlyUxtheRUpq9X9S4LXzkaZm0=
X-Google-Smtp-Source: ABdhPJz4fiyJchm4/CH4x1X+xWYtpMz3+BtPafkIaKTEBkoa0H05+gAy6cuB6tfmQiyVHzHHg96Acg==
X-Received: by 2002:a1c:f717:: with SMTP id v23mr12371387wmh.32.1622193834593;
        Fri, 28 May 2021 02:23:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18sm5842009wmj.15.2021.05.28.02.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:23:53 -0700 (PDT)
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
Subject: [PATCH v5 00/13] send-email: various optimizations to speed up by >2x
Date:   Fri, 28 May 2021 11:23:39 +0200
Message-Id: <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.458.gd885d4f985c
In-Reply-To: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hopefully the final iteration. Updates a commit message to explain why
I moved away from File::Spec::Functions, rebases on master, and
explains and deals with the "undef in config" issue Jeff King noted.

Ævar Arnfjörð Bjarmason (13):
  send-email tests: support GIT_TEST_PERL_FATAL_WARNINGS=true
  send-email tests: test for boolean variables without a value
  send-email: remove non-working support for "sendemail.smtpssl"
  send-email: refactor sendemail.smtpencryption config parsing
  send-email: copy "config_regxp" into git-send-email.perl
  send-email: lazily load config for a big speedup
  send-email: lazily shell out to "git var"
  send-email: use function syntax instead of barewords
  send-email: get rid of indirect object syntax
  send-email: lazily load modules for a big speedup
  perl: lazily load some common Git.pm setup code
  send-email: move trivial config handling to Perl
  perl: nano-optimize by replacing Cwd::cwd() with Cwd::getcwd()

 Documentation/config/sendemail.txt |   3 -
 git-send-email.perl                | 174 +++++++++++++++++++----------
 perl/Git.pm                        |  32 +++---
 t/t9001-send-email.sh              |  29 +++++
 4 files changed, 159 insertions(+), 79 deletions(-)

Range-diff against v4:
 1:  7140847367c =  1:  81025b48f1c send-email tests: support GIT_TEST_PERL_FATAL_WARNINGS=true
 2:  d27f3b48f85 =  2:  16277bd1082 send-email tests: test for boolean variables without a value
 3:  a7a21b75f2e =  3:  e3e3e6415d2 send-email: remove non-working support for "sendemail.smtpssl"
 4:  7356a528589 =  4:  961ca4c2b2a send-email: refactor sendemail.smtpencryption config parsing
 5:  cce0f89143b =  5:  f2bd12728a1 send-email: copy "config_regxp" into git-send-email.perl
 6:  8afe8661761 =  6:  4cf70c6f97e send-email: lazily load config for a big speedup
 7:  491eefde6a2 =  7:  bd0d9535718 send-email: lazily shell out to "git var"
 8:  860156013f8 =  8:  f1a879a8ae9 send-email: use function syntax instead of barewords
 9:  dd24f1249f5 =  9:  881b1093409 send-email: get rid of indirect object syntax
10:  61e3e3c93c5 ! 10:  9f21bc6e6f2 send-email: lazily load modules for a big speedup
    @@ Commit message
         under NO_GETTEXT=[|Y], respectively. Now it's 52/37. It now takes ~15s
         to run t9001-send-email.sh, down from ~20s.
     
    +    Changing File::Spec::Functions::{catdir,catfile} to invoking class
    +    methods on File::Spec itself is idiomatic. See [1] for a more
    +    elaborate explanation, the resulting code behaves the same way, just
    +    without the now-pointless function wrapper.
    +
    +    1. http://lore.kernel.org/git/8735u8mmj9.fsf@evledraar.gmail.com
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## git-send-email.perl ##
    @@ git-send-email.perl: sub maildomain_mta {
      		if (defined $smtp) {
      			my $domain = $smtp->domain;
     @@ git-send-email.perl: sub validate_patch {
    - 	my ($fn, $xfer_encoding) = @_;
      
      	if ($repo) {
    --		my $validate_hook = catfile($repo->hooks_path(),
    + 		my $hooks_path = $repo->command_oneline('rev-parse', '--git-path', 'hooks');
    +-		my $validate_hook = catfile($hooks_path,
     +		require File::Spec;
    -+		my $validate_hook = File::Spec->catfile($repo->hooks_path(),
    ++		my $validate_hook = File::Spec->catfile($hooks_path,
      					    'sendemail-validate');
      		my $hook_error;
      		if (-x $validate_hook) {
11:  ada34374286 ! 11:  66f68e38c16 perl: lazily load some common Git.pm setup code
    @@ perl/Git.pm: sub get_tz_offset {
      	my $sign = qw( + + - )[ $gm <=> $t ];
      	return sprintf("%s%02d%02d", $sign, (gmtime(abs($t - $gm)))[2,1]);
      }
    -@@ perl/Git.pm: sub hooks_path {
    - 	my ($self) = @_;
    - 
    - 	my $dir = $self->command_oneline('rev-parse', '--git-path', 'hooks');
    --	my $abs = abs_path($dir);
    -+	require Cwd;
    -+	my $abs = Cwd::abs_path($dir);
    - 	return $abs;
    - }
    - 
     @@ perl/Git.pm: sub _temp_cache {
      		my $n = $name;
      		$n =~ s/\W/_/g; # no strange chars
12:  3818000bfba ! 12:  f605b5ae49f send-email: move trivial config handling to Perl
    @@ Commit message
         "undef" or "" case (true and false, respectively), let's just punt on
         those and others and have "git config --type=bool" handle it.
     
    +    The "grep { defined } @values" here covers a rather subtle case. For
    +    list values such as sendemail.to it is possible as with any other
    +    config key to provide a plain "-c sendemail.to", i.e. to set the key
    +    as a boolean true. In that case the Git::config() API will return an
    +    empty string, but this new parser will correctly return "undef".
    +
    +    However, that means we can end up with "undef" in the middle of a
    +    list. E.g. for sendemail.smtpserveroption in conjuction with
    +    sendemail.smtpserver as a path this would have produce a warning. For
    +    most of the other keys we'd behave the same despite the subtle change
    +    in the value, e.g. sendemail.to would behave the same because
    +    Mail::Address->parse() happens to return an empty list if fed
    +    "undef". For the boolean values we were already prepared to handle
    +    these variables being initialized as undef anyway.
    +
         This brings the runtime of "git send-email" from ~60-~70ms to a very
         steady ~40ms on my test box. We now run just one "git config"
         invocation on startup instead of 8, the exact number will differ based
    @@ git-send-email.perl: sub read_config {
     -			my @values = Git::config(@repo, $key);
     -			next unless @values;
     +			my @values = @{$known_keys->{$key}};
    ++			@values = grep { defined } @values;
      			next if $configured->{$setting}++;
      			@$target = @values;
      		}
      		else {
     -			my $v = Git::config(@repo, $key);
    --			next unless defined $v;
     +			my $v = $known_keys->{$key}->[0];
    + 			next unless defined $v;
      			next if $configured->{$setting}++;
      			$$target = $v;
    - 		}
     @@ git-send-email.perl: sub config_regexp {
      	my ($regex) = @_;
      	my @ret;
13:  d36b57e429f = 13:  aa3a2de7047 perl: nano-optimize by replacing Cwd::cwd() with Cwd::getcwd()
-- 
2.32.0.rc1.458.gd885d4f985c

