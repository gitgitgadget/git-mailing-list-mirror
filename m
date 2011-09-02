From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 2/2] remote: "rename o foo" should not rename ref
 "origin/bar"
Date: Thu, 1 Sep 2011 20:35:01 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1109012022110.7267@debian>
References: <1314841843-19868-1-git-send-email-martin.von.zweigbergk@gmail.com> <1314841843-19868-2-git-send-email-martin.von.zweigbergk@gmail.com> <20110901024617.GD31838@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 02 02:35:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzHj0-0001oa-Ks
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 02:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932757Ab1IBAfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 20:35:09 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55635 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932659Ab1IBAfH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 20:35:07 -0400
Received: by vxi9 with SMTP id 9so1727139vxi.19
        for <git@vger.kernel.org>; Thu, 01 Sep 2011 17:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=jmXy1jH+l4OynDCU3xMLoC4Ep9HjpIm3ZPgxNWmHIy4=;
        b=kbJjpMr1kG0zcToxC2DtEvO8pnjcBp8m7KAsvkUHzG0+euhO7xVz+gCD3pbXRd8Dn/
         HUNohmQQbh5dHDuxLtkGfo9ek43N4Bh3apx7PqzHSif2HYXC4cxqvfHbGzB94zOz0NSx
         eNYiSaAjmA7CaRW4opQ0AJ0jwhjb5HI0RTx5E=
Received: by 10.220.115.19 with SMTP id g19mr129207vcq.45.1314923706940;
        Thu, 01 Sep 2011 17:35:06 -0700 (PDT)
Received: from [192.168.1.102] (modemcable094.77-37-24.mc.videotron.ca [24.37.77.94])
        by mx.google.com with ESMTPS id bd20sm508792vdc.8.2011.09.01.17.35.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Sep 2011 17:35:06 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <20110901024617.GD31838@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180587>


On Wed, 31 Aug 2011, Jeff King wrote:

> On Wed, Aug 31, 2011 at 09:50:43PM -0400, Martin von Zweigbergk wrote:
> 
> > When renaming a remote called 'o' using 'git remote rename o foo', git
> > should also rename any remote-tracking branches for the remote. This
> > does happen, but any remote-tracking branches starting with
> > 'refs/remotes/o', such as 'refs/remotes/origin/bar', will also be
> > renamed (to 'refs/remotes/foorigin/bar' in this case).
> 
> To be totally correct, shouldn't this check each ref against the RHS of
> the remote's old refspec, and rename it according to the remote's new
> refspec?

That's what I thought too, but was planning on leaving it for a
separate patch. However, after changing patch 1 to only update the
fetch refspecs from "refs/remotes/$OLD" to "refs/remotes/$NEW", there
is no other place in the fetchspec where a remote name can occur and
'git remote rename' still understands it. So since we're now being
more conservative about updating refspecs, I guess we need to be
equally conservative about updating ref names.


Martin
