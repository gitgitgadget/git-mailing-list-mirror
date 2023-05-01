Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A73C77B60
	for <git@archiver.kernel.org>; Mon,  1 May 2023 02:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjEACf7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Apr 2023 22:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjEACfz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2023 22:35:55 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8191BE44
        for <git@vger.kernel.org>; Sun, 30 Apr 2023 19:35:53 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b60365f53so2493264b3a.0
        for <git@vger.kernel.org>; Sun, 30 Apr 2023 19:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682908553; x=1685500553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+Czh1RNIylPLyzynhf3Y9XPFxqBBqwqKFIpi//wupY=;
        b=PStx+Sg6xowN73MuWRDTjYtE++g8PqxSk7t1RqloapdL08w68sA0LiAyORLqM1BN4z
         FQAiZFh4aZ/LAG/UzB8ee/F8Cv/lezpFzWxh6KYK92+6I/ZDe6waZ+j4nbOVGZuiLy7l
         DYS/UfWNzIYnC40IjJq/M9XyxO8NntS5SXYVL0vleCiw2O8smuhRqAfMV83dJK+Oeo2f
         oXPAZAvQqWDWqylOqTZ4IlsPR0urBlGM1JYu3CyUjUbsdSvXVC/zHqpyZWvV6fK7e7jV
         F9XlwBxU14GYDiSsNVgqtYkPLSnJzJLKcPp/ElCOeXPaVaB2FJaN7zbuv7+bOmjHWMB9
         xtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682908553; x=1685500553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+Czh1RNIylPLyzynhf3Y9XPFxqBBqwqKFIpi//wupY=;
        b=G1OibtQaTqh4bzI2BLyelSWh+90z4tJ3PqGxWk2IILKJXd5FiWgxYlKnE4N5mvXSLQ
         qgg01nD1Dl/2Y+TcP1+2liu6CHMabyALwoICPWXWsVQEXDTc1QcNIAX1TdEw+Jr/NMMH
         eb68K3J4c7m8NkCgl5fCXZDHcjaEOv+Ry+d+pEWusLZpliTwRpCbGllVM2VLxieoVEJ1
         rCYjtbBLMQu9g5Z5wW9xczhi2xyPQ67KRBx8GDtC3c1uZY3siLW8V8R46yAFHrVxZktO
         S5Rg4SaJ6k4VugDw+9pqr3uvm5v7J7Zg30v5VY7cMYNyH7Erc4R/jykR4Iya4ryMHWtQ
         Dpug==
X-Gm-Message-State: AC+VfDwq6MD2QIBl8cSWZu7Cfz2ES0ULuCYfwXUZw6CxDI94l8I+pwZE
        qFsdQQNRyoRBeOWkvdwbfdUDm9ItSKU=
X-Google-Smtp-Source: ACHHUZ6GK3FRqu8uEUp8uzZHRHOSgKI+cAbw5FSvRsPmGs90GVh+H902XtPxYkyZaKn5yPdYjMwM0Q==
X-Received: by 2002:a05:6a20:6a24:b0:f5:9f72:1aa9 with SMTP id p36-20020a056a206a2400b000f59f721aa9mr1404673pzk.14.1682908552583;
        Sun, 30 Apr 2023 19:35:52 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id f16-20020a17090a639000b0023d0c2f39f2sm18011394pjj.19.2023.04.30.19.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 19:35:52 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, eyvind.bernhardsen@gmail.com, tboegi@web.de,
        gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v3 1/1] docs: rewrite the documentation of the text and eol attributes
Date:   Sun, 30 Apr 2023 20:35:33 -0600
Message-Id: <20230501023533.35370-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230501023533.35370-1-alexhenrie24@gmail.com>
References: <20230501023533.35370-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two sentences are confusing because the description of the text
attribute sounds exactly the same as the description of the text=auto
attribute:

"Setting the text attribute on a path enables end-of-line normalization"

"When text is set to "auto", the path is marked for automatic
end-of-line conversion"

Unless the reader is already familiar with the two variants, there's a
high probability that they will think that "end-of-line normalization"
is the same thing as "automatic end-of-line conversion".

It's also not clear that the phrase "When the file has been committed
with CRLF, no conversion is done" in the paragraph for text=auto does
not apply equally to the bare text attribute which is described earlier.
Moreover, it falsely implies that normalization is only suppressed if
the file has been committed. In fact, running `git add` on a CRLF file,
adding the text=auto attribute to the file, and running `git add` again
does not do anything to the line endings either.

