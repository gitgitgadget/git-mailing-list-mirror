Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4156207D6
	for <e@80x24.org>; Sun, 23 Apr 2017 06:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427643AbdDWGmu convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 23 Apr 2017 02:42:50 -0400
Received: from lamora.getmail.no ([84.210.184.7]:46393 "EHLO lamora.getmail.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1427554AbdDWGmk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 02:42:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by lamora.getmail.no (Postfix) with ESMTP id 21B121232E1;
        Sun, 23 Apr 2017 08:42:38 +0200 (CEST)
Received: from lamora.getmail.no ([127.0.0.1])
        by localhost (lamora.get.c.bitbit.net [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bP35G9oWLReV; Sun, 23 Apr 2017 08:42:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lamora.getmail.no (Postfix) with ESMTP id ABB1A123357;
        Sun, 23 Apr 2017 08:42:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at lamora.get.c.bitbit.net
Received: from lamora.getmail.no ([127.0.0.1])
        by localhost (lamora.get.c.bitbit.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1A2aqptIhSng; Sun, 23 Apr 2017 08:42:37 +0200 (CEST)
Received: from perkele.intern.softwolves.pp.se (cm-84.209.33.229.getinternet.no [84.209.33.229])
        by lamora.getmail.no (Postfix) with ESMTPSA id 823801232E1;
        Sun, 23 Apr 2017 08:42:37 +0200 (CEST)
Received: from peter (helo=localhost)
        by perkele.intern.softwolves.pp.se with local-esmtp (Exim 4.84_2)
        (envelope-from <peter@softwolves.pp.se>)
        id 1d2BED-0007qj-I3; Sun, 23 Apr 2017 08:42:37 +0200
Date:   Sun, 23 Apr 2017 07:42:37 +0100 (CET)
From:   Peter Krefting <peter@softwolves.pp.se>
To:     =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Keith Goldfarb <keith@blackthorn-media.com>
Subject: Re: [PATCH] archive-zip: Add zip64 headers when file size is too
 large for 32 bits
In-Reply-To: <04ad7a06-969d-ffa5-b792-ccc1e7e45fd2@web.de>
Message-ID: <alpine.DEB.2.11.1704230737380.29888@perkele.intern.softwolves.pp.se>
References: <3C736801-6BB8-41CC-88FF-C42FC853A736@blackthorn-media.com> <alpine.DEB.2.11.1704222019420.12779@perkele.intern.softwolves.pp.se> <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org> <04ad7a06-969d-ffa5-b792-ccc1e7e45fd2@web.de>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe:

> The offset is declared as unsigned int, so will wrap on most platforms
> before reaching the clamp check.  At least InfoZIP's unzip can handle
> that, but it's untidy.

Right, that needs to be changed into unsigned long and clamped, just 
like the original and compressed file sizes already are.

> The offset is only needed in the ZIP64 extra record for the central 
> header (in zip_dir) -- the local header has no offset field.

The zip64 local header does have an offset field, though. I thought 
that was the zip_offset value, but that doesn't make sense, I'm not 
quite sure what it is supposed to store. I need to investigate that 
further, I assume.

-- 
\\// Peter - http://www.softwolves.pp.se/
