Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB94C1975A
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 18:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4104520724
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 18:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="eMcju8KU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgCQS63 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:58:29 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:38959 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgCQS63 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 14:58:29 -0400
Received: by mail-qk1-f172.google.com with SMTP id t17so12673358qkm.6
        for <git@vger.kernel.org>; Tue, 17 Mar 2020 11:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qkM4K3dKVTjPnzNpOIBaE08BArP3tEsngykgy6NkJCk=;
        b=eMcju8KUoFpFfvAJlycqL0Hg/qkMy3ZXmdQQG17NCKavRfdB7wzxP6NpwuNIDYYdqQ
         C2szlYyGeyBUyFgPEpwyy4/BYN8sLFSWGkl4FEuPtJ7zsHpaaPKt9u9dzvwh8kRnBnC/
         2eA2fgsThElauStmHQzoZ7OoFjuhsovBcs6mEzjYBNniQaKLh14YFEpdyrAWyRdqFg7U
         /5jYXikxIqkLlTyqiWS923uTJt7hoAPTdUYRhGRU0TJWhDVhdBep2hi5JnqhWSIuBnX8
         4U/BDtzlbiDfL3oSjfKyjCQogGfBaNxTJQZgdRIRtO8TZiipFsGZgZzcpMjh3pOhv3tD
         B8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qkM4K3dKVTjPnzNpOIBaE08BArP3tEsngykgy6NkJCk=;
        b=avqhr4SdaRqySaSqr3XNPyg4uiG9JSpQwXzf7MSUAXnXauovkH22h0uXTFSzITfz7j
         ZwDrU5h1Rwa8rWyBKlcP2dITBb30LEndkRckTg9wKCZa42Qh8wNWrgmvibtfi13LEJUO
         lhv+ka5/TqB655cxXX0bIlgSF2JexdRwX6zSUB3dRtm2VH8pismJjzyk7ls83p2qKWOx
         gXy0HmdJi5FI5cmwSrxJrjDRuIw9wNiCc7bZCIUzSCfSFSmKCrwpbyjRoyaundeTZ5g1
         YruRsXkqLM9qcvXUjvtr8DAec2X87gHIikVZ/2zctF5HHUlcNXEBdVYFTsLyELF1iCKf
         kNPQ==
X-Gm-Message-State: ANhLgQ2tISmv/Jnku9ieIjkn4yrd/pzKqPKJTJsCWpif0yLRYB/YB9fr
        psgTXmjNGAM/TqwtQI2b1rsO6oSMsC4=
X-Google-Smtp-Source: ADFU+vtwcQ8tby/MO0lp9R6L8KL47BkkbWP9ropMCbJLaCd8JYRPGP/fTMtsN0NhfeXlKrZZFkglEA==
X-Received: by 2002:ae9:c011:: with SMTP id u17mr372900qkk.92.1584471507279;
        Tue, 17 Mar 2020 11:58:27 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::2])
        by smtp.gmail.com with ESMTPSA id n190sm2414707qkb.93.2020.03.17.11.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 11:58:26 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, dreamer.tan@gmail.com, peff@peff.net
Subject: [PATCH v2 0/3] dir: update outdated field names and comments about oid_stat
Date:   Tue, 17 Mar 2020 15:57:42 -0300
Message-Id: <cover.1584471137.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1584329834.git.matheus.bernardino@usp.br>
References: <cover.1584329834.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 4b33e60 ("dir: convert struct sha1_stat to use object_id",
2018-01-28), we renamed "struct sha1_stat" to "struct oid_stat".
However, there are still some comments and struct field names which
refer to the old sha1_stat. The patches in this series update those
places.

Changes since v1:
- Renamed "ss_info_exclude" and "ss_excludes_file" to
  "info_exclude_validity" and "excludes_file_validity", as suggested
  by Junio.
- Added patch 3, addressing outdated comments' updates on dir.h, as
  suggested by Patryk.

Matheus Tavares (3):
  dir: fix outdated comment on add_patterns()
  dir: improve naming of oid_stat fields in two structs
  dir: update outdated comments about untracked cache

 dir.c                                | 44 ++++++++++++++++------------
 dir.h                                | 15 +++++-----
 t/helper/test-dump-untracked-cache.c |  5 ++--
 3 files changed, 37 insertions(+), 27 deletions(-)

-- 
2.25.1

