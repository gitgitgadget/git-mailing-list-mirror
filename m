Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161F1C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 13:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E079020714
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 13:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8Gke12A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgC2NSl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 09:18:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39846 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgC2NSk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 09:18:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id i20so14958216ljn.6
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 06:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dkk72AaJN1x1g48dgrwaiXJjOMS/xI/CCaivs+SXqWM=;
        b=I8Gke12AHgd25QZOHfuFF/3uUUS6dDRFVb7+eVbzpgSxCnE80TolMC/Mz4aUh5DECT
         If7q8+S60kORmkWnD245Ly9cE9loWXtGZdR+URXUTArhElPOZ0IgtQT34zl8vhbPA4eX
         FxnoQd4iXEgXf9vf1Tc4w1pScQs18MEorMajiZ2N9x9UziROSVwlKDVTVSE2httmp7nk
         hFfc/ZkZTuhX5IJoMVunycT1HGiqd4FDfuHAoxsjE3r1POeM1EOrOFFHdU5E12ZJMyZ5
         g1W86ii89dzR8TgASiFOz54GZC5pxvvw0fRX06TNEI05g3LoFmiR+bTzCaWMBGyPFJpK
         JYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dkk72AaJN1x1g48dgrwaiXJjOMS/xI/CCaivs+SXqWM=;
        b=Wh1VyW+v4hYtuvTqhTBIa/umTbir8a/Oct5u4pN2lEyaEP21nE+m3QwEhRY7o1VUDI
         WXJKBxuWfLAfR8Sxhi9ncKgl8dqTdV1LoMOlcTUyf2MTFZlCjLsg/QShfPohqSz+hfuY
         t5HQPUBe8VLJ+wfuLE8/9tWwKfImrgBCYehfaGlfSPaLtqN5XNqWbCFJDSvs/5Pyi135
         NY5EoOacZSKFgbBTE5AbqvBNE7JaU78arrrnK72TBLPRhR+l5FTE6kKprBB21zsLFhB/
         6UcIaULVHRJhnyycSF7MYcG6xIJai9sAzre27BA+SMhOnpx97uc3C4jtpxoaBMTnkU3n
         qhaQ==
X-Gm-Message-State: AGi0PuaCNb0emMJVJ1miIWbsGIbwv81RVTIXocLAYvf9+F6pPs4VXYXZ
        UOzxvBekVEPCx/fgqm7X9Wmu7xiA
X-Google-Smtp-Source: APiQypJiPP0gWQOtPPHqi1eIxymqbjYz+/lTVjLXrMY0soe9S5qWGqAOTIZUbuswlB8WHvCa2udCaA==
X-Received: by 2002:a2e:9789:: with SMTP id y9mr4519442lji.207.1585487918317;
        Sun, 29 Mar 2020 06:18:38 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id d16sm1247742lfm.91.2020.03.29.06.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 06:18:37 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 6/6] INSTALL: drop support for docbook-xsl before 1.74
Date:   Sun, 29 Mar 2020 15:18:10 +0200
Message-Id: <090ef11aec0476395935acf26c4072617ef1e6f2.1585486103.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1585486103.git.martin.agren@gmail.com>
References: <cover.1585486103.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several of the previous commits have been bumping the minimum supported
version of docbook-xsl and dropping various workarounds. Most recently,
we made the minimum be 1.73.0.

In INSTALL, we claim that with 1.73, one needs a certain patch in
contrib/patches/. There is no such patch. It was added in 2ec39edad9
("INSTALL: add warning on docbook-xsl 1.72 and 1.73", 2007-08-03) and
dropped in 9721ac9010 ("contrib: remove continuous/ and patches/",
2013-06-03).

Rather than resurrecting version 1.73 and the patch and testing them,
just raise our minimum supported docbook-xsl version to 1.74.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 INSTALL | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/INSTALL b/INSTALL
index b244949615..9ba33e6a14 100644
--- a/INSTALL
+++ b/INSTALL
@@ -206,9 +206,7 @@ Issues of note:
    clone two separate git-htmldocs and git-manpages repositories next
    to the clone of git itself.
 
-   The minimum supported version of docbook-xsl is 1.73.
-   It has been reported that docbook-xsl version 1.73 is buggy; it needs
-   the patch in contrib/patches/docbook-xsl-manpages-charmap.patch
+   The minimum supported version of docbook-xsl is 1.74.
 
    Users attempting to build the documentation on Cygwin may need to ensure
    that the /etc/xml/catalog file looks something like this:
-- 
2.26.0

