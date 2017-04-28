Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 146891FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 08:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423124AbdD1Ikr (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 04:40:47 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:60983 "EHLO mail.cixit.se"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1424970AbdD1IkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 04:40:25 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
        by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id v3S8eJHp003528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Apr 2017 10:40:19 +0200
Received: from localhost (peter@localhost)
        by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id v3S8e96S003512;
        Fri, 28 Apr 2017 10:40:09 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Date:   Fri, 28 Apr 2017 09:40:09 +0100 (CET)
From:   Peter Krefting <peter@softwolves.pp.se>
To:     =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Keith Goldfarb <keith@blackthorn-media.com>
Subject: Re: [PATCH v3 4/5] archive-zip: support archives bigger than 4GB
In-Reply-To: <a9cb6572-500e-bbc6-2aac-7cb940d4b171@web.de>
Message-ID: <alpine.DEB.2.00.1704280936290.1440@ds9.cixit.se>
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org> <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se> <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org> <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
 <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org> <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se> <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de> <85f2b6d1-107b-0624-af82-92446f28269e@web.de> <02ddca3c-a11f-7c0c-947e-5ca87a62cdee@web.de>
 <alpine.DEB.2.11.1704241912510.30460@perkele.intern.softwolves.pp.se> <d453610f-dbd5-3f6c-d386-69a74c238b11@web.de> <alpine.DEB.2.11.1704250851420.23677@perkele.intern.softwolves.pp.se> <fdc17512-94dc-4f7f-4fd3-f933e1b18e8f@web.de>
 <alpine.DEB.2.11.1704262154420.29054@perkele.intern.softwolves.pp.se> <87470c8c-e061-e4b3-42fe-84a30858fc0d@web.de> <alpine.DEB.2.11.1704270552590.4681@perkele.intern.softwolves.pp.se> <a9cb6572-500e-bbc6-2aac-7cb940d4b171@web.de>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Fri, 28 Apr 2017 10:40:19 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe:

> Sure, but if we were to start emitting zip64 records regardless of 
> the size of entries then we'd break compatibility.  We should have a 
> very good reason for doing that.  (I don't see the need so far.)

Sure, sounds good.

> The type of descriptor to use depends on the presence of 64-bit 
> sizes in a zip64 extra for that record.  For streaming compression 
> some kind of threshold lower than 0xffffffff needs to be set, 
> because deflate can increase the size of the result.

Indeed. And it seems that they use the version identifier (>= 45) to 
check whether it is in "zip64 format" or not. It seems a bit hit or 
miss to me, the best would be to always use the pre-amble descriptor, 
but that requires holding the entire compressed data in memory (or 
using temporary files or running two passes), neither which are very 
good ideas.

-- 
\\// Peter - http://www.softwolves.pp.se/
