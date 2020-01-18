Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25763C33CB1
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 08:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A352468B
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 08:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBKCHa+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgARIdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 03:33:47 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44369 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgARIdq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 03:33:46 -0500
Received: by mail-pg1-f196.google.com with SMTP id x7so12824568pgl.11
        for <git@vger.kernel.org>; Sat, 18 Jan 2020 00:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=onziDk+h96hl/blhgD0K8heroqR1+ZpaI7lil3/ZYFM=;
        b=eBKCHa+WAyY/KwNdMDCIgNmmWiuHY6645Ms32UXLhrnJzWKmml2uKH9OZBJ4uvh0F9
         ltIK90k4YQcBLWh/Dp4fegCLq58gd4uvRdfjWnUZtPnq59JDmU5XFRO4lgdgVDMc9uzG
         t3k8ZhaFcgJjfkJR/pfWS6wrCIS9lr5k95XGxFWh5TWvG2HgV3bA8LQl1qW+q7ZqWPkr
         TDTcdG+9j6QrTkF1e0bMemrNTbECTVN0OF6MBP8Ka1GjhuhHElsDXgOvuwGPp6XdMP4I
         kyJcVYNXHyEgTB05ioIuM5z2l5KTcjmnEEy2L4NWAqlwtRy8Du89LKpR12L1AZhH4HMo
         rRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=onziDk+h96hl/blhgD0K8heroqR1+ZpaI7lil3/ZYFM=;
        b=V7J6WzJEwIvhFCsV2FMnD6ajMSw0/y513lAkeS5piqabh8R7UdlB3pgSpGsOosX3gG
         6yzrVk2y6nhldSPqUWk7sT4U6XAEeZSMQzjNSyCWrra924hPHagKFH5l2H+/GeD1tRds
         iM0/kaQ04H6ZnhaR9m/Ttgadi8cvMRtMWaWKJ3FAaI8m0elSZh/i/cFQQL7CNozGDfzZ
         gKpEz0QMpbpMnpihGQ4AoFLHZjoQTOksbN0Wa8fRNaZDZAhIQUlEMOF+5DhcNFBiCpC6
         FfEwV1Cd1kdS4NPPkvilIOkyMH4aiqaKTabhYiNjOUnSImzVteIiCUSJsO8GaZlv6421
         quqQ==
X-Gm-Message-State: APjAAAUmIvwsFWEYPHqSQUI7Fn1xIUC7QVgmHsaTd1u7KgGAMLvxpJZ2
        B0vU4KK2epqQsxB5N23INxI=
X-Google-Smtp-Source: APXvYqxb2ix/O1EooOIvzoh1ekD2hoKdBRkUva948P7VZ6Qn2c0ryad8K4DI9ZsJBf5PolhcKuCSFA==
X-Received: by 2002:a63:f04c:: with SMTP id s12mr49688712pgj.408.1579336426297;
        Sat, 18 Jan 2020 00:33:46 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.169])
        by smtp.gmail.com with ESMTPSA id c10sm605038pgj.49.2020.01.18.00.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 00:33:45 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        shouryashukla.oo@gmail.com
Subject: [PATCH v3 0/2] t025: amended changes after suggestions from the community
Date:   Sat, 18 Jan 2020 14:03:24 +0530
Message-Id: <20200118083326.9643-5-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200118083326.9643-1-shouryashukla.oo@gmail.com>
References: <CAPig+cQX=jB1KTKcOMVE9u0jX-ZXt_vQBndkzqqQWORu5iFxeA@mail.gmail.com>
 <20200118083326.9643-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings everyone!

After some advise from Eric Sunshine, I have removed the commit to replace pipes
with redirection operators. Also, as Junio Habano and Eric Sunshine pointed out,
I made a small mistake while committing changes in my first commit and it has been
corrected as well.

Thanks,
Shourya Shukla

Shourya Shukla (2):
  t6025: modernize style
  t6025: use helpers to replace test -f <path>

 t/t6025-merge-symlinks.sh | 95 ++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 47 deletions(-)

-- 
2.20.1

