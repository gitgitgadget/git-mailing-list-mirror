Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,LONGWORDS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FCFC433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 07:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E676D60EFD
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 07:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbhIFHei (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 03:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239999AbhIFHeh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 03:34:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51205C061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 00:33:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b10so8391192wru.0
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 00:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lLx1YW2j3H2BX4UaZVyA7/VZsv/gxoclGW16NDZpQX8=;
        b=W9id08DuORP6hJD5PR6UtdHGP8fY520NSFbgrGwcubvM8GWFgyfMEOW+X0O31vDAcE
         Cs6JpslowYSBqQHzUT1rKL7A5HxhAUvhmZHVUSVU2LcFZHJEpOUGfaGmYIHYsNhJzHpp
         ECnTbIwb8kx2glFez+u4cBwfpuK188rZJJHb4EW2Jd0xQGSZzV2alSH9V+R00+n8zDQp
         8nlUYBW8LY1kTzQHWw0ZKYuF4tf7di3oW5+Vf05yHxFcDn4d1dkWlrn7qPB9vQmihowh
         6v2WcC7ZdXjkYhKGumUEJmShv/PYTF3LqBVKg60c2mtu7FEojXbERpmYMXS/ReD2SpGY
         l7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLx1YW2j3H2BX4UaZVyA7/VZsv/gxoclGW16NDZpQX8=;
        b=GV1UMUNtKRRhocpX5OH1mmSrRaKjeKUDY6d7NQL0R2rJMGoJYad8Ooz/ffae+/SL16
         j7675fIA4U1sfc5lGBKy0fCRwq/S59emRSmF3bUuyxiaTemjamqnERWsTvPmpEtVIF1C
         cxTXg8V1ACm+qmZT+nfp2pAIOjrXNBJo6UwHOSFw2QUrnDEyPQXST8Um2obmlLYAlJR7
         Ysdl739xAlx3Nhqmr5jgQ7gKIyKgyYXV44LrJuS7ya8HbOBE/kVrD6hl/4BGtDoABXV1
         RQbRhaVjYDLaCjFdTzXyxloOcY32E51G2hbdI43ki1fydqJUgzuL6miX3LHlGXXbfnRN
         vMMA==
X-Gm-Message-State: AOAM530v07uEshR1bdUYYOMDHmZzcrvCtzOQoKYKkzG88D4ReFCqCSLm
        KE7cEZfTTD4Zf6kAs/MRI2EEpNd/kY8ssw==
X-Google-Smtp-Source: ABdhPJzEgiBZL1jYR2ifhk99BG4hcsEyCbb4jz9Ul1XosgNJvahmRPpTtUDD+W0Gvy44XWhytj8ZLg==
X-Received: by 2002:adf:b60f:: with SMTP id f15mr6079479wre.257.1630913611613;
        Mon, 06 Sep 2021 00:33:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t14sm7081865wrw.59.2021.09.06.00.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 00:33:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eli Schwartz <eschwartz@archlinux.org>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] send-email: fix a "first config key wins" regression in v2.33.0
Date:   Mon,  6 Sep 2021 09:33:29 +0200
Message-Id: <patch-1.1-ae6ff9f77f1-20210906T073306Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.821.gfd4106eadbd
In-Reply-To: <96814e5e-54be-1eca-0d75-68be53b1be3d@archlinux.org>
References: <96814e5e-54be-1eca-0d75-68be53b1be3d@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression in my c95e3a3f0b8 (send-email: move trivial config
handling to Perl, 2021-05-28) where we'd pick the first config key out
of multiple defined ones, instead of using the normal "last key wins"
semantics of "git config --get".

This broke e.g. cases where a .git/config would have a different
sendemail.smtpServer than ~/.gitconfig. We'd pick the ~/.gitconfig
over .git/config, instead of preferring the repository-local
version. The same would go for /etc/gitconfig etc.

The full list of impacted config keys (the %config_settings values
which are references to scalars, not arrays) is:

    sendemail.smtpencryption
    sendemail.smtpserver
    sendemail.smtpserverport
    sendemail.smtpuser
    sendemail.smtppass
    sendemail.smtpdomain
    sendemail.smtpauth
    sendemail.smtpbatchsize
    sendemail.smtprelogindelay
    sendemail.tocmd
    sendemail.cccmd
    sendemail.aliasfiletype
    sendemail.envelopesender
    sendemail.confirm
    sendemail.from
    sendemail.assume8bitencoding
    sendemail.composeencoding
    sendemail.transferencoding
    sendemail.sendmailcmd

