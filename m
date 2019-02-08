Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFA681F453
	for <e@80x24.org>; Fri,  8 Feb 2019 19:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfBHT0e convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 8 Feb 2019 14:26:34 -0500
Received: from elephants.elehost.com ([216.66.27.132]:52912 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfBHT0e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 14:26:34 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x18JQOHo088343
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Feb 2019 14:26:25 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <000f01d4bf9e$a508eab0$ef1ac010$@nexbridge.com> <20190208165052.GC23461@sigill.intra.peff.net> <001101d4bfd6$b9430230$2bc90690$@nexbridge.com> <20190208180321.GB27673@sigill.intra.peff.net> <002501d4bfde$b26e6050$174b20f0$@nexbridge.com> <20190208191519.GF27673@sigill.intra.peff.net>
In-Reply-To: <20190208191519.GF27673@sigill.intra.peff.net>
Subject: RE: [Breakage] Git v2.21.0-rc0 - t5318 (NonStop)
Date:   Fri, 8 Feb 2019 14:26:17 -0500
Message-ID: <002b01d4bfe4$2d617f40$88247dc0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE5rFddSF2c8coPnbFiKb9P+8bdAwH0igmPAiNgz5YBSIw84wKJiaU9Aj0+V9OmuzTBEA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 8, 2019 14:15, Jeff King wrote:
> On Fri, Feb 08, 2019 at 01:47:04PM -0500, Randall S. Becker wrote:
> 
> > > Though I suspect we may be able to just find a solution that works
> > > everywhere, without having two different implementations. If we know
> > > we need $count bytes for dd, we could probably just generate a file
> > > with that many NULs in it.
> >
> > For this, we could use truncate -s count file instead of dd to get a
> > fixed size file of nulls. This would remove the need for /dev/zero in
> > t5318 (the patch below probably will wrap badly in my mailer so I can
> > submit a real patch separately.
> 
> I don't think "truncate" is portable, though.

It is available AFAIK on Linux, POSIX, and Windows under Cygwin. That's more than /dev/zero has anyway. I have the patch ready if you want it.

> > > Other cases don't seem to actually care that they're getting NULs,
> > > and are just redirecting stdin from /dev/zero to get an infinite
> > > amount of input. They could probably use "yes" for that.
> >
> > What about reading from /dev/null?
> 
> That would yield zero bytes, not an infinite number of them.

So something like: yes | tr 'y' '\0' | stuff?

