Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1D5B1F437
	for <e@80x24.org>; Tue, 24 Jan 2017 23:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750984AbdAXX5C (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 18:57:02 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36590 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbdAXX5B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 18:57:01 -0500
Received: by mail-pf0-f174.google.com with SMTP id 189so53436680pfu.3
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 15:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hSNU9cUQFA6xrBltPMJITWtL7C8FkopSHMpRuktLsE8=;
        b=oHD8MYc+A2d3RO283ROVr0fy42GxA4GhaYCMEoKoIX90nQBUhrRgRHcT6zWi3wn6k8
         qvhKVaUyHpUcFMwakCy57tEAEYL5fyErDHibMfndIKgU3QYkXTzoeF1eOS4O3Z/r6riL
         /hmDInxMPwXvF9Nj1FPDtVNL2R4xT1FKWaNt41vfqG0+AtDCHbs8XinjKPxfdy7uQo+O
         C81TVz1OdF6/VB75TSOPu1SMah6posr1GGxe+JvZemU6CT+WZYsq9wopZbrRNpFMkq7T
         mb3v+xmUNnQ+U7bfh32EyKNMiEn7vQmyDdxC5GcUWaHQbwM8V7ZIFX39k5GXnmg4WS7Q
         bwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hSNU9cUQFA6xrBltPMJITWtL7C8FkopSHMpRuktLsE8=;
        b=dLDdQFwMI1/16yBdTog/D2HkL8tPUcjcrWLGa9dKeB32NbE79XUn4aPlfas5ejjOSI
         7cI82CNGBuZbrklQBdvpg+bGxejIwEOM4+h/R+VVTssFJzaXBF4N4BNlzqL+P9S9IcfI
         bLZdP7/rp3TPnsJWmoKETRDVWy/u57JFfgdiyf4PsYSkgQFoJ2ZlArIna6ji+xIZpkp2
         H3W/QCKb/54SfG51PJxP5Xhro7MdQBmjMnc5zeV9BbiCoZCv+CODS3SA0C8EIqbICBjF
         u5AA6OKXOhuZaPNh5OF+ra/IcFfi7gHkdwOh9AUPyNZGOA1XVccWnTH7+24j64RF3JCY
         d4uA==
X-Gm-Message-State: AIkVDXJHWW0ujgx6CDipION2qsGih1z+290un2+uw5Ig0M9rz8j16+OU5iTWeX/+ZuZW/7CM
X-Received: by 10.98.32.7 with SMTP id g7mr20856297pfg.119.1485302220313;
        Tue, 24 Jan 2017 15:57:00 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:6936:a216:cb1:3482])
        by smtp.gmail.com with ESMTPSA id a1sm4201169pgc.14.2017.01.24.15.56.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Jan 2017 15:56:59 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, peff@peff.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/3] fix recursive submodule absorbing 
Date:   Tue, 24 Jan 2017 15:56:48 -0800
Message-Id: <20170124235651.18749-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.495.g04f60290a0.dirty
In-Reply-To: <20170124221948.GB58021@google.com>
References: <20170124221948.GB58021@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this second iteration, only absorb_git_dir_into_superproject is touched,
which does the check if connect_work_tree_and_git_dir is needed.

Internally I also had a patch that converts is_submodule_populated
to be gentle, but it is not needed here, so I dropped it before sending out.

Thanks,
Stefan


Stefan Beller (3):
  Add gentle version of resolve_git_dir
  cache.h: expose the dying procedure for reading gitlinks
  submodule absorbing: fix worktree/gitdir pointers recursively for
    non-moves

 cache.h                            |  5 +++-
 setup.c                            | 52 ++++++++++++++++++++------------------
 submodule.c                        | 43 ++++++++++++++++++++++++-------
 t/t7412-submodule-absorbgitdirs.sh | 27 ++++++++++++++++++++
 4 files changed, 93 insertions(+), 34 deletions(-)

-- 
2.11.0.495.g04f60290a0.dirty

