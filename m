From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 16/18] revert: Remove sequencer state when no commits are
 pending
Date: Wed, 27 Jul 2011 16:10:06 +0200
Message-ID: <20110727141006.GA24785@elie>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-17-git-send-email-artagnon@gmail.com>
 <20110727051755.GK18470@elie>
 <CALkWK0noPtLgr_t=DC_XFdLrWUNCLhUd00Mw1HbmWRJjeT4jew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 16:10:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm4of-0006eX-JK
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 16:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078Ab1G0OKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 10:10:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39047 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab1G0OKY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 10:10:24 -0400
Received: by fxh19 with SMTP id 19so447300fxh.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 07:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ASEt9Zd6nu1MIv2pQNL2zDCkwfYPSOXXF2S5wicE1co=;
        b=vpeJegU6pKJMZokFrQ6CGmyl1iMnBPqSL2V+bGmynJ2Pn/3pLGsbMbliP9xfw0uo31
         cCOtvA3BC+VQJHyx0EQjyevs+KbyyxttqmrEyEXn/X0zHYb6GfvT7SM1hhnbTdav/1Wc
         B6lUQP0id2kKyHWrAtvdlsMHvITPzwZVoZTb4=
Received: by 10.223.55.8 with SMTP id s8mr70001fag.141.1311775822806;
        Wed, 27 Jul 2011 07:10:22 -0700 (PDT)
Received: from elie (adsl-165-157-240.teol.net [109.165.157.240])
        by mx.google.com with ESMTPS id a24sm82094fak.36.2011.07.27.07.10.19
        (version=SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 07:10:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0noPtLgr_t=DC_XFdLrWUNCLhUd00Mw1HbmWRJjeT4jew@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177964>

Ramkumar Ramachandra wrote:

> Sounds nice in theory, but how do we do it?  Remove the state at "git
> commit" time?  I've already thought about the problem and presented my
> arguments here [1].
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/177465

For reference:

> My sequencer state was blown away just because of a stray
> .git/remove-sequencer-state-after-commit from a previous operation!
> This is horrible.  One can then argue: the file should only ever abort
> *that* sequencer operation, and now we run into the problem of
> assigning a UID for each sequencer operation.  Unnatural and ugly.
> Conclusion: Making "git commit" remove the sequencer state is WRONG.

That is a compelling argument for not using a
.git/remove-sequencer-state-after-commit file, but I don't see why one
would want such a file anyway.  Why can't "git commit" just call a
function or use a command that examines .git/sequencer and looks at
how many commits are left to pick?

Looking at it from the other side, "My sequencer state was blown away"
is a bit dramatic.  If it's a problem in "git commit", why isn't it a
problem in "git reset", too?  If I just commited after resolving a
conflict from applying the last commit in the series, what cherry-pick
sequence state is going to be useful to me now?

And how is this any less unnatural than making the 'abort cherry-pick'
facility unusable when and only when cherry-picking the last commit in
a sequence?  I don't get it.
