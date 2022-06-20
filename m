Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F067BC43334
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 21:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiFTVd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 17:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiFTVdz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 17:33:55 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2094113E91
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 14:33:55 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id e40so4291096eda.2
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 14:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=u9lvFiEy1Xt9VpBm/F69hy59rmpdvyQkXFqw9chckXo=;
        b=D4BdeBpw+bI6ANqQIfjbhhPRTqJKweSn+dkkxVBR3U+k9unHp8rExhzrhu1XYNSZv2
         Fsv5GVzN/AW84X+w4onRycnBQL8FPdkQXJy6UqSvEPvr1osQvoFapnysm/QpY3sufrfn
         Jv2vTApoGhKeEwQKEcLbVLld40h/WCPj96DhH1n1v+2/1TSM+LFCgCkZN1qJF4kF99JS
         NRseqLhbJF3YkJ31/CindCWeqd6squ6wNGBfjti4WUjOGlFKvMukC+YQXYmVLXnU9Okf
         vMAYeeD9e5nrcg1SwCI1WDkLrFgY0BiGZUkX7W/S/ac3NnIwSPniQ9Xi0kx7kNNcufLJ
         8AUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=u9lvFiEy1Xt9VpBm/F69hy59rmpdvyQkXFqw9chckXo=;
        b=WXxc1pzssBa9AOoVGgO5PDQScFqLo54LnUXjCbcqRcYeqIJB+u1k7MZlxRE75RSJVR
         1u3E1sLC5eWIs4KJW1x19YNhiUFoPgcbUQiKZ1ByI4TY6S8+hA6KMTZUgdM75zJ39t49
         VkPFX+HGZ98hY1zUZtrwrmhG+8HN5FlJZIL9k7q4dwfPueQJG+c8Mv6W8bxPqCp7z4x5
         mH/5g2FgW26KVMOcy1+mCZhltB6SlCYpsyg1SO9XkfQN5ELlUZy64Oi6LwwPN8gVqKeT
         dfX/Ur6y/m2cfiTLctdjjf1XiwqnNHrxdPmrrO5+H47CgXy+en9tMTTjklr5NMYJInhQ
         IQpg==
X-Gm-Message-State: AJIora98BZ47OOx5ZK/MyBxkMDKXaXlGl0VvdwPsW8ipXUg62uftNopa
        SrmDhE6SMqogINLtG5uZuX0NS2ptLo0=
X-Google-Smtp-Source: AGRyM1sVg1MscJ+QfW5rVwpd8hjpI+ABDPqVuhBqPysvwrLeeA6kSvPQMCRqwHx1JHLjJNTqAsjGkw==
X-Received: by 2002:a50:ed85:0:b0:435:6586:4b06 with SMTP id h5-20020a50ed85000000b0043565864b06mr21836665edr.315.1655760833633;
        Mon, 20 Jun 2022 14:33:53 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id kz5-20020a17090777c500b006ff0b457cdasm6539980ejc.53.2022.06.20.14.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 14:33:53 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o3P1s-00096y-7O;
        Mon, 20 Jun 2022 23:33:52 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Test Failure t5510,t5562 - was RE: [ANNOUNCE] Git v2.37.0-rc1
Date:   Mon, 20 Jun 2022 23:33:16 +0200
References: <00a401d884d0$32885890$979909b0$@nexbridge.com>
 <8d2a0a36-1d2f-c723-db1e-8978e5d03d1d@github.com>
 <00b501d884d7$d8ed1200$8ac73600$@nexbridge.com>
 <495bd957-43dc-f252-657d-2969bb7ad5f3@github.com>
 <220620.861qvjvzue.gmgdl@evledraar.gmail.com>
 <CAPc5daV29NuOkL1rZvzaqhe5fSrY2os42zsQRhtP6p6AJTp2NA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAPc5daV29NuOkL1rZvzaqhe5fSrY2os42zsQRhtP6p6AJTp2NA@mail.gmail.com>
Message-ID: <220620.86wndbuiin.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 20 2022, Junio C Hamano wrote:

> I was expecting you to use \Q...\E (and passing $remote_url as an
> argument to perl script) actually.  If you let $remote_url
> interpolated by shell into a script of the host language, whether perl
> or sed, you'd be responsible for quoting it appropriately for the host
> language yourself, and use of single-quote pair would not necessarily
> be sufficient, no?

Yes, I wasn't aiming to try to come up with an ideal Perl version, just
wondering why it needed the s/perl/sed/ while-we're-at-it...
