Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BAFC636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 20:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjBFUiv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 15:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjBFUip (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 15:38:45 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535AF93C7
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 12:38:38 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ud5so37805500ejc.4
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 12:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EW54qsdYiEeMAGTeqISZvEqZ6kTEWwISWgAmS/FukhM=;
        b=F/+akTf2BZiEwY+YG8zWD/V2MhIoneSYcWfMBGgBBiHBn67LsZagD2EgYNrQcrsBNK
         y7ADziLXJuJEaw+rArVVwRrHiue+VAl7v0+OCTtls5eEDs7Od+DKogZRoJjaF7gl+fDr
         RIvuT2wBpLhj9XIDcAgWhND9cz1JcArMHAM/yQhJ4KHFji1dYWGFgbgzPsLk67yMGU+3
         hUaLFK+Ih8CbjFwUSGlxOzAJH9G8OQVEKuz415rhS50aH1pWcpj4fQicBxOXcemrdjnp
         sop8xL4zg5zn2yQofXpzubrdbsEs2e7srY1LPC1zOOc44+bY8O0VJRc7yAcPCxi49SXD
         Khjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EW54qsdYiEeMAGTeqISZvEqZ6kTEWwISWgAmS/FukhM=;
        b=RWjjQgYlzsKxC8xq1fry2WR+qG6zqjAR8UmgOceba6RyKarJOFU6GiAuHeC2oUTd5P
         wAtWZgkFDxXPFs6E5vtdGfKX4/z01cuuasRck4QEhykLu8e1cI7r5hUSDppaa+yo7Zbn
         W4Mg3+6bniw3qnisT61HrARpx+4o4MCdHyMQRtzZIkEaPhjFchALOXrmJoOesAsmyeqm
         iujM/MK7xDSxdB/674OHZj4xudSU/ZEWXX2ScWo0A5lCHve8BpALuvF2aPsWFgCh4OnR
         d6d6qtu1r5Lj8MWKLDEEaI2iNeiQ67UX+/b1RCRS2d5vbmx0xzGse4EJUXgVOw/1ME2Q
         Hz3w==
X-Gm-Message-State: AO0yUKUpSUqZzdaNpgQb3+piQ+UOY6zo8TWYatovtbtEUCcqf17jQdyU
        Ptgy+u2iLbzoVCLWJW5uk8/CzZuYeOPMsM/y
X-Google-Smtp-Source: AK7set8DK6AQjF+ssEp1xhwULPOxEQFfN+uFkHRAj191y4VIL95ikvjhQcnA3ybYNfL973uLC5hsag==
X-Received: by 2002:a17:906:2581:b0:887:6c23:193f with SMTP id m1-20020a170906258100b008876c23193fmr656814ejb.44.1675715916509;
        Mon, 06 Feb 2023 12:38:36 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id e4-20020a170906080400b008a60ed04e42sm1244836ejd.110.2023.02.06.12.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 12:38:36 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pP8G3-000VcH-19;
        Mon, 06 Feb 2023 21:38:35 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH v8 2/3] http: read HTTP WWW-Authenticate response headers
Date:   Mon, 06 Feb 2023 21:36:41 +0100
References: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com>
 <cd9a02ba94e9eb59b07d0b95140d5b880f122941.1675711789.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <cd9a02ba94e9eb59b07d0b95140d5b880f122941.1675711789.git.gitgitgadget@gmail.com>
Message-ID: <230206.86bkm65y2c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 06 2023, Matthew John Cheetham via GitGitGadget wrote:

> From: Matthew John Cheetham <mjcheetham@outlook.com>

> +static inline int skip_iprefix_mem(const char *buf, size_t len,
> +				   const char *prefix,
> +				   const char **out, size_t *outlen)
> +{
> +	size_t prefix_len = strlen(prefix);

Style nit: We typically use \n\n after the end of decls, so an extra
newline here before the code.

> +	if (len < prefix_len)
> +		return 0;
> +
> +	if (!strncasecmp(buf, prefix, prefix_len)){

Style: ")) {", not ")){".
