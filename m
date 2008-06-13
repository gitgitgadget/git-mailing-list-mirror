From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 10:56:56 +0200
Message-ID: <bd6139dc0806130156o747fc128hbe28440ed4d228d4@mail.gmail.com>
References: <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil>
	 <alpine.DEB.1.00.0806112242370.1783@racer>
	 <20080611230344.GD19474@sigill.intra.peff.net>
	 <alpine.LFD.1.10.0806111918300.23110@xanadu.home>
	 <loom.20080612T042942-698@post.gmane.org>
	 <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com>
	 <4851F6F4.8000503@op5.se>
	 <20080613055800.GA26768@sigill.intra.peff.net>
	 <48521EDA.5040802@op5.se> <20080613074257.GA513@sigill.intra.peff.net>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Wincent Colaiuta" <win@wincent.com>,
	"Eric Raible" <raible@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 10:58:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K756Y-0001xs-6c
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 10:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495AbYFMI5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 04:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754742AbYFMI5A
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 04:57:00 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:47634 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754438AbYFMI47 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 04:56:59 -0400
Received: by wf-out-1314.google.com with SMTP id 27so4022331wfd.4
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 01:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yfiI7kWYU911bz/GyCFxlne7CuZcBQGiEn4Kr+5UYoo=;
        b=cKMG6blJ9sApGi2t3vrthqD42XxgH22TjK9EEWCvD0Dxwgc9kd8+/g96MMR0AKEj5b
         nNlZncLfZxSypSaQv5Hi+9+gPa7dhmAnKl4bbt7LvvzJLVMjTGB/3FZy8ltKhX6dOtmh
         T9kNM0DtIfyTSuX+H3a2S7zUWbrDoVnKjFQTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=Ud6QMdUKS2jhkwPHRWXqN4qSNnFItbacgIySR9Svj3MF/IXjpEUxZCnK2sg0V4Szv7
         LZBFz+DaF3oOGckPtRcEH3mqlFer4mBlaqJTgr+LO5lluwiz+wB5wo/QoSqMoFyZwmmz
         Hc3SuOJIfDc/qmnYzor6WNqS6AS5WkoFhLB0k=
Received: by 10.142.214.5 with SMTP id m5mr960861wfg.229.1213347417207;
        Fri, 13 Jun 2008 01:56:57 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Fri, 13 Jun 2008 01:56:56 -0700 (PDT)
In-Reply-To: <20080613074257.GA513@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84852>

On Fri, Jun 13, 2008 at 9:42 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Jun 13, 2008 at 09:16:42AM +0200, Andreas Ericsson wrote:
>> To me, long-living stashes are useful because I can all of a sudden be
>> pulled away from something I'm working on and set to work on something
>> entirely different for up to 6 months (so far we haven't had a single
>> emergency project run longer than that). It doesn't happen a lot, but
>> it *does* happen.
>
> So of course my first question is "then why didn't you use a branch?" :)

Because nobody / not everybody has perfect foresight, sometimes you
don't know in advance that what you thought was going to be a
temporary stash will turn into a long lived stash. What you are saying
is that really you should always create a branch, just in case your
temporary stash proved to be more long-lived than thought?


-- 
Cheers,

Sverre Rabbelier
