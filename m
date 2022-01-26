Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBE7C28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 16:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238524AbiAZQJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 11:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbiAZQJR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 11:09:17 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772D4C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 08:09:17 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id b5so54807qtq.11
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 08:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2mU6UJGILgVgBGGzpTEh9RAUc3rG17UfJKqJ/s/tUFo=;
        b=KaVnvlHtY4ccPvLZN/faOcWX+TMpZtYiuMDeqm/9sF2X57ivaNe7a/IlrxkjvwHNK4
         AdlbP2phIctrEj7u9w1gCPaydrmZy5o+ShwcS3crLm46UJT2Kztm4S3pAzasp8hT+rld
         z1ByTh/yvKQRBF03HARjshFllqKkQZQhTCfow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2mU6UJGILgVgBGGzpTEh9RAUc3rG17UfJKqJ/s/tUFo=;
        b=rJSsfY5iAlrWkeBMQgqvBUliPJjQ27q5bXRLfdFcf0IlcsMXWvSSjoGWCYYPiI48n8
         ZHLu6qmZFqiDwc3tBUOEcShg74rYq7929Ws6n1KqJ0Jua0gItMB7Pzb6Yd+jY/ajGZgB
         hs+3e8a0k9WGYg7hVLF3GcswwECZ9+5VZqGAEzDB2BS/a1g7w6ioxyRsxMHo2M/BgQ+k
         zg0pdjVNp95xsa05ovS0HpNlQIgS0JViXWolSb2///Cjhs8E1gd8m+sjEAUYIToSSrNn
         Qp/dsZ71dr8sTQRm5KTIcqVg6h4X93bZ01ZljOF1A37uXUDYbZqZhtOGLxg7rPa1r604
         dcgw==
X-Gm-Message-State: AOAM5339EZTVq9Tt6v0K/DRdjiJM81Kb/3LjvKWIYYxibVRdUPfG+b2h
        qhCG/6W696SWsmYb5WcW3KljGOaemNnhfQ==
X-Google-Smtp-Source: ABdhPJzQ1LmKU2578P7xf3z44ZB7YwOk7HFdWC/cJu00MoL7BLI+n/0In3b7xUbZ3/3sBxGyw5tvZQ==
X-Received: by 2002:a05:622a:646:: with SMTP id a6mr20513628qtb.637.1643213356561;
        Wed, 26 Jan 2022 08:09:16 -0800 (PST)
Received: from [192.168.1.211] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id b20sm10489060qtx.86.2022.01.26.08.09.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jan 2022 08:09:15 -0800 (PST)
From:   John Cai <jcai@gitlab.com>
To:     =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Yuri <yuri@rawbw.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: 'git stash push' isn't atomic when Ctrl-C is pressed
Date:   Wed, 26 Jan 2022 11:09:15 -0500
X-Mailer: MailMate Trial (1.14r5852)
Message-ID: <B6F534FC-FCEE-4A90-9576-233103865B3E@gitlab.com>
In-Reply-To: <220126.86bkzyfw3q.gmgdl@evledraar.gmail.com>
References: <4493bcea-c7dd-da0a-e811-83044b3a1cac@tsoft.com>
 <220126.86bkzyfw3q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 26 Jan 2022, at 8:41, Ævar Arnfjörð Bjarmason wrote:

> On Tue, Jan 25 2022, Yuri wrote:
>
>> Ctrl-C was pressed in the middle. git creates the stash record and
>> didn't update the files.
>>
>>
>> Expected behavior: Ctrl-C should cleanly roll back the operation.
>
> Yes, you're right. It really should be fixed.
>
> It's a known issue with builtin/stash.c being written in C, but really
> only still being a faithful conversion of the code we had in a
> git-stash.sh shellscript until relatively recently.
>
> (No fault of those doing the conversion, that's always the logical first
> step).
>
> So it modifies various refs, reflogs etc., but does so mostly via
> shelling out to other git commands, whereas it really should be moved to
> using the ref transaction API.
>
> Ig you or anyone else is interested in would be a most welcome project
> to work on…

I’d be happy to help with this!
