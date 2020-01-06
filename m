Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE68C33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 19:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7532081E
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 19:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pITDJvM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgAFTyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:54:01 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45270 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgAFTyB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 14:54:01 -0500
Received: by mail-qv1-f67.google.com with SMTP id l14so19538735qvu.12
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 11:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dfXAlHUHmL3SkdH/O1LKA79bTY6nRbz+hZRpMvza8TU=;
        b=pITDJvM2mqnN1L7+aiUZxT0YF6pFS3AA3dygO9hwk8j3WZjrv3J3RZ7nh/8VWy0W8f
         P7op6lhaPX0gfCqGPebQBOMe15h1iYoc8VH9Rg1AOz4yY6JaaV371+6Xb1XbN16VuNvj
         t/zwubkks2NVlzxTFUFCdEM0VJ7l68BFhWL39kaN9bX+AMqhhdND7d2Beh+BczgNyu8q
         gN+LJQcNvShHSi3H95A9EED7AdCIoc5mPxHAUKNtJBP8EgFIDngVrhsnirPfUXZoISFF
         d/KVy/dtgCouUvAiVQeEiW8B45rXQ6f0I4OZRf9DVf76OFr4GUNfvAo7wKpCnKBno54A
         fbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dfXAlHUHmL3SkdH/O1LKA79bTY6nRbz+hZRpMvza8TU=;
        b=ng3jX594HocHOcI7nI54YQb5NAfmzBxYN+AIao0QWuKlS+DFvZcayy0IZKD+uZ2dFf
         +6TmGGdyuMxJqZeWoIiH+mgvO0s5mT+8DIz+jOoCb2ovoad4Tv4yPUcttQOfZOPUpaBV
         5wjbnf33rGZSWfo3AwV/Hzm9YF+eMLzQBXpJoq6r3zmZLKrHzpRrd9LAsXh5p9GWQqbH
         aziyGb0HdFfbfSiKXWNEJ5u7qMk7epscFty0ZixWF8ybFtOCAb/Ec7z1o9za2aNJeT3d
         hDSx5bsdejcMY5lIxEw9pfakkLqtfhoyVFGEp6/mogOx8cePjYRp2H9JBcTYjJWTxD8D
         Pb0A==
X-Gm-Message-State: APjAAAVcLlnBrcnwUYLZWfR05U5PE3DX8cGIwV9uHEVe5VKJvIMHQCa6
        bo5xaOz+LUAbIPLfrkS9Y3tKuXlD
X-Google-Smtp-Source: APXvYqyb+cmZb8jOVJpwijGzfhN1TU8j6+edANUvMF/fateOUa8AfOUDW8PvVdRz0IwhctQcSy5g6w==
X-Received: by 2002:a05:6214:8cb:: with SMTP id da11mr68874592qvb.228.1578340439743;
        Mon, 06 Jan 2020 11:53:59 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:edba:a09c:727e:8e59? ([2001:4898:a800:1012:9eee:a09c:727e:8e59])
        by smtp.gmail.com with ESMTPSA id h34sm24095906qtc.62.2020.01.06.11.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 11:53:59 -0800 (PST)
Subject: Re: [PATCH 1/1] commit: make the sign-off trailer configurable
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>, git@vger.kernel.org
References: <20200105174127.9278-1-hji@dyntopia.com>
 <20200105174127.9278-2-hji@dyntopia.com>
 <71a718a7-2be7-391c-dc8f-0626a0a21aac@gmail.com>
 <xmqqtv58a5m2.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cfa40ca5-98a1-fc9c-9ccc-f14b81119e60@gmail.com>
Date:   Mon, 6 Jan 2020 14:53:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <xmqqtv58a5m2.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/6/2020 11:53 AM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> My initial thought was that the sign-off was supposed to be a purposeful
>> decision, but then I also realized that I never do anything in the Git
>> codebase that I _can't_ put online under the GPL. (It may not make it
>> upstream, but it will always be put online somewhere.)
> 
> Hmm...
> 
> Sorry, but I do not quite understand the flow of your logic here,
> especially, how "but then I also realized" trumps "signing off a
> patch is a conscious act---it would weaken the legal meaning if you
> automate it", which was why we deliberately avoided adding this
> configuration variable for the last 10+ years.
> 
> So, I dunno.

I guess I meant that enabling this config for a repo is also a
conscious act, making me think this is not completely unreasonable.

But if we've already discussed and rejected this feature in the past,
then that's sufficient.

Since I started the line of "this isn't a bad idea" I'll follow up with
the historical search. Here are previous attempts from 2018 [1], 2015 [2],
2010 [3].

Thanks,
-Stolee

[1] https://lore.kernel.org/git/20180204020318.4363-1-chenjingpiao@gmail.com/
[2] https://lore.kernel.org/git/1435217454-5718-1-git-send-email-cmarcelo@gmail.com/
[3] https://lore.kernel.org/git/alpine.LNX.2.00.1001131635510.16395@vqena.qenxr.bet.am/
