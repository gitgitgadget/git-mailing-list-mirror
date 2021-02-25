Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9B1C433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 18:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B76364F03
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 18:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhBYSqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 13:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbhBYSp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 13:45:58 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70419C061786
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 10:45:18 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 2so3303279qvd.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 10:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u6lOVmvjkdnW1c91Wqvo6bAoV4Ttt+K86k421Darlrk=;
        b=jkkfQPHPvvKIVRihK9L1qF6F3r8b1are3WA+uKzcdc2zDb4a8dzIc2nxe7kB3zMqD3
         odLC21gzS0sj4JwrL3hhSzUtyHIw+FnsqwIluKKg3lyZvy/hjLMisvAC8SDBj1n7Vfh1
         a3a1SoU7OISMhbjtG9qQ+DAiGFWnfZXk5FUU4RU6YBYk43I20agtas1wYNRlQeblhTdG
         qKX70j1iKY+1SnEDgKtsY1ic0BnlrPxF2ENS/Tk+9BZqF0XXyJHp360jaiwrYuLMMW3c
         7oucdToLNyyp56lCWyj6Ssdl4aZzv+e7un4bsXW2uwOWtb0G83seouyD6aMZxjDhJrT8
         muIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u6lOVmvjkdnW1c91Wqvo6bAoV4Ttt+K86k421Darlrk=;
        b=QOMVXVpp3r2oFSNAjZEyRJTl4A1DUNzZxvhSpZMDJ/NC2dRl4+Uf6pIzm9gboeDOxu
         Ik4WoX+X1WK+YqeGjPMmHCKg06o61V82HSjYOEVA+9dU1GamweH1NgYqDkkVhJ66MOsf
         CeOsCa6K93UMUWSVNW1LDRbu2pGFFfMzisPQUOTuPDxE7r7o11by8hWBaDnep9n3G+/s
         Ctv+xLS+THanqA0XOiGgA++6DhKiXc6r2dYf+d+Tq7Rw6WtW+GRDkCDIJ43rRvBvH2dK
         sEMw2AhujONhdBt/jZivbiudYaKyk1FKhZgXlEwCOeWXmK3TWM3k0ApMVYuZ6p4eSy5k
         RjZw==
X-Gm-Message-State: AOAM530JDFxuZ8Ny8ZxK8lj1midQpsGaZLtPbf4mgEKQWjcGMwOGVqDj
        vaBNsWJP/01JzkefABvHufo=
X-Google-Smtp-Source: ABdhPJwFLgBmRa3gUZmyjZkuRZByOxfNOuo1fd9RhuV2ah2VwTlPgJvg0AWI010oH6f/vU6SwztXYQ==
X-Received: by 2002:a0c:f301:: with SMTP id j1mr4068649qvl.6.1614278717749;
        Thu, 25 Feb 2021 10:45:17 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id s130sm4491495qka.10.2021.02.25.10.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 10:45:17 -0800 (PST)
Subject: Re: [PATCH 0/1] mergetools/vimdiff: add vimdiff1 merge tool variant
To:     Seth House <seth@eseth.com>, git@vger.kernel.org
Cc:     pudinha <rogi@skylittlesystem.org>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20210214022840.849312-1-seth@eseth.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <b3467a47-dffd-154f-76f9-e09b8145a5e5@gmail.com>
Date:   Thu, 25 Feb 2021 13:45:16 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210214022840.849312-1-seth@eseth.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Seth,

Le 2021-02-13 à 21:28, Seth House a écrit :
> Add yet another vimdiff layout variant to present the simplest possible
> two-way diff when resolving conflicts.
> 
> The name is an attempt at UNIX-style humor -- vimdiff3 opens four
> buffers and vimdiff2 opens three buffers so vimdiff1 should therefore
> open two buffers. It also communicates that vimdiff will be used and
> fits cleanly into the existing layout variant naming. That said,
> suggestions welcome if that isn't as great a fit as I think it is. :)

I like the name :P Slightly orthogonal though, when I first looked
at the output of 'git mergetool --tool-help', I was sort of confused by
vimdiff2 and vimdiff3 (and some others) because I looked for them in PATH and (of course)
could not find them, still Git was telling me they were available.

I think it would be good to add a short note about these variants somewhere
in Documentation/git-mergetool.txt. Might be in this patch, or not if you don't
feel like it...

Going further, we could even add a short (few words) description of each tool
and have that description show up in the output of  'git mergetool --tool-help',
something like this:

$ git mergetool --tool-help
'git mergetool --tool=<tool>' may be set to one of the following:
		emerge		Emacs (Emerge)
		opendiff	Apple FileMerge
		vimdiff		Vim (??)
		vimdiff2	Vim (3 panes)
		vimdiff3	Vim (4 panes)

Cheers,

Philippe.
