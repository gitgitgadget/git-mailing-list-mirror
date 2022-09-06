Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9859EECAAA1
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 22:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiIFWfk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 18:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiIFWfi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 18:35:38 -0400
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF7E8C021
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 15:35:38 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 287711F54E;
        Tue,  6 Sep 2022 22:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1662503738;
        bh=yWr9jAho/vkSCgCUuMzHVhRn3TlepDQfTvhXEeVj8+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g4QECyB46jq7bJHRI/PTfVb/01eo1BlZry6MlkTPGwK/MKIObHrhDb7Cx4/iD0bh4
         j8+hiQRxAC7D1bUqC9O9S9tRLECeQXFwNlHt9k2qBkyK3phN+RekfEF6nw0EvAKqAt
         y2NIg5VnK7+9V5FLuf0LVGVoqPfSYavT1ojXg1kE=
Date:   Tue, 6 Sep 2022 22:35:37 +0000
From:   Eric Wong <e@80x24.org>
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 06/18] chainlint.pl: validate test scripts in parallel
Message-ID: <20220906223537.M956576@dcvr>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <62fc652eb47a4df83d88a197e376f28dbbab3b52.1661992197.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <62fc652eb47a4df83d88a197e376f28dbbab3b52.1661992197.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com> wrote:
> +unless ($Config{useithreads} && eval {
> +	require threads; threads->import();

Fwiw, the threads(3perl) manpage has this since 2014:

       The use of interpreter-based threads in perl is officially discouraged.

I was bummed, too :<  but I've decided it wasn't worth the
effort to deal with the problems threads could cause down the
line in future Perl versions.  For example, common libraries
like File::Temp will chdir behind-the-scenes which is
thread-unsafe.

(of course I only care about *BSD and Linux on MMU hardware,
so I use SOCK_SEQPACKET and fork() freely :>)
