Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AD1C1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 02:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeBVCGF (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 21:06:05 -0500
Received: from titan.plasma.xg8.de ([85.10.203.189]:37640 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbeBVCGE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 21:06:04 -0500
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w1M25o5x005932
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Feb 2018 03:05:50 +0100
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w1M25nRf005931;
        Thu, 22 Feb 2018 03:05:49 +0100
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w1M25Zpc011338;
        Thu, 22 Feb 2018 03:05:35 +0100
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w1M25Zgb011337;
        Thu, 22 Feb 2018 03:05:35 +0100
Date:   Thu, 22 Feb 2018 03:05:35 +0100
From:   "'Peter Backes'" <rtc@helen.PLASMA.Xg8.DE>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "=?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0?= Bjarmason'" <avarab@gmail.com>,
        "'Derek Fawcus'" <dfawcus+lists-git@employees.org>,
        git@vger.kernel.org, "'Theodore Ts'o'" <tytso@mit.edu>
Subject: Re: Git should preserve modification times at least on request
Message-ID: <20180222020535.GA11063@helen.PLASMA.Xg8.DE>
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE>
 <20180221210339.GA43094@accordion.employees.org>
 <87bmgif2pa.fsf@evledraar.gmail.com>
 <20180221221420.GA7743@helen.PLASMA.Xg8.DE>
 <87a7w2ezeq.fsf@evledraar.gmail.com>
 <20180221231234.GA8509@helen.PLASMA.Xg8.DE>
 <007d01d3ab6f$e5439f10$afcadd30$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007d01d3ab6f$e5439f10$afcadd30$@nexbridge.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 21, 2018 at 06:58:34PM -0500, Randall S. Becker wrote:
> May I suggest storing the date/time in UTC+0 in all cases. I can see
> potential issues a couple of times a year where holes exist. I cannot even
> fathom what would happen on a merge or edit of history.

I consider storing the timestamp simply in the traditional 
seconds-since-epoch UNIX timestamp format. But I'm not entirely sure 
yet (see below).

If a timestamp includes the offset, there shouldn't be any issue with 
holes. UTC+0 is nice, too, of course, though some might want to 
preserve the timezone in which the timestamp was actually created.

The bigger issue is usually to copy with those pesky leap seconds. It 
makes a difference whether one uses solar seconds ("posix" style; those 
are more commonly seen) or atomic seconds ("right" style) for the UNIX 
timestamp. Those differences accumulate over time, so you can have 
almost half a minute delta if you are not careful with timestamp 
conversion. If I remember correctly, rcs uses some rather awkward 
interative convergence algorithm to portably convert from 
human-readable date and time to UNIX timestamps.

Thus I'm still not sure whether it will be a UNIX-format timestamp or 
whether a human-readable date/time might be preferrable.

Best wishes
Peter

-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
