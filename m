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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6E3C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33FAD610C7
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhEXHyg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 03:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbhEXHyf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 03:54:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73262C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:53:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z17so27480342wrq.7
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OrE7X7WuPH6TyS28TMKheqVJQgKuIA8ugx1IpzNb69U=;
        b=HO0/50rg/GpkDcIyGvzTFTKADx6y3KfB7GMgfSd9j7LLaMEvptzNnFjrZKVP/vLHtS
         NMgYo+9e4fYDH+ovgPyKVeDHgLY5jv6dknEhItIo2A8+qdhBgty2a0x3PUVJzj/bD/YP
         NaD2Ma/RaBmYk/5YOzSWqmvfEYjWk7bVa9s11tntq3AL56KRYm1wRK6/DUwlBEl81FCS
         jUwyXbTM3NpsIENWcifak/AqYSDNhe3Y0Hjon0vMYIq3KxDF6+7Cy4o80BMETwikboo/
         ZFUcMDduLY2gYhP2zWja70mGIvfiYlN1L2zYx+leBWpj/VG8EoXdGHlIkkcFMGI2Y5da
         17dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OrE7X7WuPH6TyS28TMKheqVJQgKuIA8ugx1IpzNb69U=;
        b=ZIKIYa807Xao66N/MyHyvF63cMunG13Vk9WI7DwJiXQpRFReJtSCKLIpvfTmZX16ZN
         WwDVVx+02kN7idD24PzXiP5zjG3WOJhvhKyfQk9h9p8cjsWfmfamkXRSl9/NHuLPIidr
         z17WJ1wBrkZrMGZoNj1ofO+MLLzabbLK4F604dI598scHx8Apf0yxXFH7cMCiqxZYNmo
         4gyR9SjiNy8sqm+/7SiIp30E69pBS7qKhYhFxU6WNhVvtiv7vuAid35GpPqhsZpKbP9+
         iuMytWmVO4SrMvzhDqWSZ5aHH1Z/jOgCBn0rI4i5lKZpsIQ9R/42UU0dcvAQLNyWn/4e
         uDDw==
X-Gm-Message-State: AOAM530Vx+VlagGnwdItDgHnetUjEe2bKJaRIaTJlcey+q+u5DvRc/6P
        8yNffL13P2fWhAvndB9uylfpQCBpjo/Wj9Ou
X-Google-Smtp-Source: ABdhPJxoi+OUvsb8vfAZnffHNPMrfBlxZi4fYT93vOFA7oj1lLlIx13ixJ23J7RT5Lkxp7DBh+kNwA==
X-Received: by 2002:a5d:4689:: with SMTP id u9mr5711190wrq.7.1621842785724;
        Mon, 24 May 2021 00:53:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u126sm8540459wmb.9.2021.05.24.00.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 00:53:05 -0700 (PDT)
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
Subject: [PATCH v4 00/13] send-email: various optimizations to speed up by >2x
Date:   Mon, 24 May 2021 09:52:49 +0200
Message-Id: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.385.g46e826f1e55
In-Reply-To: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
References: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This v4 fixes an issue in v3 where 12/13 had a "diff --git" as part of
the commit message (mistake during rebase/squash), which confused "git
am" in trying to apply a diff twice. See <xmqqwnrplyns.fsf@gitster.g>.

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

Range-diff against v3:
 1:  71f890dc603 =  1:  7140847367c send-email tests: support GIT_TEST_PERL_FATAL_WARNINGS=true
 2:  707c2ca5563 =  2:  d27f3b48f85 send-email tests: test for boolean variables without a value
 3:  3bbd48dab23 =  3:  a7a21b75f2e send-email: remove non-working support for "sendemail.smtpssl"
 4:  bed0f98d681 =  4:  7356a528589 send-email: refactor sendemail.smtpencryption config parsing
 5:  c12f69a4110 =  5:  cce0f89143b send-email: copy "config_regxp" into git-send-email.perl
 6:  d1c233d2515 =  6:  8afe8661761 send-email: lazily load config for a big speedup
 7:  4326c2f99c1 =  7:  491eefde6a2 send-email: lazily shell out to "git var"
 8:  e1fc71e3f90 =  8:  860156013f8 send-email: use function syntax instead of barewords
 9:  a806ce06f18 =  9:  dd24f1249f5 send-email: get rid of indirect object syntax
