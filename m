Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793D3C77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 11:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjDML61 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjDML6K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 07:58:10 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F59A5DE
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:58:04 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1879edfeff5so261450fac.4
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681387083; x=1683979083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4AoSz0sDnGJpdaZEXLG3ByVrqWl4nmgwL0lAcEIhUc=;
        b=hJpwebgJQ4Lz+FFds5NFKkYcBOwkjn1OGNQxOydMg29ZscEvlsu5ld4aLGXON8cwYJ
         j1dlVjitF6JeWCMhlKoHxUI3CBjwK9x99oBQS0b4DIZijqeS3dAhPuZjPWSh0oBSf+K8
         GioOkKoz3fRi0QBUM7a3PtLeA9OFM+z4NnhI9GsnKUCb8E07nqY/RcjCNkeqgLVqBcBK
         b69MLSrCnK9xZHxO+0lVH9tSpW3JjQuN8c6ZbeqNr7X9Bz+OMelbgUNLg4DtSFa01oqR
         up4rrZRekjWYkGMkPfZEiCrU1YQNrc2N+CG5fiOArbVBtVea43vqIT0/GNSvM8lVN8i4
         U7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681387083; x=1683979083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4AoSz0sDnGJpdaZEXLG3ByVrqWl4nmgwL0lAcEIhUc=;
        b=OzrcflaJJauUe0MEpn9bHIvKGxA5OuqG2eayxu/gwkVLu7HPB83AG3PImkYoRP9stV
         a9rlM4AKQib4S1Y47Pd7rotr323vjCkRSEAnSend/C1E7zcD5JlW+IDCfGp0LhSP2kCX
         +Oqtb+PP3H6/3VO1Yg550AqnkfC5SZ7TtCjSOLMIjqoM3Hw1dWZ3jZEo64qlyl2Imp39
         wN0qh6tjs60rjitrd8f+QIRagEG1s7ZS8XMD+5v5YPeJbgFTTz1VroaQT7tEhzZPqZpS
         aHcNQcfaFozW1kRmntS4bJFdVzOmZaLNaLAI2JjkCiWWxZ0fLfhh0zdm4BckI6yoTkGO
         xeCQ==
X-Gm-Message-State: AAQBX9fjrfYXoiCJ7Vpkw0Beb/C77+goxwW/FWXz3ifbRsfG3q7+WA/t
        YbkocLLwkNXl+OqgBfh3sOAhn/6vd+4=
X-Google-Smtp-Source: AKy350aAlcLT9/GSjUFd+QZJ82asDOn6gMWc9fg+SjIQSZusep8OatQznp7WflXw7aWOkfJVQoVzfA==
X-Received: by 2002:a05:6870:968d:b0:17a:b663:d440 with SMTP id o13-20020a056870968d00b0017ab663d440mr1469239oaq.42.1681387082971;
        Thu, 13 Apr 2023 04:58:02 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id dw19-20020a056870771300b001729072f759sm649197oab.0.2023.04.13.04.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 04:58:02 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Johnsen <chris_johnsen@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 12/12] doc: manpage: remove callout hack
Date:   Thu, 13 Apr 2023 05:57:45 -0600
Message-Id: <20230413115745.116063-13-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230413115745.116063-1-felipe.contreras@gmail.com>
References: <20230413115745.116063-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DocBook Stylesheets already have much better support for callouts.

This:

     $ git diff            (1)
     $ git diff --cached   (2)
     $ git diff HEAD       (3)

  1. Changes in the working tree not yet staged for the next
     commit.
  2. Changes between the index and your last commit; what you
     would be committing if you run git commit without -a
     option.
  3. Changes in the working tree since your last commit; what
     you would be committing if you run git commit -a

Looks much better than this:

       $ git diff            (1)
       $ git diff --cached   (2)
       $ git diff HEAD       (3)

   1. Changes in the working tree not yet staged for the next commit.
   2. Changes between the index and your last commit; what you would
   be committing if you run git commit without -a option.
   3. Changes in the working tree since your last commit; what you
   would be committing if you run git commit -a

This implementation goes back to 2006: 776e994af5 (Properly render
asciidoc "callouts" in git man pages., 2006-04-28). It probably wasn't
needed since a long time ago.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/gen-stylesheet | 17 -----------------
 t/t0600-doc-tools.sh         | 24 +++++++++++++++---------
 2 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/Documentation/gen-stylesheet b/Documentation/gen-stylesheet
index 7d1839fcab..53c3dfca17 100755
--- a/Documentation/gen-stylesheet
+++ b/Documentation/gen-stylesheet
@@ -12,23 +12,6 @@ cat <<EOF
 <xsl:param name="refentry.meta.get.quietly" select="1"/>
 EOF
 
-# convert asciidoc callouts to man page format
-cat <<EOF
-<xsl:template match="co">
-	<xsl:value-of select="concat('\fB(',substring-after(@id,'-'),')\fR')"/>
-</xsl:template>
-<xsl:template match="calloutlist">
-	<xsl:text>.sp&#10;</xsl:text>
-	<xsl:apply-templates/>
-	<xsl:text>&#10;</xsl:text>
-</xsl:template>
-<xsl:template match="callout">
-	<xsl:value-of select="concat('\fB',substring-after(@arearefs,'-'),'. \fR')"/>
-	<xsl:apply-templates/>
-	<xsl:text>.br&#10;</xsl:text>
-</xsl:template>
-EOF
-
 if [[ -z "$NO_MAN_BOLD_LITERAL" ]]
 then
 	# render literal text as bold (instead of plain or monospace); this makes
diff --git a/t/t0600-doc-tools.sh b/t/t0600-doc-tools.sh
index 545fb0e199..10a472e1e6 100755
--- a/t/t0600-doc-tools.sh
+++ b/t/t0600-doc-tools.sh
@@ -74,13 +74,19 @@ $ git diff @ \fB(3)\fR
 .RE
 .\}
 .sp
-.sp
-\fB1. \fRCallout 1
-.br
-\fB2. \fRCallout 2
-.br
-\fB3. \fRCallout 3
-.br
+.TS
+tab(:);
+r lw(\n(.lu*75u/100u).
+\fB1.\fR\h'-2n':T{
+Callout 1
+T}
+\fB2.\fR\h'-2n':T{
+Callout 2
+T}
+\fB3.\fR\h'-2n':T{
+Callout 3
+T}
+.TE
 .SH "GIT"
 .sp
 Part of the \fBgit\fR(1) suite
@@ -116,12 +122,12 @@ test_expect_success ASCIIDOC 'legacy asciidoc.py' '
 	check_manpage "git-foo"
 '
 
-test_expect_failure ASCIIDOC 'legacy asciidoc.py (docbook5)' '
+test_expect_success ASCIIDOC 'legacy asciidoc.py (docbook5)' '
 	build_asciidoc_py "git-foo" docbook5 &&
 	check_manpage "git-foo"
 '
 
-test_expect_failure ASCIIDOCTOR 'modern asciidoctor (docbook5)' '
+test_expect_success ASCIIDOCTOR 'modern asciidoctor (docbook5)' '
 	build_asciidoctor "git-foo" &&
 	check_manpage "git-foo"
 '
-- 
2.40.0+fc1

