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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815C7C47082
	for <git@archiver.kernel.org>; Sun, 23 May 2021 08:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 555D3610C8
	for <git@archiver.kernel.org>; Sun, 23 May 2021 08:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhEWI5x (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 04:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhEWI5v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 04:57:51 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B031C061574
        for <git@vger.kernel.org>; Sun, 23 May 2021 01:56:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f20-20020a05600c4e94b0290181f6edda88so2814912wmq.2
        for <git@vger.kernel.org>; Sun, 23 May 2021 01:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=14+p4V/c3NSUszE/vS5wWYfl56Bnrm3xc+my4uWtZ4M=;
        b=CpTT4y9Dab6/yxVgDHWnJFT1X7y39jh3LKo8Yt5bf4yEVKMlTswdldiZc7Maj+saAc
         VXuiuvQ8AP9dyIhJOD+GoUbmjUPuUP7NF14HJuWB3ClrbTgtLra8crLCOw45R73FM2io
         E3qPJc65XQD0dGThQdCHvRpPjfyVIJi+/EMMQH8/qg07BUguC0qW6v6JsR5mHfwFzgym
         YITEJzmykjUCVHxJJ29HYHoROPY61Rb1OjziwPq2BPTeoKLszpBsq2SL05sRaPsM0F/Z
         vsmHC0sm95iucRe0VvcOdNUnkY0r7ncECTb+ULAGx7V7209ConZWuG/CLtaiCtKypKr1
         1R9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=14+p4V/c3NSUszE/vS5wWYfl56Bnrm3xc+my4uWtZ4M=;
        b=F6shLACfIIQ8PXGvEBRBsvckQlqr/JOPaxDc892lEYpBHUiIqxXjb3EOeIqJExUheq
         kGOgtEyuY4qGKaHu4djzgiiHOd9171K04De9N42f0Hw2enwjXh6JOfeXA3eWIIImE8Cu
         N9YKxkdZ3JTcvcexz+26p+0VlVm5gnsdSnulVlAt8DNcBkCeXi6kMYZ8he44aRFMVuoM
         xW8lXfAQhtHOx1UJyjV43++oDKaHt1pragscAih36hopknndn5QigQgAdhM+rvUYNogW
         oFIdDC0WumEuXL3GzZy9AfSofXsq1uPnRIuevZ0JGpJ8UgYqG8/fnCBVaL373Wa5l3jg
         uWhA==
X-Gm-Message-State: AOAM5302ZAil+oQnrDp37kjvLn2HYeSStpazes6w4jn3Qrs23MwKyG92
        hXBRezvPcM3UnJD6Mj9ddBXwjJKLc7nq8A==
X-Google-Smtp-Source: ABdhPJx1e2HWMie8AYuB5kc5NKjtd8YdGrHI3OHwKE4QHA5tsWSNSw2QKrBsrwmVt8YuNdshh6LTkg==
X-Received: by 2002:a1c:e487:: with SMTP id b129mr15354255wmh.137.1621760181181;
        Sun, 23 May 2021 01:56:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15sm9577839wrt.54.2021.05.23.01.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 01:56:20 -0700 (PDT)
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
Subject: [PATCH v3 00/13] send-email: various optimizations to speed up by >2x
Date:   Sun, 23 May 2021 10:56:05 +0200
Message-Id: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g05cb3eebfc
In-Reply-To: <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of v2[1] which fixes issues pointed out with v2, plus some
others I noticed along the way.

There are now no longer any changes to the "public"
Git::config_regxp() API. Instead it's left bitrotting in our tree at
the end of this, having 0 in-tree users (instead of the 1 currently).

We also handle the -c foo.bar (NULL value) case correctly, per what
Jeff King pointed out. I also found a related issue with
GIT_TEST_PERL_FATAL_WARNINGS=true, which we can now turn on for
git-send-email.perl.

1. https://lore.kernel.org/git/cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com/

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
 perl/Git.pm                        |  35 +++---
 t/t9001-send-email.sh              |  29 +++++
 4 files changed, 160 insertions(+), 81 deletions(-)

Range-diff against v2:
 -:  ---------- >  1:  71f890dc60 send-email tests: support GIT_TEST_PERL_FATAL_WARNINGS=true
 -:  ---------- >  2:  707c2ca556 send-email tests: test for boolean variables without a value
 1:  8474acae68 =  3:  3bbd48dab2 send-email: remove non-working support for "sendemail.smtpssl"
 2:  b87f53adbe =  4:  bed0f98d68 send-email: refactor sendemail.smtpencryption config parsing
 -:  ---------- >  5:  c12f69a411 send-email: copy "config_regxp" into git-send-email.perl
 3:  1b27a393ae !  6:  d1c233d251 send-email: lazily load config for a big speedup
    @@ git-send-email.perl: sub read_config {
      			next unless defined $v;
      			next if $configured->{$setting}++;
      			$$target = $v;
    -@@ git-send-email.perl: sub read_config {
    - 	}
    +@@ git-send-email.perl: sub config_regexp {
    + 	return @ret;
      }
      
     +# Save ourselves a lot of work of shelling out to 'git config' (it
     +# parses 'bool' etc.) by only doing so for config keys that exist.
     +my %known_config_keys;
     +{
    -+	my @known_config_keys = Git::config_regexp("^sende?mail[.]");
    ++	my @known_config_keys = config_regexp("^sende?mail[.]");
     +	@known_config_keys{@known_config_keys} = ();
     +}
     +
    @@ git-send-email.perl: sub read_config {
      my $rc = GetOptions(
      	"identity=s" => \$identity,
      	"no-identity" => \$no_identity,
    -@@ git-send-email.perl: sub read_config {
    +@@ git-send-email.perl: sub config_regexp {
      # Now we know enough to read the config
      {
          my %configured;
    @@ git-send-email.perl: sub read_config {
      }
      
      # Begin by accumulating all the variables (defined above), that we will end up
    -@@ git-send-email.perl: sub read_config {
    +@@ git-send-email.perl: sub config_regexp {
          usage();
      }
      
    --if ($forbid_sendmail_variables && (scalar Git::config_regexp("^sendmail[.]")) != 0) {
    +-if ($forbid_sendmail_variables && (scalar config_regexp("^sendmail[.]")) != 0) {
     +if ($forbid_sendmail_variables && grep { /^sendmail/s } keys %known_config_keys) {
      	die __("fatal: found configuration options for 'sendmail'\n" .
      		"git-send-email is configured with the sendemail.* options - note the 'e'.\n" .
      		"Set sendemail.forbidSendmailVariables to false to disable this check.\n");
    -
    - ## perl/Git.pm ##
    -@@ perl/Git.pm: sub config_regexp {
    - 	} catch Git::Error::Command with {
    - 		my $E = shift;
    - 		if ($E->value() == 1) {
    --			my @matches = ();
    --			return @matches;
    -+			# Key(s) not found.
    -+			return;
    - 		} else {
    - 			throw $E;
    - 		}
 4:  acee22b77d !  7:  4326c2f99c send-email: lazily shell out to "git var"
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## git-send-email.perl ##
    -@@ git-send-email.perl: sub read_config {
    +@@ git-send-email.perl: sub config_regexp {
      }
      
      my ($repoauthor, $repocommitter);
 5:  f317cd1c01 =  8:  e1fc71e3f9 send-email: use function syntax instead of barewords
 6:  fc27024f83 =  9:  a806ce06f1 send-email: get rid of indirect object syntax
 7:  f86f5453d7 ! 10:  aa11439789 send-email: lazily load modules for a big speedup
    @@ git-send-email.perl
     @@
      use 5.008;
      use strict;
    - use warnings;
    + use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
     -use POSIX qw/strftime/;
     -use Term::ReadLine;
      use Getopt::Long;
    @@ git-send-email.perl: sub do_edit {
      
      	# SMTP password masked
      	system "stty echo";
    -@@ git-send-email.perl: sub read_config {
    +@@ git-send-email.perl: sub config_regexp {
      }
      
      sub parse_address_line {
 8:  86641377c0 = 11:  b3b342b173 perl: lazily load some common Git.pm setup code
 9:  895c9e29a9 ! 12:  950dc0f53d send-email: move trivial config handling to Perl
    @@ Commit message
     
         Optimize the startup time of git-send-email by using an amended
         config_regexp() function to retrieve the list of config keys and
    -    values we're interested in. See the earlier "send-email: lazily load
    -    config for a big speedup" commit for why changing its interface is OK.
    +    values we're interested in.
     
         For boolean keys we can handle the [true|false] case ourselves, and
         the "--get" case didn't need any parsing. Let's leave "--path" and
    -    other "--bool" cases to "git config". As noted in a preceding commit
    -    we're free to change the config_regexp() function, it's only used by
    -    "git send-email".
    +    other "--bool" cases to "git config". I'm not bothering with the
    +    "undef" or "" case (true and false, respectively), let's just punt on
    +    those and others and have "git config --type=bool" handle it.
     
         This brings the runtime of "git send-email" from ~60-~70ms to a very
         steady ~40ms on my test box. We now run just one "git config"
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    +    diff --git a/git-send-email.perl b/git-send-email.perl
    +    index 1e9273fd4f..1ea4d9589d 100755
    +    --- a/git-send-email.perl
    +    +++ b/git-send-email.perl
    +    @@ -324,7 +324,11 @@ sub read_config {
    +                    my $target = $config_bool_settings{$setting};
    +                    my $key = "$prefix.$setting";
    +                    next unless exists $known_keys->{$key};
    +    -               my $v = Git::config_bool(@repo, $key);
    +    +               my $v = (@{$known_keys->{$key}} == 1 &&
    +    +                        (defined $known_keys->{$key}->[0] &&
    +    +                         $known_keys->{$key}->[0] =~ /^(?:true|false)$/s))
    +    +                       ? $known_keys->{$key}->[0] eq 'true'
    +    +                       : Git::config_bool(@repo, $key);
    +                    next unless defined $v;
    +                    next if $configured->{$setting}++;
    +                    $$target = $v;
    +    @@ -353,14 +357,12 @@ sub read_config {
    +                    my $key = "$prefix.$setting";
    +                    next unless exists $known_keys->{$key};
    +                    if (ref($target) eq "ARRAY") {
    +    -                       my @values = Git::config(@repo, $key);
    +    -                       next unless @values;
    +    +                       my @values = @{$known_keys->{$key}};
    +                            next if $configured->{$setting}++;
    +                            @$target = @values;
    +                    }
    +                    else {
    +    -                       my $v = Git::config(@repo, $key);
    +    -                       next unless defined $v;
    +    +                       my $v = $known_keys->{$key}->[0];
    +                            next if $configured->{$setting}++;
    +                            $$target = $v;
    +                    }
    +    @@ -371,12 +373,19 @@ sub config_regexp {
    +            my ($regex) = @_;
    +            my @ret;
    +            eval {
    +    -               @ret = Git::command(
    +    +               my $ret = Git::command(
    +                            'config',
    +    -                       '--name-only',
    +    +                       '--null',
    +                            '--get-regexp',
    +                            $regex,
    +                    );
    +    +               @ret = map {
    +    +                       # We must always return ($k, $v) here, since
    +    +                       # empty config values will be just "key\0",
    +    +                       # not "key\nvalue\0".
    +    +                       my ($k, $v) = split /\n/, $_, 2;
    +    +                       ($k, $v);
    +    +               } split /\0/, $ret;
    +                    1;
    +            } or do {
    +                    # If we have no keys we're OK, otherwise re-throw
    +    @@ -389,8 +398,10 @@ sub config_regexp {
    +     # parses 'bool' etc.) by only doing so for config keys that exist.
    +     my %known_config_keys;
    +     {
    +    -       my @known_config_keys = config_regexp("^sende?mail[.]");
    +    -       @known_config_keys{@known_config_keys} = ();
    +    +       my @kv = config_regexp("^sende?mail[.]");
    +    +       while (my ($k, $v) = splice @kv, 0, 2) {
    +    +               push @{$known_config_keys{$k}} => $v;
    +    +       }
    +     }
    +
    +     # sendemail.identity yields to --identity. We must parse this
    +
      ## git-send-email.perl ##
     @@ git-send-email.perl: sub read_config {
      		my $target = $config_bool_settings{$setting};
    @@ git-send-email.perl: sub read_config {
      		next unless exists $known_keys->{$key};
     -		my $v = Git::config_bool(@repo, $key);
     +		my $v = (@{$known_keys->{$key}} == 1 &&
    -+			 $known_keys->{$key}->[0] =~ /^(?:true|false)$/s)
    ++			 (defined $known_keys->{$key}->[0] &&
    ++			  $known_keys->{$key}->[0] =~ /^(?:true|false)$/s))
     +			? $known_keys->{$key}->[0] eq 'true'
     +			: Git::config_bool(@repo, $key);
      		next unless defined $v;
    @@ git-send-email.perl: sub read_config {
      			next if $configured->{$setting}++;
      			$$target = $v;
      		}
    -@@ git-send-email.perl: sub read_config {
    +@@ git-send-email.perl: sub config_regexp {
    + 	my ($regex) = @_;
    + 	my @ret;
    + 	eval {
    +-		@ret = Git::command(
    ++		my $ret = Git::command(
    + 			'config',
    +-			'--name-only',
    ++			'--null',
    + 			'--get-regexp',
    + 			$regex,
    + 		);
    ++		@ret = map {
    ++			# We must always return ($k, $v) here, since
    ++			# empty config values will be just "key\0",
    ++			# not "key\nvalue\0".
    ++			my ($k, $v) = split /\n/, $_, 2;
    ++			($k, $v);
    ++		} split /\0/, $ret;
    + 		1;
    + 	} or do {
    + 		# If we have no keys we're OK, otherwise re-throw
    +@@ git-send-email.perl: sub config_regexp {
      # parses 'bool' etc.) by only doing so for config keys that exist.
      my %known_config_keys;
      {
    --	my @known_config_keys = Git::config_regexp("^sende?mail[.]");
    +-	my @known_config_keys = config_regexp("^sende?mail[.]");
     -	@known_config_keys{@known_config_keys} = ();
    -+	my @kv = Git::config_regexp("^sende?mail[.]");
    ++	my @kv = config_regexp("^sende?mail[.]");
     +	while (my ($k, $v) = splice @kv, 0, 2) {
     +		push @{$known_config_keys{$k}} => $v;
     +	}
      }
      
      # sendemail.identity yields to --identity. We must parse this
    -
    - ## perl/Git.pm ##
    -@@ perl/Git.pm: sub config_int {
    - =item config_regexp ( RE )
    - 
    - Retrieve the list of configuration key names matching the regular
    --expression C<RE>. The return value is a list of strings matching
    --this regex.
    -+expression C<RE>. The return value is an ARRAY of key-value pairs.
    - 
    - =cut
    - 
    - sub config_regexp {
    - 	my ($self, $regex) = _maybe_self(@_);
    - 	try {
    --		my @cmd = ('config', '--name-only', '--get-regexp', $regex);
    -+		my @cmd = ('config', '--null', '--get-regexp', $regex);
    - 		unshift @cmd, $self if $self;
    --		my @matches = command(@cmd);
    --		return @matches;
    -+		my $data = command(@cmd);
    -+		my (@kv) = map { split /\n/, $_, 2 } split /\0/, $data;
    -+		return @kv;
    - 	} catch Git::Error::Command with {
    - 		my $E = shift;
    - 		if ($E->value() == 1) {
10:  97455f993d = 13:  c1d7ea664a perl: nano-optimize by replacing Cwd::cwd() with Cwd::getcwd()
-- 
2.32.0.rc0.406.g05cb3eebfc

