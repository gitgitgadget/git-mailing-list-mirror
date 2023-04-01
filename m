Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C112C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjDAIrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjDAIrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:16 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3451B22910
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:46:51 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 6-20020a9d0106000000b006a177038dfeso3969020otu.7
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6P/MjpIc+weSsTibcyDqrbPEc4Eoh/Jp2wlHKqBOjo=;
        b=odku8DP2kwk6D8UyUMOsX/0lOFl21QWkeTveLNaLQxFAF0W1PR8OIey0YMNTvKhzO5
         xagvIo4jCzvV7KJ1b1qha4hfzAFPriNt2oH6TH4jfuRBK6xlMMgjBiR5HmC43eWURJR3
         cmWkzqOwtTwHcW/+zFXRj07AnB3YojvLXZsqlqJU4MOVYKImorahmyFPcVgDw6VIn73e
         Wlc6+dstZdsGjn2AcRINQfaWvnKA52vSppZFktfhcbs6wOeUMLMxUwLm15xB3YKsuz+7
         ZYvucP+3razSzQV8FSoaVgrjJRW6xpdGdjoTLfBcOptZ90xUlsA+RjfWf0JNFfkYdqEx
         Hwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6P/MjpIc+weSsTibcyDqrbPEc4Eoh/Jp2wlHKqBOjo=;
        b=oPIPAc3KRw6+2XcFQONOjYI8P0dpmBU41YfH4UQLHFbqT9zwa+KIfzoFXD65khZD5x
         a7MMRcJrRR460Xu+0vv4sleaat5GNnfDifjcTyAFOexxUA0lPttXUKLvyEmz9Vqiuhen
         GDG+3ZrOKcmi2kFv4TgSvevtcWLIYh9dQydEvsb0HelH6t5/1Pr6r+mVPT8UNBdo/gWy
         MX6wcNu7k4q+u7GNMNueHkSQJzR5PJ64ywZGBGZNKESh/H00Lni83Wf2Z7BNkE23YfO/
         n9vKxS3W2drglQgbDnYyR8F45Nu5IkcmEgvS36aWmAPiFdyEgVKZcLxOh1Ats2P0kOoH
         T7Ug==
X-Gm-Message-State: AO0yUKVuk7mYOGnyJeq2aDmyeHEnwM610cULvueVGTFg8dIKjGVIsQQZ
        P7O54MJ0dmFCIPHPMO/ILq5G0tQa1Is=
X-Google-Smtp-Source: AK7set+l5mAoCk5GpmXWbXr8JP5Tl5e72VyNMFcoQvI+6ybmd8g/dIb0RQJ4KFYefYI/yl0KXO6r+Q==
X-Received: by 2002:a9d:6e90:0:b0:6a0:d291:90b0 with SMTP id a16-20020a9d6e90000000b006a0d29190b0mr13623032otr.13.1680338809978;
        Sat, 01 Apr 2023 01:46:49 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id o204-20020acad7d5000000b0038986062468sm1875526oig.7.2023.04.01.01.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:46:49 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 16/49] completion: bash: remove non-append functionality
Date:   Sat,  1 Apr 2023 02:45:53 -0600
Message-Id: <20230401084626.304356-17-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no point in setting COMPREPLY only to override it later, and in
fact... we don't do that.

Therefore there's no functional difference between __gitcomp_direct()
and __gitcomp_direct_append(), since __gitcomp_direct() *always*
operates on empty COMPREPLY.

The same goes for __gitcomp_nl().

This patch makes the functionality of append and non-append functions
the same.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fd2a43de38..7554c3aeb3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -318,7 +318,7 @@ __gitcomp_direct ()
 {
 	local IFS=$'\n'
 
-	COMPREPLY=($1)
+	COMPREPLY+=($1)
 }
 
 # Similar to __gitcomp_direct, but appends to COMPREPLY instead.
@@ -470,7 +470,6 @@ __gitcomp_nl_append ()
 #    appended.
 __gitcomp_nl ()
 {
-	COMPREPLY=()
 	__gitcomp_nl_append "$@"
 }
 
-- 
2.33.0

