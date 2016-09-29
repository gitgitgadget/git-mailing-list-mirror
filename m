Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A09620987
	for <e@80x24.org>; Thu, 29 Sep 2016 19:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932929AbcI2TGU (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 15:06:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55048 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932684AbcI2TGT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 15:06:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 178824283B;
        Thu, 29 Sep 2016 15:06:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kcK9fpiMoLzjAmM8PRvp0c/e3wY=; b=DmFIP4
        6VC1rG+Z5x0ZXHAHdgdyztnzT6q2MPhZfYobz36ddPkHjdb4N6yumMF1Z+A0Ihf8
        W4B0jkaWxK7pyYN3VQSvwUOaNC9STLUzcoeiRvx8vrvUIT/qgJUrNBqt8ubAsGUh
        PPbEEnJ4HMkWhe4Lr//WZa2DOdMi5jjzgmp8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eFd/N6exHTtRvAfkM/yXfBIB4mCrBuFn
        fmYZnBq/Y/g4oBM5opaTXY3rfeTMMq8PB59y5of7ldZc3Jlvg6W9PC2JjqPYW0R+
        wStrIeiYW3jnRseT4RjZOCfFnE4Hql1Fkcdl6Humq3bTEzXBaAi3VSJpqY+UCZA7
        +Mi5/SPs/F8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EFC04283A;
        Thu, 29 Sep 2016 15:06:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 87FFD42839;
        Thu, 29 Sep 2016 15:06:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 2/4] t13xx: do not assume system config is empty
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
        <20160928233047.14313-1-gitster@pobox.com>
        <20160928233047.14313-3-gitster@pobox.com>
        <20160929090108.hf2jzfcvbcsfaxw7@sigill.intra.peff.net>
        <xmqqintefuau.fsf@gitster.mtv.corp.google.com>
        <20160929182621.lobihscwl7amtu7s@sigill.intra.peff.net>
Date:   Thu, 29 Sep 2016 12:06:15 -0700
In-Reply-To: <20160929182621.lobihscwl7amtu7s@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 29 Sep 2016 14:26:21 -0400")
Message-ID: <xmqq60pefrvc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CCBF33BE-8677-11E6-A878-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Sep 29, 2016 at 11:13:45AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > I think anytime you would use GIT_CONFIG_NOSYSTEM over --local, it is an
>> > indication that the test is trying to check how multiple sources
>> > interact. And the right thing to do for them is to set GIT_ETC_GITCONFIG
>> > to some known quantity. We just couldn't do that before, so we skipped
>> > it.  IOW, something like the patch below (on top of yours).
>> 
>> OK, that way we can make sure that "multiple sources" operations do
>> look at the system-wide stuff.
>
> Exactly.

I think it deserves a separate patch and the result is more
understandable.  I've queued this for now (on top of a revised 1/4
that uses GIT_CONFIG_SYSTEM_PATH instead).

-- >8 --
From: Jeff King <peff@peff.net>
Date: Thu, 29 Sep 2016 11:29:10 -0700
Subject: [PATCH] t1300: check also system-wide configuration file in
 --show-origin tests

Because we used to run our tests with GIT_CONFIG_NOSYSTEM, these did
not test that the system-wide configuration file is also read and
shown as one of the origins.  Create a custom/fake system-wide
configuration file and make sure it appears in the output, using the
newly introduced GIT_CONFIG_SYSTEM_PATH mechanism.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1300-repo-config.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 0543b62227bf..aa25577709c5 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1236,6 +1236,11 @@ test_expect_success 'set up --show-origin tests' '
 		[user]
 			relative = include
 	EOF
+	cat >"$HOME"/etc-gitconfig <<-\EOF &&
+		[user]
+			system = true
+			override = system
+	EOF
 	cat >"$HOME"/.gitconfig <<-EOF &&
 		[user]
 			global = true
@@ -1254,6 +1259,8 @@ test_expect_success 'set up --show-origin tests' '
 
 test_expect_success '--show-origin with --list' '
 	cat >expect <<-EOF &&
+		file:$HOME/etc-gitconfig	user.system=true
+		file:$HOME/etc-gitconfig	user.override=system
 		file:$HOME/.gitconfig	user.global=true
 		file:$HOME/.gitconfig	user.override=global
 		file:$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include
@@ -1264,13 +1271,16 @@ test_expect_success '--show-origin with --list' '
 		file:.git/../include/relative.include	user.relative=include
 		command line:	user.cmdline=true
 	EOF
+	GIT_CONFIG_SYSTEM_PATH=$HOME/etc-gitconfig \
 	git -c user.cmdline=true config --list --show-origin >output &&
 	test_cmp expect output
 '
 
 test_expect_success '--show-origin with --list --null' '
 	cat >expect <<-EOF &&
-		file:$HOME/.gitconfigQuser.global
+		file:$HOME/etc-gitconfigQuser.system
+		trueQfile:$HOME/etc-gitconfigQuser.override
+		systemQfile:$HOME/.gitconfigQuser.global
 		trueQfile:$HOME/.gitconfigQuser.override
 		globalQfile:$HOME/.gitconfigQinclude.path
 		$INCLUDE_DIR/absolute.includeQfile:$INCLUDE_DIR/absolute.includeQuser.absolute
@@ -1281,6 +1291,7 @@ test_expect_success '--show-origin with --list --null' '
 		includeQcommand line:Quser.cmdline
 		trueQ
 	EOF
+	GIT_CONFIG_SYSTEM_PATH=$HOME/etc-gitconfig \
 	git -c user.cmdline=true config --null --list --show-origin >output.raw &&
 	nul_to_q <output.raw >output &&
 	# The here-doc above adds a newline that the --null output would not
@@ -1304,6 +1315,7 @@ test_expect_success '--show-origin with --get-regexp' '
 		file:$HOME/.gitconfig	user.global true
 		file:.git/config	user.local true
 	EOF
+	GIT_CONFIG_SYSTEM_PATH=$HOME/etc-gitconfig \
 	git config --show-origin --get-regexp "user\.[g|l].*" >output &&
 	test_cmp expect output
 '
@@ -1312,6 +1324,7 @@ test_expect_success '--show-origin getting a single key' '
 	cat >expect <<-\EOF &&
 		file:.git/config	local
 	EOF
+	GIT_CONFIG_SYSTEM_PATH=$HOME/etc-gitconfig \
 	git config --show-origin user.override >output &&
 	test_cmp expect output
 '
-- 
2.10.0-589-g5adf4e1

