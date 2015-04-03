From: David Aguilar <davvid@gmail.com>
Subject: Re: RFC: git status --amend
Date: Fri, 3 Apr 2015 14:57:48 -0700
Message-ID: <20150403215744.GA39695@gmail.com>
References: <551AB64F.4030400@cs-ware.de>
 <20150331180414.GB19206@peff.net>
 <xmqqvbhhqal6.fsf@gitster.dls.corp.google.com>
 <20150401084230.GA12282@gmail.com>
 <xmqqlhibn509.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff King <peff@peff.net>, Sven Strickroth <sven@cs-ware.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 23:58:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye9bO-0004xr-Ad
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 23:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbbDCV6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 17:58:05 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:34322 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbbDCV6E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 17:58:04 -0400
Received: by obbgh1 with SMTP id gh1so178308551obb.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 14:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Yy/MQXZv5mUitgFArEgAI/9tsJMOMJKPXaphLV1tP5Q=;
        b=jfeT7NYuISFsCoDxacIgTEeg6LxkFj/sUyxWDoSd8ZC5ijh/2PtoATlN57OnYZUCsO
         HyMQNrEoTAwcUux/BFOUnRBlLzZ7TYWgbs7KPZL30lauYH6f2cwATFBEtlgn9Ev+zY6/
         W/FQb8Yck+WAjuX6e8PnTxK6flZmzRCkAumGhyMeWw2ODoY7/3j1YpqOXH4cbomi639I
         4EHONKvA7AAznNYOIdafAGIbC94/WWFsMuMUWqCU4YZ37IU7GLdUvlgd13sC9m6g+Vzz
         cL4pyRhRK4eL/6vAvnB+xVNZwKSG9/pAtnJNZhgpPO6By9knWEz3fJ5FgDIDAN2j5Jhe
         RWCA==
X-Received: by 10.60.134.199 with SMTP id pm7mr5232921oeb.36.1428098283982;
        Fri, 03 Apr 2015 14:58:03 -0700 (PDT)
Received: from gmail.com ([32.148.210.255])
        by mx.google.com with ESMTPSA id na2sm7905884obb.28.2015.04.03.14.58.02
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 03 Apr 2015 14:58:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqlhibn509.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266737>

On Wed, Apr 01, 2015 at 10:16:22AM -0700, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > Would generalizing "status" to have a more gittish syntax make
> > you feel less torn?
> 
> One of my early draft responses included a one whose punch line was
> "Why limit the comparison to HEAD and HEAD^ but no other point of
> reference?"
> 
> But I discarded it as a useless suggestion before writing it down,
> primarily because I couldn't come up with an explanation _why_ being
> able to say "git status --relative-to=next Makefile" is useful when
> on the 'master' branch.


Aesthetically it's appealing because it mirrors commands like
"git diff HEAD^", etc.

I can see it being useful for script writers but it's a minority
case that's already handled by having "status --amend" for the
common case of needing to mimic "commit --amend".

Beyond that use case, someone could use it to write a butchery
tool that gets a quick high-level diff of changes for both index
and worktree against an arbitrary ref, and then apply those
changes selectively using other git tools.

status is superior to the other tools (diff-index, diff-files,
ls-files) because we can get all of the information in a single
git invocation, which is more of a perf. concern but worth
considering.

> Surely, I may have changes in the Makefile relative to my index
> because I am preparing for the next rc release, and the Makefile in
> the index may be different from that of the 'next' branch because I
> am on my 'master' branch.  The potential output can be "explained"
> in such a mechanical sense (e.g. "we generated the output this
> way").
> 
> But I do not see an easy-to-understand explanation of the _meaning_
> of the output, i.e. "What does it mean that the working tree file
> has been modified since the checkout and the index is different
> relative to that other branch?  How does that information help me
> after I learn it?  What would I do differently with that information
> at hand?"
> 
> Compared to that, "Show me what damage I would inflict if I did
> 'commit' now.  By the way, I may want to see that information
> limited to these paths" is a question whose utility is easily
> explained, and so is the same question with 'commit' replaced by
> 'commit --amend'.

Yeah, ergonomically it would still make sense to have
"status --amend" (even if it also were to also understand
"status <ref>") for symmetry.
-- 
David
