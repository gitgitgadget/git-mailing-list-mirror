Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB74DC433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347058AbiDRR1M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347007AbiDRR1F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:05 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215A433E2C
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:10 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso12137088wme.5
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s4ms7arJwcW/tM7QEHrFT6XHDZbJrTjn1pNUsn0ptPk=;
        b=SssE2WT5C8vr39WPigGwUs/tq+NM3+Q8WjGOThIaHo5t30o6yaKaPU6kO4kDP4Nn3u
         xzgbZ/VZ40H7KV5Fb5z3nuk6GyRS+GbLVBvn4gSQyScDwfIqOFh2spk75Ly4tYPGPVTe
         HIC/nbIEFZbJXv5r9lunw4vBP31WqILCcNiCsxwg6kH6OG1adMNVm44Weu+wf0KkjRZf
         JATrge4LMKLDt1UhWBzzTqgoFL+5e7SobKzxmDQUw8k9YRO8cM+9pdGK305tee/FWm4z
         1CznOr0PxXB1Wgu38NG2jTKWwx3v1pIWidSLliA0v0qb7OaLvFCnS0cZCznStpe9tkQh
         muaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s4ms7arJwcW/tM7QEHrFT6XHDZbJrTjn1pNUsn0ptPk=;
        b=5L3QqD/VJr3D7pYT6akDn3bxFebYGUIQpJeM6SvN8tESN5DhVl/O8sqKsSqKcjWK7i
         Mmy4gySULRp59VaBRvkSQmH2TluDiJwcNWO7Js9trjirFl/mcYlv3nh9nUxd2spwbswD
         f0O/U9j+XdEt3NB0kjxWkQT0i/Q3/KCv4gML9GwqBf3qP5nvBiWsJHOk3Cmsh4KAUtoD
         kanXkk3lqcmhQLuxMYm1ey7Mq+gJ6FLqxt0R6C+KTKDACXojoVQ5jtEtqvJuWmyK4Zu2
         KADYTJueNKGY9BW8DKTV1dVGJBMcJEkfpzpVCYYbGpCCSnoitF8LUbRtQhg+Qk1sjaxf
         G12g==
X-Gm-Message-State: AOAM5302tNtfc8QUEeyORZZQg3Ztur/xX5u+8hocWSn0EZgn3MYxl1PQ
        eMXeobnrTQCJPIxXOKeVujTu6y5spf6sVg==
X-Google-Smtp-Source: ABdhPJwGPZcLIi4n8hfl+fdd9BqhFO2GadKshu7ESTM7aSJ3oDeVSG1jj5LAPHJUVA+3ap0NPeXgFw==
X-Received: by 2002:a05:600c:1c97:b0:38e:d363:3847 with SMTP id k23-20020a05600c1c9700b0038ed3633847mr12298755wms.82.1650302648472;
        Mon, 18 Apr 2022 10:24:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 08/36] bundle.h: make "fd" version of read_bundle_header() public
Date:   Mon, 18 Apr 2022 19:23:25 +0200
Message-Id: <RFC-patch-v2-08.36-2b236af147b-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the parse_bundle_header() function to be non-static, and rename
it to parse_bundle_header_fd(). The parse_bundle_header() function is
already public, and it's a thin wrapper around this function. This
will be used by code that wants to pass a fd to the bundle API.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bundle.c | 8 ++++----
 bundle.h | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/bundle.c b/bundle.c
index d50cfb5aa7e..5fa41a52f11 100644
--- a/bundle.c
+++ b/bundle.c
@@ -66,8 +66,8 @@ static int parse_bundle_signature(struct bundle_header *header, const char *line
 	return -1;
 }
 
-static int parse_bundle_header(int fd, struct bundle_header *header,
-			       const char *report_path)
+int read_bundle_header_fd(int fd, struct bundle_header *header,
+			  const char *report_path)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int status = 0;
@@ -143,7 +143,7 @@ int read_bundle_header(const char *path, struct bundle_header *header)
 
 	if (fd < 0)
 		return error(_("could not open '%s'"), path);
-	return parse_bundle_header(fd, header, path);
+	return read_bundle_header_fd(fd, header, path);
 }
 
 int is_bundle(const char *path, int quiet)
@@ -153,7 +153,7 @@ int is_bundle(const char *path, int quiet)
 
 	if (fd < 0)
 		return 0;
-	fd = parse_bundle_header(fd, &header, quiet ? NULL : path);
+	fd = read_bundle_header_fd(fd, &header, quiet ? NULL : path);
 	if (fd >= 0)
 		close(fd);
 	bundle_header_release(&header);
diff --git a/bundle.h b/bundle.h
index 7fef2108f43..0c052f54964 100644
--- a/bundle.h
+++ b/bundle.h
@@ -24,6 +24,8 @@ void bundle_header_release(struct bundle_header *header);
 
 int is_bundle(const char *path, int quiet);
 int read_bundle_header(const char *path, struct bundle_header *header);
+int read_bundle_header_fd(int fd, struct bundle_header *header,
+			  const char *report_path);
 int create_bundle(struct repository *r, const char *path,
 		  int argc, const char **argv, struct strvec *pack_options,
 		  int version);
-- 
2.36.0.rc2.902.g60576bbc845

