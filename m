Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561A4C433E1
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33DA4206F6
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDT/rJOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgGICQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 22:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgGICQx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 22:16:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70332C061A0B
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 19:16:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f18so642833wrs.0
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 19:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3efikXJWi4yEKiNU1sfB/eB3CbWzH026rNAeS4sShpE=;
        b=MDT/rJOjSrnR16kt4H/3NYHZu2hGlz+LJydF4vbau5HTGqSd+8R27eLAJ4EH9/Bs07
         ikZ3h3mrLY1qFwo/tn5xX/g+B0MJ6Mp/jL9qP2J27Axn/tnoCjyUqRZwCoKSsFtOkd14
         b33xIjUKixHws/nRFdFFCBy/wkUhtCmc9FzlPR3ZT/HPJE6eN89KM1dXNHuROB1ybQC/
         O1Gg2wiWB83OrDUhT4Nfuc/0EVBd/jUDeLWZxo9zEtQEcK85G73Xr60PbmjMWBRno6Eg
         zjhxHBZrNdM9470ARXg7wmNvlOmrzivs0qm5VwqXqtpkBoBosDORbakeqNUPQT28BTwz
         CSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3efikXJWi4yEKiNU1sfB/eB3CbWzH026rNAeS4sShpE=;
        b=gB5RxP+zxto2dJfafeVo0X2o8jg8OhK8tkfmRZ0mJcXVRILWpmn4RRGJHFZC9Ps34C
         lXDoeFGAZU3XHmPpEh6obRc7BG08A3QTkY2gCxaA5Fa67nl/kQJVMa4tupL+Do01Itfw
         OxNbQ5Jpmp2anSmA5dx8nX51tpsTjA+yfRFW2neKPtWuoGGRUmrhnyR8fCn1waAzL5/e
         3Zsxzd08IHhwQscuwpEeSQhWlQZ4Id98X9EtJRnJSati6mZGqGG7sqKRA8TaBAfjf7OW
         A6UUbJPymZADTCX91UkhD/+juV/vpK+2PNkcGIuJOihojjs4UoXopBpubx4XA/6TDi+Z
         TxUA==
X-Gm-Message-State: AOAM531UKgZ0aP4LbS5p+m+Lt1nacct9zPsb9jx+ZNquilvQTRt9lTE4
        fWMcMGWt8cEkEy+/+4WIYDwJioeQ
X-Google-Smtp-Source: ABdhPJykS25PJ1kjQp8dhoBDeyf8ZzFOfusD0f/zGw2H+4P/1zpB0UHM7ehYV3yN2SwvkDoJSGjv9Q==
X-Received: by 2002:a5d:4604:: with SMTP id t4mr30785666wrq.0.1594261012018;
        Wed, 08 Jul 2020 19:16:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f186sm2516965wmf.29.2020.07.08.19.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 19:16:51 -0700 (PDT)
Message-Id: <b8ee4a743c49553ba479839a234c421876fa14a4.1594261008.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.590.v3.git.1594261008.gitgitgadget@gmail.com>
References: <pull.590.v2.git.1593747509.gitgitgadget@gmail.com>
        <pull.590.v3.git.1594261008.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Jul 2020 02:16:45 +0000
Subject: [PATCH v3 3/6] git-rev-list.txt: fix Asciidoc syntax
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Lawrence Siebert <lawrencesiebert@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Using '{caret}' inside double quotes and immediately following with a
single quoted word does not create the desired output: '<commit1>'
appears verbatim instead of being emphasized.

Use a litteral caret ('^') instead.

Also, remove the leading tabs in shell examples to bring them more in
line with the rest of the documentation.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-rev-list.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 025c911436..aa95334a79 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -29,19 +29,19 @@ to further limit the result.
 Thus, the following command:
 
 -----------------------------------------------------------------------
-	$ git rev-list foo bar ^baz
+$ git rev-list foo bar ^baz
 -----------------------------------------------------------------------
 
 means "list all the commits which are reachable from 'foo' or 'bar', but
 not from 'baz'".
 
 A special notation "'<commit1>'..'<commit2>'" can be used as a
-short-hand for "{caret}'<commit1>' '<commit2>'". For example, either of
+short-hand for "^'<commit1>' '<commit2>'". For example, either of
 the following may be used interchangeably:
 
 -----------------------------------------------------------------------
-	$ git rev-list origin..HEAD
-	$ git rev-list HEAD ^origin
+$ git rev-list origin..HEAD
+$ git rev-list HEAD ^origin
 -----------------------------------------------------------------------
 
 Another special notation is "'<commit1>'...'<commit2>'" which is useful
@@ -49,8 +49,8 @@ for merges.  The resulting set of commits is the symmetric difference
 between the two operands.  The following two commands are equivalent:
 
 -----------------------------------------------------------------------
-	$ git rev-list A B --not $(git merge-base --all A B)
-	$ git rev-list A...B
+$ git rev-list A B --not $(git merge-base --all A B)
+$ git rev-list A...B
 -----------------------------------------------------------------------
 
 'rev-list' is a very essential Git command, since it
-- 
gitgitgadget

