From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/6] more compact progress display
Date: Tue, 16 Oct 2007 22:11:37 -0400
Message-ID: <20071017021137.GO13801@spearce.org>
References: <1192586150-13743-1-git-send-email-nico@cam.org> <1192586150-13743-2-git-send-email-nico@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 04:11:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhyO1-00064w-5b
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 04:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756691AbXJQCLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 22:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755036AbXJQCLl
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 22:11:41 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51511 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064AbXJQCLl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 22:11:41 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IhyNb-0006SN-ED; Tue, 16 Oct 2007 22:11:27 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AAFFF20FBAE; Tue, 16 Oct 2007 22:11:37 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1192586150-13743-2-git-send-email-nico@cam.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61313>

Nicolas Pitre <nico@cam.org> wrote:
> Each progress can be on a single line instead of two.

Nice.  Of course that screws with git-gui and now I have to
match two regexs and not one.  But whatever.
 
> +++ b/progress.c
> @@ -35,10 +35,11 @@ static void clear_progress_signal(void)
>  	progress_update = 0;
>  }
>  
> -int display_progress(struct progress *progress, unsigned n)
> +static int display(struct progress *progress, unsigned n, int done)
>  {
> +	char *eol;
> +
>  	if (progress->delay) {
> -		char buf[80];
>  		if (!progress_update || --progress->delay)
>  			return 0;
>  		if (progress->total) {
> @@ -51,60 +52,56 @@ int display_progress(struct progress *progress, unsigned n)
>  				return 0;
>  			}
>  		}
> -		if (snprintf(buf, sizeof(buf),
> -			     progress->delayed_title, progress->total))
> -			fprintf(stderr, "%s\n", buf);
>  	}
> +
> +	progress->last_value = n;

Hmm. n is unsigned and last_value is signed.  Uh?  I know you are
using the special value -1 to mean we've never output anything for
this progress meter but mixing signed and unsigned always gives me
the willies.

-- 
Shawn.
