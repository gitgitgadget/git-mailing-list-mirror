Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 489A5209AA
	for <e@80x24.org>; Fri, 14 Oct 2016 09:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752797AbcJNJfc (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 05:35:32 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34733 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbcJNJfb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 05:35:31 -0400
Received: by mail-lf0-f41.google.com with SMTP id b81so183881377lfe.1
        for <git@vger.kernel.org>; Fri, 14 Oct 2016 02:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=uQ6Hqcqw2eOMMetKrnzhgLUP0p+FrRQ3B8vhBwCF0bc=;
        b=dDIpJxr1P86lc0PJIlgndioqGp62BSK0Ciyf/TCOvJ3z6E/5obkUYtTx93rAxSNnw7
         itcXBYwzje+zfpoLu7lOGFUgjkKQkpBS4+QxU4tDyyoADAZsjO61AxG0ScSDoNZgmolW
         TQIqtJA5P0/pebT4x4dJrx+Wc7SA7tlNhRN2LN37op8y1DCinhh/HHcCIix5+o1fhJRc
         ovATuXElK34S9Q9rX6uB0tqJ5QQA52VqQ4SZt3PPYWe5W55B47egROZv5+jBjzdcrQfY
         BF7s3BbSZSIn4Xmb5omK77SD2gUn1PNQpj0Iy+Lib/Gbb+bPCNruU32sCXf16dhRKoM+
         Jq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=uQ6Hqcqw2eOMMetKrnzhgLUP0p+FrRQ3B8vhBwCF0bc=;
        b=QUh650aXWmfBwoB/Yc5NWNaPDLIedCb55izTbsHAsw7W1JtYDJ0gr9sntehgoM+ifq
         Jc1p1jdOVmFVjoxfOI9zRIbdgj0ZM6+6N5IQRk8SVeTtt4f/w7LhpZxO9e40yMrv4iwS
         4TEK6LMpmJDPhoCNPFksWR1iK3Fny38g1eNeCILmEbME55IDLxdnv6YsCNyXcXiq1LCs
         AeCWcfREm4UiyaA9amEoIG1utg9OZxDi0XmYO0dYjmuC2IGqUxrROZZ8zl8MnmUxH6l8
         t/Ha6tkOVItcv+03UBj6tfVOuDt3LP4C79K+KfUtr0GzwqcPOvIbGErzgb6gqef/96ld
         qNLQ==
X-Gm-Message-State: AA6/9Rl1EV0EfZvH34jKtcZg/k3TQlyaG7hlDQIY34OGl9ZlYmyWI1N3xm/JAIcpeQvuMA==
X-Received: by 10.25.215.34 with SMTP id o34mr2331520lfg.35.1476437729992;
        Fri, 14 Oct 2016 02:35:29 -0700 (PDT)
Received: from [192.168.1.26] (agd104.neoplus.adsl.tpnet.pl. [83.25.159.104])
        by smtp.googlemail.com with ESMTPSA id g7sm4862830ljg.44.2016.10.14.02.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Oct 2016 02:35:28 -0700 (PDT)
Subject: Re: Huge performance bottleneck reading packs
To:     Vegard Nossum <vegard.nossum@oracle.com>, Jeff King <peff@peff.net>
References: <ea8db41f-2ea4-b37b-e6f8-1f1d428aea5d@oracle.com>
 <20161012230143.5kxcmtityaasra5j@sigill.intra.peff.net>
 <20161012231807.syockv2emrsjf55r@sigill.intra.peff.net>
 <20161012234753.tbqhuc7qdyklpfzv@sigill.intra.peff.net>
 <fb66dc02-fb75-5aad-74e5-01b969cf9f9a@oracle.com>
Cc:     git@vger.kernel.org,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Shawn Pearce <spearce@spearce.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <3933cae1-1c2d-e32e-3fea-dc80a2f77ddb@gmail.com>
Date:   Fri, 14 Oct 2016 11:35:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <fb66dc02-fb75-5aad-74e5-01b969cf9f9a@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 13.10.2016 o 11:04, Vegard Nossum pisze:
> On 10/13/2016 01:47 AM, Jeff King wrote:
>> On Wed, Oct 12, 2016 at 07:18:07PM -0400, Jeff King wrote:
>>
>>> Also, is it possible to make the repository in question available? I
>>> might be able to reproduce based on your description, but it would save
>>> time if I could directly run gdb on your example.
> 
> I won't be able to make the repository available, sorry.

We have 'git fast-export --anonymize ...', but it would obviously
not preserve the pack structure (though it can help in other cases
when one cannot make repository available).

-- 
Jakub Narębski

