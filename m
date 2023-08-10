Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC77AC001DE
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 21:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjHJVRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjHJVRE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 17:17:04 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ED92738
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:17:02 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe501e0b4cso12703075e9.1
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691702221; x=1692307021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5q7I3edJAB5k9KZ5royy8m/gT9lYVzk+KhH4I1gZl0=;
        b=C/pNR7wMBWAWcUnJ3O86Dhm1OyTqBVY7+afZRB59rBaxbUh4Vvz3wTaJz9m7v4UFOE
         KZhOSkd4sU2MMhKQYaXgk/LBG0b+5HbVVXh3aOavGs5cGBcQzcSk/VbspesoUmXVl1+X
         Gc3qQRkmYuN9FGRLVIAgxNupmdh+MI5qqOo5jQZbpL75HVOPk7oh7V3YAp/9uhE5zZJw
         iwXf5On3ALfb5lIiLCpLsDYjhXcey1Ym3Vmyp61B7/swQAaGfGnRM1KH47b12XDt8hs/
         IHquVaZXdel4bFXZ9swlqvNXrEFet85fD3UgIdJuQ1R4Hn5PCwCSvm1WzLNrvgjfDz7t
         /90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691702221; x=1692307021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5q7I3edJAB5k9KZ5royy8m/gT9lYVzk+KhH4I1gZl0=;
        b=YMDgfV2bjNkjhRBvzs4JQGeq+6RovjHQvDATBUzoM+x1zIczs+MmOsoQWkOkwPU0pt
         U+5YQNjkA2WtCepGPdx/qXKOzQ7pf+Iy8Vb9YPzcaLUeBvuAVuaNzWw1AEiFj8i1rFzj
         PQdtMuIC7okwhBrIIxtc+TVN3A81J6k46ULBa4++I9zh67Uy4SZgJlqV3ulbN8/po89S
         KoTMYGVtSKjC/X1YUgtct3LJ1h0W66eUVKLuLCcL7v80G9rbuoNCKaXhdZVQdcngaO0u
         ZqJaHA3NZ0nwIxb1ES8jyQ5Ks3oqsgpsSanLL1l63XHvEz8ASamSaVFlJno2BBaq+iGS
         FpMA==
X-Gm-Message-State: AOJu0Yzs9k9bRLWijoXaXUU/f3WU+Xg9pJ0aAixrl4NAzTgudBQzCskw
        C5zMjOb0J1DBpK11s+wSuJEciQ6aUyRmKA==
X-Google-Smtp-Source: AGHT+IG6eLZWcFYqqWJa/fLRmfXOMLLKhWS3kzn78K0rHsW9PRmGtt7W6pXzCwYJ/kwBqKQJkLr86g==
X-Received: by 2002:a05:600c:21cd:b0:3fb:a506:5656 with SMTP id x13-20020a05600c21cd00b003fba5065656mr24661wmj.32.1691702220921;
        Thu, 10 Aug 2023 14:17:00 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c229300b003fe24da493dsm3169864wmf.41.2023.08.10.14.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:17:00 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v3 2/7] pretty-formats: enclose options in angle brackets
Date:   Thu, 10 Aug 2023 22:16:14 +0100
Message-ID: <20230810211619.19055-2-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230810211619.19055-1-andy.koppe@gmail.com>
References: <20230715160730.4046-1-andy.koppe@gmail.com>
 <20230810211619.19055-1-andy.koppe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enclose the 'options' placeholders in the %(describe) and %(trailers)
format specifiers in angle brackets to clarify that they are
placeholders rather than keywords.

Also remove the indentation from their descriptions, instead of
increasing it to account for the extra two angle bracket in the
headings. The indentation isn't required by asciidoc, it doesn't reflect
how the output text is formatted, and it's inconsistent with the
following bullet points that are at the same level in the output.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/pretty-formats.txt | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 5e1432951b..851a9878e6 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -224,13 +224,11 @@ The placeholders are:
 	linkgit:git-rev-list[1])
 '%d':: ref names, like the --decorate option of linkgit:git-log[1]
 '%D':: ref names without the " (", ")" wrapping.
-'%(describe[:options])':: human-readable name, like
-			  linkgit:git-describe[1]; empty string for
-			  undescribable commits.  The `describe` string
-			  may be followed by a colon and zero or more
-			  comma-separated options.  Descriptions can be
-			  inconsistent when tags are added or removed at
-			  the same time.
+'%(describe[:<options>])'::
+human-readable name, like linkgit:git-describe[1]; empty string for
+undescribable commits.  The `describe` string may be followed by a colon and
+zero or more comma-separated options.  Descriptions can be inconsistent when
+tags are added or removed at the same time.
 +
 ** 'tags[=<bool-value>]': Instead of only considering annotated tags,
    consider lightweight tags as well.
@@ -283,13 +281,11 @@ endif::git-rev-list[]
 '%gE':: reflog identity email (respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
 '%gs':: reflog subject
-'%(trailers[:options])':: display the trailers of the body as
-			  interpreted by
-			  linkgit:git-interpret-trailers[1]. The
-			  `trailers` string may be followed by a colon
-			  and zero or more comma-separated options.
-			  If any option is provided multiple times the
-			  last occurrence wins.
+'%(trailers[:<options>])'::
+display the trailers of the body as interpreted by
+linkgit:git-interpret-trailers[1]. The `trailers` string may be followed by
+a colon and zero or more comma-separated options. If any option is provided
+multiple times, the last occurrence wins.
 +
 ** 'key=<key>': only show trailers with specified <key>. Matching is done
    case-insensitively and trailing colon is optional. If option is
-- 
2.42.0-rc1

