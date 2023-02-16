Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0993C636D7
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 16:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjBPQ3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 11:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBPQ3f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 11:29:35 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B265354C
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 08:29:26 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id a23so1611637pga.13
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 08:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=oadnHLopr9hhxfSvJJ8qLWTr8LWBcZ3H9bi8BJffQF4=;
        b=WjKQHez8hEyQBe93uDfP/vAAB4+lmhrk4HttfN4x+KGaB0i5xIKdtUMs6JvvDkpJRW
         wfI7P1FEQqtH8vtKCWoHFmhjXiaVs6wVjsDY9Cgrompjdb0OERLt/in+b6aPKvlIy2v5
         mhlaYgyTngg2mBm3LWTmrgZ4hcG3cWCFRCXfZVby4dhPO2M92TyrWSVPQoYte85TcTgv
         ALmssbN/DBjA6BAf0NAW1B4Z/iVvbBV8tyJGmXK2K8DyJxKNnopUFKom4aO73m1Lo/Bj
         K6j3A2gyEo/iDLqOAnslykHK2FKDOvM1IOkj/VdAzVzly18fz/Zv3tbgKPWHdmAwClfL
         dphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oadnHLopr9hhxfSvJJ8qLWTr8LWBcZ3H9bi8BJffQF4=;
        b=patzldjd56i1bzaiDu+cWXkrKpWZKgSxQLtCHXLPJb/ZW6iqglCPv/p8ETklkfOJxO
         cqeaidXMfqxp+IPq7NCUM87m9s7L53tb/WxWp3BumeYG0Jnk9ZZKDZaOaFHFM3hIZtux
         rdkTdo1qTu2M26jTf8eVF0jjtB7M7EOu+M37ovTSVfe+nsCMeE+3YtdVd4qS1PkDgq3d
         vs1J/geeQ4lyEz841lZ7w6SsRBmcKHXBntmrbphvMJUrHM19F532Msq37mLxX3kwqpeS
         mMoFPgBTGrcn+HkOsN+E8quNgAUNg5aEgFOV3jpmpWHsEeYaoIAcYKetqaotdnh4lIKq
         xJog==
X-Gm-Message-State: AO0yUKV5gViKsREHOg2GjO2Yhr8NnC+fb9OZ21ZJ3ZWdUSWeWZBW/o5M
        G8N30n60hmXfmu2TZkKKdVqIE8QEsqs=
X-Google-Smtp-Source: AK7set+RS1CTNPdIZ/4T34zhTs24ri2JGpkEcbwucOoH1655sUZ2h3Bv81GLGpVN+8E0I90QYGLpkQ==
X-Received: by 2002:aa7:9581:0:b0:5a8:65e4:aba9 with SMTP id z1-20020aa79581000000b005a865e4aba9mr5255225pfj.18.1676564966030;
        Thu, 16 Feb 2023 08:29:26 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id j9-20020a62e909000000b005a87d636c66sm1497764pfh.136.2023.02.16.08.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 08:29:25 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3] rev-list: clarify git-log default date format
References: <20230201155712.86577-1-rafael@dulfer.be>
        <xmqq5ycl1c6h.fsf@gitster.g>
        <230201.864js5q9sv.gmgdl@evledraar.gmail.com>
        <xmqqy1phxabi.fsf@gitster.g>
        <d9fc8688-bbf1-96c2-07bf-a12fe38625a9@dulfer.be>
        <xmqqfsbovy7u.fsf@gitster.g> <xmqqsffouhys.fsf@gitster.g>
        <xmqqcz6av3ta.fsf_-_@gitster.g>
Date:   Thu, 16 Feb 2023 08:29:25 -0800
In-Reply-To: <xmqqcz6av3ta.fsf_-_@gitster.g> (Junio C. Hamano's message of
        "Wed, 15 Feb 2023 16:42:25 -0800")
Message-ID: <xmqqzg9dshei.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation mistakenly said that the default format was
similar to RFC 2822 format and tried to specify it by enumerating
differences, which had two problems:

 * There are some more differences from the 2822 format that are not
   mentioned; worse yet

 * The default format is not modeled after RFC 2822 format at all.
   As can be seen in f80cd783 (date.c: add "show_date()" function.,
   2005-05-06), it is a derivative of ctime(3) format.

Stop saying that it is similar to RFC 2822, and rewrite the
description to explain the format without requiring the reader to
know any other format.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * The same text as the previous one; only to correct the lack of
   "--" at the end in v2 that broke the formatting toolchain.

 Documentation/rev-list-options.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index ff68e48406..0d90d5b154 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -1100,12 +1100,12 @@ preferred format.  See the `strftime` manual for a complete list of
 format placeholders. When using `-local`, the correct syntax is
 `--date=format-local:...`.
 
-`--date=default` is the default format, and is similar to
-`--date=rfc2822`, with a few exceptions:
+`--date=default` is the default format, and is based on ctime(3)
+output.  It shows a single line with three-letter day of the week,
+three-letter month, day-of-month, hour-minute-seconds in "HH:MM:SS"
+format, followed by 4-digit year, plus timezone information, unless
+the local time zone is used, e.g. `Thu Jan 1 00:00:00 1970 +0000`.
 --
-	- there is no comma after the day-of-week
-
-	- the time zone is omitted when the local time zone is used
 
 ifdef::git-rev-list[]
 --header::
-- 
2.39.2-501-gd9d677b2d8


