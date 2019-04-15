Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69EC420248
	for <e@80x24.org>; Mon, 15 Apr 2019 04:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbfDOEsf (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 00:48:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38638 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfDOEsf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 00:48:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so18446959wmc.3
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 21:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=hFJugTf1BumDzy65hIu8k2946u8onMspStEuk9Ge71U=;
        b=aq69PG/NAUere/w/8hMQxchw/Q2AslpsWG8IJGZ3ajBy0e6mvriBzchAEgPjMT5CfZ
         0J7CjCool/8Bz4yjItgzlcyrngQvYBxY+wPnyguZAoHtQUu1QxaOQel1KpbA4BCITEPS
         M7UTq2Y9tchf5zI3BfuRDeiMEyAWTCipNZkp3mVNu5vG4PXGwQeXPlR0ztEWlOwbYT2V
         Vn44nqvrnw1T7rsVL444TwSwEvNrxLGkCVjqhAiHEf2as053dXQVNHNuGUqW7OZwanm2
         zmWXKDwCU9/ZqnD1NBuJIZ76gSt3V3ozBWKhOOIOqe2y9ftL4Q0dFNx6sln/55K+fE1s
         9T5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=hFJugTf1BumDzy65hIu8k2946u8onMspStEuk9Ge71U=;
        b=qVbTVuACc6nZ6k0zrzdDS9oEeZ8aLwDaH4Qp4p6JGkseyFSpQDrPwCN9LxDKT9e4bG
         C3CH19Pdscv0FZv7C6wNGoxlXS/+0GA4ePMxnAKjwFYI8JiOIW7LXIgKZLG5N1kW8oN5
         K0944+ubXpALxa0gti7OVAj4r/uKZQ2n0Q+MGLPeVBkooTQxzglHj8TU8XCbJ8fmHtx6
         ggsye/wbJEIdpbrUQAFU+mEaBl9y2FJgNzD8ooM4C6qsdqa5itJLVwvzGzCaRE/LYuXQ
         JlerU4WglumYGVExKgZ53CJGP4SpUHul2JTLHAt9dIM9P/SwRY5NdDw/yfC26fgAT4nh
         pdoA==
X-Gm-Message-State: APjAAAW4maSX73GIQaRF5rZPwbdHZ9HGEqomV3eWMKgVo6H49p5YfrI0
        Wvf2cXTtIE125I2PjrmGXgRAMq1tXqQ=
X-Google-Smtp-Source: APXvYqwbd+q0re9X61lLwqOrkQc55Jp40lN4Mv/HmtZLaxoDdYj6GS9QmPP16dqQVfA1pkQcf/tfag==
X-Received: by 2002:a1c:e085:: with SMTP id x127mr19791859wmg.87.1555303712904;
        Sun, 14 Apr 2019 21:48:32 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 4sm15181149wmi.14.2019.04.14.21.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 21:48:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re* [PATCH v4 1/2] transport: die if server options are unsupported
References: <20190405204413.93900-1-jonathantanmy@google.com>
        <cover.1555098572.git.jonathantanmy@google.com>
        <598b2de0162e240521f04d40d41eb11843be7198.1555098572.git.jonathantanmy@google.com>
        <20190412201228.GA15936@szeder.dev>
Date:   Mon, 15 Apr 2019 13:48:31 +0900
In-Reply-To: <20190412201228.GA15936@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Fri, 12 Apr 2019 22:12:28 +0200")
Message-ID: <xmqqlg0bvppc.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> ... therefore these should be 'test_i18ngrep'.  This applies to the
> other tests in this patch series as well.
> ...

Hmph.  That would mean the following is needed, but I suspect that
6cdccfce ("i18n: make GETTEXT_POISON a runtime option", 2018-11-08)
is somewhat broken (see the bottom for a suggested fix).

 t/t5702-protocol-v2.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 1e8357a4c7..f8912211e0 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -186,8 +186,8 @@ test_expect_success 'warn if using server-option with ls-remote with legacy prot
 	test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 git -c protocol.version=0 \
 		ls-remote -o hello -o world "file://$(pwd)/file_parent" master 2>err &&
 
-	grep "see protocol.version in" err &&
-	grep "server options require protocol version 2 or later" err
+	test_i18ngrep "see protocol.version in" err &&
+	test_i18ngrep "server options require protocol version 2 or later" err
 '
 
 test_expect_success 'clone with file:// using protocol v2' '
@@ -266,8 +266,8 @@ test_expect_success 'warn if using server-option with fetch with legacy protocol
 	test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 git -C temp_child -c protocol.version=0 \
 		fetch -o hello -o world "file://$(pwd)/file_parent" master 2>err &&
 
-	grep "see protocol.version in" err &&
-	grep "server options require protocol version 2 or later" err
+	test_i18ngrep "see protocol.version in" err &&
+	test_i18ngrep "server options require protocol version 2 or later" err
 '
 
 test_expect_success 'upload-pack respects config using protocol v2' '


-- >8 --
Subject: [PATCH] gettext tests: export the restored GIT_TEST_GETTEXT_POISON

6cdccfce ("i18n: make GETTEXT_POISON a runtime option", 2018-11-08)
made the gettext-poison test a runtime option (which was a good
move) and adjusted the test framework so that Git commands we run as
part of the framework, as opposed to the ones that are part of the
test proper, are not affected by the setting.  The original value
for the GIT_TEST_GETTEXT_POISON environment variable is saved away
in another variable and gets unset, and then later the saved value
is restored to the environment variable.

But the code forgot to export the variable again, which is necessary
to restore the "export" bit that was lost when the variable was unset.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8665b0a9b6..078efda9da 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1394,6 +1394,7 @@ test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 if test -n "$GIT_TEST_GETTEXT_POISON_ORIG"
 then
 	GIT_TEST_GETTEXT_POISON=$GIT_TEST_GETTEXT_POISON_ORIG
+	export GIT_TEST_GETTEXT_POISON
 	unset GIT_TEST_GETTEXT_POISON_ORIG
 fi
 
-- 
2.21.0-313-ge35b8cb8e2

