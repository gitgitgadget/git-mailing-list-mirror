Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70A7120D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 12:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751154AbdFAMsL (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 08:48:11 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36988 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdFAMsK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 08:48:10 -0400
Received: by mail-wm0-f46.google.com with SMTP id d127so58996130wmf.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 05:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=u0q6pS3oz1x/cM+63L8YcfDP1wXeWXQt7yscpVDWcFA=;
        b=getE4ZcbxDMQS91UnBEO6IwRsPPpkrFlaFRXwJrWJNSIWsZGJWdq5AG0rUnu7u2/mQ
         xN1zj4V6S6DobcjiXZ8QBYCZQgfcg8YyHXrSBOlc0QjvVPjAh9hYA3WtDqtTLN9tQPGG
         MQw2oH5sY0qZYYPpa/9JasnlPyoE7GL40Q0nuyrIKpMyGavxT9K/k0WzeIg47d3b2BM0
         TySNC01Cs9QRjxUaR69Gb6LWtsFbuI6JOJAhbVlqLd9BjEXCvkE1mGjjoecBTj4jGeep
         b7QOFmpWb3wvpG8XW1bX2PIheamJBf1ZyXhRptwl8dCC4CCItxkDfZZnuMT+7xjkszZL
         CJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=u0q6pS3oz1x/cM+63L8YcfDP1wXeWXQt7yscpVDWcFA=;
        b=gxBnBtwIX3k6S3pM1A1+eeouSNVTWrO/7IZxP16UKZeqzjMB0R/Y7eRyHjQEZlz8Ja
         t+/Reo4YYbaujWcp3fTrM+1Hk61LAjmHSsdFg/dS3uTfCjgTLXqFog29BZLQEqkrZRyO
         QS4XNnmK+0g/ExAjVuM6pPTs/oa13XVF70bza0v2jEfRluCqr9o3Q9z6G9AVL4slBUH0
         cpyQYt1bfprtaN8Vd13ejdumHP065CO/2NHWSQ1QXcTwSVm6CmIxdCCTgukDC9V7oKnw
         3VK45+GbirTBtewA2UWJ4ENikJ26yuEqY9WQmuJy8wOn6jt19VRrvTF48Jvx0qHeK6Am
         km7A==
X-Gm-Message-State: AODbwcBMqB/Kot8KCmymBISYyAnQGVKOTeGH5SJWTL+1326b0AAMEnEx
        D2DE8c/yhXQBNmxN0zg=
X-Received: by 10.223.166.13 with SMTP id k13mr1337463wrc.197.1496321288529;
        Thu, 01 Jun 2017 05:48:08 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id w68sm28629389wrb.49.2017.06.01.05.48.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 05:48:07 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: RFC: Would a config fetch.retryCount make sense?
Date:   Thu, 1 Jun 2017 14:48:06 +0200
Message-Id: <6762A30E-C558-4085-943B-AB85EBF18706@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>
To:     Git Mailing List <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

we occasionally see "The remote end hung up unexpectedly" (pkt-line.c:265) 
on our `git fetch` calls (most noticeably in our automations). I expect 
random network glitches to be the cause.

In some places we added a basic retry mechanism and I was wondering
if this could be a useful feature for Git itself.

E.g. a Git config such as "fetch.retryCount" or something.
Or is there something like this in Git already and I missed it?

Thanks,
Lars
