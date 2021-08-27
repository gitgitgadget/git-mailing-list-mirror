Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388E5C4320A
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 08:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E15D60EE5
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 08:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244519AbhH0IE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 04:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244564AbhH0IEe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 04:04:34 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B091FC0617A8
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 01:02:27 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b6so9028316wrh.10
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 01:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=306CQAG8hVXSWBCyCMCmsqF1EsUTK7hNwWT3FwHMmNU=;
        b=DtewzsZoXtP+RWI5YVXQpVfbdRvOJWvPgy5tVk7Z+6715opLmu698ya0k5oEtoN0s8
         XH0ZoVUhO7jgej2lcusGS4A6Wsu977noZ5StqnjfLhpfttNh791iZms5FBQbrLgIAlbZ
         Xi5rZvlnw5QTLgxsfdQeiOSCHTRfWdjCK1rZbvXpoaF23nQSKhzZZnt6OzvCBGHd+vJ+
         9OCBG1A9v49+KTFbcbzMgYee/zFPDxqRZzor8xA9iQiCfZCVoZBXaxp9D2HMgbiwoQ+D
         g2PT3Yk4dJuv5u4ZOX9nTNXs/Wrj2BPMfkjHp+KlTZbWOguvYMdGKM8Wb3ezyGZQTl0K
         mx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=306CQAG8hVXSWBCyCMCmsqF1EsUTK7hNwWT3FwHMmNU=;
        b=DTs0LR5TQBW+uddQ54bjYA951TeEkPWYJJOaS9ZSKLncPqgSwlDKkZIuZ7awre1Ld6
         C8MvIjiRmo+RBqXiS+5XoqfphuoYgvBTtGcYIweUWQY5kfVHco8Ui0YfXtPUHJsvy3BB
         1uIVnHPGo3KufwP/S4b+2KTQK/QFEyoKYIIUQsM2q/6xp3jGx3gdMeO9zYZpCA6rq4K2
         0AobV1fI2ES0Zr4ymgoPJlMEukireOKPtBXAsRlb04pMUsumd/XeVyAqVdI+memyoxCl
         G71GLaIImK6wh7mngznSrg2/eaSTtA3Q8kQHLj+NAuXnhP9w44wpVKhaM+X0nIUO53Vf
         LYoA==
X-Gm-Message-State: AOAM531AOo++zaiC/aVYT33EV7dJWRrxdNVtmKjT0aFi2GuqmsNZjhzJ
        7aLaDPxTI19Vh14JzJUsYYH1tOBtuFKTTw==
X-Google-Smtp-Source: ABdhPJxCPdHxLcm1eVDXnJrTu5kACY8p8CUufHiOGs88UUSyGw3hBA8BjOjaAxQPK8vxWRx7OXXSqw==
X-Received: by 2002:a5d:554e:: with SMTP id g14mr8604006wrw.48.1630051346018;
        Fri, 27 Aug 2021 01:02:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z137sm10922636wmc.14.2021.08.27.01.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 01:02:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/6] tr2: leave the parent list empty upon failure & don't leak memory
Date:   Fri, 27 Aug 2021 10:02:16 +0200
Message-Id: <patch-v3-4.6-946140691f-20210827T080054Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.736.g68690aaec9a
In-Reply-To: <cover-v3-0.6-0000000000-20210827T080054Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com> <cover-v3-0.6-0000000000-20210827T080054Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a subsequent commit I'll be replacing most of this code to log N
parents, but let's first fix bugs introduced in the recent
2f732bf15e6 (tr2: log parent process name, 2021-07-21).

It was using the strbuf_read_file() in the wrong way, its return value
is either a length or a negative value on error. If we didn't have a
procfs, or otherwise couldn't access it we'd end up pushing an empty
string to the trace2 ancestry array.

It was also using the strvec_push() API the wrong way. That API always
does an xstrdup(), so by detaching the strbuf here we'd leak
memory. Let's instead pass in our pointer for strvec_push() to
xstrdup(), and then free our own strbuf. I do have some WIP changes to
make strvec_push_nodup() non-static, which makes this and some other
callsites nicer, but let's just follow the prevailing pattern of using
strvec_push() for now.

We'll also need to free that "procfs_path" strbuf whether or not
strbuf_read_file() succeeds, which was another source of memory leaks
in 2f732bf15e6, i.e. we'd leak that memory as well if we weren't on a
system where we could read the file from procfs.

Let's move all the freeing of the memory to the end of the
function. If we're still at STRBUF_INIT with "name" due to not having
taken the branch where the strbuf_read_file() succeeds freeing it is
redundant. So we could move it into the body of the "if", but just
handling freeing the same way for all branches of the function makes
it more readable.

In combination with the preceding commit this makes all of
t[0-9]*trace2*.sh pass under SANITIZE=leak on Linux.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 compat/linux/procinfo.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/compat/linux/procinfo.c b/compat/linux/procinfo.c
index 62f8aaed4c..bd01f017bc 100644
--- a/compat/linux/procinfo.c
+++ b/compat/linux/procinfo.c
@@ -18,12 +18,14 @@ static void get_ancestry_names(struct strvec *names)
 
 	/* try to use procfs if it's present. */
 	strbuf_addf(&procfs_path, "/proc/%d/comm", getppid());
-	if (strbuf_read_file(&name, procfs_path.buf, 0)) {
-		strbuf_release(&procfs_path);
+	if (strbuf_read_file(&name, procfs_path.buf, 0) > 0) {
 		strbuf_trim_trailing_newline(&name);
-		strvec_push(names, strbuf_detach(&name, NULL));
+		strvec_push(names, name.buf);
 	}
 
+	strbuf_release(&procfs_path);
+	strbuf_release(&name);
+
 	return;
 }
 
-- 
2.33.0.736.g68690aaec9a

