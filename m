Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EADEC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 08:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiBPIOi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 03:14:38 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiBPIOc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 03:14:32 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A40250393
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 00:14:18 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id k3-20020a1ca103000000b0037bdea84f9cso986164wme.1
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 00:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=awfNansQ+Tc/fElV0Ux9pm23dtDubw9vDfPAUdaRzgg=;
        b=Phh7wkMxvHelxkQZS0xF9PaL8E7Gr2iyf5Vf77TbJl9o4ktgfCorZ8ohTqc8lgKTbP
         m4AZnjYAcoNSxOtT/s4JSVAxWAD1ZqzCL6D6/q5mqhLgZWkqbJZcqoePTDsSVlVuxpyR
         am+5qGOuOWs+6dwRZEnf7WWlQpFtjgLtgjE1Jc4cAkh9DNZ6Mot9i7dfQx2gbOb7xR8Q
         Y4nZg4P+L0noNpwMN6PB115h+NO4wOBmer5k/FCu9nj7qcAoukGEUnOff0TN1z/dfcbH
         chCIpThQqSZgVlwAySIRuyIBZ7ONzo+DHt4E9LkwuoMuRE2r4sNoKvA5a/QoLK4iL1P2
         BPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=awfNansQ+Tc/fElV0Ux9pm23dtDubw9vDfPAUdaRzgg=;
        b=EXXMROp2Uhf+ODWQ7mUZMViBYD2v1dj8MIXSpYYCKdFZbSJY35iXPCMDkUov8nWuvh
         QVSkSNo0ttkQLLw+ykRY/uJztvbHuQusCCbnTSdyYvJpMcsX9foae6xqTh5uawQAWpC5
         dTZWkQHDg7KyCu/gvixgBM2YYiACt5c9U9XDWrt2vrbZPwrfbNSslGsl04R57PcSgWIZ
         BF7h+H32f11JhLQOSZwsTldy5Cags4dPsfiiK7re44YX1swVa8Siaz7Kl0weiPubbNk6
         WrFfHu5X9xbV5Ek8YwMOy19P4TRZTEOT283bB3yflTOHgiUDG8ffjzz/ILDM6U3uw6Mv
         SMjQ==
X-Gm-Message-State: AOAM53163o87HU8NS9fyp6BMf5t7PmPLRGGw8QCtxHhJjzkTKoRdLP0o
        gNnT/dooVw6O/75vKgy0Q2rEahmBzPrQag==
X-Google-Smtp-Source: ABdhPJybfLRXJrFqkFuzTYzFIcIYEiFxot/Eg0b90eCQ32rV1xwi3JLO/ktF7MlUzjutvchsaC+AvQ==
X-Received: by 2002:a05:600c:3505:b0:37b:bf81:97d8 with SMTP id h5-20020a05600c350500b0037bbf8197d8mr456695wmq.30.1644999256983;
        Wed, 16 Feb 2022 00:14:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b16sm26173443wrj.26.2022.02.16.00.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 00:14:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/5] date API: add basic API docs
Date:   Wed, 16 Feb 2022 09:14:04 +0100
Message-Id: <patch-v3-4.5-5c244960133-20220216T081203Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1028.g2d2d4be19de
In-Reply-To: <cover-v3-0.5-00000000000-20220216T081203Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20220204T235143Z-avarab@gmail.com> <cover-v3-0.5-00000000000-20220216T081203Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add basic API doc comments to date.h, and while doing so move the the
parse_date_format() function adjacent to show_date(). This way all the
"struct date_mode" functions are grouped together. Documenting the
rest is one of our #leftoverbits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 date.h | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/date.h b/date.h
index c3a00d08ed6..bbd6a6477b5 100644
--- a/date.h
+++ b/date.h
@@ -1,6 +1,12 @@
 #ifndef DATE_H
 #define DATE_H
 
+/**
+ * The date mode type. This has DATE_NORMAL at an explicit "= 0" to
+ * accommodate a memset([...], 0, [...]) initialization when "struct
+ * date_mode" is used as an embedded struct member, as in the case of
+ * e.g. "struct pretty_print_context" and "struct rev_info".
+ */
 enum date_mode_type {
 	DATE_NORMAL = 0,
 	DATE_HUMAN,
@@ -24,7 +30,7 @@ struct date_mode {
 	.type = DATE_NORMAL, \
 }
 
-/*
+/**
  * Convenience helper for passing a constant type, like:
  *
  *   show_date(t, tz, DATE_MODE(NORMAL));
@@ -32,7 +38,22 @@ struct date_mode {
 #define DATE_MODE(t) date_mode_from_type(DATE_##t)
 struct date_mode *date_mode_from_type(enum date_mode_type type);
 
+/**
+ * Format <'time', 'timezone'> into static memory according to 'mode'
+ * and return it. The mode is an initialized "struct date_mode"
+ * (usually from the DATE_MODE() macro).
+ */
 const char *show_date(timestamp_t time, int timezone, const struct date_mode *mode);
+
+/**
+ * Parse a date format for later use with show_date().
+ *
+ * When the "date_mode_type" is DATE_STRFTIME the "strftime_fmt"
+ * member of "struct date_mode" will be a malloc()'d format string to
+ * be used with strbuf_addftime().
+ */
+void parse_date_format(const char *format, struct date_mode *mode);
+
 void show_date_relative(timestamp_t time, struct strbuf *timebuf);
 int parse_date(const char *date, struct strbuf *out);
 int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset);
@@ -41,7 +62,6 @@ void datestamp(struct strbuf *out);
 #define approxidate(s) approxidate_careful((s), NULL)
 timestamp_t approxidate_careful(const char *, int *);
 timestamp_t approxidate_relative(const char *date);
-void parse_date_format(const char *format, struct date_mode *mode);
 int date_overflows(timestamp_t date);
 time_t tm_to_time_t(const struct tm *tm);
 #endif
-- 
2.35.1.1028.g2d2d4be19de

