Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EA5C32771
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 09:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AD22071E
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 09:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VnlF15N6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgA0JZH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:25:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37483 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbgA0JZH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 04:25:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so6213058wmf.2
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 01:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GKAYAZWT/ztneHfOI3gpKfHYnPhkTG3yuT2u/7PoPJw=;
        b=VnlF15N6uDB7EzEx4ArCEqhfv7nEXUF79zpZPh98X/MY7VcMTi8OFd+BchVJTsEUOg
         RPqGh3RyJJ5DXsoF9ajuAQhX4rTS19gaNWsl4sOkZaxil7Mrlyqln8Mh6mTLMmUtT7BY
         fc21GRYOcHNo9KslwoA5zrHnoRv/7zXEvisFVNsI8q8BBz1FhJaLWDcwnhTjuAtiBJVf
         Ha/COWP7u79s9NNwQkJ+ld8a16xh3z3lhvaDT5u1sa4fauQbDgjCLmdBWLODta2Z13UY
         +fHW6SvHI6zjlJEMGmA+qWhJn+kGm4oygzlpdXs9p8iw107ngMAaTMZuWGZIUI2RRBWN
         zhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GKAYAZWT/ztneHfOI3gpKfHYnPhkTG3yuT2u/7PoPJw=;
        b=jpjcTfBHCwm+hr9ZO1PqUZNL7zvdR8QXCEgVMyA26S33xtRM99os5lc/nGcX3Af0W3
         yTkI3O2by0/mmWyhI5mfKq8gCQ44Mep/oJrT6h6+20ikresIJ/lJlxeAQVSsWax2jdSm
         Li6h8WgL8yq9z31jWomBxez3Pp8jeMTuj5ws7thG2lR3oKnlhDzIqUWa152O1uMOq4lX
         JVbB6RhnDtk0PUSDkuUrgrBpVDfaR2pwYTyYsEe2Rr6SYZ0wszCRbdKmIbJFvbTXL6F4
         2nF5H51jC0X0s6yJ0Xnq+fYP2Fr984+4PdlvRh9TdUuJzETYiM/ELFp1oQy4/dE/NqlC
         WE3Q==
X-Gm-Message-State: APjAAAWb27tWpQ9DAIqY1X6QZfIPhcQLkk6RlzYg4plKJx8kEdtKXyPH
        z/tipO0v+rcqWff5y0A=
X-Google-Smtp-Source: APXvYqyLF0Am9kma/itAmySVsJHMHwAVJnn63xDkl3seEwvT3LmeANACYzAJRn2E/mhon6dKXAQ/Kw==
X-Received: by 2002:a1c:7718:: with SMTP id t24mr12710869wmi.119.1580117104418;
        Mon, 27 Jan 2020 01:25:04 -0800 (PST)
Received: from localhost (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id y20sm9496896wmj.23.2020.01.27.01.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jan 2020 01:25:03 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>, Jeff King <peff@peff.net>
Subject: [PATCH] doc: clarify "explicitly given" in push.default
Date:   Mon, 27 Jan 2020 10:25:03 +0100
Message-Id: <1113893dd36a1e8cf72331dd01f36206b44f45ad.1580116685.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.24.1.497.g9abd7b20b4.dirty
In-Reply-To: <20200127070238.GA32427@coredump.intra.peff.net>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for push.default mentions that it is used if no
refspec is "explicitly given". Let's clarify that giving a refspec on
the command-line _or_ in the config will override it.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 Documentation/config/push.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

Cc: peff@peff.net

diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index 0a0e000569..d560362c9a 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -1,9 +1,11 @@
 push.default::
 	Defines the action `git push` should take if no refspec is
-	explicitly given.  Different values are well-suited for
-	specific workflows; for instance, in a purely central workflow
-	(i.e. the fetch source is equal to the push destination),
-	`upstream` is probably what you want.  Possible values are:
+	neither explicitly (on the command-line) nor implicitly (via a
+	`remote.*.push` config option) given.  Different values are
+	well-suited for specific workflows; for instance, in a purely
+	central workflow (i.e. the fetch source is equal to the push
+	destination), `upstream` is probably what you want.  Possible
+	values are:
 +
 --
 
-- 
2.24.1.497.g9abd7b20b4.dirty

