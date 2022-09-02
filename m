Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457B7ECAAA1
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 05:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbiIBFGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 01:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbiIBFG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 01:06:28 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58347A6AE5
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 22:06:27 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id br21so1774191lfb.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 22:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=7FKMzK0FUDX/iZmPKo2UwgIdTvKwfBkJx92PFHriN90=;
        b=CeqSVzzUFWY0LOnrCnPCN2L+8gh8vmEDTfu1vuVZZRffGdzFry73k6hOgcjtZLapMI
         bro5WDLulBxbdTFaKbIlj2Z3quiLUTpqo9qKgHDPu+8Qif/ROwZKN8Nk7RoLByLKjBBG
         nQfmzIe/cYTlIJbqdV5hgBPlScyn60hf61m8vUkulyCtdkv1NXpwcHE8v6lJjdW/EK5e
         rabdrgnfVo61a4JaU9T599o9Rf4Pt2bTzIgZeq1auuEP4I6oIlhGIOG88+LIRVxL/B/4
         5QOtitmpEnM4TsTOpElfQzw1VMsKK1CMvkecnLT0xMqTMGpwfyrKzbV83LY/pBrNG9tu
         va1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7FKMzK0FUDX/iZmPKo2UwgIdTvKwfBkJx92PFHriN90=;
        b=y5QdgjiUMPsKozYFnDfUMSXb23QGnY0hoMvtsA4YPz28ifel8l6rukxaatVYJ0Zxil
         Itmdq4gnt46pF2LG64A3Ow1wdc7Zjx8KstcXjJTDv5rQ21zniw4mfZ9SzqQPJQDcx710
         1azYmpgafvHXtvl3WXvWhZ0nSkOoEdndHRy3HkuEk4hSEmdmKCu9FTqIrZ8L4r/ZMYGu
         d5+DgqgXGhsT+bFkpfsS70yzTvl4LVD/YTezPYoIbyy4UQSO8ybwMt3AcLK63Mo9FVLJ
         IpACv4P2UJCMu71G7Y86E0uE3xc2ENy45R9NBXt6A7IC8Sywyhd5MH1vrI0Ak/fGLu00
         s9xQ==
X-Gm-Message-State: ACgBeo3OZiSxL8kGUwM+O/gJjgOs5ViVeN2c1tvO9pWTd1yg1LO4dwdi
        xsGIxJ1ElD15F29UPUq/GzNnDlSbYi8=
X-Google-Smtp-Source: AA6agR7Ea4S/DNJuFM15cC1yLNhVcuPseKCkJOudLKQpFkOB0ly9P0nVdxRE5Nbfdj/Y2tWPhF9j7g==
X-Received: by 2002:a05:6512:1151:b0:48c:ddba:b77a with SMTP id m17-20020a056512115100b0048cddbab77amr11124848lfg.650.1662095185282;
        Thu, 01 Sep 2022 22:06:25 -0700 (PDT)
Received: from paasan.lan (150.37-191-137.fiber.lynet.no. [37.191.137.150])
        by smtp.gmail.com with ESMTPSA id o11-20020ac24e8b000000b0049496855494sm123986lfr.104.2022.09.01.22.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 22:06:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     git@vger.kernel.org
Cc:     ingy@ingy.net, =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH] rev-parse: Detect missing opt-spec
Date:   Fri,  2 Sep 2022 07:06:21 +0200
Message-Id: <20220902050621.94381-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHJtQJ4uJc2_upHvc-SWVpA3OX2Lpu-XspswGTTDLgXWjG-Gew@mail.gmail.com>
References: <CAHJtQJ4uJc2_upHvc-SWVpA3OX2Lpu-XspswGTTDLgXWjG-Gew@mail.gmail.com>
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

Signed-off-by: Øystein Walle <oystwa@gmail.com>
---
 builtin/rev-parse.c           | 3 +++
 t/t1502-rev-parse-parseopt.sh | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index b259d8990a..04958cf9a9 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -479,6 +479,9 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 		if (!s)
 			s = help;
 
+		if (s == sb.buf)
+			die(_("Missing opt-spec before option flags"));
+
 		if (s - sb.buf == 1) /* short option only */
 			o->short_name = *sb.buf;
 		else if (sb.buf[1] != ',') /* long option only */
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 284fe18e72..15bc240027 100755
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
@@ -337,3 +344,5 @@ test_expect_success 'test --parseopt help output: multi-line blurb after empty l
 '
 
 test_done
+
+test_done
-- 
2.34.1

