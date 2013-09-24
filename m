From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] build: add default aliases
Date: Tue, 24 Sep 2013 11:39:58 -0700
Message-ID: <20130924183958.GK9464@google.com>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
 <20130924045325.GD2766@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 24 20:40:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOXWr-0001Hw-IB
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 20:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754286Ab3IXSkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 14:40:03 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:60637 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab3IXSkC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 14:40:02 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so4068914pab.18
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 11:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Cd7dZHL2LuNgDVfjoNLKAMJcusFadIfFG2SO+mv/m/w=;
        b=xGLUfBMQpng+jZ06yFpcILctwx3+f+HTUUMDpdFyz/lzS8uUsuCtua9X3Sbm4l8P5f
         Ci3hpuXQ3uLCghGeizheV4fXr4S5JiwL2qxiJXVuhT0UxkU1lDZsuqwyBiIX2yFhfPFh
         2JWOhXHk6+Y0Bicq3kLHCSJmj7qzbVW4fgiQSTm1kpjumW9GwMEWFyH/Y/SCZ1q9c8rN
         fsAdQZ7RLjl543dE6sNEOwD9CWwJqd+C9B5S1nGcABZ+/Ae2hRqzfXEA1ZBqXycHdUXC
         wI8OlN5KsX9Qc2oCBobi9Q3I2P2IcS5Mzuk4+RF+WVC8ttDW3j4I84LPYkXZHdXitBmc
         pHYQ==
X-Received: by 10.68.117.49 with SMTP id kb17mr13739913pbb.112.1380048002135;
        Tue, 24 Sep 2013 11:40:02 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id pu5sm47427074pac.21.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 24 Sep 2013 11:40:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130924045325.GD2766@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235307>

Jeff King wrote:
> On Sat, Sep 21, 2013 at 02:20:21PM -0500, Felipe Contreras wrote:

>> For now simply add a few common aliases.
>>
>>   co = checkout
>>   ci = commit
>>   rb = rebase
>>   st = status
>
> Are these the best definitions of those shortcuts? It seems[1] that some
> people define "ci" as "commit -a", and some people define "st" as
> "status -s" or even "status -sb".

I feel bad about having waited for 4 rounds of this patch to say this,
but the basic change (providing "co", "ci", etc. as aliases by
default) does not look well thought through.

It would be a different story if this were a patch to update
documentation to suggest adding such aliases at the same time as
telling Git what your name is.  The user manual doesn't explain how to
set up aliases at all yet, and that should be fixed.

But making 'ci' a synonym of another command by default while still
keeping its definition configurable would be doing people a
disservice, I fear.  As long as 'ci' works out of the box, it will
start showing up in examples and used in suggestions over IRC, etc,
which is great.  Unfortunately that means that anyone who has 'ci'
defined to mean something different can no longer use those examples,
that advice from IRC, and so on.  So in the world where 'ci' is a
synonym for 'commit' by default, while people still *can* redefine
'ci' to include whatever options they like (e.g., "-a"), actually
carrying out such a personal customization is asking for trouble.

Incidentally, that is also the reason git already doesn't allow
aliases to override built-in commands such as "git commit", even
though it would be convenient to some to not have to remember to add
"-a" each time.  As consolation we have been able to say "But you can
take the even shorter-and-sweeter 'git ci' and make it mean whatever
you want".  Now we should take that avenue away for people?

Bad idea.

Hope that helps,
Jonathan
