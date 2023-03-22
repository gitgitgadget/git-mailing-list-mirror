Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C1BC6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 17:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjCVR75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 13:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjCVR7y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 13:59:54 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F3F58C14
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 10:59:53 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o2so12610423plg.4
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1679507992;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRDbnv9eRkjhpbDAx3ZCYOjvQoPhZLNW9SmWYsy8oCU=;
        b=HAj3lgC5ET1jdFiiGuvUdOcRoeC4jEN1bUHoGfvR1jur/BcD0a4n/G27OL7rXHAhUB
         HRzF71Tsn49InRAXVFvK4egiIlt9deyYxevXyGsMAgxhpBOp5ZtP1McCUF6vhl1oOMpJ
         wgl2kUcd/YA8BkINMUFBJ6bWp7706dbxoIGIAbLqC3p13vidy4d9wY15mlBcpbOvh54i
         hnrZQnXqFIQEJQPhO230P44tYm+Rn3mxqYJXRmCjIA6FvrsUrg9/4j0MGE6+1jSH1HcW
         yKltRFi1lYsWOuLwSwfb7FV8/u3szqfFWxJ3UM39kdI11Q4wG5Wz7Rvr/TvxcwcQesTh
         /wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679507992;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LRDbnv9eRkjhpbDAx3ZCYOjvQoPhZLNW9SmWYsy8oCU=;
        b=3bFOTWNnjEiHHjIQ9jN652RAtOI5IrCTj2YzuGjUK2ZYRca0ZvRguuJpTJMpTymMaP
         hz5n6x3RLZQ4Crp7GT82Rj0waj20YrNzDIIclyCQI4QCRfcgo+SIAim/QxoDqgnvnuP9
         +Hk2uXO2S/WxrDPpo0qdOVkM8gcbb4oPEJGfX2x0ZhiYaIgzJBfq9O84TRQgm5MPVGfC
         rJEPzYaTBIl+jY6qqGjfE09VSjQe0xWZIuvxmLtpwDkZ1YRfiwgIk/73rrhVusOino6i
         IrHxSECRUzLn1yoyWKKJ3R1d6leBBvsq11i3CxKrcz+WTWmB2Xnyc0LfJIgu9u5g/H64
         rWJA==
X-Gm-Message-State: AO0yUKWFQG8aPTaeU8CAf9NZKSNYclx7qQKgeGOz9NigUGRuHjZObWnc
        h3J4OjMqPEMfmUHKAcSafhlaZg1d+SJmGhjYM8hAA2Lz4sZxn3BdnRNQMuSJ4tZWQg1LDo71jAc
        QrvleHA5BIasPA8OHe1xNtWgn9JBwChC2fg2llloIqb9v7vnLsYkrSgVzMzqIXPs=
X-Google-Smtp-Source: AK7set+tFvmugX0beCLGaICwVQZmsNnAHifT+5nNqyDyuMFYaINY5dkfR4p4WAMEG0hSIHDLPB+9aw==
X-Received: by 2002:a17:902:e5cf:b0:19d:7a4:4063 with SMTP id u15-20020a170902e5cf00b0019d07a44063mr4111778plf.46.1679507992508;
        Wed, 22 Mar 2023 10:59:52 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id c23-20020a170902849700b001933b4b1a49sm10877396plo.183.2023.03.22.10.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 10:59:52 -0700 (PDT)
Message-ID: <f337e514-8d3b-927a-5fe3-34f67f199435@github.com>
Date:   Wed, 22 Mar 2023 10:59:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Content-Language: en-US
From:   Victoria Dye <vdye@github.com>
Subject: Git 2.41 release date
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone! 

While perusing the Git Calendar [1], I noticed that the final 2.41 release
date is on a major US holiday (Memorial Day, May 29). In the past, release
dates have been shifted to avoid situations like this, and doing so has been
noticeably helpful to downstream maintainers/integrators. Would it make
sense to similarly shift 2.41?

Thanks,
-Victoria 

[1] https://calendar.google.com/calendar/u/0/embed?src=jfgbl2mrlipp4pb6ieih0qr3so@group.calendar.google.com
