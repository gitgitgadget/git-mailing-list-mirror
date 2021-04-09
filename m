Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A1CC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 13:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26A9A60241
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 13:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhDINh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 09:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhDINh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 09:37:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEC7C061761
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 06:37:45 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q26so5668650wrz.9
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 06:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RjZlXkxnLFrbRuwZAXeKjfCf4NPQwkkKxlQcRSe9EBk=;
        b=Bf+xZ7u5836/Jn1vCsdiry6oJ8KVS5JF4IQbus0tClAhDU8ujj9ZjGp4SJb7M4Axi/
         JDDn4+TH0RHMrAt6zu3z3uDJpNUcK57zmQgNtUMbAY/ACR3LQqTHNP+u6rHe+/0bEeVl
         mlVL/bADqIrMoWPG12CWoJPtNrAqsZ5ErUl/LQvSEt9MHfMolJ3KhJQ+H8f795VOtjns
         J4Tye5bMmWuB+uZi+sz7yEO73CLAOJ5OBdzusqlTEJJJYjYaBIUrxoHTW2VILyhQQO7v
         0qJtiIgzDOX9POiIs2gn98ckYxikD9sWKvT0iprdu3xSITOSRGWIbEQNQhIn/M1m082U
         g4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RjZlXkxnLFrbRuwZAXeKjfCf4NPQwkkKxlQcRSe9EBk=;
        b=ivi7G25+xdOxHLKTqRlUQ1oqTmzim5Wh64rS3tmEWpwiqbR7DwIrntMdnSZWWm9nlX
         lFCuFrGsIg01PB7iS7dw14H/NpxP+didsXH32MNxb8tNigLzEUEgw+h0WD6sfvVuWsxc
         jBYN3P89UtayNzDYZoGY8SjtYtdizX9aWKAi6ZfaGuMChJfQD6zb8EylEatX+fUg1lDT
         B7BuS1jwYtCZrnUPbuYw8sC6KWQJJlNrS4qClHyVXvO84nEOksb/F5kjasGdECoHEinp
         PfvXM+BAjN6VG1FxNwkEzUhxOPpNNc9Wb69HvC9ZNFzjg3dxku3tuGtum9Eun0l9zgaV
         GjHQ==
X-Gm-Message-State: AOAM530pCLqvEWg/Tni/1NnEE8mhQOAXSMYbePnJ78nIOadfasS+hOQQ
        pSQaCNPS0fheWVOa1VeWv4KnGq1p4cE=
X-Google-Smtp-Source: ABdhPJz1fM0W/s5DgThz2KZaGMOZyNRZGy3HuoIIb3wqhPoUg2wpcE74Zr52v6ACOPhbsdpVid4vyA==
X-Received: by 2002:a5d:510d:: with SMTP id s13mr17822328wrt.12.1617975464126;
        Fri, 09 Apr 2021 06:37:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4sm4118469wmc.2.2021.04.09.06.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 06:37:43 -0700 (PDT)
Message-Id: <505903811df83cf26f4dd70c5b811dde169896a2.1617975462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.913.v8.git.1617975462.gitgitgadget@gmail.com>
References: <pull.913.v7.git.1617541912381.gitgitgadget@gmail.com>
        <pull.913.v8.git.1617975462.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Apr 2021 13:37:41 +0000
Subject: [PATCH v8 1/2] [GSOC] docs: correct descript of
 trailer.<token>.command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

In the original documentation of `trailer.<token>.command`,
some descriptions are easily misunderstood. So let's modify
it to increase its readability.

In addition, clarify that `$ARG` in command can only be
replaced once since `$ARG` is text replacement.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-interpret-trailers.txt | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 96ec6499f001..3e5aa3a65ae9 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -237,20 +237,20 @@ trailer.<token>.command::
 	specified <token>.
 +
 When this option is specified, the behavior is as if a special
-'<token>=<value>' argument were added at the beginning of the command
-line, where <value> is taken to be the standard output of the
-specified command with any leading and trailing whitespace trimmed
-off.
+'--trailer <token>=<value>' argument was added at the beginning of
+the "git interpret-trailers" command, where <value> is taken to be the
+standard output of the specified command with any leading and trailing
+whitespace trimmed off.
 +
-If the command contains the `$ARG` string, this string will be
-replaced with the <value> part of an existing trailer with the same
-<token>, if any, before the command is launched.
+The first occurrence of substring `$ARG` will be replaced with the
+<value> part of an existing trailer with the same <token>, if any,
+before the command is launched.
 +
 If some '<token>=<value>' arguments are also passed on the command
-line, when a 'trailer.<token>.command' is configured, the command will
-also be executed for each of these arguments. And the <value> part of
-these arguments, if any, will be used to replace the `$ARG` string in
-the command.
+line, when a 'trailer.<token>.command' is configured, the command is run
+once for each these arguments with the same <token>. And the <value>
+part of these arguments, if any, will be used to replace the first `$ARG`
+string in the command.
 
 EXAMPLES
 --------
-- 
gitgitgadget

