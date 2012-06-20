From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 1/8] Makefile: apply dependencies consistently to
 sparse/asm targets
Date: Wed, 20 Jun 2012 16:00:38 -0500
Message-ID: <20120620210038.GA6142@burratino>
References: <20120619232310.GA6496@sigill.intra.peff.net>
 <20120620035015.GA4213@burratino>
 <20120620042607.GA10414@sigill.intra.peff.net>
 <20120620102750.GB4579@burratino>
 <20120620163714.GB12856@sigill.intra.peff.net>
 <20120620182855.GA26948@sigill.intra.peff.net>
 <CAFzf2Xw3TdvZCFLvbqKY5F9b+0hTzTQEEfmqjL9u=uvyc7mZ5w@mail.gmail.com>
 <20120620193638.GA32418@sigill.intra.peff.net>
 <CAFzf2XwmZo4ErG_9w0m66k4OPtDr_4_xvATL_6sOo8QVg0DhJA@mail.gmail.com>
 <20120620195709.GB32228@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 23:01:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShS1E-0004sg-Te
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 23:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179Ab2FTVAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 17:00:49 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46309 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763Ab2FTVAs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 17:00:48 -0400
Received: by yenl2 with SMTP id l2so5648980yen.19
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 14:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GDGHAbgwAiLHvI3v4W1Hmy3rpah2NDGKLC6V74rgA08=;
        b=0DZ+LYUxZRJs3R0TbrOo0R5ctMftYU+qFkHr8hTXI84Oj5wpY+oBGzA8CRljOKCiM4
         u9LGRXCp1FY0BU9wt0Oxso8viQvjLsEyMI7XLOvjFdzfn/D7vZuLyVm0a4X1cAJthiz5
         WAG+iD1txLUDV6H5/c7FS/adX07I1BQ97Jk3Nde85Vszoe+eCFfwHQQc7nRrESrz1Cqg
         dSl/t4vZgPzRV/6WcH7F8YSZv8r8Szgi5nXJ2QijqTs/9qxsIxuq26osMXWiBBvN0Lpw
         ESO1gNYKxYU1LR6naq/m38BYz24bQtncMTo58xCRSWkYf+Z2LkVbEJtHhRVU9BXE9f98
         Y1jA==
Received: by 10.236.78.105 with SMTP id f69mr29021862yhe.15.1340226047866;
        Wed, 20 Jun 2012 14:00:47 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id g22sm98747068yhh.20.2012.06.20.14.00.46
        (version=SSLv3 cipher=OTHER);
        Wed, 20 Jun 2012 14:00:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120620195709.GB32228@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200361>

Jeff King wrote:

> I just assumed that people who are actively hacking on individual header
> files in git actually have a compiler that can do COMPUTE_HEADER_DEPENDENCIES.

That's probably true.  And it is presumably possible to implement
COMPUTE_HEADER_DEPENDENCIES for Solaris cc and MSVC, so people using
those compilers would just have an incentive to do that sooner.

So it's not all that bad.

> Maybe that is not the case. If it were such a big deal, then why is
> everything in LIB_H? Why don't people use these manual rules, or convert
> existing LIB_H entries to use them?

Once a header is included by cache.h (like most headers in LIB_H),
there is not much hope for avoiding recompilations when it changes.

> For people who are not actively hacking on header files in git, the
> arguments from that patch apply (namely that LIB_H is so gigantic that
> you are unlikely to hit a specific change where one of the few manual
> rules is triggered, but LIB_H is not).

Unless they are bisecting, it would not be so bad for such people to
effectively have to run "make clean" between compiles, as you've
hinted.  They are not the people it is possible to easily improve
build performance for.

>> On the other hand, if someone were proposing adding a simple awk
>> script to implement a "make dep" fallback, I would understand that.
>
> I'd be OK with that. Do you have one in mind, or do we need to write it
> from scratch? Surely somebody else has solved this problem before.

There are lots of "make dep" implementations out there, but it's hard
to care enough to choose between them. :)  No one who actually doesn't
use gcc has spoken up as caring.  So if we're really feeling the pain
of maintaining the detailed COMPUTE_HEADER_DEPENDENCIES=no fallback
dependencies, let's just say so and drop them like you've suggested.

Before I thought you were saying "nobody is going to notice".  And I'm
pretty sure that's not true.  What I missed before is that a different
statement holds, namely "sure, some people will notice, but they have
an easy way to move forward and the outcome would be much better than
the status quo".

Sorry to be so dense before.

Jonathan
