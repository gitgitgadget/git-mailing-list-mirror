Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FDBC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 21:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 032A82075E
	for <git@archiver.kernel.org>; Wed,  6 May 2020 21:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izbkK4zc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbgEFVsj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 17:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728621AbgEFVsi (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 17:48:38 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C4EC061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 14:48:38 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id s20so1161526plp.6
        for <git@vger.kernel.org>; Wed, 06 May 2020 14:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4TjrDd77VF1uG9bmwcIglMyvhxnlsN3ZUUW8DDiOvLg=;
        b=izbkK4zcmJO/y1JA5LiLSdOzSHBAq4AfL5vHYl+UM3FCQ7oiKrDS54kz+sWNyvEueS
         DXJxqOTRQ5MW93lCF/5wFrnfXrdVHqoQSeFLrsNrxMCZ+bJc1YKEA3dr6ASATgIMv8c2
         VhQf0D6+w34sWhwGCRIGO00V/qntSdrv1ChHcMVK0J8Td/OYlvBQY6/Rea7x0WOQZDnE
         llx/XMIB4mEIxnmM2LjlYozqwMxvRd01NfFY2Os1NLzUCb5yfI2ksi3Tk0r+zlAKl1oG
         u2TkcxbGadhzESeST06cpUzMsZhH3THr46T67VP25F7qduvvF0Jbast9vaJJH053/3gr
         Us6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4TjrDd77VF1uG9bmwcIglMyvhxnlsN3ZUUW8DDiOvLg=;
        b=GmmZ8unLxSYJe7EyxrUXVMxFxiEiLaQMWZFQh+4stBTyEKkRnSp/P/sse5Bvba5VXj
         PW97vrTrETzgIXqREiAAo2l+tvx+iy0RpDbNLORbMWJDFWg9qm4A8qJTiI7V3slA3COD
         G82rOfWtSSOJv6SUgJCdE4XMz6NHx9z4+5nJooDEGS2AfV+bee9rjb9OSpCoHDvtoBtn
         wNQEsuhAwQMCGGWkO9fDf4jYPfhz+botF4qBoyWKTY3EAywFdjxsSx4a+ZUEuBGj5lLT
         wRMa3Cy8w/R0yXCBNmueh0lnraPFIQS3sRF44lJnfpAOLVCz2FjqBj/2ZzfAVw4fVN6I
         f9Jw==
X-Gm-Message-State: AGi0Pub9YuUh6ihnCFE6S2C90l66KQcUBGy19d48HVkMLJCArJi4wiDC
        69HO8R7Itla9dpl0rHAOwiMO0FZi
X-Google-Smtp-Source: APiQypIE+aiXg9M4jefhvFk5J92bQleYKbHWuqz1eiBxIYW+Ee2fqjYdijHvdc3U49sfg9OWJYoOjA==
X-Received: by 2002:a17:902:8a81:: with SMTP id p1mr10346936plo.104.1588801717415;
        Wed, 06 May 2020 14:48:37 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id z7sm2703432pff.47.2020.05.06.14.48.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2020 14:48:36 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 0/4] credential: documentation updates for maint
Date:   Wed,  6 May 2020 14:47:22 -0700
Message-Id: <20200506214726.81854-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.686.gfaf46a9ccd
In-Reply-To: <20200505013908.4596-1-carenas@gmail.com>
References: <20200505013908.4596-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

in line with Jonathan's wishlist[1] for a 2.26.3 release, the
following changes address minimal code changes related to the latest
updates as well to documentation changes that would guide helpers to
adjust to the updated credential subsystem.

patches 1 and 2 are unchanged, patch 3 has all suggestions by Peff
added and hopefully is ready; patch 4 does integrate all suggestions
as well but adds some more changes that I thought were neccesary while
rereading it.

I think this time there are no grammatical issues (and a free online
checker seems to concur), but as a non native English speaker and
ineffective spell checker user, look forward to any suggestions there.

commit message has also been improved based on the feedback received.

not sure how it will look like, but still think that this is the right
time to clarify the issue of encoding, if only so that further changes
could be coordinated more effectively with helper developers (who seem
to be mainly out of tree) so will most likely send an RFC for a 5/4
patch that could be considered for inclusion on a reroll.

[1] https://lore.kernel.org/git/20200428055514.GB201501@google.com/

Carlo Marcelo Arenas Belón (4):
  credential: update description for credential_from_url_gently
  credential: correct order of parameters for credential_match
  credential: update gitcredentials documentation
  credential: document protocol updates

 Documentation/git-credential.txt | 34 ++++++++++++++++++++------------
 Documentation/gitcredentials.txt | 25 +++++++++++++++--------
 credential.h                     |  8 ++++----
 3 files changed, 42 insertions(+), 25 deletions(-)

-- 
2.26.2.686.gfaf46a9ccd

