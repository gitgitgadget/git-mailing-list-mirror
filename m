Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4405E1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 20:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfBGUF5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 15:05:57 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:53755 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfBGUF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 15:05:57 -0500
Received: by mail-it1-f202.google.com with SMTP id i12so1869455ita.3
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 12:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=ryroGWAgkFkduVdc24JxNvaSgGerzWRIQUwPnGaDTO8=;
        b=scB2UzGDVamcZqy24UC8WEczCKQNo7Ldd+fzTQl81w9L8rc21xGDPYbJyb0WEegD3L
         hntS8yzi1y00kSWUFVZph/cf+2TzNeGAXGI4veY5VhIoqJHcpj9DoXz/2WZCO5M0FnF9
         Fu7QUMWbADFYWDNFJ0m8lnW8eR4ELb1DYKcpBeCYZXlgfEF9FmrgKyMX7AKk21O53/Of
         p/2yufN+cRePR77MrIxR43LqOb7w0jsYayzX5rQrjVvhdAdFzYx3giv8RdGEgKdGkgN/
         FFra11uSDyRIBRkakCOsMHTRW7P+0fcSogH7SfNI7hMxs++jAl7Bm/Ha1GLZXamQzj7p
         pQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=ryroGWAgkFkduVdc24JxNvaSgGerzWRIQUwPnGaDTO8=;
        b=FDl1QEJ/HqiXLtg1wgISf+71qq5qpQ90h0DKmX19A1bEZHi0ZUHYd0x8ifSznHN004
         Nz8ufBRZpOsyEgvJyc+vfGRt3u3xMKL8Ae4gyam0gsH6r4uoZGM7gHvh8Uudjkz1yX7m
         Ay5FxyZfFgyq7nJfSBnwqk5Z6bgmM2+CA/jT869QKRV1vPR0hJGtcF4ucmRzQj5LnFws
         mvWl5VTGMY+yLZNHTebEJkeJWBvBDab4B5d9wju1wXV2IewuzwHSUSDV98Ukvdj40/UV
         ITczaWsuT1dFYIeBUs9K38aA6rQeDntHo5vZEDwc4ZF7T7uSggEP/+mlolpXwM8wUFck
         +EGg==
X-Gm-Message-State: AHQUAuZzXfCY3VqG81XMqbsuZEFbYreGdomiTxGS5KhbRZlyjMOEJY1r
        lbdStF/TAUJx+5pbT+k+UQH/eCAYlpuOfzdgt1yP5qi0y7YOco9SLtUZOt7LnTxMdpwMASpDNL0
        SkXzqeyemBPJJXagu5FH4g3r0KlYCSq5sdV8G6RdTDQlbU9yt5Pr9GxmChuuzou4=
X-Google-Smtp-Source: AHgI3IZAVgNeOoIKqZHLX+BvYtdS11yXVIGn5eR4wjrasCzU0Y0DaW6uFLQMtcI0sCJ3fW9xIW6SGO34rJvEbw==
X-Received: by 2002:a24:ed8c:: with SMTP id r134mr7238881ith.30.1549569956349;
 Thu, 07 Feb 2019 12:05:56 -0800 (PST)
Date:   Thu,  7 Feb 2019 12:05:52 -0800
Message-Id: <cover.1549569479.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
Subject: [PATCH 0/2] Initialize repo object in fuzz-commit-graph
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit-graph.c now depends on the_hash_algo, which means the_repository
must be initialized before attempting to load a commit graph. This
series adds the initialization and cleanup to fuzz-commit-graph, and
fixes a leak it discovered in the cleanup code.

Josh Steadmon (2):
  fuzz-commit-graph: initialize repo objects
  object: fix leak of shallow_stat

 fuzz-commit-graph.c | 3 +++
 object.c            | 2 ++
 2 files changed, 5 insertions(+)

-- 
2.20.1.611.gfbb209baf1-goog

