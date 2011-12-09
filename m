From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 9/9] revert: simplify communicating command-line arguments
Date: Fri, 9 Dec 2011 15:09:28 -0600
Message-ID: <20111209210928.GO20913@elie.hsd1.il.comcast.net>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
 <1323445326-24637-10-git-send-email-artagnon@gmail.com>
 <20111209190236.GA20913@elie.hsd1.il.comcast.net>
 <CALkWK0m_6yGuyLt-VqvRZkAiDoSxES8KeNzeXaejYRCpW=HAOg@mail.gmail.com>
 <20111209192919.GB20913@elie.hsd1.il.comcast.net>
 <CALkWK0m2veE8FmFVTPEqNAmbtvm1sWVHtFt0QOWU=huQFafeBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 22:09:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ7hK-00012v-DT
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 22:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938Ab1LIVJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 16:09:33 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41504 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab1LIVJd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 16:09:33 -0500
Received: by ggnr5 with SMTP id r5so3752395ggn.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 13:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FQlBL5zV4xVFf67P3MXw9BSskC5hLai+PwkyWwpXGSA=;
        b=Wc3Exvz4S+kCZzCT2+HJt83IpZE0lHuFLtUfCEv0wEqm4NxlRKLBzFmDmUlzTIbUc5
         RW/zM33w6Plj52+EHS2WfZ6lP4vjA9h+Mt4KCkP1xztrkGmExiRfotw7JqSOG3ktNmg6
         rhm/PzxvVuKepFSqPTnc/G5vIXQgWbWDYuutY=
Received: by 10.101.3.9 with SMTP id f9mr2361226ani.54.1323464972708;
        Fri, 09 Dec 2011 13:09:32 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id f17sm27099773ang.20.2011.12.09.13.09.31
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 13:09:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0m2veE8FmFVTPEqNAmbtvm1sWVHtFt0QOWU=huQFafeBw@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186696>

Ramkumar Ramachandra wrote:

>                                                                a
> positive exit status can be interpreted as a conflict, but this is
> clearly not the case here.  How do we fix this problem?  By creating
> an API for "git commit", not by shelling out like this and letting it
> take over the exit status.

That might be a nice thing to do anyway, but I don't see how it would
solve anything.  The new "git commit" API would presumably return an
integer or enum value to indicate the result of trying to commit.
Tests in the testsuite for the "git commit" API would use the "git
commit" command, which would expose the newly fine-grained values
somehow.  And other people scripting but wanting the porcelain to take
care of basic UI would benefit, too.  Right?

Actually, I think cherry-pick returning a positive exit status for
"nothing left to commit after resolving conflicts" would be sensible.
It is "I did what you asked but need your help to determine the final
content of the commit or decide to skip it", rather than "you asked
for something unsensible and I am bailing out".
