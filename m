Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765A5C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 04:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiAFEcX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 23:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbiAFEcU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 23:32:20 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A82C0611FD
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 20:32:20 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so7124942pjj.2
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 20:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xcGBZE208J+nFLcDQbdOgAxCPJV3e8eVzpI4vHD3ssY=;
        b=UzPWwL4h0EkVhpBYeTCfsNIlK1bbcB2xxZhpOl8P1T3nFCgaroiGYIq43Gll7SdfCS
         B1F3VMG3oQUdszdKgUSt3s7lxpk8X3LwLDLDnTAlou0YdGPUMtwWoD7JE0kns6D80/lB
         flOkuTQ4C8ibtSMsxYlGvCJC8/3T+1NI7oem2BsqlegmlzhkWvHBOOGoO2eizoKJvuT5
         0+Kqo7pClp0hCfAAdAFDwKyhcIoNziJguUNynCdchCYnM+uTy/hmHDvSa8E8TK1BZ+P7
         s7qI6PsGbP8MoWM55m4RTRPjna2YJUBhCyWFb+0myBQn991lUIxq6fASxP6b4KnMRn2p
         T/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xcGBZE208J+nFLcDQbdOgAxCPJV3e8eVzpI4vHD3ssY=;
        b=7f8k5gzFmuKu0e8uqth/dDWpQXhyCo/bga/dc97ScMsBhYhkBpeXiEVOWHNv//2rrI
         Z9Egz/zB4YC7OdfN2hO+3NsnCl7gfoQNDbISXb2R+G27ngaa7vAABzIHRtG229Hvk3Vg
         1LHwZ4tPla1I9AO5193Toy97+9s7YFi+Z3eaSwdy2xXdu+3TLgRuDLPbCr5X7B5ao8st
         b7iTGhBUIgBGupr17o61DF9Owj5EODcyB0RO9mF2aegeIN37znWxB8Lr64DckrGemOMY
         J2t1BmRkPyHzegQ22ZJc7ZRIGrkB9l1oTae/z/i6eCmfq1dexIUea5fdBT/DtNoh7gVp
         XKJg==
X-Gm-Message-State: AOAM5320NiKNvxYsQbqidj4fRv9NF1AjSLWgXnUvi89xzNQwNIH2g4M+
        pUsvc/q3NyvthEK33+hkH1c=
X-Google-Smtp-Source: ABdhPJwrFyfjhNHvvW74kVyyc042GTJfwscpId7yT9rtgnvbUbX9i5UXgmmRNMV3qyze3Mg+PulYsw==
X-Received: by 2002:a17:902:d484:b0:149:95f1:fcd8 with SMTP id c4-20020a170902d48400b0014995f1fcd8mr37765541plg.41.1641443539971;
        Wed, 05 Jan 2022 20:32:19 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.34])
        by smtp.gmail.com with ESMTPSA id 13sm636491pfm.161.2022.01.05.20.32.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jan 2022 20:32:19 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, tenglong.tl@alibaba-inc.com,
        Johannes.Schindelin@gmx.de,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v9 9/9] cocci: allow padding with `strbuf_addf()`
Date:   Thu,  6 Jan 2022 12:31:32 +0800
Message-Id: <8dafb2b3779715aa277eb825a94af87b72f3e093.1641440700.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.1794.g2ae0a9cb82
In-Reply-To: <cover.1641440700.git.dyroneteng@gmail.com>
References: <cover.1641440700.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A convenient way to pad strings is to use something like
`strbuf_addf(&buf, "%20s", "Hello, world!")`.

However, the Coccinelle rule that forbids a format `"%s"` with a
constant string argument cast too wide a net, and also forbade such
padding.

The original rule was introduced by commit:

    https://github.com/git/git/commit/28c23cd4c3902449aff72cb9a4a703220be0d6ac

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 contrib/coccinelle/strbuf.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.cocci
index d9ada69b43..2d6e0f58fc 100644
--- a/contrib/coccinelle/strbuf.cocci
+++ b/contrib/coccinelle/strbuf.cocci
@@ -44,7 +44,7 @@ struct strbuf *SBP;
 
 @@
 expression E1, E2;
-format F =~ "s";
+format F =~ "^s$";
 @@
 - strbuf_addf(E1, "%@F@", E2);
 + strbuf_addstr(E1, E2);
-- 
2.33.0.rc1.1794.g2ae0a9cb82

