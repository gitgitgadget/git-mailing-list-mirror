From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 08/31] Add dryRun option to Transport and console
	push
Date: Tue, 19 Aug 2008 09:28:16 -0700
Message-ID: <20080819162816.GF20947@spearce.org>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com> <1219005852-21496-2-git-send-email-marek.zawirski@gmail.com> <1219005852-21496-3-git-send-email-marek.zawirski@gmail.com> <1219005852-21496-4-git-send-email-marek.zawirski@gmail.com> <1219005852-21496-5-git-send-email-marek.zawirski@gmail.com> <1219005852-21496-6-git-send-email-marek.zawirski@gmail.com> <1219005852-21496-7-git-send-email-marek.zawirski@gmail.com> <1219005852-21496-8-git-send-email-marek.zawirski@gmail.com> <1219005852-21496-9-git-send-email-marek.zawirski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: robin.rosenberg@dewire.com, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 18:29:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVU5C-0002j7-MK
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 18:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbYHSQ2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 12:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752753AbYHSQ2R
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 12:28:17 -0400
Received: from george.spearce.org ([209.20.77.23]:41046 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbYHSQ2R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 12:28:17 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A328038375; Tue, 19 Aug 2008 16:28:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1219005852-21496-9-git-send-email-marek.zawirski@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92880>

Marek Zawirski <marek.zawirski@gmail.com> wrote:
> Implementation of C Git --dry-run behavior for push operation.
> It allows investigating possible push result, while not performing real
> push operation - not updating remote refs.
 
> diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
> index a952309..f5b24c6 100644
> --- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
> +++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
> @@ -85,6 +85,9 @@ class Push extends TextBuiltin {
>  
>  	@Option(name = "--receive-pack", metaVar = "path")
>  	private String receivePack;
> +	
> +	@Option(name = "--dry-run")
> +	private boolean dryRun = Transport.DEFAULT_DRY_RUN;

Having a boolean constant DEFAULT_DRY_RUN = false is sort of
overkill in my opinion.  Most people would assume a boolean with
no value assigned and not marked final will default to false.
Setting something like dryRun to false by default is reasonable,
as you usually want it to actually execute.

What's worse though is if one day someone changes
Transport.DEFAULT_DRY_RUN = true in the library.  When that happens
the push command line tool will never function as there is no
"--no-dry-run" to set dryRun = false.

So this assignment is likely not a good idea.

-- 
Shawn.
