Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B254C2023D
	for <e@80x24.org>; Wed,  1 Mar 2017 13:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbdCAN7Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 08:59:25 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:35989 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbdCAN7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 08:59:24 -0500
Received: by mail-it0-f68.google.com with SMTP id w185so4993568ita.3
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 05:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=Av4qirOSWFaltErHH6acT1X4EeGB4pRt3BFyccdToH8=;
        b=lEqqdKI2UkK97h+mPAIt2diKUMV48hDt26n5nsTYQykwCceNy/WK7iq8jhORAfgXVk
         X5ULA4xWmSppR0DT1lKZCfCMR8y+fmQbuOC9Ijh/mPso6yccu60/dbJhCQcV5PxcBW1V
         fJj/gisqu8GQvDBvTP9XpS4qT+fDk8Rb32/f1nupUqT7Pzk1M7mvXuVOV3KhH0+T9iJE
         5pSPLGZL+loD4Hjy4akIlx2wRW9YD6skfY4VFOuaqNbp/jWFjobSFYbgPHJQPjMAph4m
         ZYI18V8tz5iXzEFLyF1SrDTEIegHZI2RKQlLyE18ORdvctBrA7RVTq6saM9Z3d0AY3Us
         3q1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=Av4qirOSWFaltErHH6acT1X4EeGB4pRt3BFyccdToH8=;
        b=NXODjWC6NdT/poWjgfLv6GQuCGOUn/gPjGn/CK+aUnhOohykDjDH6VGFE64snMB3+r
         m9h0QEl0PG7TwpNotHIZZFMvOIuKYQkOuH0bhcOZOKOdkr5THTRVaKVHi4i8PRO05p4l
         tsA3nPjlnt6JH60xfC3gj2G5fGtcwKKP+XZZMJzIjCOBaznxH9EPe2dcI5J43sW6d8VX
         FTbP0m+8gFAreJEpdmNh2ZpLY2dMM8f0Z8HIn9f6G6NF3DzMn/q1aL/m0AEz+xouZQLe
         kPJzKeNbYrnT/SO95FjFyJAaL29CdMp3eN3QWabkfkWLsaZvStwTe7MuiaM5GJUMhcq3
         vXwQ==
X-Gm-Message-State: AMke39nwRjxV0lrOu8AQDATGcEjhvMrCrcRR38BefBRxWW22H/cc2c7yDB3P1CfUScgR3Q==
X-Received: by 10.36.201.131 with SMTP id h125mr4359059itg.82.1488376276896;
        Wed, 01 Mar 2017 05:51:16 -0800 (PST)
Received: from [10.3.3.214] ([199.227.34.94])
        by smtp.gmail.com with ESMTPSA id r203sm6973546itc.5.2017.03.01.05.51.16
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Mar 2017 05:51:16 -0800 (PST)
From:   Marius Storm-Olsen <mstormo@gmail.com>
Subject: Delta compression not so effective
To:     git@vger.kernel.org
Message-ID: <4d2a1852-8c84-2869-78ad-3c863f6dcaf7@gmail.com>
Date:   Wed, 1 Mar 2017 07:51:18 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have just converted an SVN repo to Git (using SubGit), where I feel 
delta compression has let me down :)

Suffice it to say, this is a "traditional" SVN repo, with an extern/ 
blown out of proportion with many binary check-ins. BUT, even still, I 
would expect Git's delta compression to be quite effective, compared to 
the compression present in SVN. In this case however, the Git repo ends 
up being 46% larger than the SVN DB.

Details - SVN:
     Commits: 32988
     DB (server) size: 139GB
     Branches: 103
     Tags: 1088

Details - Git:
     $ git count-objects -v
       count: 0
       size: 0
       in-pack: 666515
       packs: 1
       size-pack: 211933109
       prune-packable: 0
       garbage: 0
       size-garbage: 0
     $ du -sh .
       203G    .

     $ java -jar ~/sources/bfg/bfg.jar --delete-folders extern 
--no-blob-protection && \
       git reflog expire --expire=now --all && \
       git gc --prune=now --aggressive
     $ git count-objects -v
       count: 0
       size: 0
       in-pack: 495070
       packs: 1
       size-pack: 5765365
       prune-packable: 0
       garbage: 0
       size-garbage: 0
     $ du -sh .
       5.6G    .

When first importing, I disabled gc to avoid any repacking until 
completed. When done importing, there was 209GB of all loose objects 
(~670k files). With the hopes of quick consolidation, I did a
     git -c gc.autoDetach=0 -c gc.reflogExpire=0 \
           -c gc.reflogExpireUnreachable=0 -c gc.rerereresolved=0 \
           -c gc.rerereunresolved=0 -c gc.pruneExpire=now \
           gc --prune
which brought it down to 206GB in a single pack. I then ran
     git repack -a -d -F --window=350 --depth=250
which took it down to 203GB, where I'm at right now.

However, this is still miles away from the 139GB in SVN's DB.

Any ideas what's going on, and why my results are so terrible, compared 
to SVN?

Thanks!

-- 
.marius
