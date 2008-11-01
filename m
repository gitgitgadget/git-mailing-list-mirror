From: Andreas Ericsson <ae@op5.se>
Subject: Re: libgit2 - a true git library
Date: Sat, 01 Nov 2008 19:44:12 +0100
Message-ID: <490CA37C.1070107@op5.se>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <20081031184154.GV14786@spearce.org> <20081101173042.GE26229@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 19:45:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwLTi-0002SF-6S
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 19:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbYKASo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 14:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbYKASo3
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 14:44:29 -0400
Received: from mail.op5.se ([193.201.96.20]:48127 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752041AbYKASo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 14:44:28 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 3F5AF1B800A4;
	Sat,  1 Nov 2008 19:39:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d0TwrmGpK-+K; Sat,  1 Nov 2008 19:39:06 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id EF0361B80066;
	Sat,  1 Nov 2008 19:39:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081101173042.GE26229@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99758>

Pierre Habouzit wrote:
> On Fri, Oct 31, 2008 at 06:41:54PM +0000, Shawn O. Pearce wrote:
>> How about this?
>>
>> http://www.spearce.org/projects/scm/libgit2/apidocs/CONVENTIONS
> 
> FWIW I've read what you say about types, while this is good design to
> make things abstract, accessors are slower _and_ disallow many
> optimizations as it's a function call and that it may clobber all your
> pointers values.
> 

Accessors are very nifty for one thing though; With a debugging flag,
you can use an accessor-function, while without that debugging flag you
can use a macro instead of a function. In other words, you use the
compiler as a sort of sanity-checker that you're only accessing the
variables through the proper macros.

This method introduces a bit of extra code (50% of which is always
dead) for each struct it's used on, but it makes debugging large-ish
pieces of software relatively simple, since access to all object types
is controlled through the use of macros.

> For types that _will_ be in the tight loops, we must make the types
> explicit or it'll bite us hard performance-wise. I'm thinking what is
> "struct object" or "struct commit" in git.git. It's likely that we will
> loose a *lot* of those types are opaque.
> 

The last sentence doesn't parse. I assume you mean "if those types are..",
in which case it'll be solved by using accessor-macros and forward-declaring
the structs.

> struct object in git has not changed since 2006.06. struct commit hasn't
> since 2005.04 if you ignore { unsigned int indegree; void *util; } that
> if I'm correct are annotations, and is a problem we (I think) have to
> address differently anyways (I gave my proposal on this, I'm eager to
> hear about what other think on the subject). So if in git.git that _is_
> a moving target we have had a 2 year old implementation for those types,
> it's that they're pretty well like this.
> 
> It's IMNSHO on the matter that core structures of git _will_ have to be
> made explicit. I'm thinking objects and their "subtypes" (commits,
> trees, blobs). Maybe a couple of things on the same vein.
> 

I agree. "git_commit", "git_tree", "git_blob" and "git_tag" can almost
certainly be set in stone straight away.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
