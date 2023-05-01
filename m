Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECA0C77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 15:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjEAPxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 11:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjEAPxv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 11:53:51 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7A7E8
        for <git@vger.kernel.org>; Mon,  1 May 2023 08:53:50 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-b9da6374fa2so3176761276.0
        for <git@vger.kernel.org>; Mon, 01 May 2023 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682956429; x=1685548429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r5MQh5k9nsKF29e4Xq+z7dgsJl0I4C2yAieDUuExjzs=;
        b=K51qSRoUTm8/fs9dSSEqMSEiFagpzPzmOK26krKAeUleoGafsPQyLGTntiqV/qsa7n
         xmuU5HdAM8NktFnLRn8XTacN1G/BMbpC47t/GnPUk2xKoo0un+xlxCZ7cGXdDzpmE/lN
         XSuE5ZDOWJmVSTChCHq2kXZxhWWtHuAwjXNWBz2Q5SuUZRUgezRadHs/Vu8k96CSkz3M
         knL48GReJhNSpxON+8FYqAd9vmJK1QiVBf4MbxYSKuSGvo9NhnrZ0w3VHEmffx8umdfz
         2WkZrfXMMOqY15E3//2XRrcFQ5KFF+ILmGHNWx3jnueUzeI369D/f6J38fja04NUqh9+
         14Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682956430; x=1685548430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5MQh5k9nsKF29e4Xq+z7dgsJl0I4C2yAieDUuExjzs=;
        b=KlWrrWWO1gIRJkC5Pu7HHmcdsR1nQ1K2VfU3BKYUcPxvKVVwYsg3kwvuiuFkAPL2Io
         UFAp+TDDsH0V4DpVLE5HfZ5ctavz8N86tx4pF4iKqTzybKdVszz5ijWjiPTGxonSL2lK
         TOFWRo4O0NH3TT7x6bFOLfrV43jpMZSgltZtIo9Ae7lRo7ZXerLkGbvZQsRuJ74cYPjh
         m4gCn21bYDPSBe3nY1Y2+Wnf0l4DMoIEwRV6meGiqZGcpIvoUxk0ITZholz8ULdA7z37
         dQgqvrf0t+IzdVRdAjQGgIIJUADbu/o+ZuPt4hkPlXrckX7+fOafbD0aY0pTbiSnpW9x
         2GNA==
X-Gm-Message-State: AC+VfDws+oIMQVeol8BOVmBB5OyRmLhPz9n05w94KbvfuhH5hWFKPrWZ
        7G0JosbNUo4Jz9TdGw+zYDmg8EhXX8senB9tDAgTsw==
X-Google-Smtp-Source: ACHHUZ76u0FN9fNaxiO1W7GOw2uP9P1f3W6qclLjKIM/6XSG2QCNUaoPUBQ72ZTmAnH+Mh8gzqS9Rg==
X-Received: by 2002:a25:a82:0:b0:b95:8f10:5936 with SMTP id 124-20020a250a82000000b00b958f105936mr13682047ybk.54.1682956429743;
        Mon, 01 May 2023 08:53:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j6-20020a5b0686000000b00b8f3b826e58sm6788976ybq.19.2023.05.01.08.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 08:53:49 -0700 (PDT)
Date:   Mon, 1 May 2023 11:53:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 1/7] credential.c: store "wwwauth[]" values in
 `credential_read()`
Message-ID: <a104afd5e1de792fadd51bbd6887725880dd23f9.1682956419.git.me@ttaylorr.com>
References: <cover.1682956419.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1682956419.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git-credential to read "wwwauth[]" value(s) when parsing the
output of a credential helper.

These extra headers are not needed for Git's own HTTP support to use the
feature internally, but the feature would not be available for a
scripted caller (say, git-remote-mediawiki providing the header in the
same way).

As a bonus, this also makes it easier to use wwwauth[] in synthetic
credential inputs in our test suite.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 credential.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/credential.c b/credential.c
index e6417bf880..96fc0daa35 100644
--- a/credential.c
+++ b/credential.c
@@ -238,6 +238,8 @@ int credential_read(struct credential *c, FILE *fp)
 		} else if (!strcmp(key, "path")) {
 			free(c->path);
 			c->path = xstrdup(value);
+		} else if (!strcmp(key, "wwwauth[]")) {
+			strvec_push(&c->wwwauth_headers, value);
 		} else if (!strcmp(key, "password_expiry_utc")) {
 			errno = 0;
 			c->password_expiry_utc = parse_timestamp(value, NULL, 10);
-- 
2.40.1.452.gb3cd41c833

