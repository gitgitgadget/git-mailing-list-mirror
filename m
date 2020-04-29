Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B87C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 20:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2388B2137B
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 20:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tsUy9HAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgD2UgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgD2UgG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 16:36:06 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EDCC03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 13:36:06 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a32so1247271pje.5
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 13:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7idZlwMEWmC1E+BIatlC3qc566S4hIVfrwBFKQLGmOE=;
        b=tsUy9HArxJiZrEHMT5MTAgZ+423IncZechYuleAC1EAGiysohMc5DXXzp9kybyYayz
         GBdT5IKtlfyQoLbTGuh3xHwhCq9o2sPq66KieUP2ZuJFAYJ7UX2JVQReF9gh+Gk0p0rh
         NbZIzz9A93uaokoD9gfB+x93Lp/JxMgApq0ylPv1b9sF/N6ZDJqgqCtJh7xGuL/WOMmm
         Dw8XmRXZGkmQHY6v+q2c28GDvMH4Ji3AyHRriteW1MF0d4AnWtJhai5Q7l3+evI5LJ2q
         7KyoQK/jI9pQmPBkjAlfuimGMtpKMkyqawPYRc6ysdzisj2gEDr//IcsqgLfzxOpnwNb
         D74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7idZlwMEWmC1E+BIatlC3qc566S4hIVfrwBFKQLGmOE=;
        b=VI4EFWP+D9gSbMbaVq0oOLWd4vXKKW7/J8UqnTF5jEnm71Hh40dez6cZGZrRB8Fe6N
         BQ/w7M8o6skvn7+LzJjX2tLmm4fhl22/AJGQ3OOeSgN0+sMUjDR7RbCbAINswExl3bmu
         yRyQepEwcGanGVXgx/TBWBHiZRFxDFy6XPM294sdS0W2G5fI/2OJ8pqRdnyUx/wFX6cI
         n/ZUGr7kPshT4rjvpTKR8x0sntGajZzXPPDoHBdJe1HplA7v4OcosYHTWFxJvVtPUR0H
         jhx4Vavbg76LTFqPFBvne9TmXyp6tcClPjto3wH1RR5zi6PwiqSubmOTS0YRvODQfMVc
         oN5A==
X-Gm-Message-State: AGi0PublIB8trhz4Z6tGHs5qqasfaO6FUxDbxRlAGrUm5WLqoF8lToSa
        KRdXFdg5ljskfAi+ycoJ6NIF+ZbO
X-Google-Smtp-Source: APiQypI3QDt/03AV6UKKfPo5OwYYVh07WWg74lqSjAZoHqFlr+6X0fIXpL46G7JPmskqAPVncwOE4w==
X-Received: by 2002:a17:902:bd42:: with SMTP id b2mr143881plx.219.1588192565636;
        Wed, 29 Apr 2020 13:36:05 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id h14sm1816404pfq.46.2020.04.29.13.36.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2020 13:36:05 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     dirk@ed4u.de, sunshine@sunshineco.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH v6 0/2] credential-store: prevent fatal errors
Date:   Wed, 29 Apr 2020 13:35:44 -0700
Message-Id: <20200429203546.56753-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.569.g1d74ac4d14
In-Reply-To: <20200429003303.93583-1-carenas@gmail.com>
References: <20200429003303.93583-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

with the added checks for invalid URLs in credentials, any locally
modified store files which might have empty lines or even comments
were reported[1] as failing to parse as valid credentials.

document better the format for the credential file and make sure
any failures are still handled gently by the new code to avoid
regressions but make sure that any invalid credentials are flagged
as such instead of being silently ignored.

ideally would like to add a test against the use of cert:// to make
sure that is still well supported but don't know of any use case or
if it is being used with store (AFAIK, it could and at least in theory
it should still work fine with the added validations), hence sending
this as an RFC.

also, there is no real reason to have 2 patches but I am keeping them
separated because the first one should be AFAIK otherwise almost ready.

but considering that we are validating since v4 against a missing
protocol and printing a warning since v5, it seems we should then
fully avoid all those silently ignored issues as well (as shown in
patch 2) which I hope we could squash and release together (if agreed)

[1] https://stackoverflow.com/a/61420852/5005936

Carlo Marcelo Arenas Belón (2):
  credential-store: warn instead of fatal for bogus lines from store
  credential-store: warn for any incomplete credentials instead of using

---
v6:
* get rid of redacter and only use line number for context
* make validation more strict to also catch incomplete credentials
v5:
* q_to_tab this round, with a single echo to make sure empty line
  is covered, as that seems to be a popular issue
* rebase on top of jc/credential-store-file-format-doc
* implement a redacter for credentials to use on errors to avoid
  leaking passwordss
v4:
* use credential_from_url_gently instead as shown by Jonathan
* add documentation to clarify "comments" is not a supported feature
v3:
* avoid using q_to_cr as suggested by Peff
* a more verbose commit message and slightly more complete documentation
v2:
* use a here-doc for clarity as suggested by Eric
* improve commit message and include documentation

 Documentation/git-credential-store.txt | 12 +++-
 credential-store.c                     | 23 +++++---
 t/t0302-credential-store.sh            | 80 ++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 10 deletions(-)


base-commit: 272281efcc18fcedd248597b8859f343cae1c5a0
-- 
2.26.2.569.g1d74ac4d14

