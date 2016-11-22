Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF8031FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 21:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755871AbcKVV4S (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 16:56:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60995 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751433AbcKVVzq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 16:55:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E26E5150F;
        Tue, 22 Nov 2016 16:55:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NVnPjiDjjQCLa3eEpS8U+LG4T+Y=; b=eiiu+v
        X95B9HYaXXpIgkjEKl+USzB3vtje/UjQwFMwk6KiCxx0fH936YoKJxNoZROMwwr1
        Sa+/lwNib3n01dtESuldirvd+wIPqgWg0xzwwVeQEhCfEM8yiGAtVJw4Z7QXkby9
        ZZ5cSv9RLMnp5rIsBxsvdefLMWjrxWhY+R7Wg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uewff9SKmmKPkObyHtGhPP03mHsM8py3
        ZpbwHQSMjKTjw315Fx4g3OXA25PNSvrBWaeK+3Z3NCINZ4vMWF6VaDK/Yb5BBNEA
        dTgohJB4dqmmvadET8mg7UloaDayLfZbNhDSfERJxvEaZCW10XlxL+G0DZkJmzGX
        r+eS/9oPiUw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 330A75150D;
        Tue, 22 Nov 2016 16:55:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 79E7C51509;
        Tue, 22 Nov 2016 16:55:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Taufiq Hoven <taufiq.hoven@gmail.com>
Subject: Re: [PATCH 2/3] stripspace: respect repository config
References: <cover.1479737858.git.johannes.schindelin@gmx.de>
        <5567548295222401fab10d3f2901c1787afbfd07.1479737858.git.johannes.schindelin@gmx.de>
        <CACsJy8D5oBR+vo2B+Ro2Q4SX0CG3jME4Gfs1_6AohccmpNvD0A@mail.gmail.com>
        <alpine.DEB.2.20.1611221712480.3746@virtualbox>
        <xmqqshqjqw3z.fsf@gitster.mtv.corp.google.com>
        <xmqqzikrpbz2.fsf@gitster.mtv.corp.google.com>
        <20161122195015.rztaixpz7zvdxb4u@sigill.intra.peff.net>
        <xmqqoa17p8k0.fsf@gitster.mtv.corp.google.com>
        <20161122211920.3qdohxdktykqhyga@sigill.intra.peff.net>
        <xmqqeg23p5v3.fsf@gitster.mtv.corp.google.com>
        <20161122214305.yrn4uqh4dzzafkd2@sigill.intra.peff.net>
Date:   Tue, 22 Nov 2016 13:55:07 -0800
In-Reply-To: <20161122214305.yrn4uqh4dzzafkd2@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 22 Nov 2016 16:43:06 -0500")
Message-ID: <xmqq7f7vp4ck.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 559ADE80-B0FE-11E6-ABDA-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +test_expect_success 'mailinfo with mailinfo.scissors config' '
>> +	test_config mailinfo.scissors true &&
>> +	(
>> +		mkdir sub &&
>> +		cd sub &&
>> +		git mailinfo ../msg0014.sc ../patch0014.sc <../0014 >../info0014.sc
>> +	) &&
>> +	test_cmp "$DATA/msg0014--scissors" msg0014.sc &&
>> +	test_cmp "$DATA/patch0014--scissors" patch0014.sc &&
>> +	test_cmp "$DATA/info0014--scissors" info0014.sc
>> +'
>
> And this test makes sense. Even without "sub", it would show the
> regression, but it's a good idea to test the sub-directory case to cover
> the path-munging.

Yup.  Obviously during my initial attempt I was scratching my head
wondering where these two files went--they were later found inside
t/ directory which was really bad ;-)

> In the "archive --remote" test I added, we may want to do the same to
> show that "--output" points at the correct path.

Perhaps something like this.  By going down one level, we make sure
that it is not sufficient to accidentally read from .git/config to
find out what 'foo' is, and also ../b5-nick.tar that is relative to
the prefix (aka 'a/') ends up at the top-level.

 t/t5000-tar-tree.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 09df7f0458..830bf2a2f6 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -195,7 +195,10 @@ test_expect_success 'git archive --remote' \
 
 test_expect_success 'git archive --remote with configured remote' '
 	git config remote.foo.url . &&
-	git archive --remote=foo HEAD >b5-nick.tar &&
+	(
+		cd a &&
+		git archive --remote=foo --output=../b5-nick.tar HEAD
+	) &&
 	test_cmp_bin b.tar b5-nick.tar
 '
 
