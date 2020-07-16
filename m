Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4F1C433DF
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 12:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA4F207BB
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 12:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FogAZ1b9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgGPMT5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbgGPMT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 08:19:56 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62616C061755
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 05:19:56 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so11388236wml.3
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 05:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xc0Dsv5lB7H0CaX1mN5VKlas2vXO+F2kanTBCL8drGQ=;
        b=FogAZ1b9m+za37hk+gi2MWnUmwr2ztsW38EZvp5Vd4sdrYEE6tvUB7ysR/WoF8ApwY
         sa5/SNeKpw2oMPNYNoTN3MV+/p0+8dH8PUL05jKzthD+UzjsvK7KlxUasndYfQ9vMypN
         BvuVLHatom00s6sny0WQng6ElPW4U7pElGnleFr28OaFCOPJyRe+cGaQWPcS2XQhl9DD
         CI3U6UKx2pjty5qOC9ALSVGnMr+os30UzFK7IpEvgzgzNwzn5ypm/yR6EDstpBwDCsKx
         8pHvK5ZNc/4szKoufKg5CBW7g7HU5oH23e48u/a6uWAEphEHUCYaW0fVlZvaV7luwF7M
         xDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xc0Dsv5lB7H0CaX1mN5VKlas2vXO+F2kanTBCL8drGQ=;
        b=WjYp9gedq28eJLl/Tibmdn2zNCm+aYgFYSP9ktXqZrYpP4OQAY8x2HjWkZbN0/BICn
         k1dyF2N96UFSj3ErCuWk/K0+gjyY9d/ZKgz3V7bGJ28qrCyCzT22MzA3bLdqtMiNkMEB
         d5RTHDgEIiSoPbUwGv5gawgV3aQi02Ei9wal3bfphGEewlwQpzmz43uWY/7+CO0QsdvT
         L40QVXhWwdmRlSsVElXveeelK8/YyXK5uvg/TQIYt/BohYsgE/UuGrvqsfTpJHP/roUa
         pd20ZV/arHw6wKFLx/H4GoQX+ukQeyvR8DrVuq7zkeoZvAuTRjccXJbNFE/qFJ2jeGmM
         I3vQ==
X-Gm-Message-State: AOAM531tIOcISFPMyngnNOST+t2TRXcDjEUqLQiOjd8CWdZnJ6rZErhm
        HhjVo/2IKVLf755NtDNjF9g8XtsJ5UU=
X-Google-Smtp-Source: ABdhPJyG7gvlZ6/UHaauL1dujitBlsF/Z64guMHVp2qmwWEllE+ENP6yCW6tI5RtFKppKGG94cF1ow==
X-Received: by 2002:a05:600c:258:: with SMTP id 24mr4286094wmj.126.1594901994637;
        Thu, 16 Jul 2020 05:19:54 -0700 (PDT)
Received: from localhost.localdomain ([193.56.245.81])
        by smtp.gmail.com with ESMTPSA id p4sm8725714wrx.63.2020.07.16.05.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 05:19:53 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 1/3] Documentation: clarify %(contents:XXXX) doc
Date:   Thu, 16 Jul 2020 14:19:38 +0200
Message-Id: <20200716121940.21041-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.227.g757ac19d14.dirty
In-Reply-To: <20200716121940.21041-1-chriscool@tuxfamily.org>
References: <20200710164739.6616-1-chriscool@tuxfamily.org>
 <20200716121940.21041-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's avoid a big dense paragraph by using an unordered
list for the %(contents:XXXX) format specifiers.

While at it let's also make the following improvements:

  - Let's not describe %(contents) using "complete message"
    as it's not clear what an incomplete message is.

  - Let's improve how the "subject" and "body" are
    described.

  - Let's state that "signature" is only available for
    tag objects.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-for-each-ref.txt | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 6dcd39f6f6..b739412c30 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -232,12 +232,24 @@ Fields that have name-email-date tuple as its value (`author`,
 `committer`, and `tagger`) can be suffixed with `name`, `email`,
 and `date` to extract the named component.
 
-The complete message in a commit and tag object is `contents`.
-Its first line is `contents:subject`, where subject is the concatenation
-of all lines of the commit message up to the first blank line.  The next
-line is `contents:body`, where body is all of the lines after the first
-blank line.  The optional GPG signature is `contents:signature`.  The
-first `N` lines of the message is obtained using `contents:lines=N`.
+The message in a commit or a tag object is `contents`, from which
+`contents:<part>` can be used to extract various parts out of:
+
+contents:subject::
+	The first paragraph of the message, which typically is a
+	single line, is taken as the "subject" of the commit or the
+	tag message.
+
+contents:body::
+	The remainder of the commit or the tag message that follows
+	the "subject".
+
+contents:signature::
+	The optional GPG signature of the tag.
+
+contents:lines=N::
+	The first `N` lines of the message.
+
 Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
 are obtained as `trailers` (or by using the historical alias
 `contents:trailers`).  Non-trailer lines from the trailer block can be omitted
-- 
2.27.0.227.g757ac19d14.dirty

