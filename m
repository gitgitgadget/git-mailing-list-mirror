From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Wed, 28 Feb 2007 11:32:56 -0500
Message-ID: <20070228163256.GD5479@spearce.org>
References: <17892.64236.443170.43061@lisa.zopyra.com> <20070228035713.GC5597@spearce.org> <20070228044719.GA6068@spearce.org> <17893.40847.313519.283218@lisa.zopyra.com> <17893.42063.186763.291346@lisa.zopyra.com> <20070228155412.GC5479@spearce.org> <17893.43522.511785.121778@lisa.zopyra.com> <17893.44181.129918.669187@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 17:33:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMRjy-0000Zf-Vo
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 17:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbXB1QdD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 11:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbXB1QdB
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 11:33:01 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54120 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbXB1QdA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 11:33:00 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HMRjY-0003ce-V4; Wed, 28 Feb 2007 11:32:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C46B920FBAE; Wed, 28 Feb 2007 11:32:56 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <17893.44181.129918.669187@lisa.zopyra.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40957>

Bill Lear <rael@zopyra.com> wrote:
> >The code has this:
> >
> >        unsigned long from = obj[0].offset + obj[0].hdr_size;
> >        unsigned long len = obj[1].offset - from;
> >
> >by "offset", do you want obj[0].offset and obj[1].offset?
> >
> >How do I get the size of the packfile?  Is it obj->size?

I meant something like this:

diff --git a/index-pack.c b/index-pack.c
index cf81a99..001aa46 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -287,7 +287,7 @@ static void *get_data_from_pack(struct object_entry *obj)
 	do {
 		ssize_t n = pread(pack_fd, data + rdy, len - rdy, from + rdy);
 		if (n <= 0)
-			die("cannot pread pack file: %s", strerror(errno));
+			die("cannot pread pack file: %s from=%lu, packfile size=%lu", strerror(errno), from, lseek(pack_fd, SEEK_END, 0));
 		rdy += n;
 	} while (rdy < len);
 	data = xmalloc(obj->size);

-- 
Shawn.