I.e. having any of these set in say ~/.gitconfig and in-repo
.git/config regressed in v2.33.0 to prefer the --global one over the
--local.

To test this add a test of config priority to one of these config
variables, most don't have tests at all, but there was an existing one
for sendemail.8bitEncoding.

The "git config" (instead of "test_config") is somewhat of an
anti-pattern, but follows established conventions in
t9001-send-email.sh, likewise with any other pattern or idiom in this
test.

The populating of home/.gitconfig and setting of HOME= is copied from
a test in t0017-env-helper.sh added in 1ff750b128e (tests: make
GIT_TEST_GETTEXT_POISON a boolean, 2019-06-21). This test fails
without this bugfix, but not works.

Reported-by: Eli Schwartz <eschwartz@archlinux.org>
Tested-by: Eli Schwartz <eschwartz@archlinux.org>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Sun, Sep 05 2021, Eli Schwartz wrote:

> [[PGP Signed Part:Undecided]]
> On 9/5/21 8:04 PM, Ævar Arnfjörð Bjarmason wrote:
>> 
>> On Sun, Sep 05 2021, Eli Schwartz wrote:
>> 
>>> I recently noticed that git send-email was attempting to send emails
>>> using the wrong email address. I have a global email configuration in
>>> XDG_CONFIG_HOME, and a specific one set in the {repo}/.git/config of
>>> some repos... this was trying to use the global configuration.
>>>
>>> `git config -l | grep ^sendemail.smtpserver=` reports two emails

[...]

>>> `git config --get sendemail.smtpserver` reports only the second,
>>> repo-specific one
>>>
>>>
>>> I bisected the issue to commit c95e3a3f0b8107b5dc7eac9dfdb9e5238280c9fb
>>>
>>>     send-email: move trivial config handling to Perl
>>>
>>>
>>> Using this commit, git-send-email disagrees with git config --get on
>>> which email to use.
>>>
>>> Using commit f4dc9432fd287bde9100488943baf3c6a04d90d1 immediately
>>> preceding this commit, git send-email agrees with git config --get.
>> 
>> That's a pretty bad bug, sorry about that. I believe that the following
>> patch should fix it (needs tests obviously). I.e. when we had N config
>> keys we'd previously pick the normal "last key wins", which my
>> c95e3a3f0b8107b5dc7eac9dfdb9e5238280c9fb changed to "first wins":
>> 
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index e65d969d0bb..6c7ab3d2e91 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -376,7 +376,7 @@ sub read_config {
>>  			@$target = @values;
>>  		}
>>  		else {
>> -			my $v = $known_keys->{$key}->[0];
>> +			my $v = $known_keys->{$key}->[-1];
>>  			next unless defined $v;
>>  			next if $configured->{$setting}++;
>>  			$$target = $v;
>> 
>
>
>
> Thanks, this worked for me and fixed my problem! Feel free to add my
> tested-by.

Added, and here's a properly formatted patch with a regression test.

 git-send-email.perl   |  2 +-
 t/t9001-send-email.sh | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e65d969d0bb..6c7ab3d2e91 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -376,7 +376,7 @@ sub read_config {
 			@$target = @values;
 		}
 		else {
-			my $v = $known_keys->{$key}->[0];
+			my $v = $known_keys->{$key}->[-1];
 			next unless defined $v;
 			next if $configured->{$setting}++;
 			$$target = $v;
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 57fc10e7f82..eae172e0a05 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1533,6 +1533,21 @@ test_expect_success $PREREQ 'sendemail.8bitEncoding works' '
 	test_cmp content-type-decl actual
 '
 
+test_expect_success $PREREQ 'sendemail.8bitEncoding in .git/config overrides --global .gitconfig' '
+	clean_fake_sendmail &&
+	git config sendemail.assume8bitEncoding UTF-8 &&
+	test_when_finished "rm -rf home" &&
+	mkdir home &&
+	git config -f home/.gitconfig sendemail.assume8bitEncoding "bogus too" &&
+	echo bogus |
+	env HOME="$(pwd)/home" DEBUG=1 \
+	git send-email --from=author@example.com --to=nobody@example.com \
+			--smtp-server="$(pwd)/fake.sendmail" \
+			email-using-8bit >stdout &&
+	egrep "Content|MIME" msgtxt1 >actual &&
+	test_cmp content-type-decl actual
+'
+
 test_expect_success $PREREQ '--8bit-encoding overrides sendemail.8bitEncoding' '
 	clean_fake_sendmail &&
 	git config sendemail.assume8bitEncoding "bogus too" &&
-- 
2.33.0.821.gfd4106eadbd

