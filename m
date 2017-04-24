Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D3021FE90
	for <e@80x24.org>; Mon, 24 Apr 2017 08:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166508AbdDXILl (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 04:11:41 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:39177 "EHLO mail.cixit.se"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1166501AbdDXILg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 04:11:36 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Apr 2017 04:11:36 EDT
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
        by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id v3O849CP032497
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 24 Apr 2017 10:04:09 +0200
Received: from localhost (peter@localhost)
        by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id v3O8486Z032486;
        Mon, 24 Apr 2017 10:04:09 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Date:   Mon, 24 Apr 2017 09:04:08 +0100 (CET)
From:   Peter Krefting <peter@softwolves.pp.se>
To:     Johannes Sixt <j6t@kdbg.org>
cc:     =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
        git@vger.kernel.org, Keith Goldfarb <keith@blackthorn-media.com>
Subject: Re: [PATCH v2] archive-zip: Add zip64 headers when file size is too
 large for 32 bits
In-Reply-To: <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org>
Message-ID: <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se>
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org> <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se> <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org> <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
 <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Mon, 24 Apr 2017 10:04:09 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt:

> There is no "zip64 central directory". There is a "zip64 end of central 
> directory record";

Not strange that I was confused and couldn't find it, then... :-)

All right, I need to fix up my patch to make sure I add the zip64 
extra record to both the central directory entry and to the local 
header, and make sure to trigger the zip64 end of central directory 
whenever the zip file is large enough to warrant one.

> In summary, yes, when the central directory is constructed, it must 
> use the zip64 extra record to note the values of uncompressed size, 
> compressed size, and the offset to the local header when they 
> overflow 4GB.

At least that makes it easier to construct, as we only have one 
central directory and can just extend the records that need extending.

Will fix soon.

-- 
\\// Peter - http://www.softwolves.pp.se/
