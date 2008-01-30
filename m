From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/7] Use 'printf %s $x' notation in t5401
Date: Wed, 30 Jan 2008 01:48:45 -0500
Message-ID: <20080130064845.GR24004@spearce.org>
References: <20080130062156.GA15838@spearce.org> <7vlk67izoa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 07:49:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK6l8-0006ey-Pf
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 07:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbYA3Gsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 01:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbYA3Gsu
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 01:48:50 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59980 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbYA3Gsu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 01:48:50 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JK6kZ-0000zu-8k; Wed, 30 Jan 2008 01:48:47 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 120DC20FBAE; Wed, 30 Jan 2008 01:48:46 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vlk67izoa.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72039>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
> > index 3eea306..9734fc5 100755
> > --- a/t/t5401-update-hooks.sh
> > +++ b/t/t5401-update-hooks.sh
> > @@ -25,7 +25,7 @@ test_expect_success setup '
> >  
> >  cat >victim/.git/hooks/pre-receive <<'EOF'
> >  #!/bin/sh
> > -printf "$@" >>$GIT_DIR/pre-receive.args
> > +printf %s "$@" >>$GIT_DIR/pre-receive.args
> 
> Do you really mean this? "printf %s 1 2 3" writes "123" without
> terminating LF.  You seem to check only for size but to be
> reusable you might want to use something like:

The only thing we care about is was there args or not to the hook.
I probably could do that test differently, like say:

	echo $# >$GIT_DIR/pre-receive.args

and then test that the file contains "0" instead of looking for it to
be empty.  Not sure why I didn't write it that way in the beginning.

> 	printf '%s\n' "$@"

Eh.  Since all we care is that the argument count is 0 we probably
should be looking at $# and calling it a day.

-- 
Shawn.
