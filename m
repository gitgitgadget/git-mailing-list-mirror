Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F19EB64D8
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 21:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbjFNVbx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 17:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbjFNVbw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 17:31:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC2119AC
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 14:31:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba81b37d9d2so1207847276.3
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 14:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686778308; x=1689370308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GwSvmqyN5DtpvlE6AMZEc3Qo/+B2YUZW7QjpU6CGbrc=;
        b=dYIyW7RZurL7h/AMzPx7JRKm7FM79aNwhTu4eAvpempDPUc5uYE0v7F3qH9etCYUpI
         mH6+IPndncfIOvwa2/1FZYkv4PDsRQQyCVot8PULAdWp8Fe7yCxDPpRWMfuYPUH+kgeA
         VUMZVUjOwd3Cq9sNztQDj2z5QNpB1UcP3HYNXY9LsZNLcaCu8mcEktIWhsdi8IUcWcMM
         JXv1wupb8L9s5O/LN6TuAZg4esmK7vP7ihqBehQWu5DFcXTz+mth+vmXltINb/4A3Z4w
         6bAwx+01QFkM2aDVPtOSfuXrKTVyg9dT4CXck8OWjUQja0fLJ47j8RZReYvbPFeUWo1S
         XfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686778308; x=1689370308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GwSvmqyN5DtpvlE6AMZEc3Qo/+B2YUZW7QjpU6CGbrc=;
        b=Sdbb3jkOYGRuR6vwr3NhhZhiR3K8movyx97VjxAEXqPCfFyKt+tTbbhZMtuvwHgvL7
         CBH/NZh1giFtjwcip96cYutopUgp1V4YSKmxmjrgHgkrsYMFDMIY/8I6rs1akuYynOUn
         hadTSvm3OeKzmvl3W0L91FP3BMPpQryZTTKB6ruFopnTUNjVPs/FZFPUK9O7njCKQY37
         lYV0UWpETtmQVfYbxbWkOQWOPe+yAuELWf0+LAHB0185J104iM5f8fwyCvD8XwvOWRRn
         mH2hjOF+BdKbyY/Jmr6H0Q6iQuI71ccRw6MPyPghfJNL1BtL0tnqc9vQwEi9QHcr4FMl
         D0ow==
X-Gm-Message-State: AC+VfDyTmhZXqZRczgoCFjP0f8ojjhyAYVAD8AAm4+OUidJy6N+XKHVU
        teU5pipo8O1CHJaTprbTnMGvAC2tkNSFFVPo7n38QQWG8I15Vqj+D9hcFevsxENNBZNb4UUjUyJ
        irvX0MwaXu4L7tjAWlMHYPFsfomV273J8ck89h/rvdX/BIxbPnIzDCKiUElwjqkmFOKZH3MTE7J
        WW
X-Google-Smtp-Source: ACHHUZ7YJ/ldkdcFWGmV4HtFYfEW89oDNsXWbBlGw6feyKFNnHiigdR9NMggF6CUPxaqii+36E+dRxOloyy7spA8EzV4
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:22d9:108:360e:c657])
 (user=jonathantanmy job=sendgmr) by 2002:a25:3201:0:b0:bcc:285c:66df with
 SMTP id y1-20020a253201000000b00bcc285c66dfmr415628yby.4.1686778308443; Wed,
 14 Jun 2023 14:31:48 -0700 (PDT)
Date:   Wed, 14 Jun 2023 14:31:45 -0700
In-Reply-To: <20230614001558.277755-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20230614001558.277755-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614213145.475607-1-jonathantanmy@google.com>
Subject: [PATCH v3] CodingGuidelines: use octal escapes, not hex
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the shell-scripting section of CodingGuidelines to suggest octal
escape sequences (e.g. "\302\242") over hexadecimal (e.g. "\xc2\xa2")
since the latter can be a source of portability problems.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Changes in v3: Used Junio's suggestion [1].

[1] https://lore.kernel.org/git/xmqqy1km28g9.fsf@gitster.g/
---
Range-diff against v2:
1:  c775a0db22 ! 1:  0b7d3ed8f5 CodingGuidelines: use octal escapes, not hex
    @@ Commit message
     
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
         ---
    -    I've used Eric's suggestion for the commit message and limited the scope
    -    of the documentation change to printf.
    +    Changes in v3: Used Junio's suggestion [1].
     
    -    Version 1 was here:
    -    https://lore.kernel.org/git/20230613172927.19019-1-jonathantanmy@google.com/
    +    [1] https://lore.kernel.org/git/xmqqy1km28g9.fsf@gitster.g/
     
      ## Documentation/CodingGuidelines ##
     @@ Documentation/CodingGuidelines: For shell scripts specifically (not exhaustive):
    @@ Documentation/CodingGuidelines: For shell scripts specifically (not exhaustive):
         in C ;-)
      
     + - Use octal escape sequences (e.g. "\302\242"), not hexadecimal (e.g.
    -+   "\xc2\xa2"), since the latter is not portable across commands like
    -+   "printf".
    ++   "\xc2\xa2") in printf format strings, since hexadecimal escape
    ++   sequences are not portable.
     +
      
      For C programs:

 Documentation/CodingGuidelines | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 003393ed16..39ef53c237 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -188,6 +188,10 @@ For shell scripts specifically (not exhaustive):
    hopefully nobody starts using "local" before they are reimplemented
    in C ;-)
 
+ - Use octal escape sequences (e.g. "\302\242"), not hexadecimal (e.g.
+   "\xc2\xa2") in printf format strings, since hexadecimal escape
+   sequences are not portable.
+
 
 For C programs:
 
-- 
2.41.0.162.gfafddb0af9-goog

