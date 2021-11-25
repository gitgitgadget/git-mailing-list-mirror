Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0A0C433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 22:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346135AbhKYWKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 17:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244656AbhKYWIf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 17:08:35 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031C6C0613F4
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:03:52 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v11so14397470wrw.10
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GYgnIA4xmhhg+Llr6wNhnDeJmtO52lgNQmdDkcIBID8=;
        b=VRGI+i2fvTvsF2nJyIqnqUVTyJnBgOOAHN5s4m/klM0wnG8DWozY2U/Dqfb4UTq+fl
         HLCvekvo/gjnKF1KE+hw2cohVxxfSF6rE1qdhHl11VCzca/iN6+4xU52wTV94XvhpgWn
         8QKf7Xm4jglIRdQP6FO9k4c9Hh+8JyggQId+b63FCZPuAl11OLwu9WY1RMnbmoHhh+8x
         or/4amzgzVj1GHRZxKcHKHAQl3wdfZt1tCIfXpW/3OYTgGPVGdo5og/cv1JDbWabvjF2
         EvlCvPBY1myVoD1hNhCuUZHoq9v03kZYwtdFEvXWmu/7AyS3TszIFy2gCbpU7isdQWdA
         KXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GYgnIA4xmhhg+Llr6wNhnDeJmtO52lgNQmdDkcIBID8=;
        b=ZlDc1cj5r9FFnpbrAVw+6thLFiuriM2Y/1NI60cFO6QppY2HZnuAJeX2Lf6/TwX2/f
         v+cUUULQoP0poYCE/0jp0XfEKlTlydAHq665kzEPPl2jY+92+w4rrud1pvzRLcvhNFRG
         PypOFGCQTZcU8YP+hjCKU7kwdSLdKnuhyOWQhoA/GndNaWFkRi6sWM3fufJdj4YG21E/
         Y9xxXfGJNspA4oAb3gfL4GlghZ5M09wHiJkdMwxRb5Jpau9IJe9a2NLJD1LCJRhCcsfw
         wHHCw60DRAsIiG3JD3pLFEsWDdO8Cgai/WyTlffSjt/QJTheviKazWuA5V/hFx4gXj7h
         vdeA==
X-Gm-Message-State: AOAM531mcCjwIfwhItwXBT8Ijs+ZmQY/Y6R5M4AgESS4WtTkkLkWmkQ4
        /89ltYa+gaXoXeecCrzDEt0ZssA8qFJrQA==
X-Google-Smtp-Source: ABdhPJwh1wKASCqTSpji46KfroKF+VwUSpoTvNqxW8UbgN8YP+wXYXydFSlJSpUs3/hWd9Fi2weuqg==
X-Received: by 2002:adf:ec45:: with SMTP id w5mr9931714wrn.183.1637877830373;
        Thu, 25 Nov 2021 14:03:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm8883726wmi.36.2021.11.25.14.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 14:03:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 4/6] object-name: show date for ambiguous tag objects
Date:   Thu, 25 Nov 2021 23:03:42 +0100
Message-Id: <patch-v5-4.6-36b6b440c37-20211125T215529Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.838.g779e9098efb
In-Reply-To: <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com>
References: <cover-v4-0.3-00000000000-20211122T175219Z-avarab@gmail.com> <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the ambiguous tag object output nicer in the case of tag objects
such as ebf3c04b262 (Git 2.32, 2021-06-06) by including the date in
the "tagger" header. I.e.:

    $ git rev-parse b7e68
    error: short object ID b7e68 is ambiguous
    hint: The candidates are:
    hint:   b7e68c41d92 tag 2021-06-06 - v2.32.0
    hint:   b7e68ae18e0 commit 2019-12-23 - bisect: use the standard 'if (!var)' way to check for 0
    hint:   b7e68f6b413 tree
    hint:   b7e68490b97 blob
    b7e68
    [...]

Before this we'd emit a "tag" line of:

    hint:   b7e68c41d92 tag v2.32.0

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-name.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/object-name.c b/object-name.c
index 1dcbba7fa76..707480ed191 100644
--- a/object-name.c
+++ b/object-name.c
@@ -402,21 +402,26 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	} else if (type == OBJ_TAG) {
 		struct tag *tag = lookup_tag(ds->repo, oid);
 		const char *tag_tag = "";
+		timestamp_t tag_date = 0;
 
-		if (!parse_tag(tag) && tag->tag)
+		if (!parse_tag(tag) && tag->tag) {
 			tag_tag = tag->tag;
+			tag_date = tag->date;
+		}
 
 		/*
 		 * TRANSLATORS: This is a line of
 		 * ambiguous tag object output. E.g.:
 		 *
-		 *    "deadbeef tag Some Tag Message"
+		 *    "deadbeef tag 2021-01-01 - Some Tag Message"
 		 *
 		 * The second argument is the "tag" string from
 		 * object.c, it should (hopefully) already be
 		 * translated.
 		 */
-		strbuf_addf(&desc, _("%s tag %s"), hash, tag_tag);
+		strbuf_addf(&desc, _("%s tag %s - %s"), hash,
+			    show_date(tag_date, 0, DATE_MODE(SHORT)),
+			    tag_tag);
 	} else if (type == OBJ_TREE) {
 		/*
 		 * TRANSLATORS: This is a line of ambiguous <type>
-- 
2.34.1.838.g779e9098efb

