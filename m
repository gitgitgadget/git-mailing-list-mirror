From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: [PATCH 0/6] Bunch of new features for cg-log and cg-diff
Date: Thu, 09 Jun 2005 17:14:36 +0200
Message-ID: <42A85CDC.5060401@gmail.com>
References: <42A82211.9060305@gmail.com> <20050609142243.GA26524@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Jun 09 17:25:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgOh4-0001o6-BB
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 17:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVFIPPu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 11:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVFIPPu
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 11:15:50 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:63361 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261851AbVFIPPp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 11:15:45 -0400
Received: by zproxy.gmail.com with SMTP id 18so23740nzp
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 08:15:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=pGRvfYbn5JF4fAWjoNO5h1NLhfvo1L2cy7meYBJ7HcSleJ3WMQwimmsEFxb4f5kxwwSPCqZEWIn9VTU9H29IuJy1QL2GzZvzccxchH6dO6WMYYplFddnKQR218JiXhgHIeeO+9Q3BD7jDcE2L/nNlDVJDem07Puc9dfuHzZabW0=
Received: by 10.36.39.19 with SMTP id m19mr466650nzm;
        Thu, 09 Jun 2005 08:15:39 -0700 (PDT)
Received: from ?192.168.0.4? ([80.217.52.214])
        by mx.gmail.com with ESMTP id 6sm1004608nzn.2005.06.09.08.14.52;
        Thu, 09 Jun 2005 08:15:39 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20050609142243.GA26524@diku.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jonas Fonseca wrote:
> I tried out your patchset and have a few comments ...
> 
> cg-diff:
> 
>  - The pager is only used when passing -c. Is that intentional?

Yes. The reasoning was that people wanting more features probably will 
use color as well (and I didn't want to force the pager on people who 
use cg-diff just to check *if* something changed).

But I'm not 100% convinced I'm doing the right thing. Any suggestions?

> cg-log:
> 
>  - In the non-verbose summary you use the author date. One motivation
>    for using the commit date is that the summary output makes it easy to
>    track 'activity' and see if/when your patch made it in. Maybe I've
>    just become too used to CVS changelogs.

Yeah, maybe :-) Seriously, I think author date carries more information, 
particularly since the log is already (most of the time) ordered by 
commit date. So, when you see an old date before a newer one, you 
immediately know that some old stuff was incorporated into the repository.

Also, git-rev-list --pretty uses author date, and I wanted to be consistent.

Of course, I could always add one more option :-)

>  - Even though the more dense time format in the summary output is a
>    nice idea the new date information is unfortunately also makes the
>    summary output less useful, IMO. It can even make the by-date
>    scanning harder because you have to jump between two significantly
>    different date formats. With the new verbose distinction there should
>    be no need for making the date so dense.

This is also a matter of taste, obviously. I actually *like* having two 
different formats, as it makes the difference between "today" and 
"earlier" more obvious. And I don't really care what time of day 
something was written three weeks ago.

Perhaps this should be customisable as well, if it's felt to be 
important enough?

> I don't much like the inverted colors caused by the searching. Although
> the quick goto next entry thing is nice the colors can be very
> intrusive, and having to search for some nonsense string to remove them
> is terrible.

"export LESS=-G" will do what you want. Maybe that should be the default?

> What about a COGITO_COLORS environment variable for configuring what
> string setup_colors() will work on. It could maybe take the place of the
> COGITO_AUTO_COLOR environment variable although this is two different
> things.

That should already be there. "COGITO_COLORS='header=31' cg-log" should 
give very red headers, for example.

> With the long help output of cg-log maybe we should consider also
> displaying it in a pager.

Good idea.

> A minor note about the option parsing. cg-log -sh will give the error
> 
> 	cg-log: unrecoginized option `-h'
> 

Yeah, I know. "-h" and "--help" are the only options not handled by 
optparse in cg-log. I thought I could rely on the general help-finding 
logic in cg-Xlib for that.

On the other hand, you really shouldn't say "cg-log -sh" :-)

/dan
