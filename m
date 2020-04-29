Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC93C83003
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 09:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 866CB20731
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 09:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRcn29lA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgD2Jim (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726560AbgD2Jim (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 05:38:42 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9C6C03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 02:38:42 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id s20so649335plp.6
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 02:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4sy+SflQaz6sGBUp8bFsSU1rT2xwhz68qdUlPQDZdQQ=;
        b=nRcn29lA/sgnkv7Ct+Z0JEOWtQm9cs+mwSTcRrdIq5pk/omr0/D5H3ZgkZ0FvkY14W
         JN2oz73Pa/aAMeYx99iXn2VEQLf9ao6m/gHQFrqqnYRvCwMPkMTE8pmqHfPnddI+mhUC
         8RiqlezxZAV93wB8Gpil1BQC2gouUxuwdcm6okKQFovyXxoxDZJElHxfmPfmgUODfHK0
         +1P1uJasNC+v+xv+gjEYZ5lOl74dAOgH2onwDS3eoXJRBIDQvckWd5LSVu9+eAYeXyd9
         yteBEY8FZlFY8w2ZQyAwzr5incPeshjZw+0PuSNKNSY8fcr2wYGfGYQ4st7e8iOGgYwp
         il7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4sy+SflQaz6sGBUp8bFsSU1rT2xwhz68qdUlPQDZdQQ=;
        b=fYIoM2Us1OFycQJU/EwnigsHdFQwWUxZFB8MePR2V21N/FtsSULz9Li99BB+465jR4
         bS4nXUaRXdBUrQ9eFFr6Ntts+iUdfIWM6wEelZoFHWvUoDxmR/KZpm9VnH4Tf/dBZR8d
         V6/0RA/zpkcD6MCSbBI3rW2nnzMMngFFz648GhXUTabJGCbTBpujzcGQOjVFSjvomy8f
         msb1+MK386Q23ToSb7ni5+6xZScMR5mxosu+xh7fZ3ggchzqe+kkqO//itmdSw/ZhmLr
         Eo1R77243XDe3vp4YQCPga3POnK+h5vzH8Hzo32Uk4D3iLDR4mmlqC2QFjnU2OdKNjV+
         4rfA==
X-Gm-Message-State: AGi0Pua7P9qbPoxwMu/NEKy5B0A8jkVHvpEszjKw6Ou2josAPneFwkvP
        HvAcDcXTDuq+AxqXpFQv2TJbCP3cwjs=
X-Google-Smtp-Source: APiQypLA9/fI0i5y8vwNB609UZXHpw1gDgwTsslk/Fw/fw7sfUvGThS9zRlcyOb9UO8esjzOoRyGOw==
X-Received: by 2002:a17:90b:1044:: with SMTP id gq4mr2048820pjb.81.1588153120706;
        Wed, 29 Apr 2020 02:38:40 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id o30sm667721pgn.12.2020.04.29.02.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 02:38:39 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, sandals@crustytoothpaste.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v4 3/4] gitfaq: shallow cloning a repository
Date:   Wed, 29 Apr 2020 15:08:10 +0530
Message-Id: <20200429093811.8475-3-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429093811.8475-1-shouryashukla.oo@gmail.com>
References: <20200429093811.8475-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add issue in 'Common issue' section which covers issues with cloning
large repositories. Use partial cloning to selectively clone the
repository.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
I wanted to ask why is there no mention of partial cloning in
the 'git-clone' documentation? Is it because it is an experimental
feature?

 Documentation/gitfaq.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 7d294306f9..6f32846e3d 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -243,6 +243,16 @@ I want to change the remote of my repository. How do I do that?::
 One can list the remotes of a repository using `git remote -v` command.
 The default name of a remote is 'origin'.
 
+[[shallow-cloning]]
+The repository I am trying to clone is too big. Is there an alternative
+way of cloning it in lesser space?::
+	A good way to save up space when cloning a repository is
+	by using `partial clones`. A partial clone will clone the
+	full history of the repository but will skip out the entities
+	specified by the `--filter` option one uses in `git clone`.
+	Any entity which has not been cloned to save space can be cloned
+	on-demand. See linkgit:partial-clone[1].
+
 Hooks
 -----
 
-- 
2.26.2

