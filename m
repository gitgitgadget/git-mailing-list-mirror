Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E55C54EE9
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 06:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbiIBGkO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 02:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbiIBGkI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 02:40:08 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50A21409A
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 23:40:06 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id k22so1304865ljg.2
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 23:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=sBxGKVnRtA3dfKDEgCItllTuhqGYdkjnZ8/u5jIA148=;
        b=UuH1vs02jPOFPsqTual31sl8zpzOTSgIaANdXbYfnQhrVrp42rVvGvV6GePfyZmVF3
         g6VSc3IALKEsmYpPvskl4DshTx5ZQYq/o8kMEAbK80wFc69DqF0bdXjqJeowzATT8lp7
         DjLbKDsFMaj+4r6W/rtl97k8yIoNMpkOeRE6GHujnXyv6J0jOQ6z980qGwRHe4A27JCT
         ZwNNZ/6rPLp+WjzJ3FpUPFQOPQKK/SdNvmA3Pc+TEhvdhPCQ1B5GavCmcg1GXGBzLzzt
         vjNm6acxV+IbWmThZF+lNNYSjFEmd9REQLdbbmUrF3nj9fIGN0aOpteeg9Z8glUB7UaH
         gKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sBxGKVnRtA3dfKDEgCItllTuhqGYdkjnZ8/u5jIA148=;
        b=nxnw1tqo6B9ZWobU9zvQSjk1tVn3N9i+uN5zSgLkpJg9KepblsARdehAxVM+JzeECm
         Udb+miFU92/8yIDF6VWFMcKX9itC04zc/W/U0VoCbkGLMr1aOwQ832OhSNHSzLnGB38F
         /o25xwYv3tF0pdjglzehckUhe18j6O8QvO86O1Q1TbtZQYpQrwuTJ8gg2K1WNiIXNXqp
         ARuEMDDDFrngyiZB8+9JGIVzwkxdJhcXEC+xDhuP1L/j/CjUNkUhHZtSThrqn0rbSar3
         HO3itOM8OkIMcd1Yu4wJZXKmGp4WpfmXBg5O4IHsMntpKsRLErbYgRX0eoCXiIb0VxX5
         3gag==
X-Gm-Message-State: ACgBeo0IZGSrNvPNnh/8nsTLKgiiHlWY6yWJO8YsZOlp9SwOf3Am+STo
        7cy9N3Ouy3GR2TJWU9lGmBw=
X-Google-Smtp-Source: AA6agR4+AjGMjmTLxxsLOgK9cMJZZkDb0YYaNb/7fliHTSM9Wv0b30iCjcwcYJwOADxYNt0/ekeRCA==
X-Received: by 2002:a2e:a989:0:b0:261:b21c:7b29 with SMTP id x9-20020a2ea989000000b00261b21c7b29mr10889374ljq.128.1662100804832;
        Thu, 01 Sep 2022 23:40:04 -0700 (PDT)
Received: from paasan.lan (150.37-191-137.fiber.lynet.no. [37.191.137.150])
        by smtp.gmail.com with ESMTPSA id a25-20020ac25e79000000b0048a82fec50esm137308lfr.305.2022.09.01.23.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 23:40:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, ingy@ingy.net,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH v2] rev-parse: Detect missing opt-spec
Date:   Fri,  2 Sep 2022 08:39:58 +0200
Message-Id: <20220902063958.2516-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAPig+cTAN1F1D=DxZF9jbUiTtc4UPnx0hZLLaVFKEecAa-gMsg@mail.gmail.com>
References: <CAPig+cTAN1F1D=DxZF9jbUiTtc4UPnx0hZLLaVFKEecAa-gMsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a line in parseopts's input starts with one of the flag characters it
is erroneously parsed as a opt-spec where the short name of the option
is the flag character itself and the long name is after the end of the
string. This makes Git want to allocate SIZE_MAX bytes of memory at this
line:

    o->long_name = xmemdupz(sb.buf + 2, s - sb.buf - 2);

Since s and sb.buf are equal the second argument is -2 (except unsigned)
and xmemdupz allocates len + 1 bytes, ie. -1 meaning SIZE_MAX.

Avoid this by checking whether a flag character was found in the zeroth
position.

Reported-by: Ingy dot Net <ingy@ingy.net>
Signed-off-by: Øystein Walle <oystwa@gmail.com>
---

Thanks for the review, Eric (should I then add a Reviewed-by trailer?).
Fixed the casing, added the suggested trailer, and remove the
superfluous test_done which indeed was a leftover. 

 builtin/rev-parse.c           | 3 +++
 t/t1502-rev-parse-parseopt.sh | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index b259d8990a..85c271acd7 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -479,6 +479,9 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 		if (!s)
 			s = help;
 
+		if (s == sb.buf)
+			die(_("missing opt-spec before option flags"));
+
 		if (s - sb.buf == 1) /* short option only */
 			o->short_name = *sb.buf;
 		else if (sb.buf[1] != ',') /* long option only */
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 284fe18e72..75f576249c 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -306,6 +306,13 @@ test_expect_success 'test --parseopt help output: "wrapped" options normal "or:"
 	test_cmp expect actual
 '
 
+test_expect_success 'test --parseopt invalid opt-spec' '
+	test_write_lines x -- "=, x" >spec &&
+	echo "fatal: Missing opt-spec before option flags" >expect &&
+	test_must_fail git rev-parse --parseopt -- >out <spec >actual 2>&1 &&
+	test_cmp expect actual
+'
+
 test_expect_success 'test --parseopt help output: multi-line blurb after empty line' '
 	sed -e "s/^|//" >spec <<-\EOF &&
 	|cmd [--some-option]
-- 
2.34.1

