Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B086C433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 19:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244677AbiBTTsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 14:48:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiBTTsB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 14:48:01 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1A5B847
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 11:47:39 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id k41so8385792wms.0
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 11:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Z+x5Y/1SHxNDicPKbgWzM1NaI57FOpLXxdUF1raTBIg=;
        b=RxNtwVrmfoMhaEjDG9xTcmaZc7RXh2Co3Wd06j/w7MScfbwRhqAfH0uTQWxGZ+Lf/Z
         1bgdZzFq0wamng0UWGeCxPK67lAF74d9NikdPjeiWBP93wue5XWU9xf3OJ/EJG/gcpIz
         7e9oZ2aLX4jbSM/rt2cX8zYV3NX/gnSRI4r4Tn0k4D+ISnn8CB98daccKUuvldaaIKer
         t5ZIn40PxczxlOPcxriLIEeANnyWYUcrVpgw2n+ZWgRGQraCtxMcwlboVeTuF6Eh+hGq
         VZnr/ykw8ot6gXOONYj1HCUHT8lZ6DIUXISSrwZUtJgk7OM8te/yfRHBsaxIi0/zb85v
         1hrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z+x5Y/1SHxNDicPKbgWzM1NaI57FOpLXxdUF1raTBIg=;
        b=J61N1m1GxfADd2RV77ksCHXZ55EO/eRUf7EzWWZUJ6rfhowfwXwkno9PcWxOCxkaHm
         j9zZc7gxybBy2W+yNK+d3UmvbL77mG9OBlQLQU2RGg1Gr77+amIVBfB5mwl8ZpdeZWX9
         +2PJ5n2a/jMckdJOh4JEnMLL/uZg+m0cQ608VISwuWbbbuQ2xCJEbw6ZujjHZVsgVGdu
         KPFxRZ0T7sebV9vWrtHuqlchtZIwOGJXNdjGRY2mzFgF26A7AMOMpb+H+yzXRyRBvBHY
         Nn+opaFCWpk/CujQUHqS5dP2rJLOz8VJrACqABFjf1GsYl1zgI1o2tNxp/xLWG1VxZuV
         Igcw==
X-Gm-Message-State: AOAM533H8m9d4EuopGuk9wmiLyLn5m/seOdlJ/nr9avM18y1vZeEaWQm
        zdDQHnvOnaG1+4eaqP+AdsxbmJ5P8aA=
X-Google-Smtp-Source: ABdhPJxd0dQg73pp0IS8RjxBLh7TXeAWdcH6BFARCUGHaAyNGVvNUqjcvC/aoeUmEoTCesmn+2NoBA==
X-Received: by 2002:a05:600c:230d:b0:37d:5882:ec9b with SMTP id 13-20020a05600c230d00b0037d5882ec9bmr18541064wmo.162.1645386458365;
        Sun, 20 Feb 2022 11:47:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b0037c91e085ddsm6349643wmq.40.2022.02.20.11.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 11:47:37 -0800 (PST)
Message-Id: <pull.1219.git.git.1645386457.gitgitgadget@gmail.com>
From:   "Halil Sen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 19:47:34 +0000
Subject: [PATCH 0/2] gitk: include y coord in recorded sash position
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Anders Kaseorg <andersk@mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Halil Sen <halilsen@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This PR fixes the issue reported by Anders Kaseorg in 1
[https://public-inbox.org/git/1f6e179c-d9c3-e503-3218-0acf4ff27cca@mit.edu/].

6cd80496e9 ("gitk: Resize panes correctly when reducing window size",
2020-10-03) introduces a mechanism to record previously-set sash positions
to make sure that correct values are used while computing resize
proportions.

However, if we are not using ttk, then sash represents only the x coordinate
and the recorded sash (oldsash) only includes the x coordinate. When we need
to access the y coordinate via the recorded sash position, we generate the
following Application Error popup:

    Error: expected integer but got ""
    
    expected integer but got ""
    
    expected integer but got ""
    
         while executing
    
    "$win sash place 0 $sash0 [lindex $s0 1]"
    
         (procedure "resizeclistpanes" line 38)
    
         invoked from within
    
    "resizeclistpanes .tf.histframe.pwclist 2818"
    
         (command bound to event)


To fix this, if we are not using ttk, we append the sash positions with the
y coordinates before recording them to match the use_ttk case.

halilsen (2):
  gitk: trivial indentation fix
  gitk: include y coord in recorded sash position

 gitk-git/gitk | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)


base-commit: e6ebfd0e8cbbd10878070c8a356b5ad1b3ca464e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1219%2Fsenhalil%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1219/senhalil/master-v1
Pull-Request: https://github.com/git/git/pull/1219
-- 
gitgitgadget
