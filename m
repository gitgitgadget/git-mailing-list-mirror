Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ABD01F453
	for <e@80x24.org>; Thu,  8 Nov 2018 20:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbeKIGfi (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 01:35:38 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:41436 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeKIGfi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 01:35:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1541710704; x=1573246704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XCOxUBn8GrR2EP7qpoQj8KN/Ya25Wk/XPQPogx99Ebo=;
  b=J8O1ZkfcoXnRJUtuwRitWXRUbWOaG9dQUMi4vFTvDmsmpkvmmZdNb1YO
   CKvWJOVk7uKVMaeZA0EBHrOzreTiyBah7KDg0EIKnkyANU/+68XXQkkdv
   jBY9iViozylCsL+JAmCokdh9uH4tbfOpWz77+DKEeSzYo/8MlbRQvLSFi
   8=;
X-IronPort-AV: E=Sophos;i="5.54,480,1534809600"; 
   d="scan'208";a="641194367"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2018 20:58:21 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id wA8KwJ4Y119274
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 8 Nov 2018 20:58:21 GMT
Received: from EX13D06UWA001.ant.amazon.com (10.43.160.220) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 8 Nov 2018 20:58:20 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D06UWA001.ant.amazon.com (10.43.160.220) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 8 Nov 2018 20:58:20 +0000
Received: from amazon.com (10.200.179.64) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 8 Nov 2018 20:58:19 +0000
Date:   Thu, 8 Nov 2018 20:58:19 +0000
From:   Geert Jansen <gerardu@amazon.com>
To:     Jeff King <peff@peff.net>
CC:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
Message-ID: <20181108205819.GA93589@amazon.com>
References: <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
 <87o9bgl9yl.fsf@evledraar.gmail.com>
 <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
 <20181027093300.GA23974@sigill.intra.peff.net>
 <87lg6jljmf.fsf@evledraar.gmail.com>
 <20181029150453.GH17668@sigill.intra.peff.net>
 <87bm7clf4o.fsf@evledraar.gmail.com>
 <20181029232738.GC24557@sigill.intra.peff.net>
 <20181107225524.GA119693@amazon.com>
 <20181108120256.GA29432@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181108120256.GA29432@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 08, 2018 at 07:02:57AM -0500, Jeff King wrote:

> Yes, testing and review. :)
> 
> I won't send the series out just yet, as I suspect it could use another
> read-through on my part. But if you want to peek at it or try some
> timings, it's available at:
> 
>   https://github.com/peff/git jk/loose-cache

I gave this branch a go. There's a performance regression as I'm getting a
clone speed of about 100 KiB/s while with the previous patch I got around 20
MiB/s. The culprint appears to be a very large number of stat() calls on
".git/objects/info/alternates". The call stack is:

 -> quick_has_loose()
 -> prepare_alt_odb()
 -> read_info_alternates()
