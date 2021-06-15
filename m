Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4363C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 09:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4F3D61443
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 09:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhFOJkn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 05:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhFOJkm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 05:40:42 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEF6C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 02:38:37 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id h1so8177666plt.1
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 02:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EkhRD88c7c9bGFNcGwwSn47o9FW640cAlqK3CM9o8QY=;
        b=SzKCAqfnP5itSyY7YpkCKXr6F66WaQ29Y0anoaGnR/DyRalPSAQgTVwina1HA14jaL
         auTQCYLbxLqGfBp1XP5J1tfbS3gyy9o+SuC1SX0HyFXlsoCCuLIO3qKmaEJQfzN2jrUK
         CBG+aNF3bqYvpWteHBhlGZif/WeRxLzHYxXrXrvAZ2HFLCH+4s99UmaMtpt3XI1lpr1a
         EWbgm9ZOizng5gCR13YtW6IRzz94sILCN0tI+Sp8gGZ1cQiwvzwREzAmqcUjMEMKxBS4
         x9QMQ9BIw9oy3KjtmKFNNL2sClq9PjOybAg7dSBYAGijCw+beZGj+0CJ1TGeakcTwDzO
         Udug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EkhRD88c7c9bGFNcGwwSn47o9FW640cAlqK3CM9o8QY=;
        b=CdY2+Qe9keAjsL2564Si6bqzglGqtrwAfTh+G2N8ngB/t2b3zQlUf6XCTT6iHIxj2j
         mcVjSvCR0d0l4ckDSacIqtQe3KFemLLqh1TClCbZYz2WU0PNHSIcyZ/xRLl0K1aqD8nb
         4ql+6VbFR0PyA/Sf/ETeiDIopdBspMjPeolPDKXLc7SQnRFJjowL0+a5aN6WQlMl42Hz
         ZyLQ3ph1hdWmUD4epG9XdzeBSu7ta2NfshYdSgTp1OluyUgNOjHECRt9q1ve0IZgwIAg
         5Qptf+3iPIizGVgy/+34TCseu/lPXIcTA3MfdwR9IBB+9cqBFpbJJT44skTUYw9xwsDX
         6ptg==
X-Gm-Message-State: AOAM5307sLpX3GdfZPKtgVhBXnHOHTdYaUxdo3twJs1VOQ2drEZ2YDIv
        jmegM0cg+E+MxfSz4QE+a2qeq9a/AkrJSAGJfRA=
X-Google-Smtp-Source: ABdhPJymAyBv5ujkIzBkGiIzXnG9vAzQFFtdHeRl0iQg71BPlUZbaqp0zwbf/Nlqsa/iYeWFS0Kvhw==
X-Received: by 2002:a17:903:1d0:b029:118:307e:a9e1 with SMTP id e16-20020a17090301d0b0290118307ea9e1mr3593721plh.76.1623749916717;
        Tue, 15 Jun 2021 02:38:36 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id p11sm14669854pfo.126.2021.06.15.02.38.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jun 2021 02:38:36 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [GSoC] [PATCH v5 0/3] submodule--helper: introduce subcommands for sh to C conversion
Date:   Tue, 15 Jun 2021 15:08:07 +0530
Message-Id: <20210615093810.27930-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614125157.99426-1-raykar.ath@gmail.com>
References: <20210614125157.99426-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Only two changes since v4:
 - Add missing trailers and s.o.b in [1/3]
 - In [3/3] introduce a wrapper function called 'config_submodule_in_gitmodules'
   that sets the 'submodule.<name>.<var>' configuration, and before doing so,
   checks if it is okay to write to '.gitmodules', which was the original
   behaviour of the shell version.

Atharva Raykar (3):
  submodule--helper: refactor module_clone()
  submodule--helper: introduce add-clone subcommand
  submodule--helper: introduce add-config subcommand

 builtin/submodule--helper.c | 542 ++++++++++++++++++++++++++++--------
 git-submodule.sh            |  66 +----
 2 files changed, 431 insertions(+), 177 deletions(-)

-- 
2.31.1

