Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7BFC77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 18:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbjDYSPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 14:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjDYSPw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 14:15:52 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ED4B8
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:15:52 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54f9b37c634so73882327b3.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682446551; x=1685038551;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2pu+pifuajEhOLozbtrP/o3uN7kkxKh1wTlJKHQQQI8=;
        b=YmaJoOaNOx6QpvDgPmozVDhLvnlx+Y5pCSoiJXuX0nQHDb56cnA7fZBJfIGT1gLo6A
         wNtBPoWKJKtJ/M/HKOJ9H/XBEDE3vAVoQPaSg2bzDdUpt+/6SlsQ+7HAjSQJBsDDUNfd
         175glaX+EFWjN/QSs9FsYlW5sscHJ9uVi727/6VB3g+CksVfw0R1uc+V1Zh4OwATgggG
         eVfC1YMKsO1AyhA/Z5cD+hXNRh5+g7+B37xnOycfkZhCmNkQ5/sWD9HyktGhWPQhiFCI
         Ng7Jh2ucSye7STzfm/qXrjcML73MYAKabSYm2gCNAPDWVci/B6u3P4OB9ApPgTST5/86
         dlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682446551; x=1685038551;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2pu+pifuajEhOLozbtrP/o3uN7kkxKh1wTlJKHQQQI8=;
        b=A8bTmqTMu1hWW89anyPJTNvBTTLYFhfQc4P2VNBP9m2dTY9bYYOgw98jk3+TKdtSMm
         hdVn0UsGkm3Yw3xjMmmf8zN9rB4Gn+jc3NZYvJ+r18mFdhwS9Sj02eIkxXz84Sv3Ad+3
         VDC9ESP/E5YI7+5PFqRMd0uusA1OahE6tNakJ9GXEUcX05MTty8cF7Fmx5w7W86f0/UI
         QAj+4H21dylXZSB3yXMk8Gdf6M4tLpVWxBXmViLr/asR7YfWxQp/1w9Z29c0pn/MrwaM
         eFRxCJfUBZTQ0tZDVwToc9ejYSD91GV3RlV5O9Tcr2sfM2VtPvyYediDroSnOkXDmL0F
         h1FQ==
X-Gm-Message-State: AAQBX9eK1Amyft3WJg7EkbifQbH3BdHtXGs4g/hnPJlc/k0ZNu1C0LQo
        b1LQyPsDCq76c0QGJ8lYUYjy
X-Google-Smtp-Source: AKy350ZvPrH3zEnjFy257z7z//UDroPdGyD9vYATicemb0WACAI8nxu/TLLSD0yC10ibf+38ew7ohQ==
X-Received: by 2002:a0d:dd0c:0:b0:552:bc4b:bd93 with SMTP id g12-20020a0ddd0c000000b00552bc4bbd93mr10982859ywe.5.1682446551153;
        Tue, 25 Apr 2023 11:15:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9117:8293:39bd:7100? ([2600:1700:e72:80a0:9117:8293:39bd:7100])
        by smtp.gmail.com with ESMTPSA id l67-20020a0dfb46000000b00545a08184c6sm361966ywf.86.2023.04.25.11.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 11:15:50 -0700 (PDT)
Message-ID: <0b8884ea-f37b-b7d4-6edb-825ca935a893@github.com>
Date:   Tue, 25 Apr 2023 14:15:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] revision: support tracking uninteresting commits
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <cover.1682380788.git.me@ttaylorr.com>
 <a643678c0ff7d1a910b1d6c33a839166e2a6a7b2.1682380788.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <a643678c0ff7d1a910b1d6c33a839166e2a6a7b2.1682380788.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/24/2023 8:00 PM, Taylor Blau wrote:
> The boundary-based bitmap walk will want to know which commits were
> marked UNINTERESTING in the walk used to discover the boundary.
> 
> Track which commits are marked as such during list limitation as well as
> the topo walk step, though the latter is not used.

I was surprised to see this as an addition to revision.c, and
only specific to limit_list() (and its iterative copy). I would
expect this to work for non-topo-order, too. I suppose we couldn't
completely trust that the first visit to a commit includes the
UNINTERESTING flag if there is clock skew in the commit history.

But could we also do this at the caller's end by passing a
callback that checks each walked commit if it is UNINTERESTING
and adds it to a set?

I know that the walking code in builtin/pack-objects.c does
this same computation, but it's muddled with other checks and
the trees are marked as UNINTERESTING at the same time. It
doesn't seem like we can reuse anything directly out of there,
but it did give me the idea to try a callback.

Thanks,
-Stolee
