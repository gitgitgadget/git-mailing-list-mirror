Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A627E7E657
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 17:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjIZRSe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 13:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjIZRSd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 13:18:33 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8572ACE
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 10:18:27 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690bf8fdd1aso7290850b3a.2
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 10:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1695748707; x=1696353507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ad7BKjB04KYSBzkNMaoVSzJTkjaKqhoqeVDyavYc5dY=;
        b=MTyUBmot42HIVve1uzNuKODHzVOLfs5E2ZdKisIJmWj8ukabOYqe+pKkFeIwfp2zof
         h5vD09R7iV0SyguHN7OmKJtEWvXGqt8dOgQ7Br1erC33BBDmLAPlbBYTlodyNBOX5v69
         vCU1TIKxxnFQVyZGyzOKrDaVfzGxb67okonSV1PRLb9XaXgvAyWnKb1CkuXM5FRC7Dc5
         lYprcSbThYoj3NWot8ONLMZ8k0TwcRuGC/NTAurubUCRtXeli7Do4bV2JEe0i/4HvjXE
         ZeaypA4Wyz+XE+IWGKt4QPJyv/GEzvEhc/wz+y8aMb31ilXoClQjcK6Oqb7rCkqgBWbD
         YXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695748707; x=1696353507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ad7BKjB04KYSBzkNMaoVSzJTkjaKqhoqeVDyavYc5dY=;
        b=m9Z0Trr7PCh2vogbZSkzkaml6VTJwNF+bLShV/XwBQA1YdNQBFLv2rFsudq0KmmcSL
         HuzgCXaAKmQGM2jgRo3ZaM197bQBvjKk+1WVJDRcjNfYoIWQDWcbssudmx96LZOFAjtp
         2/SGXQQ3fUSu62IlgTAJJo/Oc9eHW37F9daEIcNwO9+v2NaLoMEsjP7CfxJNIEMhJIi6
         m6H39AJloNbooWMc7TjTCo1kCnJ1bhxqFQHY40IuS0ueETY4a7ap/XDbGaYUMGOdUYkY
         cSeZl717NCJaE8nllVgirVp0qW2ufzbNSBJZyF5nKi3W0qvnsT+n9jes56gZC2eAWaOS
         +Saw==
X-Gm-Message-State: AOJu0YwamZv6lngSQSKITYw4rJ4U7XZe9fIkZ7XeRN5JyqtHMvOcmZcp
        LIO9rbZK4aqPbjGRGhnBC5h6
X-Google-Smtp-Source: AGHT+IGYqO8qtqf9H93VDSzN2Umjnri5AHrRMwI3tgyuY6O1a1hsC5kuD5ckzmXHrZIJVwAhpszQiQ==
X-Received: by 2002:a05:6a21:3e07:b0:157:609f:6057 with SMTP id bk7-20020a056a213e0700b00157609f6057mr7771218pzc.27.1695748706849;
        Tue, 26 Sep 2023 10:18:26 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id jw18-20020a170903279200b001adf6b21c77sm11291023plb.107.2023.09.26.10.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 10:18:26 -0700 (PDT)
Message-ID: <1c12ac0a-5e45-bb27-c452-250ffd4b9320@github.com>
Date:   Tue, 26 Sep 2023 10:18:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: Projects for the next Outreachy round
To:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
References: <CAP8UFD1bsez-eMis5yH7Esds+LkhMnj0qTUMFPL1tRuDv2fiPw@mail.gmail.com>
Content-Language: en-US
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CAP8UFD1bsez-eMis5yH7Esds+LkhMnj0qTUMFPL1tRuDv2fiPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder wrote:
> About the "More Sparse Index Integrations" Shuqi worked on, mentored
> by Victoria, I am likely not the best person to mentor it, but I think
> I could manage. It would be nice though if I got an idea about what
> should be done next and how much work is left in general in this area.
> (Shuqi's GSoC final report at
> https://cheskaqiqi.github.io/2023/08/22/Final/ doesn't talk much about
> this.) Perhaps even if Shuqi is continuing to work on the project,
> there is still work that could be done in parallel on other commands
> than the ones he is working on.

To be honest, I'd recommend against using "More Sparse Index Integrations"
as a project again - I was actually going to suggest "retiring" the project
after this past GSoC term. The remaining commands are all fairly complex, to
the point that they'd be challenging even for someone that's done a lot of
sparse index work.

All that said, if someone is *really* interested in this project, you might
be able to get it to work. You'll probably want to limit the scope to one
command and make sure there's a strong emphasis placed on testing. Sparse
index integrations can introduce a lot of subtle bugs (e.g. the one Shuqi
found in 'diff' [1]), and a buggy command is worse for users than lacking
sparse index compatibility.

I hope that helps!
- Victoria

[1] https://lore.kernel.org/git/20230811142211.4547-3-cheskaqiqi@gmail.com/

> 
> Sorry for the late request, but please let me know soon about this.
> 
> Thanks,
> Christian.

