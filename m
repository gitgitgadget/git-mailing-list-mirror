Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54560C636D4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 00:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBPAnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 19:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBPAmz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 19:42:55 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B954C42DEA
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 16:42:27 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id bd35so423344pfb.6
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 16:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UeSoxOGwSwTSaVj9fVWpnclz5i1etrOyMr+2khkYEtI=;
        b=JhWqi8xa8xTxT8YI3DDHJDbSAmO4Jc2OtZWKZALz9jg7MWu1VlJ7faI7xIBq9cioHI
         OXccBj6eUiCHfN1afezVOzyOd7GrUn4se+YGkeThK1Vm1xK4x1IgSXe0iqd/8IkKlFkr
         aVrj2UgcTOD+ldPnTgXcjokBZhFstxxWgcL8RdVhje/P8gaxZQGdIzveShMkb8yK+sQE
         GjsAY9VNlPJa4Wvwd9Pq4r1EzuYzNIkZ8tk/gxaqpPyFULGglKQ0YyivrMlsI25BhtEn
         IsIua5The+4f3T00Qv3IQYcX+Z1jffi/GIZq3UG49IKKRvzkiUDbIf25365b/wOSmAFf
         lRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UeSoxOGwSwTSaVj9fVWpnclz5i1etrOyMr+2khkYEtI=;
        b=sleU9Oyc613DBAsrrgsWCZcpcfT0LpoBvHXwfZ0KaEOR2gW5burEwJln3qx7FzBWWU
         A0RKONwx7KnhJ+cyNDSyeNRyroVHOP9UluD97tQNfoLhpI8m4y5tVHi0GMDpBJBLMajm
         MpmzBtahohqDVUm2X2gCfhrM2glrohD2qZMIgXNdkAs/X1RMVaCFgLHq+lAZdEdCV8Oc
         plyVyQtU3mgKTq0u9SV1VYJP2/qjauR3Eur20eEHu2vsoLBgJo4IZfXRJ5nRRCgQWxQM
         81OFq82jqet8X5yMjheZCwtbKGwnNCmACfvuQS+IbTsyubtRur0PxFEPaVMekwZtFWXu
         hOmQ==
X-Gm-Message-State: AO0yUKWlXQr1/aqLszNLxAL4pWgq62/NxyWhTU/RQQJCEg62++43JVRH
        e23B/CVjM3rdURE9wl2Y9AUDqOOd41o=
X-Google-Smtp-Source: AK7set/hcbNIDWWlKs1sG5Dll5frtJGrm7R6PSkcM1znQ/xfuZPg1iur+jJFH9HZAGkvsjkfTn/ouw==
X-Received: by 2002:a05:6a00:2388:b0:594:1f1c:3d2f with SMTP id f8-20020a056a00238800b005941f1c3d2fmr543164pfc.4.1676508146595;
        Wed, 15 Feb 2023 16:42:26 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id c2-20020aa78802000000b00571f66721aesm4529654pfo.42.2023.02.15.16.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 16:42:26 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Rafael Dulfer <rafael@dulfer.be>, Jeff King <peff@peff.net>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Rafael Dulfer <rafael.dulfer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v2] rev-list: clarify git-log default date format
References: <20230201155712.86577-1-rafael@dulfer.be>
        <xmqq5ycl1c6h.fsf@gitster.g>
        <230201.864js5q9sv.gmgdl@evledraar.gmail.com>
        <xmqqy1phxabi.fsf@gitster.g>
        <d9fc8688-bbf1-96c2-07bf-a12fe38625a9@dulfer.be>
        <xmqqfsbovy7u.fsf@gitster.g> <xmqqsffouhys.fsf@gitster.g>
Date:   Wed, 15 Feb 2023 16:42:25 -0800
In-Reply-To: <xmqqsffouhys.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        02 Feb 2023 08:53:31 -0800")
Message-ID: <xmqqcz6av3ta.fsf_-_@gitster.g>
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
 * The discussion stalled and the topic was left in limbo for a few
   weeks.  Let's attempt to reboot it instead of silently waiting
   for a rerolled version from the original author.

 Documentation/rev-list-options.txt | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index ff68e48406..9ae7ccdaa9 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -1100,12 +1100,11 @@ preferred format.  See the `strftime` manual for a complete list of
 format placeholders. When using `-local`, the correct syntax is
 `--date=format-local:...`.
 
-`--date=default` is the default format, and is similar to
-`--date=rfc2822`, with a few exceptions:
---
-	- there is no comma after the day-of-week
-
-	- the time zone is omitted when the local time zone is used
+`--date=default` is the default format, and is based on ctime(3)
+output.  It shows a single line with three-letter day of the week,
+three-letter month, day-of-month, hour-minute-seconds in "HH:MM:SS"
+format, followed by 4-digit year, plus timezone information, unless
+the local time zone is used, e.g. `Thu Jan 1 00:00:00 1970 +0000`.
 
 ifdef::git-rev-list[]
 --header::
-- 
2.39.2-456-gb1485644f9

