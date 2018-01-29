Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DC051F404
	for <e@80x24.org>; Mon, 29 Jan 2018 12:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbeA2Msh (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 07:48:37 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:41472 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751298AbeA2Msg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 07:48:36 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 2E10A1F404;
        Mon, 29 Jan 2018 12:48:36 +0000 (UTC)
Date:   Mon, 29 Jan 2018 12:48:35 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        git@vger.kernel.org
Subject: Re: git send-email sets date
Message-ID: <20180129124835.ngeywe7qstmzx555@untitled>
References: <20180126183230.0ae0c76b@kitsune.suse.cz>
 <CACBZZX7W4n9Q-uL0t1W1dttAxA=hU69fL9Tqsfe0wj5XP=O44w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX7W4n9Q-uL0t1W1dttAxA=hU69fL9Tqsfe0wj5XP=O44w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Fri, Jan 26, 2018 at 6:32 PM, Michal Suchánek <msuchanek@suse.de> wrote:
> > This is wrong because the message will most likely not get delivered
> > when the author date differs from current time.

Even by a few seconds?  I guess it depends on how many patches
you're sending at once.  It uses number of patches to set Date:
header:

	$time = time - scalar $#files;
	(and does $time++ for each patch)

> Others have covered other bases here, but I just wanted to ask about
> this. Are there really mail setups that refuse to deliver or accept
> messages whose Date headers don't match what the expect? I would think
> that such issues wouldn't be present in the wild since SMTP daemons
> need to deal with messages that are e.g. held locally somewhere, or
> the only make it to your server days afterwards due to your own
> downtime + client retries.

Having a Date that's far off is one of many indicators used to
determine spam.  SpamAssassin has a rules and scores which do
this, but it looks like the smallest one is for 3 and 6 hours
in the past (DATE_IN_PAST_03_06) so one would need 10800 patches
to trigger it (!?)

I definitely had problems back in the day with author date
being used as the Date: header, see:

	commit 1d6a003a42b3c23ad7883b0bbe6a034728e51836
	("git-send-email: do not pass custom Date: header")
