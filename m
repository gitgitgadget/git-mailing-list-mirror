Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE2CC32771
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 20:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF61424655
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 20:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bM4g7nXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgAVUm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 15:42:28 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39479 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgAVUm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 15:42:28 -0500
Received: by mail-pj1-f68.google.com with SMTP id e11so91167pjt.4
        for <git@vger.kernel.org>; Wed, 22 Jan 2020 12:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MLVSpCoTlQ1F1JIt9yM5fshYNSdJrN5U+GeYHsSjPz8=;
        b=bM4g7nXL1r1krgNrzF0l0dcneKT3N3uY5BIEKlviJ43XZdBbNHzIBTvXlRh+c/u2x/
         X6vgfDD3AgafUbF5zgHexvNAP4ZekGv8v5RFsL4OfyYk0LqlHbFQFo3kvMBY4acKs2EV
         chHA20v2AAO8Fm61f9hpuFjKUdLgwbV9mJIOZoHNEiGGkMxOIBlO3V11VikDyEIp49XY
         kW9QrVZtIrnOwKtf7jkj+eMYPOOmZauxWU4/v0p8bPNKCP2qlUQ00j2gygF3IGKtMCg8
         jKOgTZbJBPVINWXo21lqyQ8mZfwy1HblcqZEXKRtceztZmjj8mhfPot5biAhJ5lKzWL2
         jjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MLVSpCoTlQ1F1JIt9yM5fshYNSdJrN5U+GeYHsSjPz8=;
        b=c+czy/hoaGlPOTcsJKTq7fGORxIyMNEhPV2kbM5wYZPUahy8wMLDjfpXy+dQ5s8YiC
         a/BkgEwJosBnTgzehikTFXiaWD/6sANMcx3V0k1xXptjGBApkOqwTnyf1jCh2PTYHn3w
         XddRB+mBlWZyvBI3+qp/PBxKwIuGLcn2kN/ber4Zv0WnIWnCDdGfpJbnZQw9dcOTeOM5
         5YvzwIDWSTavvoO2aNfGmIzbx14seVic8dX3ZxmHxvOCDvmowGPHdvSkwGR/vbi1tfNr
         MmnoJZMviy0erBRwA6XgdOUof3lS0rpmrxBGnZfczu6Z19cAm5xnVD4zk49qhxuIcknH
         MnYg==
X-Gm-Message-State: APjAAAXlbMS32mCC8jlm4vrp2PRHvUL3WtuOFFk7s2Zs51vSto3EdK6p
        Wn0rKSJvLbIUyXybHZqVeTMLMDE9QSAqmg==
X-Google-Smtp-Source: APXvYqyWn+C2yw7GeNdP5qZ0hdukjRqfvrSFd8J5x2PWi34WJMp3m7WaPl1vK4RiPH408dZzEJrhWQ==
X-Received: by 2002:a17:90a:191a:: with SMTP id 26mr310994pjg.111.1579725747391;
        Wed, 22 Jan 2020 12:42:27 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.170])
        by smtp.gmail.com with ESMTPSA id y76sm49583508pfc.87.2020.01.22.12.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 12:42:26 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, gitster@pobox.com,
        sunshine@sunshineco.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [GSoC] Introduction
Date:   Thu, 23 Jan 2020 02:12:12 +0530
Message-Id: <20200122204212.13004-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings everyone!

I am Shourya Shukla, a Computer Science And Engineering student from IIT Roorkee.
I am very keen on contributing to Git via Google Summer of Code 2020 (GSoC 2020).

I have worked on a microproject(I saw it here[1] and thought I'd give it a shot)
and submitted a patch regarding the same[2], which has been accpeted by Junio C Hamano[3][4]
and will be queued shortly. I have become familiar with mailing lists as well now so it isn't
an issue. I want to know in which direction should I proceed now.

Thanks,
Shourya Shukla

[1]: https://git.github.io/SoC-2019-Microprojects/
[2]: https://lore.kernel.org/git/20200116203622.4694-1-shouryashukla.oo@gmail.com/
[3]: https://lore.kernel.org/git/xmqqy2u08obx.fsf@gitster-ct.c.googlers.com/
[4]: https://lore.kernel.org/git/xmqqtv4o8ob0.fsf@gitster-ct.c.googlers.com/
