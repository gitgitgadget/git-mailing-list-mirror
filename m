Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC596C6FD18
	for <git@archiver.kernel.org>; Sun, 23 Apr 2023 13:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjDWNrD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Apr 2023 09:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWNq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2023 09:46:58 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0EE170A
        for <git@vger.kernel.org>; Sun, 23 Apr 2023 06:46:57 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4eca0563b31so3495151e87.1
        for <git@vger.kernel.org>; Sun, 23 Apr 2023 06:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682257616; x=1684849616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yawSpfkFzgFl1q86Bi3J4ehwF2PSm+/QT8KDpSo1AUU=;
        b=XA5sDdmHP29e/k3L3dx8r/G2/bU6L/iCHmbuYOYIGtWTaeRHxG3dMTAQBZyoAS7Knu
         ymAjQ7KVQ+NvJSb8VEQeD9hPh6feDvO9uEJTt2V+R3f+uifMpzRQfrYG58nx8pkTuHZi
         2EDsZC5C10W+OrYux/acv3Z/IPs5UrPAiNG59Z4BrrrAxDTXQTrdPWnsiFOvlb0pocra
         cbDeyQWu7DCi6SsOwMdhkTN5KWOnMR7OM81OqRJ6j30IEp9wuazma4he5KvUtb7HpOKh
         CQ/6e6l7jb8qixg+wmV9u6syk+pNZDvkK4SqHGubJJpEjFTypbhaDP/5d0/VFP7ylnzU
         dCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682257616; x=1684849616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yawSpfkFzgFl1q86Bi3J4ehwF2PSm+/QT8KDpSo1AUU=;
        b=dkpUcMEKeZAYHmPz32C8EwuXqaqN5m4jR0fC/FZI0zU+h00geTNJr/D2J4JbO5yDP4
         3yxwb8uC6xcJKpBXd5qTjxjHpGpfx5pvqc3TR3p0V7NTzVD4u2UYoo181R9TLj8CHqGY
         Peefmt/P9DNn+hbicjHEuQx//AOwwRTfSW7Is3eEhBEOknNQCViXORjBYXb58s1CHdOu
         llqcQEexoFVOCoGBUzmuNCrIHJKstUK3d//ws2insmSTHGAuT/4JHheHZqVS8lV/mQqm
         gKtfPIr8JxFAUfMJMt34w1n4TT4mBPZYeTSn6hNI0Ypavad9erCqEaeyJ01qBNDn8CO4
         TAaw==
X-Gm-Message-State: AAQBX9fkyWChvIL/PYfIODbyFJpvjskJro+UOBZfFaxt1OEpjZIOlMgh
        7frKUhWpfd8DVQWVDpC1jw8va/JXYLj4rajkOho=
X-Google-Smtp-Source: AKy350YALSw1GPDPq60dW/hmULVbTTUio+ZCSmXgrOgjFyP+L9QdtUZcG3AStdunLqfrLfaORiGWqw==
X-Received: by 2002:a19:5210:0:b0:4db:405f:d5c0 with SMTP id m16-20020a195210000000b004db405fd5c0mr2849776lfb.48.1682257615526;
        Sun, 23 Apr 2023 06:46:55 -0700 (PDT)
Received: from titov.fritz.box ([195.246.120.55])
        by smtp.gmail.com with ESMTPSA id j24-20020ac24558000000b004db3eff4b12sm1272641lfm.171.2023.04.23.06.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 06:46:55 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/3] t1300: add tests for missing keys
Date:   Sun, 23 Apr 2023 15:46:49 +0200
Message-Id: <20230423134649.431783-4-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230423134649.431783-1-rybak.a.v@gmail.com>
References: <20230418175034.982433-1-rybak.a.v@gmail.com>
 <20230423134649.431783-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are several tests in t1300-config.sh that validate failing
invocations of "git config".  However, there are no tests that check
what happens when "git config" is asked to retrieve a value for a
missing key.

Add tests that check this for various combinations of "<section>.<key>"
and "<section>.<subsection>.<key>".

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1300-config.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 20a15ede5c..423948f384 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -98,6 +98,23 @@ test_expect_success 'subsections are not canonicalized by git-config' '
 	test_cmp_config two section.SubSection.key
 '
 
+test_missing_key () {
+	local key="$1" &&
+	local title="$2" &&
+	test_expect_success "value for $title is not printed" '
+		test_must_fail git config "$key" >out 2>err &&
+		test_must_be_empty out &&
+		test_must_be_empty err
+	'
+}
+
+test_missing_key 'missingsection.missingkey' 'missing section and missing key'
+test_missing_key 'missingsection.penguin' 'missing section and existing key'
+test_missing_key 'section.missingkey' 'existing section and missing key'
+test_missing_key 'section.MissingSubSection.missingkey' 'missing subsection and missing key'
+test_missing_key 'section.SubSection.missingkey' 'existing subsection and missing key'
+test_missing_key 'section.MissingSubSection.key' 'missing subsection and existing key'
+
 cat > .git/config <<\EOF
 [alpha]
 bar = foo
-- 
2.40.0

