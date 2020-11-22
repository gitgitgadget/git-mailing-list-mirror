Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CC7C388F9
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 03:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BFC720797
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 03:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nt0Y3tdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgKVDbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 22:31:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56149 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgKVDbU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 22:31:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B266F96221;
        Sat, 21 Nov 2020 22:31:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rsmvf4bBUsJUoL8J5JDmxcutPLk=; b=Nt0Y3t
        dcpsdP7tuDJhGtWwLnDCTkJ71aI+gcauxMB2wxC8wpt209+auue2Wim+fog84QQh
        ppHH2bKA+37vGWESpmBaPGQrY+XcdbJJQaoVPgyzKpZf1/FsEuXvvTJavNoy1Nev
        nu8MGsVELcWJpMQd2pNLh9sPyTF9vrqW6EORs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=va7K6GdVSRXT2uX/fyiTBMPsIUVC4uh5
        /J+hrNlmqkMt9A/rDC/dq1kkc1YOzpB9ekDwMJjVZ44PFF1vIPO4FceNlvwZHuXs
        qDloHPZwinP6Yqk/6JX8AMtakvrY28AlkGCzqnJDYRQC4fUTCuONbeVW2TGEqqZ4
        7hoENt+sZBE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 991709621F;
        Sat, 21 Nov 2020 22:31:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C690D9621E;
        Sat, 21 Nov 2020 22:31:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/7] t1300: test "set all" mode with value_regex
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
        <2da2131114eb47e70ccaf8fb9c51bf7fb5b173b0.1605801143.git.gitgitgadget@gmail.com>
        <xmqqo8jtvvby.fsf@gitster.c.googlers.com>
        <20201120183903.GA320614@coredump.intra.peff.net>
        <20201121222734.GG389879@camp.crustytoothpaste.net>
Date:   Sat, 21 Nov 2020 19:31:14 -0800
In-Reply-To: <20201121222734.GG389879@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 21 Nov 2020 22:27:34 +0000")
Message-ID: <xmqqlfeuqd8d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CBBD3F8-2C73-11EB-9C31-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> So that got a bit off-track, but I think:
>> 
>>   - t1300 already is very much like this, so it's not a new thing
>> 
>>   - but I would be happy not to see it go further in that direction,
>>     even if it means inconsistency with the rest of the script
>
> I agree we shouldn't make things worse.

I started looking at early parts of t1300 and here is how far I
managed to get before I can no longer keep staring the existing
tests without vomitting.

I am reasonably happy with the "let's keep the vanilla untouched one
in .git/config-initial, refrain from using [core] and other sections
that MUST be in the initial configuration for testing, and use a
wrapper that reads expected addition to the initial one from the
standard input for validation" approach I came up with, but I am not
happy with the name 'compare_expect'; 'validate_config_result' might
be a better name.

In any case, the reason I am sending this out early is if people
find this approach to clean things up a sensible one.  If we can
find concensus, perhaps I (or somebody else---hint, hint) can find
time to do the #leftoverbits following the approach after the
ds/config-literal-value and ds/maintenance-part-3 topics graduate
to 'master'.



 t/t1300-config.sh | 139 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 71 insertions(+), 68 deletions(-)

diff --git c/t/t1300-config.sh w/t/t1300-config.sh
index df13afaffd..c33520d7fa 100755
--- c/t/t1300-config.sh
+++ w/t/t1300-config.sh
@@ -7,80 +7,84 @@ test_description='Test git config in different settings'
 
 . ./test-lib.sh
 
-test_expect_success 'clear default config' '
-	rm -f .git/config
+test_expect_success 'save away default config' '
+	cp .git/config .git/config-initial
 '
 
-cat > expect << EOF
-[core]
-	penguin = little blue
-EOF
-test_expect_success 'initial' '
-	git config core.penguin "little blue" &&
+compare_expect () {
+	{
+		cat .git/config-initial &&
+		sed -e 's/^[|]//'
+	} >expect &&
 	test_cmp expect .git/config
+}
+
+test_expect_success 'initial' '
+	git config configtest.penguin "little blue" &&
+	compare_expect <<-\EOF
+	[configtest]
+	|	penguin = little blue
+	EOF
 '
 
