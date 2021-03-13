Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBA1C433E9
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 08:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE50664F27
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 08:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbhCMImG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 03:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbhCMIlh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 03:41:37 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06633C061574
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 00:41:37 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id t85so3439095pfc.13
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 00:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/L/hPso6i/F8RX2HNrOzsyeGGRLb/JBSy6pUS1wFDVw=;
        b=fxIvYw8ArCxgE6MErn6tMv8SwhaBXR64bPc9rlIzZQ28mpYVtDyeITdzx49RaEnEhd
         rHohAf+9rgS7lWWWjqw+vQvi5Of5Bwva5zluZ+DFPj1GCyYiSaXFo+0SG6LIgBQUVTWZ
         KnOE/2Wf130be+Cy3Z5m+MIiQvY6BcN5NhHO+RpRiaOhuukndZ8BnuJydXXUcdKQEDDZ
         tQhgUjBKvgMXeTJhPFTi4GhYg7cLgLumlUrsB9ZJ2sl2Y6SYvXorSgYXs8nLnqsBjtVZ
         UHfkxe2qQJrmhc91dR5b4y1TPsagmO1sY7kk7uYGts9sgYiPIQsyK33l1emkxGMwbGrz
         3C9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/L/hPso6i/F8RX2HNrOzsyeGGRLb/JBSy6pUS1wFDVw=;
        b=ERN26ca2pvlkJ6CpMgpeNOWnM5EWO1zHYqAh2VkHMlvHUmO3wQqfZxLrD3IPhQVw32
         ze8yTSqMl8Iejv9prbXLMR7o1HjV+/W11omX7pWDqYZlmRAmqvqwOb6WgCqm2Rv9b/MX
         cSn8KsRbQWU9jZh4zA/8yd2i1coG0hvqIOb2oQEgF5IzUZ4nc5JTjlmnwfPmMUNrp3Kc
         WLmp6qnSUAty0kTI6V6pApDAnCA0g+s9TY7pPst01VJwxcfIyBsiLlBBvG0/pAW3YYJo
         t+aoBPvhr6DsHS0MwFtLNyQL0S4/vwd5CMvg6A72CrzH6Dwu5d5Qy9y+xeExASL8O07Z
         DsRQ==
X-Gm-Message-State: AOAM531vatskUk4W3elo/FC23hKkHf+Xjtvn3yS/1kc2Q52i8El3P7YI
        j8tldmdZCzEQ7nLtCY30khN7cVjFrgY=
X-Google-Smtp-Source: ABdhPJy51Vuost3DnuII2EkbmdQl1i/kqO/3iSVzVY8vyUcMqOEU//UyXvGreNZefWUEJeDy4LlQ6w==
X-Received: by 2002:a63:dc50:: with SMTP id f16mr15244471pgj.16.1615624896506;
        Sat, 13 Mar 2021 00:41:36 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:a1e7:6707:cbf6:696d])
        by smtp.gmail.com with ESMTPSA id p20sm7523094pgb.62.2021.03.13.00.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 00:41:36 -0800 (PST)
Date:   Sat, 13 Mar 2021 00:41:33 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Seth House <seth@eseth.com>,
        Dana Dahlstrom <dahlstrom@google.com>
Subject: [PATCH 2/2] doc: describe mergetool configuration in git-mergetool(1)
Message-ID: <YEx6ve6AbqacVTQH@google.com>
References: <20210130054655.48237-1-seth@eseth.com>
 <20210209200712.156540-1-seth@eseth.com>
 <20210209200712.156540-2-seth@eseth.com>
 <YEbdj27CmjNKSWf4@google.com>
 <xmqqmtvbjuvl.fsf@gitster.g>
 <xmqqzgzafo5o.fsf@gitster.g>
 <xmqqlfas55mk.fsf@gitster.g>
 <YEv5d0pGvEVpepoY@google.com>
 <xmqqh7lg54h4.fsf@gitster.g>
 <YEx5hM/HWby3FBJv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEx5hM/HWby3FBJv@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In particular, this describes mergetool.hideResolved, which can help
users discover this setting (either because it may be useful to them
or in order to understand mergetool's behavior if they have forgotten
setting it in the past).

Tested by running

	make -C Documentation git-mergetool.1
	man Documentation/git-mergetool.1

and reading through the page.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-mergetool.txt | 4 ++++
 1 file changed, 4 insertions(+)

Thanks for reading.

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 6b14702e784..e587c7763a7 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -99,6 +99,10 @@ success of the resolution after the custom tool has exited.
 	(see linkgit:git-config[1]).  To cancel `diff.orderFile`,
 	use `-O/dev/null`.
 
+CONFIGURATION
+-------------
+include::config/mergetool.txt[]
+
 TEMPORARY FILES
 ---------------
 `git mergetool` creates `*.orig` backup files while resolving merges.
-- 
2.31.0.rc2.261.g7f71774620

