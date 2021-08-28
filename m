Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A690EC432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 03:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72E6760F45
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 03:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhH1DKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 23:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbhH1DKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 23:10:09 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F46C0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 20:09:19 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id eh1so5149631qvb.11
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 20:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0p2joUdC8+E2lJaryFI+A71/bsl3TrPOFNgNLp/6jjs=;
        b=rcthtdD9p4r/qfMrKiJvrBWoN7nljv82RRMubrLysOgAhghzcLT2PKHQS/ixQIRIrv
         e2xuGfEUssCuPpWXwP2r3yCpvEPKZ3rSy+YsUhcZhkEdNsbBswBGomDm1H63Ud3dlN8p
         7A4lUqPT7SvrAqLPgD1zR8GI8mtPwhbuEcxbDJOB3ABuNh4rco1UGyxjQaCXMf5ewf+w
         Su+bS8lR1BV2KtXiFunLkUjh2D/Xn5qHXXQy1Pn+TWFqAEFgMCN7+DoH2gqWYr7alvh3
         do0loWfiCyhGbEieVw9MOwK5n7UMDX7CrpUS3L+tAP+sDYXJyGxHT4HQGs1dcjlvz1Fw
         6yEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0p2joUdC8+E2lJaryFI+A71/bsl3TrPOFNgNLp/6jjs=;
        b=Hw0jfqsiu2DqHFQBh34ul7jl6SymrjcXWbIgphOXFKf99mLJd30Mt0JUlE+3DI6VSg
         8Bsd86/aDXdyz0zCkqbXf9vsnyfreDxDP85OszcX8fF6/NgKznZbbDA50SntOMhzmOCk
         1KvP3xGFH8Zje9wu8nBnzbmi9rLMaCS/udy/kb1eC5pVdUTfZZAFnffhoAKO0eTeUK1s
         LT8HJ9EBumHnBuDZiFg8MAYA1jJSk1TnEhNuarAF7etkMsy6EUsbfeKNGHa6wSVtb5Ca
         k81eTET+AiDnIvQ2wFZDBjTihBasEJiN0Xs7bNQimjjfpnbGh5kF+KkPzp5ibKo2LkqA
         kJ2A==
X-Gm-Message-State: AOAM533k70LktgDpstQ0oh7/iuoMhrzZRDp01uuxoi1WUo8qnrKp6FLx
        MN5fbTIHSJCBUNVCTziWeIk=
X-Google-Smtp-Source: ABdhPJz4AxKc6eD8WK4nXCWbntxhYNrm/IObZ5YCw95mCFBuLSsfWhaDpOCeWAc9OsTIeWwtoTPRmw==
X-Received: by 2002:a05:6214:601:: with SMTP id z1mr12627823qvw.9.1630120158831;
        Fri, 27 Aug 2021 20:09:18 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id e25sm6071682qka.83.2021.08.27.20.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 20:09:18 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, tbperrotta@gmail.com
Subject: [PATCH v3 0/3] send-email: shell completion improvements
Date:   Fri, 27 Aug 2021 23:08:36 -0400
Message-Id: <20210828030839.2989-1-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <xmqqmtpbub07.fsf@gitster.g>
References: <xmqqmtpbub07.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git send-email" completion (bash, zsh) is inconsistent, its flags are
split into both git-completion.bash and git-send-email.perl, and it only
emits format-patch flags.

Make shell completion uniform, centralizing completion
options on git-send-email.perl.

Make "git send-email --git-completion-helper" properly emit send-email
specific options.

Additionally, update git-send-email(1) man page to explicitly
mention format-patch options.

Differences from V2:

- Incorporate Junio's code suggestions.
- Follow proper conventions for git commit messages.

Thiago Perrotta (3):
  send-email: terminate --git-completion-helper with LF
  send-email: move bash completions to core script
  send-email docs: add format-patch options

 Documentation/git-send-email.txt       |  6 +++--
 contrib/completion/git-completion.bash | 11 +-------
 git-send-email.perl                    | 36 +++++++++++++++++++++++++-
 t/t9902-completion.sh                  |  3 +++
 4 files changed, 43 insertions(+), 13 deletions(-)

-- 
2.33.0

