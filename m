Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41702207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 21:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967610AbdDZVCh convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 26 Apr 2017 17:02:37 -0400
Received: from lamora.getmail.no ([84.210.184.7]:50337 "EHLO lamora.getmail.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967606AbdDZVCf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 17:02:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by lamora.getmail.no (Postfix) with ESMTP id 0981B88259;
        Wed, 26 Apr 2017 23:02:33 +0200 (CEST)
Received: from lamora.getmail.no ([127.0.0.1])
        by localhost (lamora.get.c.bitbit.net [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gzpibxfZ47aS; Wed, 26 Apr 2017 23:02:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lamora.getmail.no (Postfix) with ESMTP id 8A09588A02;
        Wed, 26 Apr 2017 23:02:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at lamora.get.c.bitbit.net
Received: from lamora.getmail.no ([127.0.0.1])
        by localhost (lamora.get.c.bitbit.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HI_bQVxVDFlC; Wed, 26 Apr 2017 23:02:32 +0200 (CEST)
Received: from perkele.intern.softwolves.pp.se (cm-84.209.33.229.getinternet.no [84.209.33.229])
        by lamora.getmail.no (Postfix) with ESMTPSA id 6443388259;
        Wed, 26 Apr 2017 23:02:32 +0200 (CEST)
Received: from peter (helo=localhost)
        by perkele.intern.softwolves.pp.se with local-esmtp (Exim 4.84_2)
        (envelope-from <peter@softwolves.pp.se>)
        id 1d3U53-0007eS-4e; Wed, 26 Apr 2017 23:02:33 +0200
Date:   Wed, 26 Apr 2017 22:02:33 +0100 (CET)
From:   Peter Krefting <peter@softwolves.pp.se>
To:     =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Keith Goldfarb <keith@blackthorn-media.com>
Subject: Re: [PATCH v3 4/5] archive-zip: support archives bigger than 4GB
In-Reply-To: <fdc17512-94dc-4f7f-4fd3-f933e1b18e8f@web.de>
Message-ID: <alpine.DEB.2.11.1704262154420.29054@perkele.intern.softwolves.pp.se>
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org> <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se> <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org> <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
 <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org> <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se> <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de> <85f2b6d1-107b-0624-af82-92446f28269e@web.de> <02ddca3c-a11f-7c0c-947e-5ca87a62cdee@web.de>
 <alpine.DEB.2.11.1704241912510.30460@perkele.intern.softwolves.pp.se> <d453610f-dbd5-3f6c-d386-69a74c238b11@web.de> <alpine.DEB.2.11.1704250851420.23677@perkele.intern.softwolves.pp.se> <fdc17512-94dc-4f7f-4fd3-f933e1b18e8f@web.de>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe:

> I struggled with that sentence as well.  There is no explicit 
> "format" field AFAICS.

Exactly. I interpret that as it is in zip64 format if there are any 
zip64 structures in the archive (especially if there is a zip64 
end of central directory locator).

> Or in other words: A legacy ZIP archive and a ZIP64 archive can be 
> bit-wise the same if all values for all entries fit into the legacy 
> fields, but the difference in terms of the spec is what the archiver 
> was allowed to do when it created them.

As long as all sizes are below (unsigned) -1, then they would be 
identical. If one, and only one, of the sizes are equal to (unsigned) 
-1 (and none overflow), then it is up to intepretation whether or not 
a ZIP64-aware archiver is allowed to output an archive that is not in 
ZIP64 format. If any single size or value overflows the 32 (16) bit 
values, then ZIP64 format is needed.

> 	# 4-byte sizes, not ZIP64
> 	arch --format=zip ...
>
> 	# ZIP64, can use 8-byte sizes as needed
> 	arch --format=zip64 ...
>
> Makes sense?

Well, I would say that it would be a lot easier to always emit zip64 
archives. An old-style unzipper should be able to read them anyway if 
there are no overflowing fields, right? And, besides, who in 2017 has 
an unzip tool that is unable to read zip64? Info-Zip UnZip has 
supported Zip64 since 2009.

-- 
\\// Peter - http://www.softwolves.pp.se/
