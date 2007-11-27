From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Mon, 26 Nov 2007 21:08:43 -0500
Message-ID: <20071127020842.GN14735@spearce.org>
References: <Pine.LNX.4.64.0711252236350.4725@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 27 03:09:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwpsq-0003MC-W3
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 03:09:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173AbXK0CIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 21:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbXK0CIs
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 21:08:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44449 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbXK0CIs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 21:08:48 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IwpsH-0004pR-NR; Mon, 26 Nov 2007 21:08:33 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1447220FBAE; Mon, 26 Nov 2007 21:08:43 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711252236350.4725@wbgn129.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66160>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> This program dumps (parts of) a git repository in the format that
> fast-import understands.
...
> +-------------------------------------------------------------------
> +$ git fast-export --all | (cd /empty/repository && git fast-import)
> +-------------------------------------------------------------------
> +
> +This will export the whole repository and import it into the existing
> +empty repository.  Except for reencoding commits that are not in
> +UTF-8, it would be a one-to-one mirror.

WTF?

Why are you reencoding the commits on output in fast-export?
Why aren't you dumping them raw to the stream?  fast-import takes
them raw.  Oh, it doesn't have a way to set the encoding header.
DOH.

I think this should be prefixed by fast-import patch to teach it
something like "encoding N" as a subcommand of commit, so that you
can feed data in a non UTF-8 encoding and get it to include the
proper encoding header in the commit object it creates.  That way
a pipeline like the above really does create a duplicate repository,
with the same commit SHA-1s, even if the commits weren't in UTF-8.

-- 
Shawn.
