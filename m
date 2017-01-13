Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C091020756
	for <e@80x24.org>; Fri, 13 Jan 2017 16:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750843AbdAMQ7B (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 11:59:01 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:45782 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750760AbdAMQ7A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 11:59:00 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 0300A20756;
        Fri, 13 Jan 2017 16:58:19 +0000 (UTC)
Date:   Fri, 13 Jan 2017 16:58:19 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Pat Pannuto <pat.pannuto@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] Use 'env' to find perl instead of fixed path
Message-ID: <20170113165819.GA6069@starla>
References: <20170112055140.29877-1-pat.pannuto@gmail.com>
 <20170112055140.29877-3-pat.pannuto@gmail.com>
 <6fe462dd-929a-671b-a210-36ee38e99115@kdbg.org>
 <CAAnLKaGbf9-GAF19+61=7_RfCOBM0=Ounwf8KkL1jS6HX3pOag@mail.gmail.com>
 <alpine.DEB.2.20.1701121118170.3469@virtualbox>
 <xmqqbmvcj9le.fsf@gitster.mtv.corp.google.com>
 <CAAnLKaGvz4Wzs36gMSdoYCg+tzx6KFCe59FNnk5zNQ-L58ww1g@mail.gmail.com>
 <20170113024842.GA20572@starla>
 <alpine.DEB.2.20.1701131626160.3469@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1701131626160.3469@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> I guess I do not understand, still, what the difference is between using
> -w and adding `use warnings` *very early* in the script... Could you give
> an example where it makes a difference?

"use warnings" won't leak across files/modules.  In the following
example, only the "useless use of join or string in void context"
from void.perl gets shown w/o -w.  The VoidExample.pm warning
can get lost.

----- VoidExample.pm ------
package VoidExample;
use strict;
# use warnings; # uncomment to trigger warning on next line:
join('', qw(a b c));

1;
------ void.perl ------
#!/usr/bin/perl
use strict;
use warnings;
use VoidExample;

join('', qw(a b c)); # warns
----------8<----------

$ perl -I . void.perl    # 1 warning
$ perl -w -I . void.perl # 2 warnings
