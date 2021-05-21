Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567C8C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 21:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31372613EC
	for <git@archiver.kernel.org>; Fri, 21 May 2021 21:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhEUVUV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 17:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEUVUU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 17:20:20 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01967C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 14:18:56 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso7408412wmc.1
        for <git@vger.kernel.org>; Fri, 21 May 2021 14:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=yUgfyvKEkWcl1taLVC0ce0rLgkqv30cLK3ahrF0pTHs=;
        b=rsy/z0MLiWt71wCdd+R0RpkWvi88denSMPoVXuRqsHmZJec6yPPZpzWAf8CmuE5xF0
         BiXEMda/1HMC8Ho/80pAsBcDLBnZ/Tn6YJuSUoGmVVLJ4MRJBMWg2D0R2t4ya1HFvD85
         SiJa4cubWXJKBsyXH2R0YXcDcfbSnfPkmnAJQXfBi9BnfdaiCUzMsLU5L9Qj6fSTF/uz
         AJlHUcp3yrGX4Iv+BkM8l+6NKqUPBijRcHVaw8GMADc3sucXHbgTrrf1f3/kjxUrF10r
         SRbPgR/VsHcLRdI9QpIWOBzoAhiz5dJu3MoVADa+y/RHY6bAhM9xu87UxCrNWk0XMYar
         Zr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=yUgfyvKEkWcl1taLVC0ce0rLgkqv30cLK3ahrF0pTHs=;
        b=MnA5HvUudlMXl058q3gKVKo2tmHic/uP40WPhhO05PyHhYd7ZMQvd13z7ySpJo4zqZ
         tIxr+Wytz9OtQ6GfnEDVBRNu2y58ayVi5xg0YEZdeMFU2/ZGRoZCxOrJMNn6aq1OC4yX
         sbIiRYlZDvFZZZkmQFBeXSD1izdLaJfOGG8ilw5i3tR5H+Go/PERdTCGp/jyN1L59n9p
         RsiQjaxzefJVyxwkMzRyyM4sHVUjp0mP/0plPbb9yA4G3bfXs6NuTE0AK1O0uDqPqljI
         5tnNJEQC910ROgjWRzXPcA+WTgnbDU9juok068+nsnevV/1I8fLcAS/WE6YTyTw5nEoe
         KQaw==
X-Gm-Message-State: AOAM5339qFcGBiu8RlkrApFJPz0jpV+7nb+m+ZOjKjjiHtugfJc+/APz
        GrKVGaSIFRh863wlbYEDJ6icT1eWmb23mA==
X-Google-Smtp-Source: ABdhPJw6DFwEE38xN6eKhr9pm94Kk3DR24yBfnBF+8hOgn+sQI4t2gawkVEk1lzpuHlAPTbS15Wqkg==
X-Received: by 2002:a1c:3186:: with SMTP id x128mr10108067wmx.167.1621631934387;
        Fri, 21 May 2021 14:18:54 -0700 (PDT)
Received: from [192.168.1.182] (host-92-30-127-152.as13285.net. [92.30.127.152])
        by smtp.gmail.com with ESMTPSA id q10sm685757wmc.31.2021.05.21.14.18.53
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 14:18:53 -0700 (PDT)
From:   Aidan <aidgal2@gmail.com>
Subject: Formatting options are ignored when tracking functions
To:     git@vger.kernel.org
Message-ID: <63cf407c-95bd-fdda-88ec-5eca36d24998@gmail.com>
Date:   Fri, 21 May 2021 22:18:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git log with formatting options do not work when using -L:<funcname>:<file>

Works as intended for path
---------------------------
aidan@AidanLaptop:~/Repos/git$ git log --oneline -- advice.c
a20f70478f add: warn when asked to update SKIP_WORKTREE entries
3b990aa645 push: parse and set flag for "--force-if-includes"
c4a09cc9cc Merge branch 'hw/advise-ng'
---------------------------

Works as intended for revision range
---------------------------
aidan@AidanLaptop:~/Repos/git$ git log 91e70e00ac..HEAD --oneline
107691cb07 (HEAD -> master, origin/master, origin/HEAD) Merge branch 
'ds/sparse-index-protections'
2b8b1aa6ad Merge branch 'tz/c-locale-output-is-no-more'
c69f2f8c86 Merge branch 'cs/http-use-basic-after-failed-negotiate'
---------------------------

Does not work tracking a function
---------------------------
aidan@AidanLaptop:~/Repos/git$ git log -L:vadvise:advice.c --oneline
b3b18d1621 advice: revamp advise API
diff --git a/advice.c b/advice.c
--- a/advice.c
+++ b/advice.c
@@ -99,19 +141,23 @@
-static void vadvise(const char *advice, va_list params)
+static void vadvise(const char *advice, int display_instructions,
+                   const char *key, va_list params)
  {
         struct strbuf buf = STRBUF_INIT;
         const char *cp, *np;

         strbuf_vaddf(&buf, advice, params);

---------------------------

Is this a bug or am I invoking the command incorrectly?

Kind regards,
Aidan
