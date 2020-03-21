Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D89DC4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 03:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A19206F9
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 03:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="cl1K1xME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgCUDoV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 23:44:21 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:56246 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgCUDoV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 23:44:21 -0400
Received: by mail-pj1-f67.google.com with SMTP id mj6so3358850pjb.5
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 20:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=KrMcN3q3cnoS3AmQt+Iu/lFE5gQxr9GGdvL+xuYpqHI=;
        b=cl1K1xMERr7sGMAKBWMc+Frv5wPODMBGn1AUQ5mrLyxTtrY7l5BsJ7RNGns+cV1mZk
         0+HjLDJI7qnhY+HNge0EeeyhXTByhJwo0t+O3OKFHMfFZrS5evFVwXZNKrGfcS8cgCBW
         lPRyfeNMrAljdPLPgVhNiGShTIyqoJobadlKeyN1E+wsmuX+mavRvQ3MCd19MFwYquOP
         1Zd2ka1ERiQ95EOEi5Dxd60WCTFgB8lrL+o9p38NMcnJ39GRpDuv3KjRVww/RiVxhGx9
         pQmcHvHNX9D88P9afq1xTLQylV+pv9dplf9gElzZR4BHISUCUGRqa52T7K2NYW6eeDc1
         tx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KrMcN3q3cnoS3AmQt+Iu/lFE5gQxr9GGdvL+xuYpqHI=;
        b=rWbNwiFNgYe3plnFKku2k/ErEq9xMroDKUcqEEr/xvWw443EnU4HtIqfZNNUEeJQf3
         bfKKxkHBD/beQ2DAu6pz5I+FiQ2A0vYZ+3h6UBs0kFYeylx6Qz4TkQ6UiWTTotaeR4xF
         lclGz/kZrPnOc8IEuIWQiH50ZTLUOFbL6oeJZsAHflcI43O49DxJ2Pxu3tTeXjZAFVcF
         XKqEAijplBMf2lLevMlow4ZXIbryhdi/DoHxBATc8PSCjPLcf/cFvv9Y3R9r9I9Y8RnZ
         HoMH06tHyC5t+lmR8qAqaGNsuljFteaVwiwuChMfa5Eh2nxUWV/DfGDNtsSH0iwbSq3e
         XGLg==
X-Gm-Message-State: ANhLgQ3A3qd+MBMGrbqs0U/A1pdFSg7cfbXJ4kcS8YEWSvxAKhC5Oaf5
        MY6EiuuZpiv+KxTB1uHEHboOJHVHGwU=
X-Google-Smtp-Source: ADFU+vsXbo5tFQ8IYHY8oQLJntBRFblU9fRJH1miKhFdH2uBKpIy1Y0wRIeqAsX8exk+OEv7GPLu0Q==
X-Received: by 2002:a17:902:22e:: with SMTP id 43mr11077255plc.119.1584762259092;
        Fri, 20 Mar 2020 20:44:19 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id h95sm5989411pjb.46.2020.03.20.20.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 20:44:18 -0700 (PDT)
Date:   Fri, 20 Mar 2020 21:44:16 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 0/1] commit-graph: avoid unnecessary tag deference when
 merging
Message-ID: <cover.1584762087.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here's a patch that Peff and I were kicking around from a couple of
months ago when we were investigating deploying commit-graphs at GitHub.
Particularly, we were looking into why merging two commit-graphs after a
write with '--split' took as much time as we were seeing in our
infrastructure.

This patch avoids an unnecessary tag dereference in
'merge_commit_graph()', which can improve the running time of a
commit-graph write by around ~7.4% on average.

Thanks in advance for your review.

Taylor Blau (1):
  commit-graph.c: avoid unnecessary tag dereference when merging

 commit-graph.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--
2.26.0.rc2.311.g8e52d2684b
