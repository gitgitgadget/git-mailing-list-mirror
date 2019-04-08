Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F95F20248
	for <e@80x24.org>; Mon,  8 Apr 2019 16:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfDHQDe (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 12:03:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43222 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfDHQDe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 12:03:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id c8so7877024pfd.10
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 09:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VQYsCdc9fItHn8NG7n4Jb08doOT8V1wscyujTWDEmas=;
        b=LOP9RPDvskcYmDeNY23LqBEzGjJK5cf0JtpXoNLboSmqzgVmnfSWZ7RDrDY3CCxmxV
         g1uSDsu01mDVlr+8uSeFUWLmhFq3f51iPAUHQfG10amIQeOcO04o6ieIomirZVUx75S/
         uhkzo8rE7SKW8lrlEr8OusuLGXd2UTxXApZToyYOPeu0Y0xkloPcX8dAnqYYG4gySz+G
         GnmwSH4TRI0egjzVvuQYicx/+MgEJugiUKMJXXyDIOocs/UM6vtMYFYhyavcJQjK1tuw
         R6mgqHFPXn0QrsLs/jNUcZAyRX6qCctzDy6r6QuG7qznYfeL7qf3/oVuO8swqXy4HPGR
         c6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VQYsCdc9fItHn8NG7n4Jb08doOT8V1wscyujTWDEmas=;
        b=faJC6Prf0JsOhRn619/EV4pBJaYa7AepUyGUrIaYJAK7sWEy9q//EOj5MKt7jTyb84
         0iAMP8GfM+nqghiCTIi+6PUC346YBa8VolUxscxEKGUvO5o6Xh32wsz4drU+5HEe9rOS
         TWMnBTLlmIJFeRzKKAL3MIDUB49wxydufamAdXgTzsHgzFTMvGZRvs7M1Xu9tyXrBSnx
         REapdXXC1ZPktjqPItCXWD+qMMTufHAadQ/J2WaKhlSRA4Cybiw8zCzeAHLeox1/YCv3
         QI9K696QL/0EMyG6mtuFXKF0kJKvkJIQ3b9pOEUmc/ZXQUa/ya4kGGdbc/YCrRx1+cAQ
         vNXQ==
X-Gm-Message-State: APjAAAX9FWoNMJgBSw+pdsOQEfMvcSETSf5pZ/HkEhACzQsIRtADlrim
        yayCbOiTppL5iv9KIYk0oNfnEQ==
X-Google-Smtp-Source: APXvYqybhRUI0FO5CQP+R/2jGF4+P2y24mdfdGqIewvvP+c8Cemif6Kxxumv7xJ83vZ/APdb2J+3vg==
X-Received: by 2002:a63:e556:: with SMTP id z22mr28449380pgj.290.1554739412822;
        Mon, 08 Apr 2019 09:03:32 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id v7sm41851717pgh.53.2019.04.08.09.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 09:03:31 -0700 (PDT)
Subject: Re: [PATCH v5 6/6] RFC blame: use a fingerprint heuristic to match
 ignored lines
To:     Michael Platings <michael@platin.gs>, David Kastrup <dak@gnu.org>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190407214635.12984-1-michael@platin.gs>
 <8736mtqy9n.fsf@fencepost.gnu.org>
 <CAJDYR9TXL_9JpWvNv9ahK1aYV4isduHhvzvobCJ16q7LWhPRcA@mail.gmail.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <6752a735-2e7b-7d13-799f-a42e6995498c@google.com>
Date:   Mon, 8 Apr 2019 12:03:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAJDYR9TXL_9JpWvNv9ahK1aYV4isduHhvzvobCJ16q7LWhPRcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/8/19 5:48 AM, Michael Platings wrote:
> Hi David,
> You also get an out-of-memory error with the patch Barret posted at
> the start of this thread.

I think I see the issue, and will fix it when I repost the patch set.

Barret
