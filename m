From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/6] revert: don't let revert continue a cherry-pick
Date: Sun, 8 Jan 2012 13:37:49 -0600
Message-ID: <20120108193749.GH1942@burratino>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326025653-11922-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 20:32:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjyU3-0000xr-Jk
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 20:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044Ab2AHTcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 14:32:42 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59578 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212Ab2AHTcm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 14:32:42 -0500
Received: by iaeh11 with SMTP id h11so5655152iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 11:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TOlXaMJAZUYSk6uUL0y1tIj1zFFwfVBL6mAtqXUg/14=;
        b=HLcbINHjX5a+aDGgJarRiNQfU9RpioVl5TvWUxkxdlDBH365nGu2UyTpnneIBFhUYR
         AIFG6XB0BVILeY79HwCPp9rRFG6EN1CEmh7fzYlCpLyjMRAXJXv3IvgfHCMXAjGkrcfu
         8nilxwHpFnQ1+NIf8FUYLPAjilOo/gqD2zDmM=
Received: by 10.50.214.42 with SMTP id nx10mr16285153igc.0.1326051161703;
        Sun, 08 Jan 2012 11:32:41 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id i2sm11525239igq.6.2012.01.08.11.32.41
        (version=SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 11:32:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1326025653-11922-4-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188118>

Ramkumar Ramachandra wrote:

> When we allow mixing "revert" and "pick" instructions in the same
> sheet in the next patch, the following workflow would be perfectly
> valid:
>
>   $ git cherry-pick base..latercommit
>   [conflict occurs]
>   $ edit problematicfile
>   $ git add problematicfile
>   $ git revert --continue
>   [finishes successfully]

Does "workflow" mean "sequence of commands"?

> This is confusing to the operator, because the sequencer is an
> implementation detail hidden behind the 'git cherry-pick' and 'git
> revert' builtins.

I don't know --- it's not confusing to me.  Could you explain further
what harm the current behavior does?  E.g., could it cause me to
misunderstand some basic concepts, or could it lead me to run commands
that cause me to scratch my head or lose data?

>  builtin/revert.c                |   57 +++++++++++++++++++++++++++++++++++++++
>  sequencer.h                     |    1 +
>  t/t3510-cherry-pick-sequence.sh |   11 +++++++
>  3 files changed, 69 insertions(+), 0 deletions(-)

I haven't read the patch, but based on the above rationale and this
diffstat, it doesn't look good.
