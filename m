X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: how to revert changes in working tree?
Date: Wed, 6 Dec 2006 13:13:02 -0500
Message-ID: <20061206181302.GA20320@spearce.org>
References: <4576680B.7030500@gmail.com> <81b0412b0612060043t488d356du8f5fcdd164a45eb5@mail.gmail.com> <45769417.70601@gmail.com> <81b0412b0612060220n11fb7e19hc6ed202759962bd3@mail.gmail.com> <4576A60A.3060003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 18:13:21 +0000 (UTC)
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <4576A60A.3060003@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33500>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs1Gd-0006M2-OB for gcvg-git@gmane.org; Wed, 06 Dec
 2006 19:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935993AbWLFSNK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 13:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937017AbWLFSNK
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 13:13:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49727 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S935993AbWLFSNG (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 13:13:06 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gs1G6-0001ay-Uk; Wed, 06 Dec 2006 13:12:43 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 12FBA20FB7F; Wed,  6 Dec 2006 13:13:03 -0500 (EST)
To: Liu Yubao <yubao.liu@gmail.com>
Sender: git-owner@vger.kernel.org

Liu Yubao <yubao.liu@gmail.com> wrote:
> $ git merge "sync from origin" HEAD origin
> Updating 088406b..ff51a98
> include/linux/netfilter/xt_CONNMARK.h: needs update
> include/linux/netfilter/xt_DSCP.h: needs update
> include/linux/netfilter/xt_MARK.h: needs update
> include/linux/netfilter_ipv4/ipt_CONNMARK.h: needs update
> include/linux/netfilter_ipv4/ipt_DSCP.h: needs update
> include/linux/netfilter_ipv4/ipt_ECN.h: needs update
> include/linux/netfilter_ipv4/ipt_MARK.h: needs update
> include/linux/netfilter_ipv4/ipt_TCPMSS.h: needs update
> include/linux/netfilter_ipv4/ipt_TOS.h: needs update
> include/linux/netfilter_ipv4/ipt_TTL.h: needs update
> include/linux/netfilter_ipv6/ip6t_HL.h: needs update
> include/linux/netfilter_ipv6/ip6t_MARK.h: needs update
> net/ipv4/netfilter/ipt_ECN.c: needs update
> net/ipv4/netfilter/ipt_TOS.c: needs update
> net/ipv4/netfilter/ipt_TTL.c: needs update
> net/ipv6/netfilter/ip6t_HL.c: needs update
> net/netfilter/xt_CONNMARK.c: needs update
> net/netfilter/xt_DSCP.c: needs update
> net/netfilter/xt_MARK.c: needs update
> fatal: Entry 'net/ipv4/netfilter/ipt_ECN.c' not uptodate. Cannot merge.
> 
> I really have never modified these files manually.

You are just *very unlucky*.  :-)

The Linux kernel has case sensitive file names.  In other words there
are two files in the kernel:

  net/netfilter/xt_MARK.c
  net/netfilter/xt_mark.c

and they have different content!  On NTFS or FAT, where filenames
are not case sensitive, these become the same file.  So Git now
starts to think that the file was modified, because one of those
files overwrote the other when they were checked out.

Moral of the story: You cannot work with the linux.git repository
on a case insensitive filesystem, like NTFS, FAT (Windows), or HFS+
(Mac OS X).

-- 
