Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F142C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49696613C2
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhFRSaE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbhFRS37 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:29:59 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C4BC06175F
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:27:49 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so10642825otl.0
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=95IgTgOFdBlNy87ptSV3o7lyWR9/XtExYZz+fWvbGyo=;
        b=arSxaMsfYVTrbSjl6Z2qsFsKYv2NduzF5KoowLjthDJ38vh8ek3u16+Wl1rrGDRDhQ
         EAqP4fCVGgAQ5SfCZ15grN9HHd/AFoO6P3CrmN9bQ+r0jqaEnIyZ3qSUJaJzowuk+oaL
         7ebJR0m8JaS8yRZJlKmDlO7mzNd/9Ww+arr5Izfe1cF8zaSmH/jYC3naOMpu/V+2dJ0d
         iOG17Vtff1LUqJF2j2SQGdsxYK+bxYN5PwqdF9UXUHkFfZrDaTZTWIbF6gwmTQ8nLrNX
         ojyqophrJRRfAwtxcGdyOc8J5ERsI+x0U/0N/8Kg0uHcNVmJOG5tv2HGNfO0lhYJuiQe
         h3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=95IgTgOFdBlNy87ptSV3o7lyWR9/XtExYZz+fWvbGyo=;
        b=nBYriLNKSCmRPvRI0q6LyrtBOeTV8O3DgsFqmvanmUxDdpQJOVo2qEaqDIS+gFO2TD
         AGStTQtS37SXYclUnKEx0ZPqCcMkPJThe4gvKqCfzzVg6Rk06vn1bp/4okzVNXh8Vzek
         Tm9qRx0ABAOQ37WJhQqAVHLqBlauNAuG2U23WkrDLgw5bJLUxZlu5fbA3knVK9AnVENX
         ANByQSnekNUBDONatljI0QdP41Ltj68+cQDxLH1UWKYhZKh5O5MyuVfSuF+pBaMpkhKB
         2B71e+gMomXwNH8FPBmlTExeygLgGMwyP9uqCx0cEPD3PdCqx78PqRc7i73HTYSgf5q7
         ZrtA==
X-Gm-Message-State: AOAM533PPyOtF9k8/hyKZ374GuZiuGouGP1z3bJLeFbjDjdU43t/SJ56
        Vy1m4rQjaujeybtnmuc+5Yj5gXxgxduijQ==
X-Google-Smtp-Source: ABdhPJwDNqhGXJdgFrKg8jJgpFxspMNwrvx7b2K831zMJihksELS1Ezc5PgooBRw5EOeNiqJSNjCgQ==
X-Received: by 2002:a05:6830:22d9:: with SMTP id q25mr10943434otc.98.1624040868551;
        Fri, 18 Jun 2021 11:27:48 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id c184sm838235oob.43.2021.06.18.11.27.47
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:27:48 -0700 (PDT)
Date:   Fri, 18 Jun 2021 13:27:47 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Message-ID: <60cce5a2e46ec_a88e92088c@natae.notmuch>
Subject: [ANN] git-completion 1.3.3 released
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Git-completion is a friendly fork of the official Git completion and
prompt scripts for Zsh and Bash.

The main goal is to provide a more up-to-date completion for Zsh (I'm
the developer), which is basically just a wrapper around the Bash
completion.

Compared to Git upstream, you get many benefits for Zsh, but there's
also benefits for Bash users too.

Since the last version, a regression in upstream v2.32 has been fixed.

In total there are 45 patches [1] on top of git's master.

For installation instructions, and more information, check the wiki [2],
but basically.

 * make install
 * fpath=(~/.local/share/git-completion/zsh $fpath)

And for Arch Linux users I've created an AUR package: [3].

Cheers.

[1] https://lore.kernel.org/git/20210618182518.697912-1-felipe.contreras@gmail.com/
[2] https://github.com/felipec/git-completion/wiki/Zsh
[3] https://aur.archlinux.org/packages/git-completion/

-- 
Felipe Contreras
