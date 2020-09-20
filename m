Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E5EC43465
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 23:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B0120809
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 23:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgITXXN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 19:23:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35296 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726305AbgITXXM (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 Sep 2020 19:23:12 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3053561FE7;
        Sun, 20 Sep 2020 23:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1600644161;
        bh=fMsI9ZJTqIFTP4FQY8UNiCvX26TldDkhjOmjXH3iT0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=bY2jQ52JU1rurLIPFRAmp3MWZXFTD8UsilrJi+35w/NXFI58EQ2m1u2hTWoQHMFKy
         Jp3p4l0/s84TrgbYb9xCZu5k/vWSYOVxiyGFC7uPFwRN5LFa25lQy4DcNm9ihjAyBW
         l2ou1zFqpLIE6pDQzwNO9eILXxyJH5QMJdmTNxw/RffrX+MV9sDBgVNDhXT2Eirc9G
         FS1jlxkN6apHMauRQqNy5g7hp4+soaExF7XNTjaYP6cp56fjLzPqcPFhQjkHUl3eTo
         HCRdQD1B4FTNvtgB87i60IEQ0G+qZnQJU57FZEVDN/scS42R3HXlJxIZHsjKChREnA
         J0pO4MAB6OVrlWEuEh8BT3c9NMi5Ss4CUec3u5YTLOJBmNShWUeHDK9GUapwkfvlPw
         JpN9unFIWlyZLS8hAOlRl0b59sAcGoqqWzjDHM0zYzZThq6DER1IbZ7KWthZ7jm0mX
         Ec7i2YPWngcYN0Wy8m2+asnVrRjyoGhaDJ5Bf6Pc1jBfqfN6ytP
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 3/3] docs: explain how to deal with files that are always modified
Date:   Sun, 20 Sep 2020 23:22:31 +0000
Message-Id: <20200920232231.1300394-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200920232231.1300394-1-sandals@crustytoothpaste.net>
References: <20200912204824.2824106-1-sandals@crustytoothpaste.net>
 <20200920232231.1300394-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users frequently have problems where two filenames differ only in case,
causing one of those files to show up consistently as being modified.
Let's add a FAQ entry that explains how to deal with that.

In addition, let's explain another common case where files are
consistently modified, which is when files using a smudge or clean
filter have not been run through that filter.  Explain the way to fix
this as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitfaq.txt | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 176b097cf7..afdaeab850 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -363,6 +363,39 @@ information about how to configure files as text or binary.
 You can also control this behavior with the `core.whitespace` setting if you
 don't wish to remove the carriage returns from your line endings.
 
+[[always-modified-files-case]]
+Why do I have a file that's always modified?::
+	Internally, Git always stores file names as sequences of bytes and doesn't
+	perform any encoding or case folding.  However, Windows and macOS by default
+	both perform case folding on file names.  As a result, it's possible to end up
+	with multiple files or directories whose names differ only in case.  Git can
+	handle this just fine, but the file system can store only one of these files,
+	so when Git reads the other file to see its contents, it looks modified.
++
+It's best to remove one of the files such that you only have one file.  You can
+do this with commands like the following (assuming two files `AFile.txt` and
+`afile.txt`) on an otherwise clean working tree:
++
+----
+$ git rm --cached AFile.txt
+$ git commit -m 'Remove files conflicting in case'
+$ git checkout .
+----
++
+This avoids touching the disk, but removes the additional file.  Your project
+may prefer to adopt a naming convention, such as all-lowercase names, to avoid
+this problem from occurring again; such a convention can be checked using a
+`pre-receive` hook or as part of a continuous integration (CI) system.
++
+It is also possible for perpetually modified files to occur on any platform if a
+smudge or clean filter is in use on your system but a file was previously
+committed without running the smudge or clean filter.  To fix this, run the
+following on an otherwise clean working tree:
++
+----
+$ git add --renormalize .
+----
+
 [[recommended-storage-settings]]
 What's the recommended way to store files in Git?::
 	While Git can store and handle any file of any type, there are some
