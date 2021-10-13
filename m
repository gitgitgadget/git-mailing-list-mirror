Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E99CC433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 10:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3725A60E09
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 10:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbhJMK0y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 06:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239375AbhJMK0v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 06:26:51 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BDEC061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 03:24:48 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y12so8162717eda.4
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 03:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Gl3FS2E4jzSp6AlUIOiUdM91++JaZhYNFu4goxBwwdM=;
        b=cFa2TiGIjTC0k7/gqFFeB7a6JZUm6x6D0d7SycNhkXJTZTBAYpOE0TYQ7RFKyr00c3
         DscH6N7fwP/QSsmHpbYvctQQvNV6KPy60oLqzzNiDJ1yOlU0EFlL7WOp8QxFYi/1Bv2s
         oQopVOpMh4Y/+XFOp7orYQIkK5NDPw8C965jvRjlhwdNNtpobHzIZRZ0YdTAbyOV5xn7
         kACFLZs4H2MIU0lcFFxO5gN+BJb1Z45Fa3nZUxf5ZSZpqfPQuvyivL+MgGAQ+56InkRm
         dKuK3TkHd/O5IAPwTRWBc5210Xg3fEVuBp/cLdK8oYTJSYpoTT5KctoOH1oLUwNMx9oD
         HHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Gl3FS2E4jzSp6AlUIOiUdM91++JaZhYNFu4goxBwwdM=;
        b=YBLoM6vQh3GGTtOWwY3mOLC3xJjqa6NCe8EchgCSreD9KjmpEwRNJ1mn+VV2BogSGR
         JsweqsBrUXE3SBPrzOlZz/CO9bpo//i/w3gCfCFP05cCuTjreYTmqfFOjQOp6uV9eiQ5
         ZuCCaWPcexukeeAN1VJcEGW9gxkS8irXpfKDn7bpFGNdLBCizAoWmAuj5L2ZcaOwy94s
         qEm9QEYrAa9vFeCCQoeqZCpdmxo3vTeYrMXI0rAcYySHNWub8l5ssDIS5NkKTzocD3ud
         pYtYzI1UEuW53pvBHXAKzAv7NGh2rmuSxBPTbO4iaU2899/csPCC3wJfjrsYNpQSy4yA
         mWwQ==
X-Gm-Message-State: AOAM531QsHffcPyI7ax2G/flFyB185cnyjX+E/g1iwD4xG6gQcDEZl11
        l4nYb5EquH+OAmM/vGF0U/4=
X-Google-Smtp-Source: ABdhPJyXi6l4G6UNBKRvnHqkXqYG7e+K0YNwN0l5Y91+odBmfdw0A43VaZvHn5khkTXp43phAjaOpA==
X-Received: by 2002:a50:cf0d:: with SMTP id c13mr8177756edk.269.1634120686578;
        Wed, 13 Oct 2021 03:24:46 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y8sm6419559ejm.104.2021.10.13.03.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 03:24:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, David Turner <novalis@novalis.org>,
        Elijah Newren <newren@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: test-lib.sh musings: test_expect_failure considered harmful
Date:   Wed, 13 Oct 2021 12:10:43 +0200
References: <87tuhmk19c.fsf@evledraar.gmail.com> <xmqq4k9m6vkw.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqq4k9m6vkw.fsf@gitster.g>
Message-ID: <87o87ti5n6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 12 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Mon, Oct 11 2021, Junio C Hamano wrote:
> [...]
>> Presumably with test_expect_failure.
>>
>> I'll change it, in this case we'd end up with a test_expect_success at
>> the end, so it doesn't matter much & I don't care.
>
> I do agree with you that compared to expect_success, which requires
> _all_ steps to succeed, so an failure in any of its steps is
> immediately noticeable, it is harder to write and keep
> expect_failure useful, because it is not like we are happy to see
> any failure in any step.  We do not expect a failure in many
> preparation and conclusion steps in the &&-chain in expect_failure
> block, and we consider it is an error if these steps fail.  We only
> want to mark only a single step to exhibit an expected but undesirable
> behaviour.
>
> But even with the shortcomings of expect_failure, it still is much
> better than claiming that we expect a bogus outcome.
>
> Improving the shortcomings of expect_failure would be a much better
> use of our time than advocating an abuse of expect_sucess, I would
> think.

I'd like to improve it, but I'll have to get any patch in this are past
you :)

My reading of your opinion from past exchanges is that you find it
objectionable to say "this is a success" when it's not the /desired/
behavior, whereas I think it's valuable to just test for and document
the exact existing behavior, even if it's not desirable. So you don't
really need a function different from test_expect_success, just a
comment saying "this should change", or add a ("non-hash so it's not TAP
syntax") "TODO" to the description of the test.

But if you agree that we shouldn't conflate failures in the different
steps I think we're getting somewhere, so to begin with what do you
think about the hack in the v2 of my series?
https://lore.kernel.org/git/cover-v2-0.2-00000000000-20211012T142950Z-avara=
b@gmail.com/

If we were to prompote those semantics to something that
test_expect_failure would use it would be the below, which I think is
the only sensible way to use it.

But that would mean changing all existing test_expect_failure uses in
the test suite, so it would need either a pretty large patch, or some
incremental steps to get there:

But it will mean we can't use it for any test that's actually flaky, so
we'll need a test_expect_flaky, or have some test-specific workarounds
in those areas.

diff --git a/t/t7815-grep-binary.sh b/t/t7815-grep-binary.sh
index 90ebb64f46e..9a95c9e7d69 100755
--- a/t/t7815-grep-binary.sh
+++ b/t/t7815-grep-binary.sh
@@ -64,7 +64,7 @@ test_expect_success 'git grep ile a' '
 '
=20
 test_expect_failure 'git grep .fi a' '
-	git grep .fi a
+	test_must_fail git grep .fi a
 '
=20
 test_expect_success 'grep respects binary diff attribute' '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8361b5c1c57..6d9291b7ead 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -728,8 +728,8 @@ test_known_broken_ok_ () {
 	then
 		write_junit_xml_testcase "$* (breakage fixed)"
 	fi
-	test_fixed=3D$(($test_fixed+1))
-	say_color error "ok $test_count - $@ # TODO known breakage vanished"
+	test_broken=3D$(($test_broken+1))
+	say_color warn "not ok $test_count - $@ # TODO known breakage"
 }
=20
 test_known_broken_failure_ () {
@@ -737,8 +737,8 @@ test_known_broken_failure_ () {
 	then
 		write_junit_xml_testcase "$* (known breakage)"
 	fi
-	test_broken=3D$(($test_broken+1))
-	say_color warn "not ok $test_count - $@ # TODO known breakage"
+	test_fixed=3D$(($test_fixed+1))
+	say_color error "not ok $test_count - $@ # TODO a 'known breakage' change=
d behavior!"
 }
=20
 test_debug () {
