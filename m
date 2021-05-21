Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D873C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DFB4613D8
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhEUWqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhEUWqX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:46:23 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106CEC06138A
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:44:59 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id q17-20020a4a33110000b029020ebab0e615so3000926ooq.8
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8rOlatWt4JVTIzmy0PIKFwpkSn+lV99PiEz5KG3yTmM=;
        b=ZU2fPkiicSZ/t4mwKh4e6fKssKRpz90rafEJldAv5UyrQZ8990lBuemasG36S5QYcH
         h6TgE6maXaZfQXBnmePGyR2h8pBSLskyMiZ0MSdRy+iEhn7vxgqORuZ4wpjjjZWYuf75
         mHW4synG3qHoMSE7lTp60dZMlLmeYSqNvHrVH6Es2psLcS1b44Kw1kADOjiQY2tuOTWi
         MTZF4bAfuoMRkjU22R8fhBZp1b2ILT9EUcogNqkOW7y3Ap65sBq0W1EHTuM7HPJ1oiKU
         Y2rxvLdBZmPLO7SKehTCwEc2RPg6bEaxUHkTWnxrKtmAP2xrGmmwkPqplDxmT7aJOGrf
         fCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8rOlatWt4JVTIzmy0PIKFwpkSn+lV99PiEz5KG3yTmM=;
        b=mMSueSpn+KL3XqaTmqposYgnNTht1otHkHkGToJeFbQJv+cs+d2HBRJ0tHS6ckm4yS
         rguCRIHFOmBPtVDzgZrZ4GVyCUZ90q3w0tReF7WeGctJHeO1tO6FLPKeiN9xD0j0JHRn
         8Yo7z0gEZYxYvCRFWF3dujl9hp7FHgo9XRmzJwtI5wotlbn6gPUk5gRa3xfdee2UP7fU
         CwlFi+QU8tz5KzdgEC6EmsasPxdA8lUzo7jIpDq3xKHuc/+jaqinPYGQfzPhhKZ7yqY8
         GCPV5kSAas3iLOEFHzfbM8sZci7rzlhY/VbQmavc5GpHaMXR5tiIX/m1zMgHdS+hJocm
         HK4Q==
X-Gm-Message-State: AOAM533ZwVSdjxx/1ORkxrm7MFEKNft8wTZ96l+nkiaNJCoSzo0WifwS
        GwDIjMrYUDjR+qv3cih25tPtzgTCfMrXgA==
X-Google-Smtp-Source: ABdhPJw4mQkNaV1eI8dPOiXm4+ZK9SASYoZi5Naeti4oxmsCPEcs+XSiNMt4wiEtaegZT7hR0cHFvw==
X-Received: by 2002:a4a:ab83:: with SMTP id m3mr9982148oon.2.1621637098151;
        Fri, 21 May 2021 15:44:58 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id q63sm1415407oic.15.2021.05.21.15.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:44:57 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 02/11] doc-diff: drop --cut-footer switch
Date:   Fri, 21 May 2021 17:44:43 -0500
Message-Id: <20210521224452.530852-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521224452.530852-1-felipe.contreras@gmail.com>
References: <20210521224452.530852-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Ågren <martin.agren@gmail.com>

Now that our doc-diff convinces Asciidoctor to insert the exact same
formatted dummy date as AsciiDoc, we can drop the --cut-footer switch.
It has been useful to ignore this difference between the two tools, but
it's effectively a no-op now. Similar to when we repurposed this from
--cut-header-footer in 83b0b8953e ("doc-diff: replace
--cut-header-footer with --cut-footer", 2019-09-16), just drop it
without worrying about any kind of backwards compatibility or user-base.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/doc-diff | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index c11b90a6ef..6b6bb444ac 100755
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
2.32.0.rc0

