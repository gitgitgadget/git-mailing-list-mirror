Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B22C43460
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 20:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FAFB613C0
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 20:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhDTUcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 16:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbhDTUcu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 16:32:50 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CB0C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 13:32:15 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id l21so3224341iob.1
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 13:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OoACPE5u4SUbbCsECOTUn+hT4tdzz3u6dLtGg/hHiBo=;
        b=AqyrQbrv7aW+3Xl2LqFqxesk3aAqjJummX8gnsusehohcqNDSi9CgyiOa3K8WWf4Rl
         bsy6kNSzLjOUY+CSlMklm0GbEIXfwSv2uuUpvtuQcyondj1QyW7jMcRMGIXChBbhmoy6
         aCOm8NohPJnOBVncSAKKW19AzKsny2lH9MXhqmOg26AUz4VnCE4ZM+Ydo3A4oC1y4hLL
         U5domEzKGm3ap4cxfnOLzNXkXPBD6pzLYxmX/wk6Aet5saTsFdvBbgTVFhzu+8WbVl1m
         ewvDX06NsDTTbhXKr5o+BwBQR+fWdDd6NQdqBP+xQ5JtjdDkASA6yb4+o0vj13FYl2eP
         LPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OoACPE5u4SUbbCsECOTUn+hT4tdzz3u6dLtGg/hHiBo=;
        b=K241wLZ6hm6N1kJnnLs3ITB5Mx9b+0XW56V61+7hHHcGdZUjSNh/2Se4m7qrjLnoye
         1Mjq9lhLZ85Pb5+ihQO9D3vPMt5pWWEvQHZXIj3d5Ls0PF3QIzNQPRUz7fOh7NXcOgWA
         /clng9mHekSsgl0Cz35ArhsTUSAvWbYrAk2JKg/hxX33esMks+hqGQs19mqvwFSIp0JN
         YoOlpuaJBpK8ObV3s45j7cGRgQltxikDazSzmbgVYHahNXigZ1jPmBXLWJ57jwKW3M2x
         G1rc51E9OOzmOrLbnjC6ri2SlsAhhOZgVJ38A4y1rxrad6Fvy6sE/yBNj0tZmjgzhzcU
         OVMA==
X-Gm-Message-State: AOAM5331jl2mipWdUnUp3YXNUpjsGGTww5cFbJSvRLNaGrK3/x2pLqtH
        klpDoq24+CpO7U5mOFKJLDoTOE66denunHbG
X-Google-Smtp-Source: ABdhPJxiWOs4T00UJoiMgUbkneA2ay6r6EgkMGjdlFCDMkB9eLC9vi8TNeFTcy/d3l8SN+pfLjeMAA==
X-Received: by 2002:a6b:903:: with SMTP id t3mr8221586ioi.145.1618950734718;
        Tue, 20 Apr 2021 13:32:14 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:b323:36c3:bfb7:a769])
        by smtp.gmail.com with ESMTPSA id a17sm9032515ili.6.2021.04.20.13.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 13:32:14 -0700 (PDT)
Date:   Tue, 20 Apr 2021 16:32:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH v2] builtin/repack.c: set a default factor for '--geometric'
Message-ID: <8d8dea2e2c149303891cfe6ae8dbec06b538622c.1618950726.git.me@ttaylorr.com>
References: <1ecab817396fae6a1cbafde1ca8b3ebfd9ae4c11.1618883241.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ecab817396fae6a1cbafde1ca8b3ebfd9ae4c11.1618883241.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The '--geometric=<n>' argument specifies that each pack must contain at
least 'n' times as many objects as the size of the next-largest pack.
The factor 'n' is customizable, but setting it to '2' is a sane default.

Instead of making the factor a required argument, make the argument
optional with a default value of '2'.

To ensure that the option is setup correctly, modify the most complex
test of t7703 to drop the explicit factor.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
Range-diff against v1:
1:  1ecab81739 ! 1:  8d8dea2e2c builtin/repack.c: set a default factor for '--geometric'
    @@ Documentation/git-repack.txt: depth is 4095.
      
     --g=<factor>::
     ---geometric=<factor>::
    -+-g=[<factor>]::
    ++-g[=<factor>]::
     +--geometric[=<factor>]::
      	Arrange resulting pack structure so that each successive pack
    --	contains at least `<factor>` times the number of objects as the
    + 	contains at least `<factor>` times the number of objects as the
     -	next-largest pack.
    -+	contains at least `<factor>` (`2` if unspecified) times the
    -+	number of objects as the next-largest pack.
    ++	next-largest pack. If `<factor>` is not specified, then `2` is
    ++	used by default.
      +
      `git repack` ensures this by determining a "cut" of packfiles that need
      to be repacked into one in order to ensure a geometric progression. It

 Documentation/git-repack.txt | 7 ++++---
 builtin/repack.c             | 5 +++--
 t/t7703-repack-geometric.sh  | 2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 317d63cf0d..f7c7e0aeae 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -165,11 +165,12 @@ depth is 4095.
 	Pass the `--delta-islands` option to `git-pack-objects`, see
 	linkgit:git-pack-objects[1].
 
--g=<factor>::
---geometric=<factor>::
+-g[=<factor>]::
+--geometric[=<factor>]::
 	Arrange resulting pack structure so that each successive pack
 	contains at least `<factor>` times the number of objects as the
-	next-largest pack.
+	next-largest pack. If `<factor>` is not specified, then `2` is
+	used by default.
 +
 `git repack` ensures this by determining a "cut" of packfiles that need
 to be repacked into one in order to ensure a geometric progression. It
diff --git a/builtin/repack.c b/builtin/repack.c
index 2847fdfbab..f2359c9d3a 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -494,8 +494,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("repack objects in packs marked with .keep")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
 				N_("do not repack this pack")),
-		OPT_INTEGER('g', "geometric", &geometric_factor,
-			    N_("find a geometric progression with factor <N>")),
+		{ OPTION_INTEGER, 'g', "geometric", &geometric_factor, N_("n"),
+				N_("find a geometric progression with factor <n>"),
+				PARSE_OPT_OPTARG, NULL, 2 },
 		OPT_END()
 	};
 
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 5ccaa440e0..77cd5f2284 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -123,7 +123,7 @@ test_expect_success '--geometric with small- and large-pack rollup' '
 
 		find $objdir/pack -name "*.pack" | sort >before &&
 
-		git repack --geometric 2 -d &&
+		git repack --geometric -d &&
 
 		find $objdir/pack -name "*.pack" | sort >after &&
 		comm -12 before after >untouched &&
-- 
2.31.1.163.ga65ce7f831
