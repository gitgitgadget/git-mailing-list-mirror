Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263C2C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 10:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E982F206A4
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 10:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKHmxR6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgD0KzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726504AbgD0KzG (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 06:55:06 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5C8C0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 03:55:06 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m13so25328987otf.6
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 03:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vEPC6OQ6L2c7VbLhl96yHfugpO0cDdxK9+1eji6EbtM=;
        b=TKHmxR6/k5Nzq/h0MfcFtaoiuFH6uuuGcEQodcVgh3nviKN7f4RcmVJevigDiV/qOm
         +8shYj6hldC7n2ZLuV8ALcwO5+4SyRpzvOVfVWEIDJUQe/KcpCgeuxj1cHmmgxUYlt40
         d3E21irTT709Y3iXSB2lCk9BxZSQkNrPNQP2H1uyvF3pu7gBU5FECHyvLdWkfJEUgIFX
         svytO+l6sDIKAZG9oITFPrVU9AZldJZ/vvnsxvxY0Fa7qycI991/m+xdEyEGH7MdNFk6
         0SX0yqMhQcqgcWXs4FmAVx2/UAYh1bDi3A9v/CN7vt8koOlc172HLYBxyH2qMj+p7gfC
         2LmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vEPC6OQ6L2c7VbLhl96yHfugpO0cDdxK9+1eji6EbtM=;
        b=Hfdwpw1VgNqIflEty/pwdqLNS1NKf42K6aAXe3RrVJAJGPOr4vkeb1rJhDwKHbuiay
         /Ji+Dj9W21Ib8XaV1Bgm+fLwpfiyTPVfa5yPQhhdl/Q8fxBT6hylemW3ovRAhci3ijHV
         BEEzK7w20bP5kd6SzhUJ2CSmkIia+QAtivEzfWACyyvYOROwtN56v3zGGmb+TLTlThKX
         WMJYB2IiDnj+jMpZA+UKQ01lO/G37TyqbIdyJvJNnu8UriHDJ5NdWgNMCExRZnVAh/Ud
         fiRHZUnJdrwFwIAPU9N3UFLeyLYecBbBU+cMSv75ViKa+frE53mFygVHEkraM7+4e1Y0
         +DyQ==
X-Gm-Message-State: AGi0PuZnuUTR1Ie+vitvwbcDLwrSYJnfICBI1sr9ynBRbd2nGNcPuaV9
        OnrjwvuCSIvPHcn8zRmPLL0=
X-Google-Smtp-Source: APiQypJ06Ou8Nc+j/GKwTSJ2FXrW1bvourFV7969Sw+Mv1XcmmtA2oNwXUwQfOJmP1h7rNggGSMi/Q==
X-Received: by 2002:a9d:2622:: with SMTP id a31mr18955847otb.231.1587984905555;
        Mon, 27 Apr 2020 03:55:05 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 76sm3923206otg.68.2020.04.27.03.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 03:55:05 -0700 (PDT)
Subject: Re: [PATCH] Teach git-rev-list --simplify-forks
To:     Antonio Russo <antonio.e.russo@gmail.com>,
        git-ml <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Derrick Stolee <dstolee@microsoft.com>
References: <df0b9e59-e6d7-8839-ca3b-86145dc3bdf3@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4ee983f6-402f-85bb-25a8-75b39f07cabb@gmail.com>
Date:   Mon, 27 Apr 2020 06:55:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <df0b9e59-e6d7-8839-ca3b-86145dc3bdf3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/27/2020 1:07 AM, Antonio Russo wrote:
> === Problems
> 
> Travis CI is showing issues with the tests I've added [1].  I cannot
> reproduce them locally, neither with gcc 4.8.5 (RHEL) nor 9.3.0 (Debian).
> They're also only failing on one of the runners.

This is probably because the tests run a second round with GIT_TEST_COMMIT_GRAPH=1, which enables the commit-graph feature. This triggers a different set of logic for the topo-order, which ignores the logic the way you inserted it here.

Thanks,
-Stolee