10:  aa11439789d = 10:  61e3e3c93c5 send-email: lazily load modules for a big speedup
11:  b3b342b173b = 11:  ada34374286 perl: lazily load some common Git.pm setup code
12:  950dc0f53dd ! 12:  3818000bfba send-email: move trivial config handling to Perl
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    -    diff --git a/git-send-email.perl b/git-send-email.perl
    -    index 1e9273fd4f..1ea4d9589d 100755
    -    --- a/git-send-email.perl
    -    +++ b/git-send-email.perl
    -    @@ -324,7 +324,11 @@ sub read_config {
    -                    my $target = $config_bool_settings{$setting};
    -                    my $key = "$prefix.$setting";
    -                    next unless exists $known_keys->{$key};
    -    -               my $v = Git::config_bool(@repo, $key);
    -    +               my $v = (@{$known_keys->{$key}} == 1 &&
    -    +                        (defined $known_keys->{$key}->[0] &&
    -    +                         $known_keys->{$key}->[0] =~ /^(?:true|false)$/s))
    -    +                       ? $known_keys->{$key}->[0] eq 'true'
    -    +                       : Git::config_bool(@repo, $key);
    -                    next unless defined $v;
    -                    next if $configured->{$setting}++;
    -                    $$target = $v;
    -    @@ -353,14 +357,12 @@ sub read_config {
    -                    my $key = "$prefix.$setting";
    -                    next unless exists $known_keys->{$key};
    -                    if (ref($target) eq "ARRAY") {
    -    -                       my @values = Git::config(@repo, $key);
    -    -                       next unless @values;
    -    +                       my @values = @{$known_keys->{$key}};
    -                            next if $configured->{$setting}++;
    -                            @$target = @values;
    -                    }
    -                    else {
    -    -                       my $v = Git::config(@repo, $key);
    -    -                       next unless defined $v;
    -    +                       my $v = $known_keys->{$key}->[0];
    -                            next if $configured->{$setting}++;
    -                            $$target = $v;
    -                    }
    -    @@ -371,12 +373,19 @@ sub config_regexp {
    -            my ($regex) = @_;
    -            my @ret;
    -            eval {
    -    -               @ret = Git::command(
    -    +               my $ret = Git::command(
    -                            'config',
    -    -                       '--name-only',
    -    +                       '--null',
    -                            '--get-regexp',
    -                            $regex,
    -                    );
    -    +               @ret = map {
    -    +                       # We must always return ($k, $v) here, since
    -    +                       # empty config values will be just "key\0",
    -    +                       # not "key\nvalue\0".
    -    +                       my ($k, $v) = split /\n/, $_, 2;
    -    +                       ($k, $v);
    -    +               } split /\0/, $ret;
    -                    1;
    -            } or do {
    -                    # If we have no keys we're OK, otherwise re-throw
    -    @@ -389,8 +398,10 @@ sub config_regexp {
    -     # parses 'bool' etc.) by only doing so for config keys that exist.
    -     my %known_config_keys;
    -     {
    -    -       my @known_config_keys = config_regexp("^sende?mail[.]");
    -    -       @known_config_keys{@known_config_keys} = ();
    -    +       my @kv = config_regexp("^sende?mail[.]");
    -    +       while (my ($k, $v) = splice @kv, 0, 2) {
    -    +               push @{$known_config_keys{$k}} => $v;
    -    +       }
    -     }
    -
    -     # sendemail.identity yields to --identity. We must parse this
    -
      ## git-send-email.perl ##
     @@ git-send-email.perl: sub read_config {
      		my $target = $config_bool_settings{$setting};
13:  c1d7ea664ac = 13:  d36b57e429f perl: nano-optimize by replacing Cwd::cwd() with Cwd::getcwd()
-- 
2.32.0.rc1.385.g46e826f1e55

