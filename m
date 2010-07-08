From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Why is "git tag --contains" so slow?
Date: Thu, 08 Jul 2010 04:12:36 -0700 (PDT)
Message-ID: <m37hl6mdnb.fsf@localhost.localdomain>
References: <20100701121711.GF1333@thunk.org>
	<20100701150331.GA12851@sigill.intra.peff.net>
	<20100701153842.GA15466@sigill.intra.peff.net>
	<20100702192612.GM1333@thunk.org>
	<20100703080618.GA10483@sigill.intra.peff.net>
	<20100704005543.GB6384@thunk.org>
	<20100705122723.GB21146@sigill.intra.peff.net>
	<20100705141012.GA25518@thunk.org>
	<20100706115826.GA15413@sigill.intra.peff.net>
	<1278430303.32094.15.camel@wpalmer.simply-domain>
	<20100707174546.GA4979@coredump.intra.peff.net>
	<11D5771D-EB47-42E9-BCC3-69C8FE1999EC@MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Will Palmer <wmpalmer@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Thu Jul 08 13:12:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWp25-0005e5-3J
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 13:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113Ab0GHLMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 07:12:39 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58265 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725Ab0GHLMi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 07:12:38 -0400
Received: by bwz1 with SMTP id 1so356014bwz.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 04:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=KbL+SMjAF39v5s8BpTWrkxa511BpvtgW6JrtK0TZRmE=;
        b=aevD738WmGKvI8wPfXSjCiXq9RQ7b08jHsWZKUycbivdwwPGBDdVyPuTn6aIKpl+3D
         N/6WgK4paKTnkzkiRb+cDRSAgss+HLUz9mxVw7FpIRpnhhzvn4D/mopBOx7sCQRVDDWR
         TAMxvLU5MuBtjxborfjAOB2wdksO8gCA3R1lE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=KuAasuFLpRaA8PFQaR1RNWNevcEe+H+7JyEkNjUD3kdA24ZOAjghlIYjh+nFwILYZh
         TQYbK9cvCBqiekXUzc9ghURHn6GefzkIuAW3i5w+Y0AJ1MGfO4egPnUW3QiweQNIz0tX
         vPX93nr5xw4c0ZpR0wi7Lw8wI4V27bFB3Qv9k=
Received: by 10.204.46.23 with SMTP id h23mr6074557bkf.75.1278587556951;
        Thu, 08 Jul 2010 04:12:36 -0700 (PDT)
Received: from localhost.localdomain (abvu212.neoplus.adsl.tpnet.pl [83.8.218.212])
        by mx.google.com with ESMTPS id s17sm29506283bkx.6.2010.07.08.04.12.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 04:12:36 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o68BBw1s011784;
	Thu, 8 Jul 2010 13:12:09 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o68BBb67011780;
	Thu, 8 Jul 2010 13:11:37 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <11D5771D-EB47-42E9-BCC3-69C8FE1999EC@MIT.EDU>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150560>

Theodore Tso <tytso@MIT.EDU> writes:
> On Jul 7, 2010, at 1:45 PM, Jeff King wrote:
> 
> >     And of course it's just complex, and I tend to shy away from
> >     complexity when I can. The question to me comes back to (1) above.
> >     Is massive clock skew a breakage that should produce a few
> >     incorrect results, or is it something we should always handle?
> 
> Going back to the question that kicked off this thread, I wonder if there
> is some way that cacheing could be used to speed up the all cases,
> or at lest the edge cases, without imposing as much latency as tracking
> the max skew?   i.e., some thing like gitk's gitk.cache file.  For bonus
> points, it could be a cache file that is used by both gitk and git tag
> --contains, git branch --contains, and git name-rev.
> 
> Does that sound like reasonable idea?

By the way, what had happened to the rev-cache project from GSoC 2009?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
