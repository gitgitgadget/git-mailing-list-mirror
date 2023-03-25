Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210ECC6FD1C
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 08:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjCYIiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 04:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjCYIhU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 04:37:20 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B1D1816F
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 01:37:03 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso7231137pjb.0
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 01:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679733423;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9lQcnZS35qRxFqfUfh9xxvgmfadICOlH1ps5XVUI90=;
        b=CilBkdP+uHQq8tWT+KFA3nHIslUUgkhRf+nizrB7wBpgRRt5tn2f2P+A121S2qEFi0
         oLDG/p3WsaM7qY3+BKJ9lMlyJPSaY23PXVdeSTksVQUAqLwPlB08HdQ942v3d4Bf32my
         TXbq0D74OkFjuTHKJ+OshdbyCGi/q+1UxnKKzmdUGK45ycoV8hk8jALEs2NpIGZGEqoI
         adNuvJclP5Lrljh4iD9Vi+0DSUz5BDeYA4+rH/6jxLdEAT2Cw35nt4PVPVlxeNIIw1W3
         Yj5c2jJ7aTtQL+d6MiUn3QI413giQDEqK7DEd6++Bb3lQsPS5/+hLiS1PPysvsi6jSA1
         iBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679733423;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w9lQcnZS35qRxFqfUfh9xxvgmfadICOlH1ps5XVUI90=;
        b=NLaOsS5KAmhh8ClBTvpVOW7Qm9Bar+3yck4hBDhYxw5NCcEX+eJ+P8oBERURUeflkx
         iRFKYhV1Ea7G3PwfgHQ00TYWU1EIADkq+Cus2FEaNEH9vIIHrej+pL7ReX4xrpLafW2f
         voIPnjpNwuboFYnPfr90TIynBuz6Y+uIV6Q5e3MoYgTlpycpQc67MmXQhqcxm7vfX/RG
         o36/UPUf7OCraBfhEkFmb1/cR0LhK32pOO6Cwo7g/JNNeDWq1q5vH+UMYwDrHXLlNDQH
         jY6ZA7zT5pFPE6+1CsQYejsFGbDFMkCyanVtG2XJoFLt0jyN+De52d5Yo/jQr8crDCY3
         j9xQ==
X-Gm-Message-State: AO0yUKUJtUX5IHGK/ELc/4oDvDjjx+YQ0gaNUE4nD6EYFOtnlFuud+pn
        FkXnEiIUPIZ/pXt1vd8QwqBYSC+3VtHMGA==
X-Google-Smtp-Source: AK7set8DHp8lddN/oJF26lJXUmi88y0N2y/l4vEgvsfchflykUc7PR34KRsmb1l4TZSHDpGjFweDYA==
X-Received: by 2002:a05:6a20:b227:b0:da:53ea:5ca3 with SMTP id eh39-20020a056a20b22700b000da53ea5ca3mr5292661pzb.57.1679733422718;
        Sat, 25 Mar 2023 01:37:02 -0700 (PDT)
Received: from [192.168.1.113] ([202.83.126.194])
        by smtp.gmail.com with ESMTPSA id i21-20020aa787d5000000b00625f5aaa1d9sm15089114pfo.83.2023.03.25.01.37.01
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 01:37:02 -0700 (PDT)
Message-ID: <20e57ea3-3284-a5c8-09a8-5f2159818d57@gmail.com>
Date:   Sat, 25 Mar 2023 14:36:58 +0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
From:   Khalid Masum <khalid.masum.92@gmail.com>
Subject: [RFC][GSoC Proposal Draft] clone: bundle-uri: make it resumable
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

This is my draft proposal to implement resumable bundle-uri clone.

I would love to hear your thoughts on this.  Also, I think the timeline 
section

could be improved amd I need your input on that.


thanks,

  -- Khalid Masum


======================================================
GSoC23 Draft Proposal: Resumable cloning with git bundle
======================================================

Overview:
=========
Currently, git clones are not resumable. But there is a workaround using
git bundles, where the user can `wget -c` the bundle, then clone from it.
However this comes with drawbacks that `git clone` does not have. For
example, with git clone we can specify branch, or send authentication 
credentials,
which we can not do with `wget` in a simple manner.

However with the new `bundle-uri` we should be able to add this feature.

As suggested by Derrick Stolee <derrickstolee@github.com> here:

https://lore.kernel.org/git/7097d1d6-00a1-2a82-1923-610d41f4053f@github.com/

Where it is suggested that, the randomized temporary download files 
could be
renamed with hashed url, enabling the ability to have resumable clone.

Deliverables:
=============
- Ability to resume a cloning process with bundle-uri.
- Testcases for the newly added feature.
- Update on documentation for the newer changes.

Timeline:
=========
Before April 25:
     - Familiarize myself with git's codebase and architecture.
     - Making small contributions to git.

Before May 25:
     - Research and familiarize with git bundle and git object download
       process.
     - Understanding the core implementation of git bundle.
     - Communicate with mentors for further understanding and finding 
ways of
       implementation.

May 26 - June 20:
     - Starting to implement the git bundle-uri resumable feature.
     - Refactor the codebase for necessary integration.
     - Write some of the test-cases for the created modules.

June 21- July 20:
     - Finish implementing the feature.
     - Necessary test cases are implemented and reviewed.
     - Document the changes.

July 21 - Aug 10:
     - Finishing touches, making sure everything is stable.

Aug 11- 27:
     - Buffer period for any unexpected events.
     - Final report writing.
     - Project submission

Contributions
==============
Microproject:
-------------
Modernized test script: t3501
Link: 
https://lore.kernel.org/git/20220405150657.19801-1-khalid.masum.92@gmail.com/
Status: Accepted

Other contributions:
--------------------
Patch review: 
https://lore.kernel.org/git/pull.1474.git.git.1679233875803.gitgitgadget@gmail.com/

Motivation:
===========
I am captivated by the engineering behind Git and aspire to contribute
regularly to the project, impacting its features. I view GSoC as an
excellent opportunity to jumpstart my contributions and deepen my
understanding of software engineering.

Conclusion:
===========
Implementation of resumable clone is a long wanted feature in git
since 2011. With this contribution I believe we will be able to be
closer to this goal, or at least get a very good workaround on this
feature.

