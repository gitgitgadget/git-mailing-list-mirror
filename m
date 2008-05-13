From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH v2 17/24] Added the class TreeFilePattern.
Date: Mon, 12 May 2008 21:22:53 -0400
Message-ID: <20080513012253.GF29038@spearce.org>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de> <1210623222-24908-18-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Florian Koeberle <florianskarten@web.de>
X-From: git-owner@vger.kernel.org Tue May 13 03:24:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvjFS-00059U-3L
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 03:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756335AbYEMBW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 21:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756412AbYEMBW6
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 21:22:58 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47626 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586AbYEMBW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 21:22:57 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JvjE4-00038P-Ou; Mon, 12 May 2008 21:22:44 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 59AB020FBAE; Mon, 12 May 2008 21:22:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1210623222-24908-18-git-send-email-florianskarten@web.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81977>

Florian Koeberle <florianskarten@web.de> wrote:
> +/**
> + * Represents a pattern like "documents/*.txt" which matches all *.txt files in
> + * the tree documents.
> + * 
> + */
> +class TreeFilePattern implements FilePattern {
> +
> +	private final List<String> path;
> +
> +	private final int offset;
> +
> +	private final GlobalFilePattern globalFilePattern;

Hmm.  This looks a lot like the ComplexFilePattern class to me;
only it has the optimization of avoiding the regex match on the
leading parts of the path.

Wouldn't it be simpler to define ComplexFilePattern taking a
List<FilePattern> and have two implementations of FilePattern;
one that uses FNMatch and one that uses strict String.equals()?
Then this entire class becomes unnecessary as the pattern
"documents/technical/*.txt" can be handled by two ExactMatch
instances followd by an FNMatch instance.

The performance difference is probably not even measurable, but
the code will be less complicated and less special-cased.

-- 
Shawn.
