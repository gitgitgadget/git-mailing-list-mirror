Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C04EC001E0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 16:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbjHJQhq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 12:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbjHJQh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 12:37:28 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB6235A5
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 09:37:15 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5646e695ec1so1660027a12.1
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 09:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691685435; x=1692290235;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hxwe3WOPjWpLytPYCre2jdZg6NAXnh3CgUy2eTaECm0=;
        b=V9faoNYq2YG2yoGVogZwr1ISMPT0fUs0yb2kJ50xxKWRvH4t/xEo+cSnd0Lv+aH0ef
         qR8VJTc8huFopMmiFYdRI2OWjhvHBHHkUsXXnuL4NUk+HdMoUpfCVhkm7pKUOnW6gJY2
         N3loc5NkDzDU71laY4J3koe5XxQ3baNyGT6edIZ52PQhSzKFc0pB8Bd5YK6Wl+xZIqA3
         gITnDYfUQtcp4LneRv0HA0ed1r1Ok4gvP9EaU5fXTmmTNWPUR4dhj/zYxtqAzFAgfuor
         6MaEti+t08xvl/Zs7HCcIlDTJST5ItilXTeSJR2prhf46lzzagh/1mP54v2jPSvN+pyp
         6yQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691685435; x=1692290235;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hxwe3WOPjWpLytPYCre2jdZg6NAXnh3CgUy2eTaECm0=;
        b=P1W3cBBovGAfx36VvMv9zfdt6q+ixtr3Akbso3AK6K4z69PCTOJes0vLkG9QLwzWo9
         RMsEsUpuf8GurLZH3RMT5qJHpIPL/5YUKijJ0kIi/XulNRty8ojoUnNYHz72FFy/d+SH
         6OKl/FSSHzQfT8Osbf+oxKfRr12i+QKenIIMbiLQxrPO1C0EvDFWvA6XGydyU45T7fN5
         Zz5ZpPO5IzKCpDluw1wGtW5FHKs1n+l0VcH/jw1eM1I9gCs/7dBd/SiF4gCWbDs7Slyv
         3clUrBw6J7ba7NhjAq4Btux8vTsVrSWqQCFOD5HYSvL2BsE1yfrasTSDlArxmBpn92l4
         wadw==
X-Gm-Message-State: AOJu0YwToe3UkYRmKxxiRniFiLOZ2jtaXCYJmMWYOYkZFIUWe6JTIjqF
        4ITv+cFOtmDEsZfatyCMwTW+HRsErSrzHNycmZKqL+4ZB8ZI5Koqd3gPz4OG//XcKxQ+X2BFxH4
        RpRLgi1gB4/8e68aTATu9ntOH1CNhpIPkWeQbc0aA6zGSI/RhocnehH8Dl5lwR5ebkw==
X-Google-Smtp-Source: AGHT+IFLVbIbZdSFKMo0thT1gdW5WpS0+5bEAD1/VccPY0yHzxxhsVddK5feN/jsgzzTbGHGTaEU2R28jb6I9Dg=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:f543:b0:1bb:a367:a8b with SMTP
 id h3-20020a170902f54300b001bba3670a8bmr997503plf.4.1691685435220; Thu, 10
 Aug 2023 09:37:15 -0700 (PDT)
Date:   Thu, 10 Aug 2023 16:36:50 +0000
In-Reply-To: <20230810163346.274132-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230810163346.274132-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230810163654.275023-3-calvinwan@google.com>
Subject: [RFC PATCH v2 3/7] config: correct bad boolean env value error message
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        chooglen@google.com, jonathantanmy@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An incorrectly defined boolean environment value would result in the
following error message:

bad boolean config value '%s' for '%s'

This is a misnomer since environment value != config value. Instead of
calling git_config_bool() to parse the environment value, mimic the
functionality inside of git_config_bool() but with the correct error
message.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 config.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 09851a6909..5b71ef1624 100644
--- a/config.c
+++ b/config.c
@@ -2172,7 +2172,14 @@ void git_global_config(char **user_out, char **xdg_out)
 int git_env_bool(const char *k, int def)
 {
 	const char *v = getenv(k);
-	return v ? git_config_bool(k, v) : def;
+	int val;
+	if (!v)
+		return def;
+	val = git_parse_maybe_bool(v);
+	if (val < 0)
+		die(_("bad boolean environment value '%s' for '%s'"),
+		    v, k);
+	return val;
 }
 
 /*
-- 
2.41.0.640.ga95def55d0-goog

