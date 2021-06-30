Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71243C11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 18:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50BA461285
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 18:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhF3Stu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 14:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbhF3Str (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 14:49:47 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FBDC061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 11:47:18 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c3so2525276qkc.3
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 11:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ofm3XVqFcS5n0Atyk1mMNq7rR4bgVrTUysnGIfkGqlw=;
        b=QTXj9l8ce2+DxKljq2OjCE0p8KLKXhTaFZX4Kqp9uMEubD4ImgfitjA1/0jxn1hpYn
         48ft56dy1EkNCqbGP2c9jWDt5NMq2GQfPe9SY9XTUuGluqy62c1re3XSZG8vD00KCluC
         nI/jENCeefaD9no+1hDgemmNEwTlC09XGEHMxUtj1Nk4nQgDlzMacfvsC8v3qLj9AH2H
         3AIYTBBn8aF3mjHVRsikIjXWikRPCr4EoVgnyLR7RNrQHeBu+hIVMrp/qZ9HCdkHNdr8
         UC11cs6zS+ZHaSJcb2WFl9U3qDXp4MoHwh8shUE+XLprpoRGtdA134Fx46+xE9pmuTSc
         qcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ofm3XVqFcS5n0Atyk1mMNq7rR4bgVrTUysnGIfkGqlw=;
        b=RMGj+PqM6BD+ruCGnwvOimtDY+zFqgpGglqjvWELiKqOgz4GEghAKzMi2dgQcSrBK9
         ZNw2yDwrwxM5xN35G78G8tqFh8MoJ/lXXX+PCMutRW8kIanxqZ9qDvv6QupFNuW9rFsM
         deN75BZv8TTvu+DpXl6NsqFiwD5Z7NKuL7CdIzajuoeaf1hryy40aqSpmB9igAIZjifH
         nCTxZ1mzet0nDzFtMFzwT6woUHkBhT1HttwBQXZGWgtGYXK0MLhmHMjShcsrE+fz+vy4
         SbVVHJnuSIu9V7R3MpdAl6GeiP7mf53y28ZyZ3Z1SDdDWM+zYa52AYiv65RoQGuu5uZn
         giwg==
X-Gm-Message-State: AOAM532zY2V2xVMBQzQnQzZmY2mMWlgEktRUHf/COWWJbq322wKpv7X+
        +l8DennGg3D6rNGQkqlzKos=
X-Google-Smtp-Source: ABdhPJzjSVD3eQKXYLpN0/9LXpLgh/mjjgHv2+QLCfptcXFvjFJvaoxK97lPKmamibGBF3jDHZzNeg==
X-Received: by 2002:a05:620a:12da:: with SMTP id e26mr4751904qkl.333.1625078837225;
        Wed, 30 Jun 2021 11:47:17 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id 202sm12434004qki.83.2021.06.30.11.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 11:47:16 -0700 (PDT)
To:     Git mailing list <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Subject: [BUG] 'git bisect start' fails to detect bad revisions without '--'
Message-ID: <0df90d98-3b79-3751-8712-69e1d44a32fd@gmail.com>
Date:   Wed, 30 Jun 2021 14:47:15 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I've found a small bug in the argument parsing of 'git bisect 'start',
i.e builtin/bisect--helper.c::bisect_start.

If one mistypes bad (or good) revisions but does not write the double-dash,
the code does not check that the revisions exist and it goes on and checks out HEAD.
 From what I understand the mistyped revisions are (in some cases) interpreted as paths
(they are written to '.git/BISECT_NAMES), even if they do not match any paths...

For example, these invocations all check out HEAD and do not give any error in git.git:

	git bisect start BAD GOOD
	git bisect start v2.31.0 GOOD
	git bisect start v2.31.0 GOOD ANOTHER

But these correctly error:

	git bisect start BAD GOOD --
	git bisect start v2.31.0 GOOD --
	git bisect start v2.31.0 GOOD ANOTHER --
	git bisect start v2.31.0 v2.30.0 GOOD BAD

This one does not error and correctly checks out the mid point between 2.31 and 2.30,
but does not check that BAD exists (in this case it's not written to BISECT_NAMES):

	git bisect start v2.31.0 v2.30.0 BAD


This is on the latest master, 670b81a890 (The second batch, 2021-06-14). I tried older versions
before the start of the conversion of 'git bisect' from shell to C and they seem to behave the same.

I'm CC-ing Christian and Dscho since I noticed 73c6de06af (bisect: don't use invalid oid
as rev when starting, 2020-09-25) touched the argument parsing in 'bisect start' and is tangentially
related.

Cheers,

Philippe.
