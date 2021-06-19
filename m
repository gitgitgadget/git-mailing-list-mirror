Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155A1C2B9F4
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 11:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D73B560FEE
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 11:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhFSLba (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 07:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhFSLb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 07:31:29 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BFEC061574
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 04:29:16 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id d7so12250113edx.0
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 04:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dQ4qXRvL708xN+TIHW3sVcMMyq4ks4eBICXJrbDPhZ0=;
        b=nu5of01W5FZrOCbW8yG2AJk+GHSYN5T4t0GPvHpUY14U1qBoD6PkfU2DZUkRncn3GA
         /mPGDDxMDqbx8FacgSVhovqyLJwzxlPBGlJoO5BeC97xtGcLx4zaX+uvPoAT8zF9DNY7
         qQ/OIp+co829E3loMTIYXpRFP6jRRFcHT+xdTjBuGackmeaQsXugFbIixh31uq8HTPG+
         KPazLF0DXLsCOgm3h07ownpUduROgG7fsqQvp/saXnqQHG6TT5BJbeZeN4MfAPgtZz69
         0DVHWOXTmwzIYhxvqfnK/xqcICdudKTV2nWyLyu4JD5jjs3vZraJ3/Lz5w6dBrNI9Kbx
         NP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dQ4qXRvL708xN+TIHW3sVcMMyq4ks4eBICXJrbDPhZ0=;
        b=HsNrPMEOCbE8++3aJsFkim5O72GGbPdCvDG8PnpwEvQrbANYL92TVp0hPaZ+K8kR82
         KCGDwfEq4Z1GlLMNhsepP1zRRhevUaC4CWEUZDb2LXVrZ33SL75LfUQTsNyLu3itgSZx
         2CuNo2rJMEwFne+RM40oIypX/itKo/KRD7kLXx41WD5yDIKLzPjL+CBQLxXqx+WUCkKQ
         aHEX8dQL/eQkihqoOSAEySMAF1anF7GZqBkf9G/IA1BNs2st0yHyqRtS4HqLRVWj/nnD
         +qDSCmE/N3aUtzvwQjwngWgPOm9XO4y8vJx2r2KSbvLk5VS8rhYTWe2+LMQjnCwLtJuJ
         jvTg==
X-Gm-Message-State: AOAM531Jhy8fQzdctVneiL074QVomYm3myEC/o+7VBnIiLrjne5q2naB
        mDzDfLtaiyFsU2RHJFb5fmpszINJ/AXwQqueA9Dntg==
X-Google-Smtp-Source: ABdhPJzEa8CDJgocy86OaTKoXjdamX6+q5iwxMqC+ZCDTAcKEAuapHyEz2d1rJYttkfZwvNgpsCPkQ==
X-Received: by 2002:aa7:da8a:: with SMTP id q10mr4151391eds.81.1624102154069;
        Sat, 19 Jun 2021 04:29:14 -0700 (PDT)
Received: from titov.fritz.box ([2001:a61:34c8:7e01:39e2:683d:7a5c:2a16])
        by smtp.gmail.com with ESMTPSA id q9sm7690098edv.31.2021.06.19.04.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 04:29:13 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Barret Rhoden <brho@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] blame: correct name of config option in docs
Date:   Sat, 19 Jun 2021 13:29:12 +0200
Message-Id: <20210619112912.76136-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618221104.42260-1-rybak.a.v@gmail.com>
References: <20210618221104.42260-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As can be seen in files "Documentation/blame-options.txt" and
"builtin/blame.c", the name of this configuration option is
"blame.markUnblamableLines".

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---

Thanks to Bagas Sanjaya for review.  Changes since v1:

  - tweaked commit message

Range-diff:

1:  e32c298ee8 ! 1:  6ea64765e7 blame: fix typo in documentation
    @@ Metadata
     Author: Andrei Rybak <rybak.a.v@gmail.com>
     
      ## Commit message ##
    -    blame: fix typo in documentation
    +    blame: correct name of config option in docs
     
         As can be seen in files "Documentation/blame-options.txt" and
    -    "builtin/blame.c", the name of this configuration variable is
    +    "builtin/blame.c", the name of this configuration option is
         "blame.markUnblamableLines".
     
         Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>

 Documentation/config/blame.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/blame.txt b/Documentation/config/blame.txt
index 9468e8599c..4d047c1790 100644
--- a/Documentation/config/blame.txt
+++ b/Documentation/config/blame.txt
@@ -27,7 +27,7 @@ blame.ignoreRevsFile::
 	file names will reset the list of ignored revisions.  This option will
 	be handled before the command line option `--ignore-revs-file`.
 
-blame.markUnblamables::
+blame.markUnblamableLines::
 	Mark lines that were changed by an ignored revision that we could not
 	attribute to another commit with a '*' in the output of
 	linkgit:git-blame[1].
-- 
2.32.0

