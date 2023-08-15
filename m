Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB8FC001B0
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 19:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239652AbjHOTaP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 15:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239634AbjHOT3r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 15:29:47 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AAD10FF
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 12:29:46 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso57554855e9.1
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 12:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692127785; x=1692732585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmxd68RbnPTXsJirZu1vvcpnqqlipxZHsm55/aEa0po=;
        b=KVN2L/PW42YSw/3PNiaagtCScAeJX3UD25TKbOu84Vt2ZK8daNuzqqU95dMcJIBx20
         595RUdHl1raPnBa7Qy59elhKYvWKgHqkRjQ8RLrhdpBRODHogQLxZSD6mr639PB7kvcU
         GZIM+wJmMdZiMBYOgEs/A0bE2bmOko1+u74zCLZgeVt6+EwwQHXM39gm7eQGqch3pV1v
         H+Kl70GRbr7E/Ci7dfu8kX7yI+/r6Z9powRgOYGE0Q+S8zVrysupxbScfosV8sRBz9pc
         WOhfzcmzVTy+q4IZrdcP4FVh1A39zzYkeRPrduN5t9HxCxNQKK8h7ONtHoDcNUJnKRKX
         ic5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692127785; x=1692732585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmxd68RbnPTXsJirZu1vvcpnqqlipxZHsm55/aEa0po=;
        b=hyqdnpLDvs/1hMAzBT4fzmWwrHSe6BAijT4UQqjUNzR1cVo5evceW/WB0a/8gwJLjA
         zJC62dttHXb+YK3+4tLM+QgBRcxnEN7K2GBy1gjNKnTI9R+fsexsmJDnGGSS/fzQ3QMF
         W4hKWHZQTN4LKSJUhHC1sryoMIGRlWT98PSuS11lWmhJUDutr0stztMTPTrM5aGezGc6
         P6Mds4bwZewbZOdiHgwktsUTCIhR9Ga8kKUMX+Cyaqw+dFkLmhI1hXzGKYqpZd5tc9Tv
         g82J45K9s3s84N/RT8pNZHDSPBul8m0vFBdTxap56/zGjJAZDzPT/4seJbP5r/wIiWV+
         BizA==
X-Gm-Message-State: AOJu0YwzVrAHGwH7rjfEGvsHNZCFz9lfNYhQ39FvFW5Kzz1On1OLlBuU
        cqTy1syP2wlB/5hOOmLn73s=
X-Google-Smtp-Source: AGHT+IEU/d//W00ytRBNhwNoTTM/0kLbM5paFA9Mo8sdadpJG1PJthV1pnnPRtqMplWL4wCpp7aCQg==
X-Received: by 2002:a05:600c:214d:b0:3fc:193:734e with SMTP id v13-20020a05600c214d00b003fc0193734emr11495951wml.32.1692127784594;
        Tue, 15 Aug 2023 12:29:44 -0700 (PDT)
Received: from [192.168.0.17] (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id t15-20020a7bc3cf000000b003fe601a7d46sm21759965wmj.45.2023.08.15.12.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 12:29:44 -0700 (PDT)
Message-ID: <ce5d20db-2220-45dd-8c39-2a52e0f9f816@gmail.com>
Date:   Tue, 15 Aug 2023 20:29:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: main != master at github.com/git/git
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20230715103758.3862-1-andy.koppe@gmail.com>
 <20230715160730.4046-1-andy.koppe@gmail.com>
 <kl6l351j22dr.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CAHWeT-ZA8f-TGRwDHixAvi5kddVBbuK8LpVGJ9cjYZMsMk5ODw@mail.gmail.com>
 <xmqq7cpwjhr1.fsf@gitster.g> <006574bd-4d53-495e-8cfe-677ede521908@gmail.com>
 <xmqq350kjfk8.fsf@gitster.g>
From:   Andy Koppe <andy.koppe@gmail.com>
In-Reply-To: <xmqq350kjfk8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/08/2023 20:01, Junio C Hamano wrote:
>> See [1], where main currently is at v2.41.0.
>>
>> [1] https://github.com/git/git/tree/main
> 
> Ah, that one.  The CI job is unfortunately attached to that tree and
> updating 'master' and 'main' with the same commit at the same time
> wastes CI cycles, so I had to tentatively stop updating it.
> 
> It used to be that 'main' was set to lag behind 'master' by 24 hours
> or so to prevent the problem---CI notices that the commit updated
> 'main' has been already dealt with 24 hours ago at 'master' and
> refrains from wasting time on it.  But resurrecting it would still
> make folks confused about how 'main' is different from 'master'.
> Perhaps it is a good time to remove stale 'main' and keep only
> 'master' there?

An alternative might be to exclude one of the branches in the workflow 
file, as per [1].

Andy

[1] 
https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#example-excluding-branches
