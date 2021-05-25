Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E195C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 07:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01E296128B
	for <git@archiver.kernel.org>; Tue, 25 May 2021 07:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhEYHtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 03:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbhEYHtG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 03:49:06 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE95C061574
        for <git@vger.kernel.org>; Tue, 25 May 2021 00:47:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gb17so27758972ejc.8
        for <git@vger.kernel.org>; Tue, 25 May 2021 00:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Ddj6eC5Vs3nkxTbe/fAF3AQ740xmXg4OryJK+Sj0izI=;
        b=bWqbGuZbWzfJoXBsX+ZM+nUsIBA50wGEiWNpw/toRVmAqqotYuGslzLMQ0EHfSeUe8
         q1/JdpfDpM8ZUjVGK0gcz5RRKHGcSeU8DlLa5HZs+bGLTO9+ALDA2//WGgs1u4Fk8c5A
         XBUr6VQU8SLklMQ83XdiaKUDFswezQaLYf6lEof8tJfh9bhz5PF3c5DWZOIlVAoNmH0e
         ChXektNNEGvvgZfhdyE0YRKlCMASL3VWlrCSRqm0qYLnw42uH+dN3B0yqzWl0Ux4IKh/
         3L3G/P6a13n6edPW1VRUUX/trGHjlnYqiuiHqClFQNrFLR+jzoNO5imjR4lazHssbguF
         MZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Ddj6eC5Vs3nkxTbe/fAF3AQ740xmXg4OryJK+Sj0izI=;
        b=F9hbf9v1b8AFyFPXuQQldzKK7XnAvfzLR/UTD4jOhab6ef0mcoFHmOo+KAnIUUB3d/
         cjPDObIujCoc97uyLrGz7NmGoqMePPolR91WMTJGyTzZE6qsQoN2ILG38K3xqUEm/Y86
         brRCDbIzBn0X7r2V05pRD2G9J3O+KtGnHdrC+N7sfsrtzmdxA2gjfAAYGseQAqT7W6De
         x0HDLBqPo92nsbjrzmLimYqHI8md8Bz8p4waLdHvRiMOe1rhRPKSmhZrU2eYuTxsRWTw
         3TWJqDrFeMM6z7JMHvS5EARblhX5hpHE0S+YPfU1yW9XbkBcv6hcYJU2nTOlayPpRaNB
         ENgw==
X-Gm-Message-State: AOAM530Px7USYRLN1dsi5F4z6VOWGiY3hp7QE7pD1Oyw4oR4a1htn/YL
        dvfxlJL+WFp277yYDYCsVVI=
X-Google-Smtp-Source: ABdhPJwqJ6vChpCTUE/+nvXw5iSXHRNKQ+k0r8hfQCI1gsjFhLyeyOjSSdWBQN4HYVOQRDw7pCemrA==
X-Received: by 2002:a17:906:ca4f:: with SMTP id jx15mr14693122ejb.160.1621928853742;
        Tue, 25 May 2021 00:47:33 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id gb26sm9112458ejc.25.2021.05.25.00.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 00:47:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] t1092: use GIT_PROGRESS_DELAY for consistent results
Date:   Tue, 25 May 2021 09:39:02 +0200
References: <pull.960.git.1621886108515.gitgitgadget@gmail.com>
 <YKwMU13DOtTIgaeP@google.com>
 <e35b5217-362f-fc4f-7396-08218a9abf63@gmail.com>
 <YKwd2e5VxVmU6zqj@nand.local> <87fsybohy5.fsf@evledraar.gmail.com>
 <YKxBIP4lkoPeCYvb@nand.local>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YKxBIP4lkoPeCYvb@nand.local>
Message-ID: <87y2c3mezw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 24 2021, Taylor Blau wrote:

> On Tue, May 25, 2021 at 12:57:52AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> On Mon, May 24 2021, Taylor Blau wrote:
>>
>> > But I don't think this isolated instance should push in the direction =
of
>> > adding support for either of the above, regardless of how easy it might
>> > be.
>>
>> I don't see why we wouldn't just tweak GIT_PROGRESS_DELAY to support -1
>> or something for "inf".
>
> Ironically, I think that this already works, since we parse the value of
> GIT_PROGRESS_DELAY as unsigned, and don't bother checking for if the
> input is negative (since we eventually call git_parse_unsigned(), which
> doesn't have any extra checks other than for overflow).
>
> So we silently convert -1 to 2^64-1, and call it a day.

Well yes, it works in the sense that instead of arbitrary big value for
delay we have the biggerest and largerest value we can manage :)

I mean why do just that when we can also do this:

diff --git a/progress.c b/progress.c
index 680c6a8bf93..191c62cbbfb 100644
--- a/progress.c
+++ b/progress.c
@@ -252,7 +252,13 @@ void display_progress(struct progress *progress, uint6=
4_t n)
 static struct progress *start_progress_delay(const char *title, uint64_t t=
otal,
 					     unsigned delay, unsigned sparse)
 {
-	struct progress *progress =3D xmalloc(sizeof(*progress));
+	struct progress *progress;
+
+	/* GIT_PROGRESS_DELAY=3D-1 */
+	if (delay =3D=3D (unsigned)-1)
+		return NULL;
+
+	progress =3D xmalloc(sizeof(*progress));
 	progress->title =3D title;
 	progress->total =3D total;
 	progress->last_value =3D -1;

Which will cause the progress code to abort early in that case, and IMO
is less magical if we're going to have this GIT_PROGRESS_DELAY=3D-1 in the
codebase and relying on the wrap-around of -1.
