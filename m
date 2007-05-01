From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 4/8] git-repack --max-pack-size: add fixup_header_footer()
Date: Tue, 1 May 2007 01:06:33 -0400
Message-ID: <20070501050633.GZ5942@spearce.org>
References: <463679EB.2010301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 07:06:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HikZW-0003Gv-GA
	for gcvg-git@gmane.org; Tue, 01 May 2007 07:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423791AbXEAFGj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 01:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423794AbXEAFGj
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 01:06:39 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60736 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423791AbXEAFGi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 01:06:38 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HikZP-0008LD-Jx; Tue, 01 May 2007 01:06:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D7E1B20FBAE; Tue,  1 May 2007 01:06:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <463679EB.2010301@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45913>

Dana How <danahow@gmail.com> wrote:
> Add our own version of the one in fast-import.c here.
> Needed later to correct bad object count in header for split pack.
...
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index bc45ca6..98066bf 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -562,6 +562,42 @@ static off_t write_one(struct sha1file *f,
>  	return offset + size;
>  }
>  
> +static void fixup_header_footer(int pack_fd, unsigned char *pack_file_sha1,
> +				char *pack_name, uint32_t object_count)
> +{

This looks a *lot* like the code in fast-import.c.  Why not
refactor both to use the same implementation and stuff it away in
say pack-check.c (for lack of a better place), or start a new file
(pack-write.c)?

There is a *lot* of code in fast-import.c (over 2,000 lines) that
was half-copied from other core code, and that was half created
on its own.  This is also true in index-pack.c and pack-objects.c;
I'd like to see these implementations unify more rather than copy
code from each other.

I know git-blame will identify the original author quite well,
but I'd really like to avoid adding lots more code to maintain
if we can avoid it.

-- 
Shawn.
