Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50845C3F2D1
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 16:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B86920828
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 16:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnzVRGtk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbgCCQMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:12:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40061 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgCCQMz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 11:12:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id r17so5078059wrj.7
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 08:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VwKJWNeHOtL6QVhLs7VqgMeEYj6yg2UafvoXkcHjsqs=;
        b=SnzVRGtkSaqCa0eN34pvUh9jeFKaCrWmFqmV2+IeUAH0aOs+obu8liswBHnAiURJRf
         vFwiTHeuH6mHDseYSswlU5YkKFubvaJwlBx4t+UOeDFSoZEkILkKnNNYCMoa4W0NiRhV
         IU8y9b66u3TENuwdxqGO0iUx6scXiY2OhR2SrQSGVQC5HLgnp294DompgmPH4xU1rM/5
         0oAhqmW7jrYCs5YQZMhpSztyHubbBZDbiPa4+f+zE2Z0XooYUaIfL/aGueOuoFPWfhRE
         Wi/tgmhDm3jgd4SyWmu+cEEPSS8ZlePsrnJN4B/JXNrtTe2DKFytKt27faFnqVa/pe6+
         MxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VwKJWNeHOtL6QVhLs7VqgMeEYj6yg2UafvoXkcHjsqs=;
        b=Asz3cjkEvHApdhQXmttv137ksrcmwX1+CIs3sYQrjTLIVcDO/sVI/8xmEbc+jWxA/8
         5UM1otORl2j3Rb+f+ofBX7GcKhRgxcIZl3cTPPuVoqWa3+tRkCNVQJQxVaLTnoGySbFs
         LhwvuN8l+ai8480hkrjJdMYn100KHSboL8d7fdR55tZfzTjCGBdSYuDoBGnQ1hRenvum
         H+c5XOonOBZrJxKkOpRGSctFdboz+v01NFh8abaXRNOBQlU32JsSdbiVNpIwoRowVUgA
         cJMMsPDUClt1pfIu3Eq60Ylydak6OuaYk/8jraGoakS9SXvTHyHd1eEQUa6lBNnER318
         4Ezw==
X-Gm-Message-State: ANhLgQ2q7rwbNlYUaBYBbztQH1DMV51Enkb5Skfo0CSqQpkKJxq+ukER
        tdYkMoWDbPMT1qZjmEfDJVhAMmRIVeI=
X-Google-Smtp-Source: ADFU+vtSdhsjg4TbytYGkqF24Q7BvGr4X1MXsbcu6V1MJ3o++S0j8y0+yjWUu879flZmIMAABQu+lg==
X-Received: by 2002:adf:a312:: with SMTP id c18mr6484862wrb.77.1583251973630;
        Tue, 03 Mar 2020 08:12:53 -0800 (PST)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id l8sm4847472wmj.2.2020.03.03.08.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 08:12:52 -0800 (PST)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Jeff King <peff@peff.net>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v2 0/2]
Date:   Tue,  3 Mar 2020 17:12:21 +0100
Message-Id: <20200303161223.1870298-1-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302133217.GA1176622@coredump.intra.peff.net>
References: <20200302133217.GA1176622@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is the version 2. I incorporated Jeff's preliminary patch, and handled
all push.default cases and added tests for them.

Damien Robert (1):
  remote.c: fix handling of %(push:remoteref)

Jeff King (1):
  remote: drop "explicit" parameter from remote_ref_for_branch()

 ref-filter.c            |   6 +--
 remote.c                | 113 +++++++++++++++++++++++++++++-----------
 remote.h                |   3 +-
 t/t6300-for-each-ref.sh |  29 ++++++++++-
 4 files changed, 115 insertions(+), 36 deletions(-)

-- 
Patched on top of v2.25.1-377-g2d2118b814 (git version 2.25.1)

