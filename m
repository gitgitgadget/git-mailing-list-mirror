Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4DFC2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 17:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E7E20720
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 17:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqQPLVWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgA2RNC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 12:13:02 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37213 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgA2RNA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 12:13:00 -0500
Received: by mail-pf1-f194.google.com with SMTP id p14so8736924pfn.4
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 09:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HgEtcSUNpmsV4l4K8JGG1GuKFPuUuMqHE/ZLnrxT44Q=;
        b=sqQPLVWryXycS28q4GbKkC7w0Vt+EEmIt63cLhy4c5OOvoJwxt9ZK/0ap4hH2rKSRt
         3BHqbct1HxTZGT3pkFkIIg2eKa83Lzt0lWplbcIdvVuomceZfTu0yu0/DnMlhJ3byFtI
         ooe11PUqpowHVqR/zFdFU7DPPwJXUL9Y6ZGx69fZ7qsbQeV8EBXQT01VyOxnbD8rdvBe
         fCjAi+bsrkpC8ql2imUhyHsVL861eN5umG6JDAHit/1R1GyigYgedm73xzxKwxt8vOci
         1Gzg44mKBLKysAS2+Tov3LvO4OTVJJDslBTs6kAFe69/ryarFKGqzC4ZQoFkl2oxqsUX
         NXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HgEtcSUNpmsV4l4K8JGG1GuKFPuUuMqHE/ZLnrxT44Q=;
        b=dtq6aFDiTfzeioAmI64NxISNZ6Waq7ZtvPdCfooXR7gAxOC3Ljd9YQQ9iyJmKiVcDp
         FuRszg+VureJ4JW0vtxxWQcxq78Y/BGH/pbr8sXAT9gEVV4ZKhkL7hVlUD635W8aTbCc
         XEDT01sNvu7/JXcI4H2y0PbxOlE6bFWahLv2/6nEG1GC+8wr/F4Zg/wzr7R+q5VeNRlb
         XHM2IQDA66jYZWQlCyfqd4DkQWG093dhYZadKAG9EJ1rJ7HHrWblBPhyJD9f9BcLfMOd
         BLVA5pnUp3eI6YqD22q/7uBCqYwjzTm5VaCXakeGdSSGSHW1Sy3LWAWApXWwmEvTVMmv
         9qlQ==
X-Gm-Message-State: APjAAAXsSwuQ/ceiHa4bmfpYguuP2nRyhezNVx/9WMvLcR9PX531hMFB
        c6XJFMJ4Vk2ZTeONreBe46k=
X-Google-Smtp-Source: APXvYqyfzoBNQd9Oz2BTFPjiwDjCI/t/pMPVIyCDqC5xqs8VRJtRmhUnpykoejdc38SC1Xau5uDHMw==
X-Received: by 2002:a62:b607:: with SMTP id j7mr559040pff.45.1580317980083;
        Wed, 29 Jan 2020 09:13:00 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.172])
        by smtp.gmail.com with ESMTPSA id m12sm3254844pjf.25.2020.01.29.09.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 09:12:59 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     christian.couder@gmail.com, t.gummerer@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [GSoC] Exploring Previous year Projects
Date:   Wed, 29 Jan 2020 22:42:48 +0530
Message-Id: <20200129171248.6217-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I was looking at the previous year projects[1] and a project intrigued me, namely:
"Convert scripts to builtins".

Following from Christian's advice[2], I have decided to focus on my project proposal.
I noticed that various commands such as "git bisect", "git web--browse"(it particularly
interests me) are still in their "shell" form and will be needed to be converted into
their "C" form as per the project description.

I want to contribute in this project for GSoC '20, hence I want to know in which direction
should I proceed.

Thanks,
Shourya Shukla

[1]: https://git.github.io/SoC-2019-Ideas/
[2]: https://lore.kernel.org/git/CAP8UFD2Fo=2suQDLwzLM-Wg3ZzXpqHw-x0brPtPV0d4dRsgs9A@mail.gmail.com/
