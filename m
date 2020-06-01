Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF70C433DF
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 19:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 581E1206E2
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 19:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGGgeJgJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgFATfe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgFATfd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 15:35:33 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4AEC061A0E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 12:35:32 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w3so10235799qkb.6
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 12:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pqO/FNbBpXZN+maO3sMSBXvgtX2F/xH7w03yDUd4MFA=;
        b=dGGgeJgJUxostL8LEyzhZoJcV/xRzY/g5pkjbwmVcSJePTYxQ6YJmqLsVoG6EQxPd2
         m3k9i2LJtm2v4WH3q4nJuUjb5os4yKFyjabv49lhYun7/zuwJS7RGlioSAPJRpNcdffa
         2J8CjTpUeCbP3eICXTq6Lk7A8uNjjznzlzSP+JMeNTOrWN3LWjq/fQNcJXURh0hu6Sk8
         0ALb4V5IpMUQ/8HrqE4U4s5F4khMzU7d8uNC8cnTrMpKtcmk5LXKtTLQ2UHh+s6/Gyuo
         yDUlYUgEutkhwwQ3TdFKiWT6cl07VFg5Bw82zl4ogIkxN7NkEFW9ranZg5XLtOGxylnX
         3x9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pqO/FNbBpXZN+maO3sMSBXvgtX2F/xH7w03yDUd4MFA=;
        b=DMsc1tVGpnmo48E5E1ObTWXcoKsFXkj7bwI+IBuC5X2GyLCOm/1B4bvFtIFFN3NUIs
         YiQHzVzeKQM3/l/tlRHifjObIp9Cw9nqgn8hmzR/WCToCvp67gKE9MtzJBxTHvObh0BY
         gv1hDyLXZN2pTmqCCzVPgo3T+6QkUqanM/fxqJsMu+fLhBQA5qC66slblVMPSCF5eF92
         ijTwbunRDFYASbWib8O5GrAzo3DsaQsSWFV9Ln6lH+HVKwNvwdDTZz4IgV1aETCnKH2x
         5g1FreQhfWJxezXED4CNaccfubBAMCoNaANbeKD8RB2y2tEYUWsr7EY9kTPL7hbggcWM
         BwZg==
X-Gm-Message-State: AOAM530ICT9V/VtJuKWpz9+PtVEtmZw1oc4n0gAq63I03zNRAVd31H/d
        GR63bt7Npz/x2ZxpM8odEzU=
X-Google-Smtp-Source: ABdhPJzF4pytw6wnVHTmZklIGrBO784mlQ8iUl2Sb28fuyz8JtV2/SpqnQKGtqnkyTu19QgYzIrSFA==
X-Received: by 2002:ae9:eb83:: with SMTP id b125mr22942491qkg.85.1591040132042;
        Mon, 01 Jun 2020 12:35:32 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id n75sm197518qke.52.2020.06.01.12.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 12:35:31 -0700 (PDT)
Subject: Re: [PATCH 0/2] t5318: test '--stdin-commits' with '--[no-]progress'
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     dstolee@microsoft.com
References: <cover.1591034353.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <153faa41-2801-d6bc-1f48-05a0ac08b446@gmail.com>
Date:   Mon, 1 Jun 2020 15:35:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <cover.1591034353.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/1/2020 2:01 PM, Taylor Blau wrote:
> Here's a short pair of patches that I wrote this morning after looking
> at Stolee's most recent coverage report.
> 
> The first patch is just cleanup, and the second patch is the real
> change. It would have been nice to parameterize these tests over the
> arguments to 'git commit graph' (ie., have three tests for 'write',
> 'verify', and 'write --stdin-commits'), but '--stdin-commits' is special
> since it requires input.
> 
> These patches are based off the tip of 'next', but really only need my
> changes from 'tb/commit-graph-no-check-oids'.

The first patch is an obviously good patch, and it even has a good
justification in the message.

The second is also good. The case of forcing "--progress" would be
enough for covering your new-ish progress meter. Perhaps the other
tests (or at least the one specifying "--no-progress") could be
removed, but I don't feel strongly about that.

Thanks,
-Stolee
