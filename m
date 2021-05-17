Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CBCC433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7409611C2
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241473AbhEQQwb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 12:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240880AbhEQQwY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 12:52:24 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87906C061352
        for <git@vger.kernel.org>; Mon, 17 May 2021 09:45:00 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id k19so5321507qta.2
        for <git@vger.kernel.org>; Mon, 17 May 2021 09:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sQ6TtynHYJOsQ4erznoiounGSpzsia6zGAwKfXsOzYg=;
        b=OM1YsNjxrivY6vksZSYWNJzSp4jKuTVUYPM5zFk+ykMH9eqO+LOseKc/1SqlNUmrc3
         OLqTWMyXeiU0nJ/ecM4ZWPWW52GLc6Te8ej6ExUpEgbzw+jeqFHCYh6OA3+YlNC6Lra4
         Rsl6n3iuXmymEYhddyneYRWqPLgsIhdz/RUT/8HDn1W3/Pr2HzqWpuFfdJ3ezm7vLLML
         2Pw85SFp2q3KK6w0EMl0J8OqsM3e55G0XTNTuVPP0TPUGYTHVs1XJkqKhtSgc2QrHEut
         Y/zFoXJ8lAlUv1Na7jAOUv77o79JGdrk6cl1hIwFfdwG64hF8Sx6AV5WcI6M1iw8MvUI
         oA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sQ6TtynHYJOsQ4erznoiounGSpzsia6zGAwKfXsOzYg=;
        b=uNXLZLXDDVuRs/N9pCWN+t6RPtHuLSP0HgBduiZ4Ikg0t8JNe6oBsVeZvJS1aBHrze
         H0JOifDa4JlhyhMJgah+/iuGORFnAUpLXcUQKBcFSFTNKMVEaoxQkFVpXg2tA73vsZTM
         9962bNpEkqKg7CI5miRYIxYX1SlsHqlTZvLrNfnMV6DCqjj9wPz2FrMxvaaU8A/Iwvx9
         G3rvOecXMgg6+sQfjrVxMjlxWyHJQvppmb1CEy8ZlRlEDCBckmtJ9bPCBVC1bG1IjCY8
         PtSRRehFwhUzXbGQ2HDYBlPsHdD57ppaou3NsQbtvzw4k1CKify8/PuKeiJUG+OwXdMF
         9jWg==
X-Gm-Message-State: AOAM531QBfb4sdAFkx8zHokF6bKaui+Jmp6H/pGMAiTuB6KBG+dTPxyv
        K/Chuy7HCMisfHU1Qf+fA5I=
X-Google-Smtp-Source: ABdhPJx0zSkQ3dEGAi2UrNPyFdR/KlmB5l9LCGbu7lSeGK2e95r4K2qW78X41y10gaosjSjT9FVy8w==
X-Received: by 2002:a05:622a:2cb:: with SMTP id a11mr422089qtx.12.1621269899739;
        Mon, 17 May 2021 09:44:59 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:68e5:b0b1:d7d3:e820? ([2600:1700:e72:80a0:68e5:b0b1:d7d3:e820])
        by smtp.gmail.com with ESMTPSA id r72sm11089999qka.18.2021.05.17.09.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 09:44:59 -0700 (PDT)
Subject: Re: [PATCH v2] describe-doc: clarify default length of abbreviation
To:     =?UTF-8?Q?Anders_H=c3=b6ckersten_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        =?UTF-8?Q?Anders_H=c3=b6ckersten?= <anders@hockersten.se>
References: <pull.1026.git.git.1621150366442.gitgitgadget@gmail.com>
 <pull.1026.v2.git.git.1621230831465.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4d101a5d-3ee7-5601-2de1-4a8afeeaaec4@gmail.com>
Date:   Mon, 17 May 2021 12:44:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <pull.1026.v2.git.git.1621230831465.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/17/2021 1:53 AM, Anders Höckersten via GitGitGadget wrote:
> From: =?UTF-8?q?Anders=20H=C3=B6ckersten?= <anders@hockersten.se>
> 
> Clarify the default length used for the abbreviated form used for
> commits in git describe.
> 
> The behavior was modified in Git 2.11.0, but the documentation was not
> updated to clarify the new behavior.

I'm a bit late to the party, but am interested in our abbreviation
code. I found these updates to be sensible, and that you appropriately
adjusted from v1 according to the feedback.

Thanks,
-Stolee
