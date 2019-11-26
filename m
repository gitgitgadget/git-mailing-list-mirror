Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C72C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CB120835
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kiowghsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKZBbJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:31:09 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:49183 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKZBbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:31:09 -0500
Received: by mail-pg1-f202.google.com with SMTP id 14so9817320pgv.16
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eQNDez1mOSd2R3G90VGNMqKOdhiI0ECZgbVvcZVWfl8=;
        b=kiowghsAqMVZNFZjK56XvRKTGFh2SoUtBd6EWHon9A0aYHgOJ0ehl2h9xIO2oncMBt
         PbITeM5sBoZuAdKs+PVUK14Llgba+7Mul+cvh9+k781uX9Bs1iufZef2EaV5tusY/SYF
         a4Y/A7HbIrB6GVRn0tEilZMlMaHwsKg0JzaIbmdUhjtK8sZcKw56RVI0wU+DIxchets9
         PU5JhfO32D/4tI2WPNvFIHQW/co78m60kFWVuOZchdtLMuhq2FuVDZLJlOc+lLO6E30W
         SmQGsHTNDoSt6k1BB1fW7uJV9Ng6mhc6+LoTa1PztukQwRZJKPbshyhiV3MdIMNpAXLM
         fT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eQNDez1mOSd2R3G90VGNMqKOdhiI0ECZgbVvcZVWfl8=;
        b=I6dHHQJMT4GbXD4J++gZtl9SeO0EUZanMvFOCGuPeoH5ewycMWZT9vfCj9Vufhx4kF
         iB9C1csxQ9HXJvfKL3rrdhiOoidiOV0SqCMm2G2gapP5XBehamXPzLBeV4NmXr1Vuagu
         CnRuXsSOkuufQ5sNMGn3QIRlnURijxYVEtgOYqoRHWbjmq1HTI7EwfFHl4G+B6E3Jt8+
         MlJMs4KfxvIJpeiahYm6JFb5L5u3UP7gFq3C6b508cF2KPQu7dh0Zt3/3h4Qo9dCd3kC
         1NDG9WNKAuOvl0LSrIF5wCrO8G/xzpEh4tvTAXs+SEwo40GYpUjyiUC3XHzujexnev7o
         qJ+w==
X-Gm-Message-State: APjAAAUW8H46Ml3YAbN/8FOkqCj559czw+g87P96qP4up0n0I0k05IdP
        3kl3oC7/rF6+MmFZzfqQC0NHLzToli/NLlZiS7+equTDVTryBXa3ApXLiknwtvGM9YploBbB7i5
        s5RtAdA/7bhUkd5wTgMBMWBCvNAkXIX6/pGnFKZ5nnKsggpWORUBensmfG26U2bNi96kpberCQ6
        zW
X-Google-Smtp-Source: APXvYqxVUz/NuUNsRvI130kJuQuhWtlbGmGeIfHhmVIZVR7mvPqiqgSR462DHFZfm9zXlQgI+hE4iz8aVDa3zvXt/f/z
X-Received: by 2002:a63:e54f:: with SMTP id z15mr36719518pgj.453.1574731866906;
 Mon, 25 Nov 2019 17:31:06 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:30:59 -0800
In-Reply-To: <cover.1574731649.git.jonathantanmy@google.com>
Message-Id: <a8125b946227d918865fde0dcbec516474b42386.1574731649.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1574731649.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH 1/2] Doc: explain submodule.alternateErrorStrategy
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 31224cbdc7 ("clone: recursive and reference option triggers
submodule alternates", 2016-08-17) taught Git to support the
configuration options "submodule.alternateLocation" and
"submodule.alternateErrorStrategy" on a superproject.

If "submodule.alternateLocation" is configured to "superproject" on a
superproject, whenever a submodule of that superproject is cloned, it
instead computes the analogous alternate path for that submodule from
$GIT_DIR/objects/info/alternates of the superproject, and references it.

The "submodule.alternateErrorStrategy" option determines what happens
if that alternate cannot be referenced. However, it is not clear that
the clone proceeds as if no alternate was specified when that option is
not set to "die" (as can be seen in the tests in 31224cbdc7). Therefore,
document it accordingly.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
When I said "not clear" above, I mean that it is not clear *to me*, and
I assume that others will feel the same way. Feel free to drop this from
the patch set if the existing documentation is clear to most people.
---
 Documentation/config/submodule.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index 0a1293b051..b33177151c 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -79,4 +79,6 @@ submodule.alternateLocation::
 submodule.alternateErrorStrategy::
 	Specifies how to treat errors with the alternates for a submodule
 	as computed via `submodule.alternateLocation`. Possible values are
-	`ignore`, `info`, `die`. Default is `die`.
+	`ignore`, `info`, `die`. Default is `die`. Note that if set to `ignore`
+	or `info`, and if there is an error with the computed alternate, the
+	clone proceeds as if no alternate was specified.
-- 
2.24.0.432.g9d3f5f5b63-goog

