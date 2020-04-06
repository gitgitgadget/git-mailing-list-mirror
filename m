Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EB9C2BA17
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 18:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF6F206B8
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 18:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3vtsrd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgDFSMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:12:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39910 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgDFSMd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 14:12:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id k15so7961610pfh.6
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 11:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lg2FU0TfQ5tqzwR6WRCL/X6aoZ5Y3+1hD8rAGGdUu9E=;
        b=X3vtsrd3ybh8yHC3nvZxETjHV2gbu2KbSXdRM9ALMzOmnaA2dqu1S51yqu42l9laHk
         COLql8OxJxNKvTj5lZwkrj3s7t9MMPyoFBu8igIHZpbmBn7rIENlIDibLVTx+MkNAzu6
         uvNgW0/6CDzzNVA6CFhw9yS4tC3jQqkj7OxXl5xrh7++/K3MaLkchBqDf2bEdA84fe+d
         01DYPraB7ALWrTkvajp4CeCdzKiabmpgZ9sjp+C8E6LIFRTGyuwf46hQQXKgv1VBOG9m
         dbyLbnPRqQALoh4O3M6cfIbkxXfoRbZHnqNs3A/F04WDmtJ6EyVk0Rj7kTxQdpJ7DOUF
         Lv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lg2FU0TfQ5tqzwR6WRCL/X6aoZ5Y3+1hD8rAGGdUu9E=;
        b=PlqSWa77oG40XTjN5Nyu1GDBjEHOcRPa/PWn/vROQ3gCKmyYKXzqDxNP1GB8oooyxa
         KCmWy6j0lqLoJfeoSzGqDX7k1WcDamao9idUeLOSgTHTJhsDUyYQ9U1UETwrR9yUfl9k
         pVbUhX2+LFFSBOoxjj4ybIvxBKGqPXYTSjbPXC1l7GLuyTn1jYxwhs9Xn+Sj9ECBiOWh
         JuAPYPSaKrZxGBZmxWuvh30a1TIFh5ka58sQ4+yZUVwdKorNv5DxKNp0CcZDGFK8+1yq
         mEZHSO8jjHHfwtoYJp8/5d2uHplgixydgW+dr66y7C3OGO9jk4DQtgyYOioDaw6+B5ie
         ejUQ==
X-Gm-Message-State: AGi0PuZ8CKVIqjTQ9cDSa13YwsUC/0C14W5e8RKbCoS/3Vd4pJLuULS4
        uRtPvDOAlVbNRBchQvTyIQRIF+VEB7Q=
X-Google-Smtp-Source: APiQypIlrFHK3sWZfsYLQfrcV3skUYh8O7F+2Sd6P/CwX8UKm5LAuA/kmagroizP0QTV0BMLCgexAA==
X-Received: by 2002:aa7:9104:: with SMTP id 4mr735131pfh.168.1586196748925;
        Mon, 06 Apr 2020 11:12:28 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.174])
        by smtp.gmail.com with ESMTPSA id l22sm246543pjq.15.2020.04.06.11.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 11:12:28 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net,
        emilyshaffer@google.com, martin.agren@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH 0/2] Add more issues in gitfaq
Date:   Mon,  6 Apr 2020 23:42:14 +0530
Message-Id: <20200406181216.5340-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have tried adding more issues and their respective solutions in the
gitfaq. Please feel free to point out any mistakes I have made in any
sense here. I have tried to add some basic questions such as difference
between rebasing and merging, changing remote, etc.

I intend to add even more changes in the further patches. Also, one
thing I wanted to ask is whether I should add a sort of guide section to
configuring 'send-email' and a using 'format-patch'. Although there does
exist a man page for the same but I thought that a simpler and all at
one place version could be made.

One suggestion I have is that we should have an INDEX/CONTENTS section
in this guide because the end user may not know whether solution to a
particular problem exists here or not.

Regards,
Shourya Shukla

Shourya Shukla (2):
  gitfaq: cleanup gitfaq.txt
  gitfaq: append the 'Common Issues' section

 Documentation/gitfaq.txt | 182 +++++++++++++++++++++++++++------------
 1 file changed, 127 insertions(+), 55 deletions(-)

-- 
2.20.1

