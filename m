Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67D3E1F453
	for <e@80x24.org>; Wed,  7 Nov 2018 22:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeKHI2A (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 03:28:00 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:30481 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbeKHI2A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 03:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1541631327; x=1573167327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=03vNOeY1E5ZbJR+b0ArcdTaaF7Q+YW2GcTJmNa3A4IQ=;
  b=ODr4VNZEIAQNgRNsE8EuUfGK9MgB+HsX5VM/DV5rCjkAR23gOSyZsJ9A
   ovZbKY10rjhR5n7du3sa6QZyyFF/DhjmVoVN6mbRKoh1nVgbb6XDR++SJ
   YGxV0sXH9xcnjIGnzLHCSna+vRBb2eX/zTNVV4+ocW6RuNzpmoLbhor0c
   4=;
X-IronPort-AV: E=Sophos;i="5.54,477,1534809600"; 
   d="scan'208";a="744683345"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Nov 2018 22:55:26 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id wA7MtPN8003309
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 7 Nov 2018 22:55:25 GMT
Received: from EX13D12UEE001.ant.amazon.com (10.43.62.147) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 7 Nov 2018 22:55:25 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D12UEE001.ant.amazon.com (10.43.62.147) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 7 Nov 2018 22:55:25 +0000
Received: from amazon.com (10.200.179.64) by mail-relay.amazon.com
 (10.43.62.226) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Wed, 7 Nov 2018 22:55:24 +0000
Date:   Wed, 7 Nov 2018 22:55:24 +0000
From:   Geert Jansen <gerardu@amazon.com>
To:     Jeff King <peff@peff.net>
CC:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
Message-ID: <20181107225524.GA119693@amazon.com>
References: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com>
 <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
 <87o9bgl9yl.fsf@evledraar.gmail.com>
 <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
 <20181027093300.GA23974@sigill.intra.peff.net>
 <87lg6jljmf.fsf@evledraar.gmail.com>
 <20181029150453.GH17668@sigill.intra.peff.net>
 <87bm7clf4o.fsf@evledraar.gmail.com>
 <20181029232738.GC24557@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181029232738.GC24557@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 07:27:39PM -0400, Jeff King wrote:

> On Mon, Oct 29, 2018 at 08:36:07PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >  * Re-roll my 4 patch series to include the patch you have in
> >    <20181027093300.GA23974@sigill.intra.peff.net>
> 
> I don't think it's quite ready for inclusion as-is. I hope to brush it
> up a bit, but I have quite a backlog of stuff to review, as well.

We're still quite keen to get this patch included. Is there anything I can do
to help?

Also I just re-read your comments on maximum cache size. I think you were
arguing both sides of the equation and I wasn't sure where you'd ended up. :)
A larger cache size potentially takes more time to fill up especially on NFS
while a smaller cache size obviously would less effective. That said a small
cache is still effective for the "clone" case where the repo is empty.

It also occurred to me that as a performance optimization your patch could read
the the loose object directories in parallel using a thread pool. At least on
Amazon EFS this should result in al almost linear performance increase. I'm not
sure how much this would help for local file systems. In any case this may be
best done as a follow-up patch (that I'd be happy to volunteer for).
