Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 416C31F453
	for <e@80x24.org>; Fri,  8 Feb 2019 17:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfBHRuV convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 8 Feb 2019 12:50:21 -0500
Received: from elephants.elehost.com ([216.66.27.132]:36302 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbfBHRuP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 12:50:15 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x18Ho6Qt080923
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Feb 2019 12:50:06 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <000f01d4bf9e$a508eab0$ef1ac010$@nexbridge.com> <20190208165052.GC23461@sigill.intra.peff.net>
In-Reply-To: <20190208165052.GC23461@sigill.intra.peff.net>
Subject: RE: [Breakage] Git v2.21.0-rc0 - t5318 (NonStop)
Date:   Fri, 8 Feb 2019 12:49:59 -0500
Message-ID: <001101d4bfd6$b9430230$2bc90690$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE5rFddSF2c8coPnbFiKb9P+8bdAwH0igmPpvyuCaA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 8, 2019 11:51, Jeff King wrote:
> On Fri, Feb 08, 2019 at 06:08:33AM -0500, Randall S. Becker wrote:
> 
> > t5318 is rather problematic and I have no good way to fix this. There
> > is no /dev/zero on the platform, and the corrupt_graph_and_verify
> > hard-codes if=/dev/zero, which is a linux-specific pseudo device.
> > Please provide a more platform independent way of testing this
> > feature. Pretty much all subtests from 46 onward fail as a result.
> 
> We did discuss this at the time of the patch, but it seems we already use
> /dev/zero in a bunch of places:
> 
>   https://public-inbox.org/git/xmqqbm57rkg5.fsf@gitster-ct.c.googlers.com/
> 
> Were you just skipping the other tests before?

I did not catch the implications of the review at the time - my bad. We were not intentionally skipping the tests. It looks like some are automatically skipped. t4153 automatically skips (missing TTY), and t5562 fails also but for a different reason (hang - we don't have apache2 to serve up http content).

Would you object to something like this:

if [ ! -e /dev/zero ]; then
	# use shred or some other mechanism (still trying to figure out a solution)
else
	# existing dd
fi

