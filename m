Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BDDC61DD8
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B8A221F9
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVmvEjOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbgKPQIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 11:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731658AbgKPQIi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 11:08:38 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34EFC0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 08:08:37 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id l1so19252142wrb.9
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 08:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I45Wez2549eUcVcvjzTBIh58pyxNIL9ydV8QhHpZrSs=;
        b=sVmvEjOrfiQ72g4ptzgbVRwIktv2ALrkds1QgWASNCYKtYPeJnziWQ5JgvokPx8e7L
         E+cl1vMufRsN0SuF+B9p7/PV8hKc5Mbd2ImQSewfbbA+/MXmrHXv92wsyGuRJ29HxjDA
         MMSJIq6bM0AAUxxfsMoCRqr17Mpfc6rz5+wxY3kcY8KnwCX40xJ7mC+bM+31/5sCm+yt
         K9zH4MXG0MW/9Xai0dMTVYX3wl9zfz8AmzsQAT+gYY/aqZiCnei7fXKuI8u2DamOs9jE
         v3ocGfs5bbxYblU9YWK5gVM0SUTgmnYSZukB5NX9pQwlW5RyqwRfYThxasofNm/VxZ5m
         lBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I45Wez2549eUcVcvjzTBIh58pyxNIL9ydV8QhHpZrSs=;
        b=XO+5ihtgcq6EuTDesezelxXpjwKdxOcC8hwQGSDgFniIokoGlxF7YEanJCaYdwfJgM
         pkBqiKdG0GV03uZt/e65DrNujk//L9WlY5GGmB1ICG+DBFORB3jyFUfYXJcFObyxvaEu
         yUGPV42HuRSVu/FujHAvhTFENko9HiKxR867wcn/6Z4ua961+ZjvY8P5oOh6okKnPqeP
         C0yELdGgHYjnPpzrM7Qqe2trPWVV/0KCyc+638CkMQqPP7v6gbaxtv5b9Y5w+zn14gvR
         uOUoWuep9a7xVUqpl2XpyN/6Qhckd2AmJJN0Jl7oT3k+L1DHnFiunr/4G7z2TGq+257p
         zcNQ==
X-Gm-Message-State: AOAM530E4pNqv0/jvT4gc08TrbckT5pDChKmyLE6+KWHswmUuEOq7PGh
        /jr2S7/whyodKYW2FoPOTFEVzDELwn4=
X-Google-Smtp-Source: ABdhPJwMduVXgsGH+XeWyZ6jK9MGUOSBJAz7P4DtfPzMcqqfXX1ZRD+r5QRqbCIWeoa+Yo/ggmZ0Jw==
X-Received: by 2002:a5d:62c7:: with SMTP id o7mr15930655wrv.29.1605542916574;
        Mon, 16 Nov 2020 08:08:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k3sm3349509wrn.81.2020.11.16.08.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:08:36 -0800 (PST)
Message-Id: <98deb538d91ba0ab485fa8d97cc6062bcc680938.1605542912.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
References: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
        <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Nov 2020 16:08:24 +0000
Subject: [PATCH v3 03/11] add -p (built-in): imitate `xdl_format_hunk_hdr()`
 generating hunk headers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In libxdiff, imitating GNU diff, the hunk headers only show the line
count if it is different from 1. When splitting hunks, the Perl version
of `git add -p` already imitates this. Let's do the same in the built-in
version of said command.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index be4cf6e9e5..b6d53229bb 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -661,9 +661,14 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 		else
 			new_offset += delta;
 
-		strbuf_addf(out, "@@ -%lu,%lu +%lu,%lu @@",
-			    old_offset, header->old_count,
-			    new_offset, header->new_count);
+		strbuf_addf(out, "@@ -%lu", old_offset);
+		if (header->old_count != 1)
+			strbuf_addf(out, ",%lu", header->old_count);
+		strbuf_addf(out, " +%lu", new_offset);
+		if (header->new_count != 1)
+			strbuf_addf(out, ",%lu", header->new_count);
+		strbuf_addstr(out, " @@");
+
 		if (len)
 			strbuf_add(out, p, len);
 		else if (colored)
-- 
gitgitgadget

