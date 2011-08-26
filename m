From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/5] RFC: patterns for branch list
Date: Fri, 26 Aug 2011 10:30:41 +0200
Message-ID: <4E5759B1.50705@drmicha.warpmail.net>
References: <4E5607E0.1050300@drmicha.warpmail.net> <cover.1314259226.git.git@drmicha.warpmail.net> <20110825175301.GC519@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael Schubert <mschub@elegosoft.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 10:31:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwroZ-0000lx-AJ
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 10:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568Ab1HZIar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 04:30:47 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:35791 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753541Ab1HZIao (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2011 04:30:44 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BADC820CEA;
	Fri, 26 Aug 2011 04:30:43 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 26 Aug 2011 04:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=1hYQOFAASBVjyYzDdJfcT7
	ZqPv8=; b=CInXEPJBH5iv4QgFQT3wW71yfPCBXJZVnkgE3Zb1iPzH9t3v+PJfq+
	u2RTd3Y8es44ZI8pHuVLdi4i7lL1WkHBfuPVT98olPBmQHSTMsJovnf3s04r/nDa
	9S7X4aG1Q4eQGOMojWml6qIVe2SF5L8HG/eMt6uZeAH+0nPgfESAQ=
X-Sasl-enc: u9gTwFsSKSnUri/HnzYrOtN6Hdxc1KktmIxaTCduuuOl 1314347443
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 04982A20713;
	Fri, 26 Aug 2011 04:30:42 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <20110825175301.GC519@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180157>

Jeff King venit, vidit, dixit 25.08.2011 19:53:
> On Thu, Aug 25, 2011 at 10:30:16AM +0200, Michael J Gruber wrote:
> 
>> This mini series is about introducing patterns to the list mode of
>> 'git branch' much like the pattern for 'git tag -l'. There are several
>> related things which are to be considered for the ui design:
> 
>> [log vs tag vs branch]
> 
> I agree that the ideal UI change would be to move git-branch's "-l" to
> "-g", and make "-l|--list" work the same as it does for git-tag.
> 
> Even though branch is generally considered a porcelain, I worry a little
> about making that change. A script that wants to create a branch has no
> real choice other than to use "git branch" (OK, they can use
> "update-ref" themselves, but I seriously doubt that most scripts do so).
> However, I kind of doubt anyone actually uses "-l"; it is mostly
> pointless in the default config, so maybe it is safe.
> 
> Searching google code for "git.branch.*-l" turns up only one hit, and it
> is somebody who apparently thought that "-l" meant "list".

;)

Thanks for doing the search.

>> Analogous to "git tag", "branch" has several modes, one of which is list mode.
>> It is currently activated (and possibly modified) by "-v" and "-vv", and when
>> there are no arguments. So, at the least,
>>
>> git branch -v[v] <pattern>
>>
>> should match just like "git tag -l <pattern>" does. And that is what the first
>> patch in my series does.
> 
> The order of your patches seems backwards to me. You add
> pattern-matching for "-v", but there is no way to get pattern-matching
> for the non-verbose case. Shouldn't "--list" come first?
> 
> Maybe I am just nitpicking, as I think the end result after the series
> is the same. I just found the first patch very confusing.

It's an RFC series to revive the discussion about what to aim for.
Agreement about "--list" seems to be growing, so a natural first patch
would introduce that.

>> "git tag" should probably learn the same long option and others. And why not
>> verify tags given by a pattern?
> 
> Yeah, having them both do --list makes sense. Whether it is appropriate
> to glob for other operations, I don't know. I think you'd have to
> look at each operation individually.
> 
>> Both "tag" and "branch" could activate list mode automatically on an invalid
>> tag name rather than dieing:
>>
>> git tag v1.7.6\*
>> Warning: tag 'v1.7.6*' not found.
>> v1.7.6
>> v1.7.6-rc0
>> v1.7.6-rc1
>> v1.7.6-rc2
>> v1.7.6-rc3
>> v1.7.6.1
> 
> That just seems confusing to me. What is the exit status? Shouldn't the
> warning be "error: tag 'v1.7.6*' is not a valid tag name"?

Sure, and sorry, copied the wrong one. I'd just like to have the simple
way to say "git branch peff/\*" at least as long as we don't have "-l"
for "--list".

>> -v[v] sanity
>> ============
>>
>> '-v' and '-vv' both take considerable time (because they need to walk).
>> It makes more sense to have '-v' display cheap output (upstream name)
>> and '-vv' add expensive output (ahead/behind info). '-vvv' could add super
>> expensive info (ahead/equivalent/behind a la cherry-mark).
> 
> I think the original rationale was not so much "how much time does it
> take", but rather "how much space do you want each line to take on your
> terminal". For many people, the upstream name in "-vv" is just
> cluttering noise.

According to my experience, the ahead/behind computations take so much
time (in a git.git clone with my devel branches) that they render all
"-v" versions unusable, unless I use a restrictive pattern.

On the other hand, I have branches based on all of origin/{master,next}
and others, so having the upstream name is valuable.

Seems that I'm an outlier, though.

> Tag and branch listing are really just specialized versions of
> for-each-ref. I wonder if it makes sense to do:
> 
>   1. Teach for-each-ref formats replacement tokens for ahead/behind
>      counts.
> 
>   2. Let the user specify a for-each-ref format for tag and branch
>      listing output. Then the various levels of "-v" just become some
>      special format strings, and the user is free to ask for whatever
>      they want (or even have "branch.defaultListFormat" to get it
>      without typing over and over).

for-each-peff ;)

For a moment, the use of the walker in builtin/branch.c even tricked me
into thinking that it might not use for-each-ref at all. God forbid!

I actually like the format suggestion. Then we only need to discuss the
default format, which is hopefully less of a problem. But that is
something for later, I'll discard the -v[v[v]] patches for now. Have we
unified log formats and for-each-ref formats and parsers already, btw? I
recall some efforts.

Michael
