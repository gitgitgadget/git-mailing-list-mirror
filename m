From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: suggestion: git status = restored
Date: Tue, 29 Mar 2011 12:32:13 -0500
Message-ID: <4D92179D.6050102@gmail.com>
References: <imil67$oec$1@dough.gmane.org> <20110329145818.GC10771@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 29 19:32:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4cmG-0004te-M9
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 19:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860Ab1C2RcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 13:32:20 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62660 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279Ab1C2RcT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 13:32:19 -0400
Received: by gyd10 with SMTP id 10so170746gyd.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=iXF+jVE+YdVy9fgD/BA12zrQ6pZ8v3scGG0PrIqO+Oc=;
        b=XgOeeK9viJIM0Ee15/Li9/OKIL3dydxW+IRrM2ZK+ARqJsE/FyDGb/CKhrzmV64AL5
         FfLu6t8Cokm/hsW4zfFz4wVWNQQpz3l0Mw6B8SQuP+LPYzeqkjQW/MY0yNfwTFBWEvbD
         q3ouZe/IAWtaEj8RUSz4HmDNCWJWzfFvNB+wc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=pLuPYRB2DB2q9fVQAvU16GctbNWej+Zm3HIkpj3Al9HTHsoIUtRN8f6gQwQwzPMAQE
         /t5fJV7hGuNDtuj3w/C1J09SLtKGXLySHl75GshGYrJmgT42Sg+ITKMgYZPqSvPGw/WF
         YI+QG5DqYFyAQqGsq8j7nWx/m+3L5uEZSTYDE=
Received: by 10.90.145.13 with SMTP id s13mr396065agd.90.1301419938350;
        Tue, 29 Mar 2011 10:32:18 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id u20sm2579057anu.14.2011.03.29.10.32.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 10:32:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20110329145818.GC10771@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170288>

On 3/29/2011 9:58 AM, Jeff King wrote:
> On Fri, Mar 25, 2011 at 12:59:34PM -0500, Neal Kreitzinger wrote:
>
>> We deleted (git-rm) a file from the repo by mistake.  Several commits later
>> we restored it (git-checkout, git-commit).  Git status shows "added" for
>> this file.  IMHO, it seems like git status should be "restored" or
>> "unremoved", etc, for this file.  Git detects renames and copies so it seems
>> like it could detect restores.
>
> I am mildly negative on the idea, though I think it is mostly just
> because I would not find that information useful at all.
>
> But what gives me pause is that it is adding a totally new dimension to
> git-status. Currently status is about three things:
>
>    1. What's in your index, and how does it differ from what's in HEAD.
>
>    2. What's in your working tree, and how does it differ from what's in
>       your index.
>
>    3. What untracked files are in your working tree.
>
> So it is only about HEAD, the index, and the working tree, and we only
> have to look at those things. We detect copies and renames, yes, but
> only in the diffs between those points.
>
> But what you are proposing requires looking backwards in history to see
> if we used to have something like the thing that has been added. So that
> introduces a few questions:
>
>    1. What are we claiming to have "used to have"? Some arbitrary content
>       at the same path, or similar content at the same path, or similar
>       content at any path?
>
>    2. Which history do we look at? Do we start traversing backwards from
>       HEAD? If so, how far back do we go (you probably don't want to go
>       to the roots, which is expensive)? Is it useful to see similar
>       files on other branches (e.g., instead of "you are adding foo,
>       which is being resurrected from 'HEAD~20: remove foo'", you would
>       find out that "you are adding foo, which has also been added on
>       branch 'topic'").
>
>    3. How expensive is the test going to end up? For generating a commit
>       template or running "git status", it's probably OK. But keep in
>       mind also that people run "git status --porcelain" to generate
>       their shell prompt. So it needs to either be really fast, or it
>       needs to be easy to turn it off in some cases.
>
> -Peff

I see your point about the current worktree/index/HEAD.  I'm not a git 
developer, but my idea is based on the concept that the sha-1 of the 
content already exists in the object store regardless of its path(s). 
I'm talking about identical blob sha-1's, not "similar" content.  It 
seems like the loose object directory would be easy enough the check for 
duplicate blob sha-1's, but the the pack would probably be more 
difficult (i'm not sure how you could do that).  If this capability 
doesn't fit well into fast default behavior, maybe there could be an 
option to --find-restores-harder.

That being said, I see how it may not be feasible for git-status to do 
that extra work.  Git-status runs against "what you just did" so 
hopefully I should know in my mind that I just checked something out to 
restore it.  However, for analyzing history it would be nice for git-log 
or git-diff to be able to do that extra work of finding restores when asked.

In our workflow it would be useful because we have a utility directory 
of mostly obsolete programs that needs to be deleted to eliminate noise, 
but we're sure some of them will get restored once we realize they're 
still needed.  An interrogation command with --name-status 
--find-restores-harder would give an accurate picture of what was really 
added (new content) and what was simply restored (old content revived).

v/r,
neal