On top of that, in several places the documentation for the eol
attribute sounds like it can turn on normalization on checkin, but eol
only controls conversion on checkout. It also sounds like setting eol
(or setting a config variable) is required to turn on conversion on
checkout, but the text attribute can turn on conversion on checkout by
itself if eol is unspecified.

Rephrase the documentation of text, text=auto, eol, eol=crlf, and eol=lf
to be clear about how they are the same, how they are different, and in
what cases conversion is performed.

Helped-by: Torsten Bögershausen <tboegi@web.de>
Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/gitattributes.txt | 60 ++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 39bfbca1ff..076a056a72 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -120,20 +120,19 @@ repository upon 'git add' and 'git commit'.
 `text`
 ^^^^^^
 
-This attribute enables and controls end-of-line normalization.  When a
-text file is normalized, its line endings are converted to LF in the
-repository.  To control what line ending style is used in the working
-directory, use the `eol` attribute for a single file and the
-`core.eol` configuration variable for all text files.
-Note that setting `core.autocrlf` to `true` or `input` overrides
-`core.eol` (see the definitions of those options in
-linkgit:git-config[1]).
+This attribute marks the path as a text file, which enables end-of-line
+conversion: When a matching file is added to the index, the file's line
+endings are normalized to LF in the index.  Conversely, when the file is
+copied from the index to the working directory, its line endings may be
+converted from LF to CRLF depending on the `eol` attribute, the Git
+config, and the platform (see explanation of `eol` below).
 
 Set::
 
 	Setting the `text` attribute on a path enables end-of-line
-	normalization and marks the path as a text file.  End-of-line
-	conversion takes place without guessing the content type.
+	conversion on checkin and checkout as described above.  Line endings
+	are normalized to LF in the index every time the file is checked in,
+	even if the file was previously added to Git with CRLF line endings.
 
 Unset::
 
@@ -142,10 +141,11 @@ Unset::
 
 Set to string value "auto"::
 
-	When `text` is set to "auto", the path is marked for automatic
-	end-of-line conversion.  If Git decides that the content is
-	text, its line endings are converted to LF on checkin.
-	When the file has been committed with CRLF, no conversion is done.
+	When `text` is set to "auto", Git decides by itself whether the file
+	is text or binary.  If it is text and the file was not already in
+	Git with CRLF endings, line endings are converted on checkin and
+	checkout as described above.  Otherwise, no conversion is done on
+	checkin or checkout.
 
 Unspecified::
 
@@ -159,26 +159,30 @@ unspecified.
 `eol`
 ^^^^^
 
-This attribute sets a specific line-ending style to be used in the
-working directory.  This attribute has effect only if the `text`
-attribute is set or unspecified, or if it is set to `auto`, the file is
-detected as text, and it is stored with LF endings in the index.  Note
-that setting this attribute on paths which are in the index with CRLF
-line endings may make the paths to be considered dirty unless
-`text=auto` is set. Adding the path to the index again will normalize
-the line endings in the index.
+This attribute marks a path to use a specific line-ending style in the
+working tree when it is checked out.  This attribute has effect only if
+the `text` attribute is set or unspecified, or if it is set to `auto`,
+the file is detected as text, and it is stored with LF endings in the
+index.
 
 Set to string value "crlf"::
 
-	This setting forces Git to normalize line endings for this
-	file on checkin and convert them to CRLF when the file is
-	checked out.
+	This setting converts the file's line endings in the working
+	directory to CRLF when the file is checked out.
 
 Set to string value "lf"::
 
-	This setting forces Git to normalize line endings to LF on
-	checkin and prevents conversion to CRLF when the file is
-	checked out.
+	This setting uses the same line endings in the working directory as
+	in the index when the file is checked out.
+
+Unspecified::
+
+	If the `eol` attribute is unspecified for a file, its line endings
+	in the working directory are determined by the `core.autocrlf` or
+	`core.eol` configuration variable (see the definitions of those
+	options in linkgit:git-config[1]).  The default if `text` is set but
+	neither of those variables is is `eol=lf` on Unix and `eol=crlf` on
+	Windows.
 
 Backwards compatibility with `crlf` attribute
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- 
2.40.1

