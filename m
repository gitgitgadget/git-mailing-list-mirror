Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EE4C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 07:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbiHEHwV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 03:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbiHEHwU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 03:52:20 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD5510FFE
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 00:52:19 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d20so1594540pfq.5
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 00:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=lEnDYITPseCu0YJhDhgChvRay2YjrdZY4s7PBcSaKFo=;
        b=CoNDzs20ihpjJ3CPv+GB/+PdbEifjlF9tRH9O6tpANxPsPBX4DAk0BH2Y002j/Ojtu
         08RovPJ7enOQGI5dDilIufxN+LV9Vrh53THhz/TIgdJycg8Hm8Vckrlspm0D0MVGagM0
         n84Bzpe09y0V9kWnzwuQUxfwh0mdKdEyfYhuw+AcdO+5FFk5YBXo/w4UaL9w47Zm+9UP
         TC/2C0kturi/imL0att/spcdR3sWD12U+zjDWL9X1D62zo3uUGElxVlTQLp8f1u0w2Xv
         qwJ37747q5xaP9HJxq8uzK4QLOgryj4SrueYt6dM1BtfYPuUHaoIBqur3vqJtGR44LFr
         BClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=lEnDYITPseCu0YJhDhgChvRay2YjrdZY4s7PBcSaKFo=;
        b=RUAUYrbsROaG6cFc+em/Waq8zaQYtishtrGh17woeeg0urRjmmb7ImiJNXoqA2YXBD
         UbnPd5u6rZk5HUiB9Zj78nxa4cjByGvcba5KWGNbsElECMH3WSunr1AI/GIh8mQRaUMF
         K1jEiPv3bIdXBJkA9a4P/1cGFjwiJDx9JNF3FXNIiVRBKC0dFoPB9tR+C61i61LuoLU4
         BQ5WMr8JcObKBRq0MT6lGjX6QEnsrsC7cmbT5u0ArsfAMOrZD6f3p6GujErFOl5cf6WV
         zQR6bakhKExiruiVy4JddE+TzfGC0Acilh70GxuTalcSETrv3Yt7OiJHwgSvC2cFY1Bh
         5ahA==
X-Gm-Message-State: ACgBeo2Q7gLcwgouEWz5ih1/mT0Gd2phlDQslc2eb8mL/OyerlPcblaA
        qJzHjAbI7vymobfm8fjoLNg=
X-Google-Smtp-Source: AA6agR4mpOcfxHcH2ZPTPJJJSCVUDArgDaGHdmU9MZa3Whj9qs6HeePaEae4hhcrUaocxsLw4hSG/g==
X-Received: by 2002:a63:4620:0:b0:41b:8a9:9868 with SMTP id t32-20020a634620000000b0041b08a99868mr4702616pga.345.1659685938738;
        Fri, 05 Aug 2022 00:52:18 -0700 (PDT)
Received: from localhost ([113.172.46.62])
        by smtp.gmail.com with ESMTPSA id k18-20020aa79732000000b0052d16416effsm2265555pfg.80.2022.08.05.00.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 00:52:18 -0700 (PDT)
Date:   Fri, 5 Aug 2022 14:52:15 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Ilya K <me@0upti.me>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [bug] Segfault in git commit when a hook has a broken shebang
Message-ID: <YuzML2lVGDBIK1uF@danh.dev>
References: <30015309-00f1-9b44-023c-001ee3f242e4@0upti.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30015309-00f1-9b44-023c-001ee3f242e4@0upti.me>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-08-05 08:45:02+0300, Ilya K <me@0upti.me> wrote:
> Hello! I ran into a weird bug just now that is probably easier to show than
> explain:
> ❯ git init
> Initialized empty Git repository in /home/k900/test/.git/
> ❯ echo '#!/usr/bin/oops' > .git/hooks/pre-commit
> ❯ chmod +x .git/hooks/pre-commit
> ❯ touch oops
> ❯ git add oops
> ❯ git commit -a
> fatal: cannot run .git/hooks/pre-commit: No such file or directory
> [1]    24580 segmentation fault (core dumped)  git commit -a
> This happens consistently with git 2.37.x, and I don't think it happened
> with git 2.36 or earlier.

This seems to be a side-effect of a082345372, (hook API: fix v2.36.0
regression: hooks should be connected to a TTY, 2022-06-07)

Since it makes hooks run in "ungroup" manner, hence run-command will
pass NULL as first argument to notify_start_failure.

This patch seems to fix the crash, however, I think we should remove
that clause entirely.

---- 8< -------

 hook.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hook.c b/hook.c
index d113ee7faa..dc54a2ac67 100644
--- a/hook.c
+++ b/hook.c
@@ -84,8 +84,8 @@ static int notify_start_failure(struct strbuf *out,
 
 	hook_cb->rc |= 1;
 
-	strbuf_addf(out, _("Couldn't start hook '%s'\n"),
-		    hook_path);
+	fprintf(stderr, _("Couldn't start hook '%s'\n"),
+		hook_path);
 
 	return 1;
 }
----- >8 --------------

-- 
Danh
