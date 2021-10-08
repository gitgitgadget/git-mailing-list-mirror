Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73CEC433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 09:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB1B460F6C
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 09:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbhJHJS0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 05:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236957AbhJHJSY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 05:18:24 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DD4C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 02:16:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k23so7121895pji.0
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 02:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77fDDclkZ0uPeVoZdicBnKC29McFXjmXp18oCeIaCb4=;
        b=RVzOzF05OWwoKixNpES7o4PjFSc5w3Vyq4DY5t5oUp7ajFgiFEObrdUuwoUnI8OwwE
         VQ//p5wviSVv1Kwbvpau9C/y6OIcK9h9iSzYXqF8Mg4zry3pDF6JgTP/tak3rMeeNvCn
         T03HSqAHSoEvfThPVLBlzKEuZ1MKsJmVauOCR4VsAk/vUzzrxcTU4Brkjip3O1TjQVpu
         hwEREWSMdbxUn9xCs1ZtLNGHv7HpZCQLj9q/0jjuegCcPx14vqolRO/Ij//N5Spg93cw
         +SHAQnkkmxPVt1hT1J1+V7Lnlu42JTbMTy1+bB6BBRORnAg9G7oi8qcQgfDnANl+jGBW
         5FrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77fDDclkZ0uPeVoZdicBnKC29McFXjmXp18oCeIaCb4=;
        b=xprdcXC2UcENLDPMpK9u01LDJ8hkOxisfnXrTMXHxJl7Y5O00N0h8Bxw/94cKVGH6y
         YamNjWpMphkPrCuLtPXyGo0rmbIjEE3kfEAgGfFYKL8u4RYcsAzpgAPEYDoaPhuUiZ+P
         xS7b+q+jiEoMIzvgtVw1X2kYieJBqYXcnEImce5d2VjySDHNT8R2pxJLhbhv41aF2Pe+
         5/2jju+5tnoqkF71wA9+1paQfFEZkdBQtXigyUGQq0kkMajA+8c+gYOw3fgdFL1Wm7Nf
         Gw2vI565IpLJHTA1K8FSEjXUSxUoEusPgPtXjw0cDJEDmc+iJ+Ms9jhphu/01G6OxLxa
         O8VA==
X-Gm-Message-State: AOAM530BnGt14mFxpGRTrecQ1NqhLt+fh4+blaL8S/u9OZXE81GHcP5M
        7qYaIp/QeB6TR95SJM0aw7XXORzdsEU=
X-Google-Smtp-Source: ABdhPJxUmuyekWY/29eNTMVeu+RImGUXVk1vwgjGksWOyzJuwZblWsnPblW9eaHkuIWJf1O2KBAmVg==
X-Received: by 2002:a17:902:bd8d:b0:13a:8c8:a2b2 with SMTP id q13-20020a170902bd8d00b0013a08c8a2b2mr8346392pls.89.1633684588751;
        Fri, 08 Oct 2021 02:16:28 -0700 (PDT)
Received: from ubuntu.mate (subs28-116-206-12-49.three.co.id. [116.206.12.49])
        by smtp.gmail.com with ESMTPSA id q2sm10495908pjo.27.2021.10.08.02.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 02:16:28 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        "Dr . Matthias St . Pierre" <m.st.pierre@ncp-e.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v5 0/2] blame: documentation update
Date:   Fri,  8 Oct 2021 16:16:12 +0700
Message-Id: <20211008091614.732584-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document the default output format for git-blame(1), as well as the
--color-* options which are currently undocumented but mentioned in
usage help.

Bagas Sanjaya (2):
  blame: describe default output format
  blame: document --color-* options

 Documentation/blame-options.txt | 11 +++++++++++
 Documentation/config/color.txt  | 33 ++++++++++++++++++---------------
 Documentation/git-blame.txt     | 17 +++++++++++++++--
 3 files changed, 44 insertions(+), 17 deletions(-)

(NOTE: This is resend of
https://lore.kernel.org/git/20211008043343.189651-1-bagasdotme@gmail.com/T/#t,
due to forgetting to mark the linked patchset as v5. Sorry for that).

base-commit: 106298f7f9cca4158a980de149ef217751e1f943
-- 
An old man doll... just what I always wanted! - Clara

