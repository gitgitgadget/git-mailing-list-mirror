From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 07/31] rebase: stricter check of standalone sub command
Date: Thu, 30 Jun 2011 22:55:03 -0500
Message-ID: <20110701035503.GA9818@elie>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-8-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 01 05:55:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcUpL-0004CS-Vc
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jul 2011 05:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534Ab1GADzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 23:55:16 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49946 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754310Ab1GADzP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 23:55:15 -0400
Received: by iyb12 with SMTP id 12so2477261iyb.19
        for <git@vger.kernel.org>; Thu, 30 Jun 2011 20:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=h1gE1kHSX7T4Lyjg+XPp7Cr7wyoyorAz8knA2QMjtBc=;
        b=i1ebgy9Gi+/r1tSiUa0tDBrsQluDGOUZ3rNPjA8CljgguCg2Ifmycechf8f0YiZCxg
         1lmAwlgRgTkGbR4PhxMK/uiWdJAe/cU19ZRE2rcbnZJYwQyW7R6ymPLINaSS2gmu7eM5
         xQTaM0UvFjNFAqEU2CuLIFRMQwsdlSrdf+NuA=
Received: by 10.42.230.5 with SMTP id jk5mr1077699icb.526.1309492514106;
        Thu, 30 Jun 2011 20:55:14 -0700 (PDT)
Received: from elie (adsl-68-255-110-41.dsl.chcgil.sbcglobal.net [68.255.110.41])
        by mx.google.com with ESMTPS id y1sm2870677ica.4.2011.06.30.20.55.10
        (version=SSLv3 cipher=OTHER);
        Thu, 30 Jun 2011 20:55:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1297017841-20678-8-git-send-email-martin.von.zweigbergk@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176514>

Hi Martin,

Martin von Zweigbergk wrote:

> The sub commands '--continue', '--skip' or '--abort' may only be used
> standalone according to the documentation.
[...]
> Is this too simplistic? Do we forsee that we want to support passing
> options when resuming a rebase? Is it better to check for each other
> option that it is not passed (i.e. no '-v', no '-s' etc.)?
>
> Might some users be depending on the current behavior, even though it
> is undocumented?

Yes.

I have no clue why, but my fingers are wired to do

	git rebase -i --continue

when resuming an interactive rebase.  So with v1.7.6, I use two commands
instead of one.

It's possible that I was crazy, and we should just mention this in the
release notes and move on.  Another possibility would be to make "git
rebase -i --continue" mean "check if in the middle of an interactive
rebase, and if so, continue".  Yet another possibility would be to
allow transforming a non-interactive rebase into an interactive one
after a conflict with that command (though I can't imagine why someone
would want to).  I'm tempted to say the first way (keeping the command
broken and documenting the change) is the way to go, since it means it
would be possible to make commands like this mean something else in
the future.

What do you think?

*searches*

Ah, it seems you already wrote a patch at [1].  The commit message
says it fails for "-i --continue" but I don't any code doing that;
what am I missing?

[1] http://thread.gmane.org/gmane.comp.version-control.git/164241/focus=166684
