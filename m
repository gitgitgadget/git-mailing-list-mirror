Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ECA22047F
	for <e@80x24.org>; Sat, 23 Sep 2017 07:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750831AbdIWHyL (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 03:54:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32823 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbdIWHyK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 03:54:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id m127so2992281wmm.0
        for <git@vger.kernel.org>; Sat, 23 Sep 2017 00:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=t4KWFaR8ZAYS4QeiOGFhIBpLL/vYX1OjNVILdsIeoac=;
        b=pOGa/BwuLFcB/xorQ+tBkaNi/M6OCzKYXXAP7WzNonwkS0DJxmJ508aZVKxJqJA3iV
         quSDvi3BV4fEE8x8LuDxEImTAzApmW/f1KFknHZwf8AHCBYT27p7Xugys9JVCqla913I
         9pme3BgHlHg7j7TrlBkUoj1/qPis5CinCtzDJuIt3KFNyxJrqlQ4JyD5AYKGOOLGx69r
         zAZ8AiblyKMaFVd5nOvrCQ/W2c3XQLCvZJZtcYCJBEGeAALVAhdznAFy8wlrdQIRLD+E
         uK2F9WoJdMBOhi99/U5ukrMN4fqbY8c2XJXLKK3RXQGnCFZ1wi3VlsiPDBEHYboW1uCp
         Msyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=t4KWFaR8ZAYS4QeiOGFhIBpLL/vYX1OjNVILdsIeoac=;
        b=Po4hFTJvVFFzAA8Ayd/au+fS0NfApVToA3pzYO26mhlQATY4XTjTSLmHzJFJNE6gvG
         vnWgDQnqJ5BIU5M+1WQpWolpbvGAlxtwnQPqx+iisglGdkLBVFyr+4FZ816fF+7TPUor
         4yOmsZS5h77Nm28eoo1cvZDvK1sWmt9POHqJ6zqQas7gHvr5mGrOnb7b+HG9SmXo7oaw
         1ZtvwfF5KAeaBblh2QwwaEu46ygeRtpDwJCGJTxVmZe0GnwV/J3HA+pxk5IsOA/WZv+P
         3mz58Tib2QpDzfB/hKeSxnC8cdvKpN1PyvaSJ8zSv8//7NhlllmBoYoaOEcr9HIoR+j6
         Ei0g==
X-Gm-Message-State: AHPjjUjS5RkFNWH8SUJ7HCePpJ8hbtSDrNu9kjKnoHVWa6uK8MCtl619
        EYaxwJAWB9bZdTeLOVj31u2FurCnvWkL/Q2do1fox5/z
X-Google-Smtp-Source: AOwi7QCWKW0vMQga0xy0lnfrgac2/mtGdqwyse5GR23+vTAbLwCInECcl8aylo7MEi0wJoGjKoSl+J0VdybftLQLhRc=
X-Received: by 10.28.45.9 with SMTP id t9mr4463134wmt.94.1506153248335; Sat,
 23 Sep 2017 00:54:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.154.247 with HTTP; Sat, 23 Sep 2017 00:53:47 -0700 (PDT)
From:   Ilya Kantor <iliakan@gmail.com>
Date:   Sat, 23 Sep 2017 10:53:47 +0300
Message-ID: <CAFU8umjZL0nXUFbuZWVapTaCfAjtAoTT=G3GCKczDE7O8bzAOw@mail.gmail.com>
Subject: [PATCH] userdiff: fix HTML hunk header regexp
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Current HTML header regexp doesn't match headers without attributes.

So it fails to match <h1>...</h1>, while <h1 class="smth">...</h1> matches.
The fix makes attributes optional.
The regexp is still far from perfect, but now it at least handles the
common case.

Signed-off-by: Ilya Kantor <iliakan@gmail.com>
---
 userdiff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/userdiff.c b/userdiff.c
index 6321103ce..dbfb4e13c 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -38,7 +38,7 @@ IPATTERN("fortran",
  "|//|\\*\\*|::|[/<>=]="),
 IPATTERN("fountain", "^((\\.[^.]|(int|ext|est|int\\.?/ext|i/e)[. ]).*)$",
  "[^ \t-]+"),
-PATTERNS("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$",
+PATTERNS("html", "^[ \t]*(<[Hh][1-6]([ \t].*)?>.*)$",
  "[^<>= \t]+"),
 PATTERNS("java",
  "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
--
2.14.1

---
Best Regards,
Ilya Kantor
