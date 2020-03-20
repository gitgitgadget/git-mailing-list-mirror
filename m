Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA45C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 16:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A18620739
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 16:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3ZqrhAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgCTQIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:08:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37564 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgCTQIW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 12:08:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id h72so1252895pfe.4
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 09:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u85v4aCxIJ9hemBDYT4AGUh8d6IzG/xXfhxWrTMM6XA=;
        b=o3ZqrhAECR5PLtmBG0v/zEg1hyupjLKpQXQiDpyop11tIKvp27RcTwSp3iXQQ2pyXU
         PyO0CklHuVntWDgU4Z7VX8XXVDIPj2sd6BgmjQqq6tAkqDJMdLadwDcgSFrWagXFwkTn
         98a81vKZ60zYHiG+ljHb4Gjus2J1K8YQb6euqFOEDHUUPdrj8zQmDcoGL0jnYv8oIux0
         StHNo+eSVe2SeMJNltcH25QNepQ8Q7jnsPXCTZXWjenThKTppRtfpapvRvvOzZAA6OaB
         JGuPIz2MxGKxj4c1X4cYQoCL47+JdL3vkH3pLwAcp5rOGbNveUjc+aR0ZKoakTQzB8xa
         vvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u85v4aCxIJ9hemBDYT4AGUh8d6IzG/xXfhxWrTMM6XA=;
        b=pfemO/0Y3+Qf0S916RUYWvk0bo1QuLegf1T7G0qRVmkhgpSeafvHOz9+srnRMHxXwR
         v+xPB1uRZu11p88fg6B701f8xt5UwLvYqmlt0ePKj/UZkj5mjYloociVQWUvgladGBF1
         wd3YYvofuZ0/NCeV+hLrRbxvpzPwhhz0L86Zd8luo2aIL+I74mnnrUMHzNNtgALIP7YU
         05hUsqzZKb0HqgtjUJg1LC8xxuJQmlt6+mJYAvp5UUcwSvRKTkqmk4qSY8+Ucc/Q/SEC
         x0d9ykIA9BbOv9V3LP27xChCRWZ+HVKX1pH4OxXakEhj/CuhsKV1+XWrQ6almWBFMbIO
         REqQ==
X-Gm-Message-State: ANhLgQ3B2VhGzoO+AXvmeppd4wA28b38ZjalmdYTKjCRzBvyGbTxbVju
        lUQxojZNcRbS72d10ppDBlTiUSO+eunssS+p
X-Google-Smtp-Source: ADFU+vt7097KG332jip49fNFfVjnwofYEGQHL7hMPfNTkwETBQCH99h3NUXauxH9O+PSa1SXb360Sg==
X-Received: by 2002:a62:1a50:: with SMTP id a77mr10718272pfa.289.1584720501226;
        Fri, 20 Mar 2020 09:08:21 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.171])
        by smtp.gmail.com with ESMTPSA id g18sm5919733pfh.174.2020.03.20.09.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 09:08:20 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     gitster@pobox.com
Cc:     chriscool@tuxfamily.org, git@vger.kernel.org, jnareb@gmail.com,
        johannes.schindelin@gmx.de, newren@gmail.com, peff@peff.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: Re: [RFC][Feature]
Date:   Fri, 20 Mar 2020 21:38:13 +0530
Message-Id: <20200320160813.9242-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <xmqqh7ykdo7e.fsf@gitster.c.googlers.com>
References: <xmqqh7ykdo7e.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>    "We want submodule A and B's sub(sub)*modules all the way down
>    to the leaf submodule, but directory C houses many submodules,
>    among which only one can be active, and we want C/X and its
>    sub(sub)*modules all the way down to the leaf but not C/Y nor
>    C/Z or any other C/<anything>."

That's a tough one. Would you advise developing the feature which may
work atleast for the "normal" cases? In case it does not work for the
aforementioned case and the like, we classify it as a BUG for further
correction?

Regards,
Shourya Shukla

