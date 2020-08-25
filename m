Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D2FC433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 23:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA2532075F
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 23:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="db0v2LnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgHYXWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:22:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62897 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgHYXWP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 19:22:15 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E28A8E58B6;
        Tue, 25 Aug 2020 19:22:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7C4mjlcceSiTg7MFbMscNMj9Lks=; b=db0v2L
        nVDElOK27wj7SicB0HP2f3EjdEkJA/tyU6ddFc2n43V7BaQT8aD2TwhMHk4dPUea
        Oh3prU15Jpf+R7JGa6ADhEX6tOxT9pBwCLkISSAnXNSj1TLbMDEpvwac94q/+UyV
        JMqBk7TzOSsQvrMejnDHrt8KpL5aOKnAKLEFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G8WCuAZ4A7GW71gkKmgIDiQJdEPjUQ0Q
        qOCzJa4dFbWEqxHJjvozavqdcKwhbCkn9SfrUqv/YZo/nXZtrz/0w8/hZV2gFSeZ
        MXUd3w2rRLaRFMGsO/Hy3bGzVRdDE/kXqFRer05LsPAkkhYfr4SVls3JOMFI+tlk
        J3vi8qiLpJY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DAD8FE58B5;
        Tue, 25 Aug 2020 19:22:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5D4F5E58B4;
        Tue, 25 Aug 2020 19:22:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH] pack-redundant: gauge the usage before proposing its removal
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
        <20200825022614.GA1391422@coredump.intra.peff.net>
        <xmqqtuwq1zux.fsf@gitster.c.googlers.com>
        <20200825172214.GC1414394@coredump.intra.peff.net>
        <xmqqh7sq1u0a.fsf@gitster.c.googlers.com>
        <20200825182745.GA1417288@coredump.intra.peff.net>
        <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>
        <20200825230904.GA23203@syl.lan>
Date:   Tue, 25 Aug 2020 16:22:04 -0700
In-Reply-To: <20200825230904.GA23203@syl.lan> (Taylor Blau's message of "Tue,
        25 Aug 2020 19:09:04 -0400")
Message-ID: <xmqqwo1mxqeb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA6BE5FA-E729-11EA-A4BD-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Aug 25, 2020 at 03:45:52PM -0700, Junio C Hamano wrote:
>> The subcommand is unusably slow and the reason why nobody reports it
>> as a performance bug is suspected to be the absense of users.  Let's
>> show a big message that asks the user to tell us that they still
>> care about the command when an attempt is made to run the command,
>> with an escape hatch to override it with a command line option.
>>
>> In a few releases, we may turn it into an error and keep it for a
>> few more releases before finally removing it (during the whole time,
>> the plan to remove it would be interrupted by end user raising hand).
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>
> Thanks. Peff's plan seems reasonable to me (and I'd like to add that I
> am a frequent reader of the release notes ;-)), as does this patch.
>
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks.  It needs updates to a test script, though.

diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
index 6b4d1ca353..2dd2d67b9e 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -39,6 +39,8 @@ relationship between packs and objects is as follows:
 master_repo=master.git
 shared_repo=shared.git
 
+git_pack_redundant='git pack-redundant --i-still-use-this'
+
 # Create commits in <repo> and assign each commit's oid to shell variables
 # given in the arguments (A, B, and C). E.g.:
 #
@@ -154,7 +156,7 @@ test_expect_success 'master: no redundant for pack 1, 2, 3' '
 		EOF
 	(
 		cd "$master_repo" &&
-		git pack-redundant --all >out &&
+		$git_pack_redundant --all >out &&
 		test_must_be_empty out
 	)
 '
@@ -192,7 +194,7 @@ test_expect_success 'master: one of pack-2/pack-3 is redundant' '
 		cat >expect <<-EOF &&
 			P3:$P3
 			EOF
-		git pack-redundant --all >out &&
+		$git_pack_redundant --all >out &&
 		format_packfiles <out >actual &&
 		test_cmp expect actual
 	)
@@ -231,7 +233,7 @@ test_expect_success 'master: pack 2, 4, and 6 are redundant' '
 			P4:$P4
 			P6:$P6
 			EOF
-		git pack-redundant --all >out &&
+		$git_pack_redundant --all >out &&
 		format_packfiles <out >actual &&
 		test_cmp expect actual
 	)
@@ -266,7 +268,7 @@ test_expect_success 'master: pack-8 (subset of pack-1) is also redundant' '
 			P6:$P6
 			P8:$P8
 			EOF
-		git pack-redundant --all >out &&
+		$git_pack_redundant --all >out &&
 		format_packfiles <out >actual &&
 		test_cmp expect actual
 	)
@@ -284,9 +286,9 @@ test_expect_success 'master: clean loose objects' '
 test_expect_success 'master: remove redundant packs and pass fsck' '
 	(
 		cd "$master_repo" &&
-		git pack-redundant --all | xargs rm &&
+		$git_pack_redundant --all | xargs rm &&
 		git fsck &&
-		git pack-redundant --all >out &&
+		$git_pack_redundant --all >out &&
 		test_must_be_empty out
 	)
 '
@@ -304,7 +306,7 @@ test_expect_success 'setup shared.git' '
 test_expect_success 'shared: all packs are redundant, but no output without --alt-odb' '
 	(
 		cd "$shared_repo" &&
-		git pack-redundant --all >out &&
+		$git_pack_redundant --all >out &&
 		test_must_be_empty out
 	)
 '
@@ -343,7 +345,7 @@ test_expect_success 'shared: show redundant packs in stderr for verbose mode' '
 			P5:$P5
 			P7:$P7
 			EOF
-		git pack-redundant --all --verbose >out 2>out.err &&
+		$git_pack_redundant --all --verbose >out 2>out.err &&
 		test_must_be_empty out &&
 		grep "pack$" out.err | format_packfiles >actual &&
 		test_cmp expect actual
@@ -356,9 +358,9 @@ test_expect_success 'shared: remove redundant packs, no packs left' '
 		cat >expect <<-EOF &&
 			fatal: Zero packs found!
 			EOF
-		git pack-redundant --all --alt-odb | xargs rm &&
+		$git_pack_redundant --all --alt-odb | xargs rm &&
 		git fsck &&
-		test_must_fail git pack-redundant --all --alt-odb >actual 2>&1 &&
+		test_must_fail $git_pack_redundant --all --alt-odb >actual 2>&1 &&
 		test_cmp expect actual
 	)
 '
@@ -386,7 +388,7 @@ test_expect_success 'shared: create new objects and packs' '
 test_expect_success 'shared: no redundant without --alt-odb' '
 	(
 		cd "$shared_repo" &&
-		git pack-redundant --all >out &&
+		$git_pack_redundant --all >out &&
 		test_must_be_empty out
 	)
 '
@@ -417,7 +419,7 @@ test_expect_success 'shared: no redundant without --alt-odb' '
 test_expect_success 'shared: one pack is redundant with --alt-odb' '
 	(
 		cd "$shared_repo" &&
-		git pack-redundant --all --alt-odb >out &&
+		$git_pack_redundant --all --alt-odb >out &&
 		format_packfiles <out >actual &&
 		test_line_count = 1 actual
 	)
@@ -454,7 +456,7 @@ test_expect_success 'shared: ignore unique objects and all two packs are redunda
 			Px1:$Px1
 			Px2:$Px2
 			EOF
-		git pack-redundant --all --alt-odb >out <<-EOF &&
+		$git_pack_redundant --all --alt-odb >out <<-EOF &&
 			$X
 			$Y
 			$Z
