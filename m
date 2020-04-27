Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB1AC54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 10:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68376206A4
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 10:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUoWveuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgD0K55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726504AbgD0K55 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 06:57:57 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB03C0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 03:57:56 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k12so13833527qtm.4
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 03:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jtVxX0PU+0FHw7CNIZ8erFjV6iPdqCT9SVRL4xf4hOc=;
        b=hUoWveuId11uH9hJp2K9XPOJzF5yoXPBhWNrNrBOzEAUgjt2n5zRgV5jD0Nn+MnWS5
         TKz03gWDM0rZSYlGBP9pWXATqiLF9k+G/V3iyaS1gbn/vv8JNfDEBAut8Y+4VyvQuGQ1
         NDdhuLqIwISAz9xNNY09m7WdEb0H8ffgnjvSLK8QaBih0ia62LUBZo+KbO/AjjpYlbAw
         tPMWgL+625JqleCZPYzv6MUyB0CXjrqcv+hJ93ZvXcagfTulzGVVS2s+iXk3nBBxfdiC
         TRqaRi72zzOA1C7HpVJSsd6n0zfbkE3hXaiMuVIvOX+pgVeqKjRjTS36xW95sJVcJ5RZ
         8m0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jtVxX0PU+0FHw7CNIZ8erFjV6iPdqCT9SVRL4xf4hOc=;
        b=pAKAZsJFHax2FMGipvIRwdVoOk4EAEkI29nJQQEnsFc4nrGSH5gyh1ljIbk/6+kySd
         Lrw9+qSqmxNbqrgoNmBbL0Lb442/8C4z2p/0ORab00yHuVL1v8SmuCGepfX8CefsIfU0
         7k7UAW90Th2c40qvjkyCZY1Q+IoljD51yMchtwsMeh93+mLDtBmJdlJwAF1ugwyB//x5
         q0ws5y/bFlYbTz1IiWNq0FO4qjcgX5LPgGSXj8OOu4qgfDUL/Igz2Qv/LbXoKOKFIx4/
         s1xX6XGnXmIqG7xSQ6icmVu6AFLS8Bgjlc/S/z1+Oj+O+cOMt019+xF9iScDv2vdLP57
         lwKA==
X-Gm-Message-State: AGi0PuaQMKj2MlCq+ViWLd7+kOvOx3s3z0fbJ9j3bdEfSmMWWfkIH1ui
        S9FwdYMb8Tp38b6SD23dPYM=
X-Google-Smtp-Source: APiQypKXMhlJCRLPKJZWRtOK+KiSAaiTYCavdoGF5bNxN+YlOs5rkTWw/hpQkwclXAeRISH4b1JQRg==
X-Received: by 2002:ac8:12c2:: with SMTP id b2mr22116237qtj.7.1587985075900;
        Mon, 27 Apr 2020 03:57:55 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id a194sm10126479qkb.21.2020.04.27.03.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 03:57:55 -0700 (PDT)
Subject: Re: [PATCH 4/4] commit-graph: close descriptors after mmap
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        szeder.dev@gmail.com, dstolee@microsoft.com
References: <cover.1587677671.git.me@ttaylorr.com>
 <e05db264cb50760cab222157b436e82adeaeadc8.1587677671.git.me@ttaylorr.com>
 <xmqq368tg8po.fsf@gitster.c.googlers.com>
 <2232c379-d0ec-0b52-96b4-379438642785@gmail.com>
 <xmqqmu70d547.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7f344c3c-98e1-fc3c-4018-46e64f8010c0@gmail.com>
Date:   Mon, 27 Apr 2020 06:57:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <xmqqmu70d547.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/24/2020 4:02 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>> Date: Fri, 24 Apr 2020 13:11:13 +0000
>> Subject: [PATCH] multi-pack-index: close file descriptor after mmap
>>
>> We recently discovered that the commit-graph was not closing its
>> file descriptor after memory-mapping the file contents. After this
>> mmap() succeeds, there is no need to keep the file descriptor open.
>> In fact, there is signficant reason to close it so we do not run
>> out of descriptors.
> 
> The above is sufficient a justification.  Let's leave the remaining
> two paragraphs under three-dashes.

Works for me! I also thought there were too many first-person pronouns,
but erred on the side of reporting "how did we figure out this was an
issue?" in the message.

-Stolee
