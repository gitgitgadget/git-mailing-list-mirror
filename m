Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E962C433EF
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 08:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbiAHI4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jan 2022 03:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiAHI4h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jan 2022 03:56:37 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A29FC061574
        for <git@vger.kernel.org>; Sat,  8 Jan 2022 00:56:37 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso14816588pje.0
        for <git@vger.kernel.org>; Sat, 08 Jan 2022 00:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+sBRqX3wRqfZPScS0uBjLr2x1Q+9m/7H0QMgLJdRyXk=;
        b=KcsWEFNdQ6RnTzGcyHkyBWjurmCnygbE+XR83bfYODXoJBOBq+Sk7qfyVjHTkYrw8u
         PIoFQeqPAwC2OEOK5gTX0HJVnFuVJqc6yMqkTpm1Ui8xGgl1NlY61177H3uDrM7P9+1e
         Em19oncJG+3+dASKxupk2l+53fxTqitB4SkMDRdPAQaRV9yOyCBh9vsyvZch0O0692Nz
         iC5C3vn9JuxQhdWgLWPA/MMcYP3p0f7AqMYXVuUB83tove2ZkhlegDrtb8biYGc/JWwA
         TZh2I0cnCYbygOg6TtEO6CksYOFK/TpBy8Mc4UtEQu2nNRz4ZYrxAhBOXrdjbTPvVUI+
         LhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+sBRqX3wRqfZPScS0uBjLr2x1Q+9m/7H0QMgLJdRyXk=;
        b=yA/5iQA/oZKK57fSw1nClPymiJMjbZV9lOZE1Fumacdfjk4OmGPS5usSsKz8zsX7KY
         ldF4Yrtreg6cOs9oAgToh7cuvFWKIQZrWl/cZoo06XikTc+AYd87pGpd/lXC5ulg+Efb
         qnAt51fm3Pxzn1JAizO2vPky8HUfC/TTd3L28Qn5f8U7qnfRUNxFtTGBq1zXaHcxAk7R
         iprjBLf+EkZvhJEysRi3sFCOK2ifIuhGo1tWlj+zBvMfhBmhQC/q5ZT0qXxZjmdgOn0I
         wl/MHBPFs7AWGoxWviGTNMmcbB4hXOCbiHLk04J7NGbi9euUudSZ6X00SjTvkr0HzcTH
         lh1A==
X-Gm-Message-State: AOAM531hdceKC1SSfBMOxeq0DYwHuAVvb8MhXA6WGcEa3kObDS1bGM77
        AR1Ei5JytOs9/X9rprlMhPk=
X-Google-Smtp-Source: ABdhPJyjjxjsNo6ot+RclcUGHrs1al13DtpB3jYhRT+EVDJ2spczD/Y//Rq69NUrzkhPLRy1tx4STg==
X-Received: by 2002:a17:902:b58d:b0:149:9c02:6345 with SMTP id a13-20020a170902b58d00b001499c026345mr43748629pls.21.1641632196838;
        Sat, 08 Jan 2022 00:56:36 -0800 (PST)
Received: from localhost.localdomain ([58.100.34.57])
        by smtp.gmail.com with ESMTPSA id x25sm1240990pfu.113.2022.01.08.00.56.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jan 2022 00:56:36 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v8 3/6] object-file.c: remove the slash for directory_size()
Date:   Sat,  8 Jan 2022 16:54:16 +0800
Message-Id: <20220108085419.79682-4-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.1.52.gc288e771b4.agit.6.5.6
In-Reply-To: <20211217112629.12334-1-chiyutianyi@gmail.com>
References: <20211217112629.12334-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

Since "mkdir foo/" works as well as "mkdir foo", let's remove the end
slash as many users of it want.

Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 object-file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index 5d163081b1..4f0127e823 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1831,13 +1831,13 @@ static void close_loose_object(int fd)
 		die_errno(_("error when closing loose object file"));
 }
 
-/* Size of directory component, including the ending '/' */
+/* Size of directory component, excluding the ending '/' */
 static inline int directory_size(const char *filename)
 {
 	const char *s = strrchr(filename, '/');
 	if (!s)
 		return 0;
-	return s - filename + 1;
+	return s - filename;
 }
 
 /*
@@ -1854,7 +1854,7 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename,
 
 	strbuf_reset(tmp);
 	strbuf_add(tmp, filename, dirlen);
-	strbuf_addstr(tmp, "tmp_obj_XXXXXX");
+	strbuf_addstr(tmp, "/tmp_obj_XXXXXX");
 	fd = git_mkstemp_mode(tmp->buf, 0444);
 	do {
 		if (fd >= 0 || !dirlen || errno != ENOENT)
@@ -1866,7 +1866,7 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename,
 		 * scratch.
 		 */
 		strbuf_reset(tmp);
-		strbuf_add(tmp, filename, dirlen - 1);
+		strbuf_add(tmp, filename, dirlen);
 		if (mkdir(tmp->buf, 0777) && errno != EEXIST)
 			break;
 		if (adjust_shared_perm(tmp->buf))
-- 
2.34.1.52.gc288e771b4.agit.6.5.6

