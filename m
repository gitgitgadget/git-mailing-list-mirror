Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 680AC1FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 12:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932426AbdJ0MdP (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 08:33:15 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:45811 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932415AbdJ0MdO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 08:33:14 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3yNjvr3kBKz1r9vM;
        Fri, 27 Oct 2017 14:33:12 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3yNjvr2kJKz1tSmG;
        Fri, 27 Oct 2017 14:33:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id nmBcT0JphUfd; Fri, 27 Oct 2017 14:33:11 +0200 (CEST)
X-Auth-Info: oVEuznBOlfkFDefozFVXlARTzobCDzLhMvSem1p+u9SeQSWNsWugWk5xc2Qkz8eL
Received: from igel.home (ppp-188-174-149-32.dynamic.mnet-online.de [188.174.149.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 27 Oct 2017 14:33:11 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 06A3E2C45DA; Fri, 27 Oct 2017 14:33:11 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Alvaro del Castillo <acs@bitergia.com>
Cc:     git@vger.kernel.org
Subject: Re: Why does fetch-pack not works over http?
References: <1509100979.32292.19.camel@bitergia.com>
X-Yow:  Yow!  I like my new DENTIST...
Date:   Fri, 27 Oct 2017 14:33:10 +0200
In-Reply-To: <1509100979.32292.19.camel@bitergia.com> (Alvaro del Castillo's
        message of "Fri, 27 Oct 2017 12:42:59 +0200")
Message-ID: <873764bwjd.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Okt 27 2017, Alvaro del Castillo <acs@bitergia.com> wrote:

> We're wondering why "fetch-pack" (when is running from the command
> line) doesn't handle "https://" protocol. It only works with "git://".
>
> For instance, this doesn't work:
>
> $ git fetch-pack https://github.com/git/git refs/heads/master
> fatal: I don't handle protocol 'https'
>
> while this does:
>
> $ git fetch-pack git://github.com/git/git refs/heads/master
>
> The funny thing is that under the hood, "fetch" calls "fetch-pack"
> using "https" procotol. Example of a trace below:
>
> 12:03:07.512558 git.c:344               trace: built-in: git 'fetch-
> pack' '--stateless-rpc' '--stdin' '--lock-pack' '--thin' 'https://githu
> b.com/git/git/'

With --stateless-rpc, fetch-pack doesn't do the connect itself, but
expects the caller having set up a pipe to it.  The URL is then actually
ignored.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
