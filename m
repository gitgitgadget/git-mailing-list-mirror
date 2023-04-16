Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC8BC77B73
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 19:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjDPTKY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Apr 2023 15:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjDPTKW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2023 15:10:22 -0400
X-Greylist: delayed 314 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Apr 2023 12:10:16 PDT
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDEC30CA
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 12:10:16 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Q004D1hRNz1r1Ms;
        Sun, 16 Apr 2023 21:05:00 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4Q004D1RvJz1qqlS;
        Sun, 16 Apr 2023 21:05:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id WtpaK7ZDHAwZ; Sun, 16 Apr 2023 21:04:59 +0200 (CEST)
X-Auth-Info: iB9GRsuuJyc7y1BttlhjtSZblRrnsbqOwfk1Q2vUEpc4/77qlqOw+Bpj1xx6F/VT
Received: from igel.home (aftr-82-135-86-95.dynamic.mnet-online.de [82.135.86.95])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 16 Apr 2023 21:04:59 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 30D102C12AB; Sun, 16 Apr 2023 21:04:59 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     =?utf-8?Q?Ma=C3=ABl?= Nison <nison.mael@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Glob patterns w/ **; zero or more?
In-Reply-To: <CANiF4iAaWB9j+Mma0-yfp6GvoQuM4k_OBAXn0keR+vCg8PQjmA@mail.gmail.com>
        (=?utf-8?Q?=22Ma=C3=ABl?= Nison"'s message of "Sun, 16 Apr 2023 20:40:43
 +0200")
References: <CANiF4iAaWB9j+Mma0-yfp6GvoQuM4k_OBAXn0keR+vCg8PQjmA@mail.gmail.com>
X-Yow:  Here I am in the POSTERIOR OLFACTORY LOBULE but I don't see CARL SAGAN
 anywhere!!
Date:   Sun, 16 Apr 2023 21:04:59 +0200
Message-ID: <87ttxfsl5w.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Apr 16 2023, Maël Nison wrote:

> I noticed that, in a repo with a single `main.c` file, `git ls-files
> './**/main.c'` (note the surrounding quotes, to avoid shell globbing)
> returns no result even though `git ls-files main.c` does. It however
> can find any `main.c` file located in a subdirectory, suggesting `**`
> is interpreted as "one or more" rather than "zero or more". Can you
> confirm it'd be a bug? I checked in both 2.38 and 2.40.

By default, pathspec matching does not take "**" specially, making it
equivalen to "*", but it can match "/".  Thus "./**/main.c" is the same
as "*/main.c" (the leading "./" always matches) and matches paths with
at least one "/" in it (thus "*/main.c" does not match "main.c").

If you use ":(glob)./**/main.c", it uses shell glob matching, where "**"
is special and "/**/" can match "/", but "*" does not match "/".

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
