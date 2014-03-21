From: Jeff King <peff@peff.net>
Subject: Re: [RFC] [GSoC] Draft of Proposal for GSoC
Date: Fri, 21 Mar 2014 14:07:45 -0400
Message-ID: <20140321180745.GB15508@sigill.intra.peff.net>
References: <CAM+=D-BWCt9kNSUUQ19ZcPykb6j-tuEr=igBz0ukEk2TA3vWkg@mail.gmail.com>
 <20140321054208.GA31737@sigill.intra.peff.net>
 <CAM+=D-ATimdXmcYpqSyKwZXE=TYXg9cZFG9kyjEOg22K1wF+3Q@mail.gmail.com>
 <xmqq8us3v42o.fsf@gitster.dls.corp.google.com>
 <CAM+=D-D=PW=ZJFvc0y+Zhs8tPcbXnP-q4w-MeeLwT+t-QD_55w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Brian Bourn <ba.bourn@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 19:08:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR3rK-0002RK-Te
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 19:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbaCUSHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 14:07:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:44210 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750785AbaCUSHr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 14:07:47 -0400
Received: (qmail 24453 invoked by uid 102); 21 Mar 2014 18:07:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Mar 2014 13:07:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Mar 2014 14:07:45 -0400
Content-Disposition: inline
In-Reply-To: <CAM+=D-D=PW=ZJFvc0y+Zhs8tPcbXnP-q4w-MeeLwT+t-QD_55w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244715>

On Fri, Mar 21, 2014 at 02:03:41PM -0400, Brian Bourn wrote:

> > What do they do, what does the caller expect to see (do they get
> > something as return values?  do they expect some side effects?)?
> 
> so something like this would be better I'm assuming?
> 
> Some basic sample API calls are found below, each of these would hold
> code to complete parsing and/or formatting the flags.
> Add_Opt_Group() - returns an OPT_CALLBACK with contains, merged,
> no-merged, or formatting which can be used in a commands options list.
> 
> Execute_list()-the main call into the library and would pass into the
> library all of the necessary flags and arguments for parsing the
> request and executing it. This would accept the flags like
> -contain, with arguments such as the commit or pattern that is being
> searched for.
> 
> The next four commands would be called by execute_list() to execute
> the original command with respect to the flags that are passed into
> this library.
> Parse_with_contains()
> Parse_with_merged()
> Parse_with_no_merged()
> Parse_with_formatting()

Think about how the callers would use them. Will git-branch just call
Parse_with_contains? If so, where would that call go? What arguments
would it take, and what would it do?

I don't think those calls are enough. We probably need:

  1. Some structure to represent a "list of refs" and store its
     intermediate state.

  2. Some mechanism for telling that structure about the various
     filters, sorters, and formatters we want to use (and this needs to
     be hooked into the option-parsing somehow).

  3. Some mechanism for getting the listed refs out of that structure,
     formatting them, etc.

-Peff
