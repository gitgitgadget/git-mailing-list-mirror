Return-Path: <SRS0=m/qT=4Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2311C10DCE
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 14:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8758220637
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 14:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXEJ/5UI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCHO5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Mar 2020 10:57:51 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40275 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCHO5v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Mar 2020 10:57:51 -0400
Received: by mail-pj1-f65.google.com with SMTP id gv19so3278974pjb.5
        for <git@vger.kernel.org>; Sun, 08 Mar 2020 07:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mKP2Gk2uqRnUB7TUvaIdTadhCLkDnSzjeen0smG6scY=;
        b=BXEJ/5UI20IFlkJBa6Q3RKlRcOru2p3YB9COrbROGmVBoBt/4QzdrLIILAkF52mHl2
         gVEJvzKzGqw026ZzoDAYw4fjQeWvNfxNwkHbZIQL7an2Q8Ab341wxV5uupoImGdZpdKb
         0CUScqW52/jsT0RzaWVbBqJGuu7X9piV7VPNWSnd4E8mrYxl+Y2eupT6vA1JFjtvc4K+
         vPD2cKa2CXhdtI/YLUgfGh/i0rKr3KjoQj7NQ4DhNHu+ejqWeD+ResX2wLCxtwYfhNSk
         CXvHsY3VbgcufU+HchO8Y56LMpAeCUssbzUxmVS4+pcnHDJR0Nv0lwmTuEARnT5zZ3Bg
         fKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mKP2Gk2uqRnUB7TUvaIdTadhCLkDnSzjeen0smG6scY=;
        b=FU8RnvoBtBKWGIZ/Oj0HCnq32BnEm3CedGJWfO5QVeo538tstCF73adk9a1Et8fNu2
         vrTfk8tlqvhKzStt1B83Lb4KF+4V3GtJJUBOkLCIlSMuBB2l0e7jF0sCTLzKukmrc1LZ
         oao2PLFKIqbYTf2C7ewM21UbMvjHHXvnl08VswQ337Sl3ic5dwv8cX2oXzWdGaSvNSLT
         EAY/08/X3LLbZIdqj7vIZ9iVCy0NcWavJTJ731OuQrClidowra/VTfadHxYUWu5pNiRS
         xbwnpJ61nMGHf/uPJU2fjPeMSyBiYTvT1wScn/qYIwB4V1jmhwQM9KaJhyPxC0suZPxu
         BEHA==
X-Gm-Message-State: ANhLgQ2VKCeU2kGhlnuPMdXLll/eGveDMYLxTOmIJHJUR60YCNpAFiCs
        FAZj8BWNSf/i9b6vHMucMvc=
X-Google-Smtp-Source: ADFU+vvuWE0MkP0hTVkyrVJyWkxLAavDYrfBBg/59hoFHzw8RlD3S+vU5m9aj7+gt8P5Qll8PO9ELA==
X-Received: by 2002:a17:90a:8a0b:: with SMTP id w11mr13721902pjn.114.1583679470316;
        Sun, 08 Mar 2020 07:57:50 -0700 (PDT)
Received: from localhost.localdomain ([117.136.0.219])
        by smtp.gmail.com with ESMTPSA id q7sm27339309pfs.17.2020.03.08.07.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2020 07:57:49 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 0/5] New proc-receive hook for centralized workflow
Date:   Sun,  8 Mar 2020 22:56:26 +0800
Message-Id: <20200308145631.64040-1-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.26.0.rc0.5.gb02b988a14.dirty
In-Reply-To: <CANYiYbE2V3bLfEgH-aRDv4Y5V+_BTZn-oUN7fOVpARm+_14BdQ@mail.gmail.com>
References: <CANYiYbE2V3bLfEgH-aRDv4Y5V+_BTZn-oUN7fOVpARm+_14BdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1:

* Use a better name "proc-receive" for the new hook.
* Rename the new config variable to "receive.procReceiveRefs".

--

Jiang Xin (5):
  receive-pack: add new proc-receive hook
  refs.c: refactor to reuse ref_is_hidden()
  receive-pack: new config receive.procReceiveRefs
  receive-pack: read env from proc-receive output
  hook: add document and example for "proc-receive" hook

 Documentation/config/receive.txt     |  14 +
 Documentation/githooks.txt           |  22 +
 builtin/receive-pack.c               | 160 +++++-
 refs.c                               |  11 +-
 refs.h                               |   1 +
 t/t5411-proc-receive-hook.sh         | 831 +++++++++++++++++++++++++++
 templates/hooks--proc-receive.sample | 119 ++++
 7 files changed, 1141 insertions(+), 17 deletions(-)
 create mode 100755 t/t5411-proc-receive-hook.sh
 create mode 100755 templates/hooks--proc-receive.sample

-- 
2.26.0.rc0.5.gb02b988a14.dirty