-cat > expect << EOF
-[core]
-	penguin = little blue
-	Movie = BadPhysics
-EOF
 test_expect_success 'mixed case' '
-	git config Core.Movie BadPhysics &&
-	test_cmp expect .git/config
+	git config ConfigTest.Movie BadPhysics &&
+	compare_expect <<-\EOF
+	[configtest]
+	|	penguin = little blue
+	|	Movie = BadPhysics
+	EOF
 '
 
-cat > expect << EOF
-[core]
-	penguin = little blue
-	Movie = BadPhysics
-[Cores]
-	WhatEver = Second
-EOF
 test_expect_success 'similar section' '
-	git config Cores.WhatEver Second &&
-	test_cmp expect .git/config
+	git config ConfigTests.WhatEver Second &&
+	compare_expect <<-\EOF
+	[configtest]
+	|	penguin = little blue
+	|	Movie = BadPhysics
+	[ConfigTests]
+	|	WhatEver = Second
+	EOF
 '
 
-cat > expect << EOF
-[core]
-	penguin = little blue
-	Movie = BadPhysics
-	UPPERCASE = true
-[Cores]
-	WhatEver = Second
-EOF
 test_expect_success 'uppercase section' '
-	git config CORE.UPPERCASE true &&
-	test_cmp expect .git/config
+	git config CONFIGTEST.UPPERCASE true &&
+	compare_expect <<-\EOF
+	[configtest]
+	|	penguin = little blue
+	|	Movie = BadPhysics
+	|	UPPERCASE = true
+	[ConfigTests]
+	|	WhatEver = Second
+	EOF
 '
 
 test_expect_success 'replace with non-match' '
-	git config core.penguin kingpin !blue
+	git config configtest.penguin kingpin !blue
 '
 
 test_expect_success 'replace with non-match (actually matching)' '
-	git config core.penguin "very blue" !kingpin
+	git config configtest.penguin "very blue" !kingpin
 '
 
-cat > expect << EOF
-[core]
-	penguin = very blue
-	Movie = BadPhysics
-	UPPERCASE = true
-	penguin = kingpin
-[Cores]
-	WhatEver = Second
-EOF
-
-test_expect_success 'non-match result' 'test_cmp expect .git/config'
+test_expect_success 'non-match result' '
+	compare_expect <<-\EOF
+	[configtest]
+	|	penguin = very blue
+	|	Movie = BadPhysics
+	|	UPPERCASE = true
+	|	penguin = kingpin
+	[ConfigTests]
+	|	WhatEver = Second
+	EOF
+'
 
 test_expect_success 'find mixed-case key by canonical name' '
-	test_cmp_config Second cores.whatever
+	test_cmp_config Second configtests.whatever
 '
 
 test_expect_success 'find mixed-case key by non-canonical name' '
-	test_cmp_config Second CoReS.WhAtEvEr
+	test_cmp_config Second CoNfIgTeSts.WhAtEvEr
 '
 
 test_expect_success 'subsections are not canonicalized by git-config' '
@@ -94,28 +98,27 @@ test_expect_success 'subsections are not canonicalized by git-config' '
 	test_cmp_config two section.SubSection.key
 '
 
-cat > .git/config <<\EOF
-[alpha]
-bar = foo
-[beta]
-baz = multiple \
-lines
-foo = bar
-EOF
-
 test_expect_success 'unset with cont. lines' '
-	git config --unset beta.baz
+	{
+		cat .git/config-initial &&
+		cat <<-\EOF
+		[alpha]
+		bar = foo
+		[beta]
+		baz = multiple \
+		lines
+		foo = bar
+		EOF
+	} >.git/config &&
+	git config --unset beta.baz &&
+	compare_expect <<-\EOF
+	[alpha]
+	bar = foo
+	[beta]
+	foo = bar
+	EOF
 '
 
-cat > expect <<\EOF
-[alpha]
-bar = foo
-[beta]
-foo = bar
-EOF
-
-test_expect_success 'unset with cont. lines is correct' 'test_cmp expect .git/config'
-
 cat > .git/config << EOF
 [beta] ; silly comment # another comment
 noIndent= sillyValue ; 'nother silly comment
