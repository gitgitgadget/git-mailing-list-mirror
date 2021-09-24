Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CAFC433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 02:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E5F610C9
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 02:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243957AbhIXCsg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 22:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243952AbhIXCsf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 22:48:35 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7483DC061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 19:47:03 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 11so5451851qvd.11
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 19:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hJ+uuD2Uc5Jftwa7bWD03Ywnk/fanlhn01I66NfQ5w4=;
        b=J4EAgiWUMZLp0cj/HiG1UrtLH8RlxbSri0ZcOahr5h0JQ3dXtoNCJFYqOop7vOZMeL
         X/B3KX3txD2e4lfOA11H1t7P9c+zX7UEDL3+4qdIyH8SmtfEEBlQaE2hAXvlMAvPO1Ba
         7PESjiL8SMc6E2zZCSzWCFbyIkN8WmlfnBOsdykADCKzGAuak2YrxeCBbTqgrqGPI0OO
         1oSpRChkQfED81JLktk5+k7kUnoFyVCqITqnAVKA1f7iEXNMrB+pIUq280LmaXM0d01/
         BR3igekk/P/4vs0cjcJURz0pi+bchQoT3245a/suqO/m86EeeR8mgLnr8QokjOLWaA8E
         TZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hJ+uuD2Uc5Jftwa7bWD03Ywnk/fanlhn01I66NfQ5w4=;
        b=oJF9Ha1UWwQgI/ZFggfQFsDAkinKS/YP7SdFJM5J1et2b1QkuNR8mOZAarxIwHgJKn
         kIw+/drFUoKB3kYGaY3uEbUQWqYBFLu+GXt9uChCth5UQghLSU4KIJeVSGaHQ7QiUFk0
         6nNjeGYPwdEbdCYf7VVWcGWt292NRaSitH5RLokOmNKdUs48gJktuGBCXX25FObugJec
         uEsNb5SQ4xaN4QxMXP1yZNG4TGqWNr7oR3YUHoI8JhcD31xG1neL42Ab9bbFmd6OU2Yv
         cRA3MlYm8ru9B6SBgqVb8PsHjJr0LhhPg05MC9slJ7mDLFynuhHMANKHp7CfhK7/XbLu
         +aTg==
X-Gm-Message-State: AOAM533cmr5rEyOrLq/kBWYImdDN1RVN2gWugBkull23hylvkSh8l5tW
        1WZN2kW125LYlFGQVQb2nTIAjuVyNhc=
X-Google-Smtp-Source: ABdhPJz5ajKDdAGbaCRVdtEOAsvFHqkhSFe3/++GgIOd/aF1lKoyWVVyAUvK46E8vP96i1GGUTEVJA==
X-Received: by 2002:ad4:54a9:: with SMTP id r9mr7889350qvy.61.1632451622604;
        Thu, 23 Sep 2021 19:47:02 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id v5sm5698011qkh.17.2021.09.23.19.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 19:47:02 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     carenas@gmail.com, gitster@pobox.com, bagasdotme@gmail.com,
        avarab@gmail.com
Cc:     Thiago Perrotta <tbperrotta@gmail.com>, git@vger.kernel.org
Subject: [PATCH v5 0/3] send-email: shell completion improvements
Date:   Thu, 23 Sep 2021 22:46:03 -0400
Message-Id: <20210924024606.20542-1-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <87zgs34ccx.fsf@evledraar.gmail.com>
References: <87zgs34ccx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
specific options, generating them programmatically.

Additionally, update git-send-email(1) man page to explicitly
mention format-patch options.


Differences from V4:

Incorporate Carlo Arenas' and Ævar Arnfjörð Bjarmason's suggestion to
programatically generate the flags.

I tried to be concise whilst preserving readability, hopefully it's
straightforward to parse the current implementation.


Reviewers of previous versions:

- Bagas Sanjaya
- Carlo Arenas
- Junio Hamano
- Ævar Arnfjörð Bjarmason


Ævar wrote earlier:

> Note: using --in-reply-to to the previous version in "git format-patch"
> helps keep track of the context.

Thanks for the heads up, I am slowly getting used to this email
workflow, this is my first contribution. Hopefully I got it right this
time.

> Isn't this just:

> my @params = <getopts list>;
> GetOptions(@params);

Let me know if the regex approach I went with is OK. You seem to have
suggested me to do something with the `GetOptions` module, but I'm
afraid I only know the basics of Perl.

I tried to do something like `GetOptions($USAGE)` but it didn't quite
work (clearly I have no idea how to do that :P). If you have something
specific in mind, I'd appreciate if you could send a small patch back
that I can incorporate. Otherwise, either way, the current regex
approach isn't too horrible and seems to be reasonably reliable.

Thiago Perrotta (3):
  send-email: terminate --git-completion-helper with LF
  send-email: programmatically generate bash completions
  send-email docs: add format-patch options

 Documentation/git-send-email.txt       |  6 ++++--
 contrib/completion/git-completion.bash | 11 +----------
 git-send-email.perl                    | 21 +++++++++++++++++----
 t/t9902-completion.sh                  |  3 +++
 4 files changed, 25 insertions(+), 16 deletions(-)

-- 
2.33.0

