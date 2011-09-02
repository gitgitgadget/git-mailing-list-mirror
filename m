From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 1/2] remote: write correct fetch spec when renaming remote
 'remote'
Date: Thu, 1 Sep 2011 20:02:53 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1109011945560.7066@debian>
References: <1314841843-19868-1-git-send-email-martin.von.zweigbergk@gmail.com> <20110901024211.GC31838@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 02 02:03:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzHDv-0000hm-JU
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 02:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932745Ab1IBADA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 20:03:00 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:36803 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932742Ab1IBAC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 20:02:59 -0400
Received: by vxi9 with SMTP id 9so1712088vxi.19
        for <git@vger.kernel.org>; Thu, 01 Sep 2011 17:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=nFkmPnd/WUrMjANynnvgIq4q4+edhSj8PFY6E+9rylE=;
        b=AE39dcT4UVRXxQftn7PZ4yrVLgz+wEZC722m85vkFS2P/k6+OcGFrZylplpUJ2STUj
         oG9mK1aemLl8XTE9R+olV89XNW5CrFGZuK7aAuKMWfQgguBSiltewtJwgwBDx2ijss3c
         QT+X1pWOCEngA6acmCMItDrOXF7R6Wdtms6Gs=
Received: by 10.52.112.201 with SMTP id is9mr441006vdb.379.1314921778370;
        Thu, 01 Sep 2011 17:02:58 -0700 (PDT)
Received: from [192.168.1.102] (modemcable094.77-37-24.mc.videotron.ca [24.37.77.94])
        by mx.google.com with ESMTPS id bi11sm458033vdb.13.2011.09.01.17.02.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Sep 2011 17:02:57 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <20110901024211.GC31838@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180586>


On Wed, 31 Aug 2011, Jeff King wrote:

> On Wed, Aug 31, 2011 at 09:50:42PM -0400, Martin von Zweigbergk wrote:
> 
> > Reduce the risk of changing incorrect sections of the refspec by
> > requiring the string to be matched to have leading and trailing
> > slashes, i.e. match "/<name>/" instead of just "<name>".
> 
> Doesn't this just mean that:
> 
>   git remote rename remotes foo
> 
> will break in the same way?

Yes, "r", "ead" and such now work and only exactly "refs", "heads" and
"remotes" don't work. Sorry, forgot to mention that in the commit
message.

> > We could have required even a leading ":refs/remotes/", but that would
> > mean that we would limit the types of refspecs we could help the user
> > update.
> 
> Actually, I think it's better to be more conservative [...]

I think you are right. That's what I did (match all the way from
"refs/...") at first, but then I thought that maybe the reason the
matching was relaxed was to allow non-default refspecs. However, as
you point out in the footnote to your reply to PATCH 2/2, that case is
not working consistently anyway, so it seems safe (w.r.t. backwards
compatibility too) to ignore it. Will switch back to matching
":refs/remotes/$OLD".


Martin
