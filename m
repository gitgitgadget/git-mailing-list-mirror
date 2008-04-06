From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Update, and clear up the pack format documentation a bit
Date: Sun, 6 Apr 2008 00:51:32 -0400
Message-ID: <20080406045132.GA10274@spearce.org>
References: <20080405180759.GA29710@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Peter Eriksen <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Sun Apr 06 06:52:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiMrp-0000rO-9U
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 06:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbYDFEvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 00:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbYDFEvh
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 00:51:37 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35594 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbYDFEvg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 00:51:36 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JiMqs-0003lO-Sy; Sun, 06 Apr 2008 00:51:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4F19620FBAE; Sun,  6 Apr 2008 00:51:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080405180759.GA29710@bohr.gbar.dtu.dk>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78885>

Peter Eriksen <s022018@student.dtu.dk> wrote:
> The current documentation does not mention the ofs_delta pack
> object type. This patch is also supposed to make the text a bit
> more readable, since it moves the object entry header
> description earlier.
...
> diff --git a/Documentation/technical/pack-format.txt
> b/Documentation/technical/pack-format.txt
> index aa87756..35ee01d 100644
> --- a/Documentation/technical/pack-format.txt
> +++ b/Documentation/technical/pack-format.txt
>       compressed delta data
> + 
> +     (for object type ofs_delta)
> +     n-byte offset (n*7-bit as above, but with size0 being 7 bit)     
> +     compressed delta data
> +

That is not correct.  The ofs_delta is encoded as an n-byte offset
that is subtracted from the current object's first byte (the byte
holding the type/representation field and first 4 bits of length).

The n-byte encoding for an ofs_delta is different then the one
used for the length.  We add 1 for each byte where the MSB is 1.
We also store the data in big-endian form (the most significant
byte is first and the least significant byte is last).

See get_delta_base in sha1_file.c for the details of this.

In pack v4 I planned on using this particular encoding in more
of the format than just here.

-- 
Shawn.
