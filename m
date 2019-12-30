Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7BAC2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 14:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC912071E
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 14:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtEND+/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfL3Ov3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 09:51:29 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:35113 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfL3Ov3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 09:51:29 -0500
Received: by mail-qv1-f66.google.com with SMTP id u10so12351754qvi.2
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 06:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rtDCKUL2KTN9c482ZEu8xbcQOkJknyEeY1wiVRgX5cM=;
        b=dtEND+/en2EKKuHIuFUoFDQgmpZNGgsQF9SnJY3KxZcW2A/QT6wBxO3UYA5v4VtE7t
         Y51eRFHGgL199YfTcLhyfmeO3YOMGiGEE92tjOpmMHL4Jsv8OF1sdv7zNroN9v23xP3p
         fdPxeq20IATebV3xV6DAkL4QYbjh/TghIUmV0Y/nJiuXtqQv3/TUhcsU+quDvHXkNPS0
         kXPVT4b79EqnPu/AHy2U7+DJ8cSVeRedSJh9qKWUBv/LXOyPUWomKibJsM4FKBkGzJ2p
         fIZHWc5ZDuyUJonGmMxCRcT1QPuK9uqnbx3r0vYf+y6nQlJXj+4PkFZDWte8kuJHyHuW
         OBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rtDCKUL2KTN9c482ZEu8xbcQOkJknyEeY1wiVRgX5cM=;
        b=do60xJCGqohM37LzRlBW6IV9yHTkRnz8MFhbqfcEFjpt3U1/xLDY/vLzfJieD2ghii
         5uZZsitB+xQnzJH8bI5pXhmluItATx21mvCuBZFZ7vZ7YZJ0xkP24mF1y48oGDGz/uAX
         Bn4J3mJSeGJZdkVH5Gwb5h0a9qpKB+hI8/xcWJmyZiytI7uTtSnAiN+NKlkueWmqhr+8
         nBfzGWZzqvmmwtmps2XslpuNxo2WmFKLNerroZUgwsv8EEgw4Dqqk+yZ1SSY7/zfzhYH
         WkOmKm/ocfFVn8zpul31qcncRh3JjjZZleyUY60KgRqr2LNuzT3Ypaqar0M3tRMR3942
         KJ4w==
X-Gm-Message-State: APjAAAVQcYr4m8kluf8DLYD+o7vL+fPe4Loyr+qcdkVQ62VfOw1V4MbJ
        wNuMDA7lBE9poij844OAWzo=
X-Google-Smtp-Source: APXvYqxtAHa6Rin20ImEPr5mOcef7AhOpqwDwHaLO8SFKgeq1w+QKqxNGeDs6anZl2d4d5XXYlEgBQ==
X-Received: by 2002:ad4:51cc:: with SMTP id p12mr50221749qvq.113.1577717488044;
        Mon, 30 Dec 2019 06:51:28 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:58a9:3b9:96c0:ccb8? ([2001:4898:a800:1010:9df:3b9:96c0:ccb8])
        by smtp.gmail.com with ESMTPSA id b191sm12596504qkg.43.2019.12.30.06.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 06:51:27 -0800 (PST)
Subject: Re: [PATCH 1/3] commit-graph: examine changed-path objects in pack
 order
From:   Derrick Stolee <stolee@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>
References: <20191222093036.GA3449072@coredump.intra.peff.net>
 <20191222093206.GA3460818@coredump.intra.peff.net>
 <8b331ef6-f431-56ef-37a9-1d6e263ea0fe@gmail.com>
 <20191229061246.GB220034@coredump.intra.peff.net>
 <b9bd0c2e-63fc-5658-7a24-b8ab078acd44@gmail.com>
Message-ID: <f0579d4c-b44e-e17f-f395-ae8970765f20@gmail.com>
Date:   Mon, 30 Dec 2019 09:51:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <b9bd0c2e-63fc-5658-7a24-b8ab078acd44@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/30/2019 9:37 AM, Derrick Stolee wrote:
> On the Linux kernel repository, this change reduced the computation
> time for 'git commit-graph write --reachable --changed-paths' from
> 6m30s to 4m50s.

I apologize, these numbers are based on the AzureDevOps repo, not the
Linux kernel repo. After re-running with the Linux kernel repo my
times improve from 3m00s to 1m37s.

-Stolee


