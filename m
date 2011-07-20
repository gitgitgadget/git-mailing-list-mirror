From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] t9159-*.sh: Don't use the svn '@<rev>' syntax
Date: Wed, 20 Jul 2011 11:07:02 +0200
Message-ID: <4E269AB6.8070207@drmicha.warpmail.net>
References: <4E21D295.7020600@ramsay1.demon.co.uk> <7vvcuy82kn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: sam@vilian.net, Eric Wong <normalperson@yhbt.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 20 11:07:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjSkL-00087C-FH
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 11:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269Ab1GTJHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 05:07:06 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:38301 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750936Ab1GTJHF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2011 05:07:05 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E914D20385;
	Wed, 20 Jul 2011 05:07:04 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 20 Jul 2011 05:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=hpGvWKS52AlRL5JcPVrbXW
	d+eRM=; b=RbBVJtIr/JwHmmC8KmvBM30KhvRxWVB9C+jZOV3mO62ymbE3rpIMpC
	kd+29TiP38PQKycHizdOkfWSo9k+/VB8XgG9gJ9emTEMOnBPpxF7e2Mi79fQbk9u
	XyfGLlss0VwWTBLd37ZMdWNJVFBMNQ5NxpVj3EoRPHJbCWugDwh44=
X-Sasl-enc: qa88PZyFeUGtKVlM0CD111KQGvvmxz1nQwBHCLg+dH3h 1311152824
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EC42B451E5F;
	Wed, 20 Jul 2011 05:07:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
In-Reply-To: <7vvcuy82kn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177528>

Junio C Hamano venit, vidit, dixit 19.07.2011 21:58:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> Avoiding the use of the '@<rev>' syntax, in favour of an '-r <rev>'
>> parameter, allows older versions of svn to execute the test.
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> ---
>>
>> Hi Junio,
>>
>> This test is failing for me on Linux and MinGW (I don't have svn
>> installed on cygwin), again (i suspect) due to the older versions
>> of svn I have. [v1.4.3 on Linux and v1.4.6 on MinGW]
>>
>> This patch fixes the test for me. However, I noticed that there are
>> two other uses of the syntax in t9104-git-svn-follow-parent.sh which
>> look like this:
>>
>>         (svn_cmd cp -m "resurrecting trunk as junk" \
>>                "$svnrepo"/trunk@2 "$svnrepo"/junk ||
>>          svn cp -m "resurrecting trunk as junk" \
>>                -r2 "$svnrepo"/trunk "$svnrepo"/junk) &&
>>
>> which, unless I'm confused (possible), has been coded specifically
>> to cater to just this problem!
>> However, I think the above is a little too "belt & braces" for my
>> liking. What do you think?
> 
> Hmm, but I am actually having trouble understanding what ffab626 (git-svn:
> handle changed svn command-line syntax, 2007-09-21) wanted to do.  It
> says:
> 
>     git-svn: handle changed svn command-line syntax
>     
>     Previously, if you passed a revision and a path to svn cp, it meant to look
>     back at that revision and select that path.  New behaviour is to get the
>     path then go back to the revision (like other commands that accept @REV
>     or -rREV do).  The more consistent syntax is not supported by the old
>     tools, so we have to try both in turn.
>     
>     Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
>     Acked-by: Eric Wong <normalperson@yhbt.net>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> The explanation is not making sense at all. "Go back at the revision and
> pick that path" vs "Pick the path and go back to the revision" would
> change behaviour if the path was renamed since the revision, but it is not
> like that the issue ffab626 wanted to fix was make sure which semantics is
> used by using the right syntax that uses that semantics, so why did it
> bring it up in the first place?  The first three lines and half might be
> stating the fact, but it seems utterly irrelevant to what the commit does.
> 
> I am guessing that the "more consistent syntax" in the above is trying to
> say that the author wants to see "path@REV" used as much as possible
> instead of using "-rREV". But why use path@REV if newer subversion does
> not drop support for the path@REV syntax?
> 
> Or is it "path@REV picks path and then goes to the REV, vs -rREV path goes
> to REV and picks path"? If that is the case, then "we try both in turn"
> needs a lot more explanation. If a newer subversion with path@REV support
> that follows the "file identity" of path can be used, it copies from what
> is now called "trunk" as it used to be at rev2, while an older subversion
> without it cannot do so and copies from "trunk" that was at rev2. These
> two may give vastly different results if "trunk" was renamed in between,
> no? And if there was no such rename of "trunk" that affects what would
> happen, then there is _no_ point in writing "path@REV || -rREV path" in
> the first place---we know we can always use "-rREV path" without worrying
> about what version of subversion is being used.
> 
> I am confused. Sam/Eric, care to help clarify the situation?

path@REV are so-called peg revisions, introduced in svn 1.1, and denote
"I mean the file named path in REV" (as opposed to "the file named path
now and maybe differently back then"). It (now) defaults to BASE (for
worktree) resp. HEAD (for URLs). A bit like our rename detection.

-r REV specifies the operative revision. After resolving the
name/location using the pegrev, the version at the resolved path at the
oprative version is operated on.

svn 1.5.0 (June 2008) introduced peg revisions to "svn copy", so I
assume our people were following svn trunk and adjusting in 2007 already
(to r22964). There were some fixes to "svn copy" with peg later on.

I do not understand the above commit message at all; and I did not find
anything about how "svn copy -r REV" acted in svn 1.4. I would assume
"operative revision", and the above commit message seems to imply that
peg defaulted to REV here (not HEAD) and that that changed in 1.5.0, but
that is a wild guess (svnbook 1.4 does not so anything).

> I also recall that svn:mergeinfo support is relatively new; is it even
> supported in a old version that did not understand trunk@1 syntax?

While that is true, the said test sets the svn:mergeinfo property and
commits it (which you can do with any svn that knows properties), and
then tests whether our own "git svn init -s && git svn fetch" can grok
that, which only needs a property-reading svn (-binding). So, this does
not need subversion's merge support at all.

Cheers,
Michael
