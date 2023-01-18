Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C992C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 07:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjARHkb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 02:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjARHi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 02:38:29 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB74E32E74
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 23:00:34 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id i1so10390947pfk.3
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 23:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZFcw1A7c0NxWlGZ2/AG3Folnq0FXlK47KTLoBfSkQs=;
        b=Ygf7Jlb8oHKfXOvNk8DPxUfI1U8Txqpp/1MFBwHndyJXTakKgoxFVX4F2E3ZaGll6W
         zslSs36moZImbNTeJTYewr4MXAC9Y8+YXAAIWbaZDafwPSrIrvtFq8d5BdOS8lbPtLC2
         Q5FQQkR9LHaJe6onfLq6vf0FYO7H+sXHyHA8GeQYqb8afpBnQpxN09y+TNlK/KXDscFX
         mRLKrTB8Xgs8VXPodG3sD5IKoB6KitR8otgWGjMRJBeKyLE8aLIoJa81mONb4WCW44O4
         xDqaSoJRbJBRNwx/xu0tZM4dg2qsH/OOwNF8Z4PZG5WfPJ+QLHjL8AnAwwWAiO7xKyWN
         aeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZZFcw1A7c0NxWlGZ2/AG3Folnq0FXlK47KTLoBfSkQs=;
        b=vjc0V1UYhtT9zwft8ruT37TqoHEjQnY5WXMHnXGlXYtITK3ZidoSnJXZrC1o6OSKMR
         XV6Ufp7aMY1xCVoWrUvkP3e4ZuGf0SaHpnJ4i+NfhV/uKSKBHi7/jT1IhPY/9ywO2lZ0
         KRYIxsGqXQq7E5qsHnVGxgeOADtHvadclNIursUVDMPA5Xx/qzmNOSmm+vhzmb2/2F0E
         1homZN9fukUXlnNAR5nc+KMaOBuYXgpFSGrGqgSvMeQdThVVXuFdyHszLrL7KKKkg1NE
         TSSFyTCzK1J6tb09jpyQp0MAaUKMZ4zlzJ8WG6rwjdlpEiJqGa46027Wf6YzLF3uPkvS
         /J8Q==
X-Gm-Message-State: AFqh2koCdEzhnXRKh+bAre4uULY7ntAcmQhdE3OMT9c8Pn3Dkj2fcvcT
        qtet4NOVLCwBntrb0lG6euU=
X-Google-Smtp-Source: AMrXdXuXLujZUKRy8gXyc6adrjW+sBC10nlgBzW5d9HS7mMOh4hgwmAOwK1gp63rA+YpRJodZBbwsA==
X-Received: by 2002:a05:6a00:4088:b0:58d:9ad6:6ae7 with SMTP id bw8-20020a056a00408800b0058d9ad66ae7mr7062120pfb.19.1674025232398;
        Tue, 17 Jan 2023 23:00:32 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p12-20020aa79e8c000000b0058bc7e47a58sm7158695pfq.30.2023.01.17.23.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 23:00:32 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 20/19] branch: the ref_filter is not cleaned
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
        <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
        <patch-v4-08.19-1fe25bc6981-20230117T151202Z-avarab@gmail.com>
        <xmqqedrs8igj.fsf@gitster.g>
Date:   Tue, 17 Jan 2023 23:00:31 -0800
In-Reply-To: <xmqqedrs8igj.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        17 Jan 2023 22:28:28 -0800")
Message-ID: <xmqq1qns8gz4.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recently, a test that uses "branch --point-at" was marked
(incorrectly) as passing the leak tests, but it was premature.

As there is no API support to release the resource held by the
ref_filter structure when we are done, let's mark the singleton
instance that does not grow unbounded as such with UNLEAK() to
squelch pointless leak checker errors.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/branch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index f63fd45edb..4fe7757670 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -742,6 +742,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (filter.abbrev == -1)
 		filter.abbrev = DEFAULT_ABBREV;
 	filter.ignore_case = icase;
+	UNLEAK(filter);
 
 	finalize_colopts(&colopts, -1);
 	if (filter.verbose) {
-- 
2.39.1-231-ga7caae2729

