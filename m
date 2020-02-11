Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5216EC352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 17:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FF521739
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 17:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdM4pj6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgBKREL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:04:11 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42899 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbgBKREL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 12:04:11 -0500
Received: by mail-pl1-f195.google.com with SMTP id e8so4492927plt.9
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 09:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DpJcnz70+XK8vFToPCcN1128Mib4stHHnTDhW8OwXLg=;
        b=DdM4pj6KVGsLKwvFlzsGla5aKEBDt2NPRIpIHQUj4RPxZhBJHxVhHAJK9rjonopqVE
         7xC2UWucvtnuAZSszwa00Y67NX9cNeEyRu5yOKFy7BFMMda1e2svHnMkYYtuQyPUcb1Z
         tlICK9r1G8IE6iCll4VxtXIuNUNEbUM8KEMI8v2IfyedIVieTsf6z58SNfnE2ZiOFVbl
         vLnQCup0rVrGfyhFf9y7DlZ8KLrBzgJ8mwzXSH1yGPgBGFTVl2ceVNZN5oXG9LugBb+X
         YhlGMS9EGge1RPFkKGWkva8y0CUXY4ycU9ZGci9ppBcB+SiSgN/umG4eaIjAPeVyLuqw
         q4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DpJcnz70+XK8vFToPCcN1128Mib4stHHnTDhW8OwXLg=;
        b=EvKxJ7EwH9q/7PsWNAAvLHYFkqjJZQAccisNvh+T3ahk9Hc4dfWyNgL4IqzXu1Akjq
         AyKfZtZujE5VtPUDrL2nBPBhqLDoWvUV+81+PlQmiM+hvcq10zXNlnXjA1rPToWsNOx2
         5vmG9bzadOWO/smFJhwmvQVmbEXBrolTrHlOdhrRURd8XVEW0yc6DRGzNgtO4BwwgrS6
         FT2N0xEZM+4c3OVRkfMVlZ7gmB9QiWWaS9MI+70/ZyaAsX7VMMnJ3kkLCjZGqJS3v8fo
         TEvCWIpfld8/O0fqCACGSstxFrDBsBE6Y1asluc9fA9a0QIlKgsc1UoZsSK9krMEYNdB
         jcAQ==
X-Gm-Message-State: APjAAAU8+ia1/MOFv6Wpa6LxQGpv6Sb1N7dtpU3dScFv+9ahUjfvzvv1
        LGk7OUKQ0Vw1zzlgAmPRFM+RlxnVX+cs/A==
X-Google-Smtp-Source: APXvYqwDSwv3l4x1IgM5f5SZNwpFa1+owbv0S1xJeO/His3FtDeTz26Ly+TWaHn9DnKX0SS0abN1kA==
X-Received: by 2002:a17:90b:f06:: with SMTP id br6mr6049775pjb.125.1581440650014;
        Tue, 11 Feb 2020 09:04:10 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.172])
        by smtp.gmail.com with ESMTPSA id g2sm4737462pgn.59.2020.02.11.09.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 09:04:09 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        peff@peff.net, chriscool@tuxfamily.org
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH 0/1] [RFC][GSoC] submodule: enforcing stricter checks
Date:   Tue, 11 Feb 2020 22:33:58 +0530
Message-Id: <20200211170359.31835-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings everyone!

I have tried to improve the checks in some functions of 'submodule.c'
and attempted to make them stricter. Initially, not all conditions were
satisfied by the functions 'update_path_in_gitmodules()' and
'remove_path_from_gitmodules()' while changing(updating/removing paths)
the '.gitmodules' file.

Now, on implementing the 'is_writing_gitmodules_ok()' function in one of the
if cases of the functions, all the conditions are checked before returning a
value unlike before.

Thanks,
Shourya Shukla

Shourya Shukla (1):
  submodule: using 'is_writing_gitmodules_ok()' for a stricter check

 submodule.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- 
2.20.1
