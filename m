X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Geert Bosch <bosch@adacore.com>
Subject: Re: git-fetching from a big repository is slow
Date: Thu, 14 Dec 2006 18:01:46 -0500
Message-ID: <E30DCF6F-5D3E-4CA3-85D7-CD2847B86F86@adacore.com>
References: <200612141340.43925.andyparkins@gmail.com> <4581573E.40803@op5.se> <Pine.LNX.4.63.0612141513130.3635@wbgn013.biozentrum.uni-wuerzburg.de> <4581685D.1070407@op5.se> <C287764F-6755-4291-A87A-3E8816E90B49@adacore.com> <20061214194636.GO1747@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 23:03:11 +0000 (UTC)
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061214194636.GO1747@spearce.org>
X-Mailer: Apple Mail (2.752.2)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34425>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuzbW-0006oz-Su for gcvg-git@gmane.org; Fri, 15 Dec
 2006 00:03:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750728AbWLNXDB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 18:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbWLNXDB
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 18:03:01 -0500
Received: from nile.gnat.com ([205.232.38.5]:53039 "EHLO nile.gnat.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1750728AbWLNXDA
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 18:03:00 -0500
Received: from localhost (localhost [127.0.0.1]) by filtered-nile.gnat.com
 (Postfix) with ESMTP id CFFC648CC2E; Thu, 14 Dec 2006 18:02:19 -0500 (EST)
Received: from nile.gnat.com ([127.0.0.1]) by localhost (nile.gnat.com
 [127.0.0.1]) (amavisd-new, port 10024) with LMTP id 26453-01; Thu, 14 Dec
 2006 18:02:19 -0500 (EST)
Received: from [172.16.1.2] (sdsl-216-220-103-157.dsl.bway.net
 [216.220.103.157]) by nile.gnat.com (Postfix) with ESMTP id 541F448D055; Thu,
 14 Dec 2006 18:02:19 -0500 (EST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org


On Dec 14, 2006, at 14:46, Shawn Pearce wrote:
> And yet I get good delta compression on a number of ZIP formatted
> files which don't get good additional zlib compression (<3%).
> Doing the above would cause those packfiles to explode to about
> 10x their current size.

Yes, that's because for zip files each file in the archive is
compressed independently. Similar things might happen when
checking in uncompressed tar files with JPG's. The question
is whether you prefer bad time usage or bad space usage when
handling large binary blobs. Maybe we should use a faster,
less precise algorithm instead of giving up.

Still, I think doing anything based on filename is a mistake.
If we want to have a heuristic to prevent spending too much time
on deltifying large compressed files, the heuristic should be
based on content, not filename.

Maybe we could some "magic" as used by the file(1) command
that allows git to say a bit more about the content of blobs.
This could be used both for ordering files during deltification
and to determine wether to try deltification at all.

   -Geert

