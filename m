Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56410C43460
	for <git@archiver.kernel.org>; Fri, 14 May 2021 15:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 333A161108
	for <git@archiver.kernel.org>; Fri, 14 May 2021 15:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhENPov (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 11:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhENPot (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 11:44:49 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CB0C061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 08:43:38 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j10so43649520lfb.12
        for <git@vger.kernel.org>; Fri, 14 May 2021 08:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6bRWEe/XfOFf0HOHwbuiJ8YKaY9UbocbjhHryHSCji8=;
        b=RcpJT+Teg/fwEjmxsmeKGvu572U62vE3COkqFFnKkmM3rmmkK6iCHgGXPmUuD1wb9/
         +ApAKyW7o1bmF46Bz+Dmzvh8xD80bZsdi+3Mj+ed7cu0hCyzJsmtlWT0ZWM2H4ozsVSd
         uxjGNEa/LLBg6LO+1EqeotNd2ny3YucxOApb6V83xKvk/BozNinX1RMXEPFZ/IHiwryF
         omheHIdeoCABJf/R6rWPNfX4JGF15GmKMI5B0bD1tGbwCVQ/+gKAaTKpNFQc4DtrS2Bu
         hVRyEH+D5bs8NufTEtDV31bpFI3uB/5vPL1FLrJ+hOkNHrYalpMnvdUWT5JHhVVD8mXL
         uxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6bRWEe/XfOFf0HOHwbuiJ8YKaY9UbocbjhHryHSCji8=;
        b=Cc/FANCy8fBIhRK/6/JCLM8/excmsPk0PGK+nXMk3yLYjAnkv5Lrddm5l1tSAVZcjj
         pLi+3ZvQovv7F8ynM1h0D/UgoHho4NLRWutGc/6amE4oc2QUZNS/G4cGAST59cCS9g9/
         xX17BOQAWPKrfLkjQQ8kD4dz8IJDKYldCatLUAFo/kbBGFigmeugLPjwczl6TTFKo7uV
         DUZUBqjbHPR6W7dnr0RJLId9mSVnyD0zclFQfDj70mI15yAL5diGQ0ltAISoW5VEhYL1
         ztoQS1GND1kTASPZ2aHsC1hwm3TEAnfxCthxZboU46hfHaWQ0A5yqLkG9jyW8tWDiTga
         LycQ==
X-Gm-Message-State: AOAM533TWO1n3uOQNpeXGIciWRe+g29h6rbQEeQIWGGdb+Kcd3EYXL9p
        QsmNCy9eXHUrNEq3Z/SFEx1p4N7NUQA=
X-Google-Smtp-Source: ABdhPJy22Lk8ytUeAalYTCGfW8rg1UoU5jz6KBDJ6wbkYaBn2hi4nxZDX7D2kAJoiGdnMHUipnqeAg==
X-Received: by 2002:ac2:4dad:: with SMTP id h13mr2242770lfe.564.1621007016781;
        Fri, 14 May 2021 08:43:36 -0700 (PDT)
Received: from localhost.localdomain (81-231-136-235-no600.tbcn.telia.com. [81.231.136.235])
        by smtp.gmail.com with ESMTPSA id i11sm787054lfe.211.2021.05.14.08.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 08:43:36 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        "Jeff King" <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 03/11] doc: doc-diff: set docdate manually
Date:   Fri, 14 May 2021 17:43:16 +0200
Message-Id: <20210514154316.810-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd
In-Reply-To: <20210514121435.504423-4-felipe.contreras@gmail.com>
References: <20210514121435.504423-4-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 14 May 2021 at 14:14, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>
> Asciidoc automatically generates a date with format '%Y-%m-%d', while
> asciidoctor '%F'.

Is that really the format Asciidoc uses? Not that it matters much for
the purposes of this patch.

> I personally prefer the latter, so only modify it for diff purposes.

I agree completely.

> Fixes tons of these:
>
> -Git omitted                       01/01/1970                        GIT-ADD(1)
> +Git omitted                       1970-01-01                        GIT-ADD(1)

>         then
> -               echo USE_ASCIIDOCTOR=YesPlease
> +               echo USE_ASCIIDOCTOR=YesPlease ASCIIDOC_EXTRA='-adocdate="01/01/1970"'
>         fi

Nice.

If you introduce a separate Makefile flag and incorporate Peff's patch
to doc-diff "asciidoctor" and "asciidoctor-direct", you'd need to
duplicate this a bit, or maybe just emit the ASCIIDOC_EXTRA outside of
the whole if chain.

You could follow up with the patch below. If you'd rather keep it out of
your series to avoid it ballooning, fine. I can repost it later, once
the dust has settled. Don't let it hold up your work.

-- >8 --
Subject: [PATCH] doc-diff: drop --cut-footer switch

Now that our doc-diff convinces Asciidoctor to insert the exact same
formatted dummy date as AsciiDoc, we can drop the --cut-footer switch.
It has been useful to ignore this difference between the two tools, but
it's effectively a no-op now. Similar to when we repurposed this from
--cut-header-footer in 83b0b8953e ("doc-diff: replace
--cut-header-footer with --cut-footer", 2019-09-16), just drop it
without worrying about any kind of backwards compatibility or user-base.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/doc-diff | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index aae5fc1933..97671ca65d 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -21,7 +21,6 @@ asciidoc		use asciidoc with both commits
 to-asciidoc		use asciidoc with the 'to'-commit
 to-asciidoctor		use asciidoctor with the 'to'-commit
 asciidoctor		use asciidoctor with both commits
-cut-footer		cut away footer
 "
 SUBDIRECTORY_OK=1
 . "$(git --exec-path)/git-sh-setup"
@@ -31,7 +30,6 @@ force=
 clean=
 from_program=
 to_program=
-cut_footer=
 while test $# -gt 0
 do
 	case "$1" in
@@ -55,8 +53,6 @@ do
 	--asciidoc)
 		from_program=-asciidoc
 		to_program=-asciidoc ;;
-	--cut-footer)
-		cut_footer=-cut-footer ;;
 	--)
 		shift; break ;;
 	*)
@@ -118,8 +114,8 @@ construct_makemanflags () {
 from_makemanflags=$(construct_makemanflags "$from_program") &&
 to_makemanflags=$(construct_makemanflags "$to_program") &&
 
-from_dir=$from_oid$from_program$cut_footer &&
-to_dir=$to_oid$to_program$cut_footer &&
+from_dir=$from_oid$from_program &&
+to_dir=$to_oid$to_program &&
 
 # generate_render_makefile <srcdir> <dstdir>
 generate_render_makefile () {
@@ -168,16 +164,6 @@ render_tree () {
 			"$tmp/rendered/$dname+" |
 		make -j$parallel -f - &&
 		mv "$tmp/rendered/$dname+" "$tmp/rendered/$dname"
-
-		if test "$cut_footer" = "-cut-footer"
-		then
-			for f in $(find "$tmp/rendered/$dname" -type f)
-			do
-				head -n -2 "$f" | sed -e '${/^$/d}' >"$f+" &&
-				mv "$f+" "$f" ||
-				return 1
-			done
-		fi
 	fi
 }
 
-- 
2.31.1.751.gd2f1c929bd

