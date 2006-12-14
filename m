X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-fetching from a big repository is slow
Date: Thu, 14 Dec 2006 14:46:36 -0500
Message-ID: <20061214194636.GO1747@spearce.org>
References: <200612141340.43925.andyparkins@gmail.com> <4581573E.40803@op5.se> <Pine.LNX.4.63.0612141513130.3635@wbgn013.biozentrum.uni-wuerzburg.de> <4581685D.1070407@op5.se> <C287764F-6755-4291-A87A-3E8816E90B49@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 19:46:52 +0000 (UTC)
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <C287764F-6755-4291-A87A-3E8816E90B49@adacore.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34387>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuwXZ-0004nm-Fv for gcvg-git@gmane.org; Thu, 14 Dec
 2006 20:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750865AbWLNTqq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 14:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWLNTqp
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 14:46:45 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59586 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1750862AbWLNTqp (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 14:46:45 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GuwXG-0004jg-Az; Thu, 14 Dec 2006 14:46:30 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 6C3E920FB65; Thu, 14 Dec 2006 14:46:36 -0500 (EST)
To: Geert Bosch <bosch@adacore.com>
Sender: git-owner@vger.kernel.org

Geert Bosch <bosch@adacore.com> wrote:
> Such special magic based on filenames is always a bad idea. Tomorrow  
> somebody
> comes with .zip files (oh, and of course .ZIP), then it's .jpg's other
> compressed content. In the end git will be doing lots of magic and  
> still perform
> badly on unknown compressed content.
> 
> There is a very simple way of detecting compressed files: just look  
> at the
> size of the compressed blob and compare against the size of the  
> expanded blob.
> If the compressed blob has a non-trivial size which is close to the  
> expanded
> size, assume the file is not interesting as source or target for deltas.
> 
> Example:
>    if (compressed_size > expanded_size / 4 * 3 + 1024) {
>      /* don't try to deltify if blob doesn't compress well */
>      return ...;
>    }

And yet I get good delta compression on a number of ZIP formatted
files which don't get good additional zlib compression (<3%).
Doing the above would cause those packfiles to explode to about
10x their current size.

-- 
