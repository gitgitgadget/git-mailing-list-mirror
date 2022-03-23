Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AB7C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 09:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243370AbiCWKAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 06:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239268AbiCWKA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 06:00:29 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7238515A0
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:58:59 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t14so709927pgr.3
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F+kX71v3yDzOjvDh5tYCU0xXbVJ+poOJSUitPTAfHpk=;
        b=cXDVEnhRIIiqLHyPfbSJ7kDYmWV3fHQ7JjAIDJ0v+IQD/NAldxJAX1hENbJ7G4wOtW
         t2nhvmf92+auu/8m4HwfGZM5BTqBvG7+00baHAIvUnKk7GxldpAPHVKd6686H0BeV91D
         KMZOBMHj2pCc3PQguJ9u3inM0UwUbHa/M0Js49SmolAK/MILt4bg/SWpIMG+hGDQ6stF
         q0+icootCXmhxtNHXStOSHx0EEdtKaKOGQBH80DLgZDvk9XuT4WfKNCQVFC91kJ1DlKU
         CROlcOJwz+04iZrL7QOVuo4cTfyy8SOAh+xb8+9+qhvijsmlZQjInhnpjy6s447NTj+w
         yDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F+kX71v3yDzOjvDh5tYCU0xXbVJ+poOJSUitPTAfHpk=;
        b=BAzASbsZtTSrbV0kD3dCXij/ba4HTQc7beUbkhT5Sa2c0q+h7cmD9zr1D0h0XL+uKV
         nW/4SiuPzQecmsoXBDrNZB0XoHNB3e+Gifz0cIqFKf+pN/zHNfa4D4iOZTCdakkXLjeD
         HJ6inx3tceAAF+u003Fh1GbzqMuPILGDP1oWQtjkzl1x8i/RGhjbRZV57zdl7yR9nXPj
         ubV5ATOATzs0FaiNXydrwmRAtR6Q/3yvh3/u2CGHvNB65wbVG/MwhoebwBJpuvFsu301
         RVMdlZXRXnAaFF6m0c80JKxZprrLKoESukXLPqSX+UwUPmOxDsRqalLTB6B1QSkMSVaI
         Tf+A==
X-Gm-Message-State: AOAM530xiUXEbj6QUwtwX/VO/rbQyHB4dM4RCKfgnb4NLeYIOFuttyV0
        /EcwCG770kR41Gy/qf0tVME=
X-Google-Smtp-Source: ABdhPJxFK1r06zi+tLXENRKQITMSUZqsKteQp2+7Nwv77OnqvV+HySR/RacbeHMcdsGtb3UH4DCxZg==
X-Received: by 2002:a05:6a00:3387:b0:4fa:9063:dfed with SMTP id cm7-20020a056a00338700b004fa9063dfedmr18150726pfb.15.1648029539188;
        Wed, 23 Mar 2022 02:58:59 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.57])
        by smtp.gmail.com with ESMTPSA id il7-20020a17090b164700b001c779d50699sm2758558pjb.55.2022.03.23.02.58.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Mar 2022 02:58:58 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        dyroneteng@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v13 16/16] ls-tree: split up "fast path" callbacks 
Date:   Wed, 23 Mar 2022 17:58:54 +0800
Message-Id: <20220323095854.7787-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.577.g74cc1aa55f.dirty
In-Reply-To: <220321.865yo7d5ki.gmgdl@evledraar.gmail.com>
References: <220321.865yo7d5ki.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 21 Mar 2022 10:20:34 +0100, Ævar Arnfjörð Bjarmason wrote:
 
> FWIW I didn't do any exhaustive benchmarks of this, but I checked a few
> things against origin/master on linux.git and all the reported
> "hyperfine" timings were the same/within the +/- interval.

I sended a reply on gmail but seems not updated on public-inbox,
so I sended again use git send-mail this time. If the duplicated
message appears, sorry for that.

I tested the performance between fast-paths and non-fast-paths again on linux.git.
And I found the default format appeared a performance regression which maybe was
brought by this commit: 

    $hyperfine --warmup=10 "/opt/git/master/bin/git ls-tree -r HEAD"
    Benchmark 1: /opt/git/master/bin/git ls-tree -r HEAD
      Time (mean ± σ):     111.3 ms ±   2.3 ms    [User: 86.2 ms, System: 25.0 ms]
      Range (min … max):   107.8 ms … 115.1 ms    25 runs


    $hyperfine --warmup=10 "/opt/git/master/bin/git ls-tree -r --format='%(objectmode) %(objecttype) %(objectname)%x09%(path)' HEAD"
    Benchmark 1: /opt/git/master/bin/git ls-tree -r --format='%(objectmode) %(objecttype) %(objectname)%x09%(path)' HEAD
      Time (mean ± σ):     159.1 ms ±   4.7 ms    [User: 131.8 ms, System: 27.3 ms]
      Range (min … max):   152.3 ms … 170.4 ms    19 runs

Further, the other fast-paths except "default format" seem like what we expect, then I made this change:

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index c9eb7f7243..7d784f97c7 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -406,15 +406,17 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
         * The generic show_tree_fmt() is slower than show_tree(), so
         * take the fast path if possible.
         */
-       while (m2f++) {
+       while (m2f) {
                if (!m2f->fmt) {
                        fn = format ? show_tree_fmt : show_tree_default;
                } else if (format && !strcmp(format, m2f->fmt)) {
+                       fprintf(stderr, "[dyrone] format: %s\n", format);
                        cmdmode = m2f->mode;
                        fn = m2f->fn;
                } else if (!format && cmdmode == m2f->mode) {
                        fn = m2f->fn;
                } else {
+                       m2f++;
                        continue;
                }
                break;

----------end diff---------------

After the scenario has been tested agin, the result seems OK:

    $hyperfine --warmup=10 "/opt/git/master/bin/git ls-tree -r --format='%(objectmode) %(objecttype) %(objectname)%x09%(path)' HEAD"
    Benchmark 1: /opt/git/master/bin/git ls-tree -r --format='%(objectmode) %(objecttype) %(objectname)%x09%(path)' HEAD
      Time (mean ± σ):     112.2 ms ±   2.5 ms    [User: 86.3 ms, System: 25.9 ms]
      Range (min … max):   108.8 ms … 117.4 ms    25 runs


Thanks.

