From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Fri, 10 Jun 2011 00:04:56 +0200
Message-ID: <201106100004.58040.jnareb@gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <20110609200403.GA3955@sigill.intra.peff.net> <4DF13D00.2060000@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 10 00:05:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUnLl-0006pc-Ap
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 00:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756547Ab1FIWFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 18:05:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38113 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755648Ab1FIWFG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 18:05:06 -0400
Received: by fxm17 with SMTP id 17so1278605fxm.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 15:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=vRs0i6BJrl/IpYSCnmSQis3BrplChyR9WZrMVbDMcwg=;
        b=mO8wP99kr/EfNXKo9adIT3LjdpMNqb09Mpaa76nmpJhixGBvrnvGQn8ncW3R03P/3K
         BqrH4cb3C2/iTZWQKfMu7gq3z5tT9+JPO1I2yfxTdl1LV6pjfyA+aArRMf8fbxtgbti8
         /Yx3nmvHqd2gg6hq0Ek1MpOPdSB/T3T91nv5U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=V0DGeu6tANyN0PsXk17qfaSorzR+P82F3HI542fc8M5t8QnhcdwY+vfu3UA3Bvi+75
         LYa6AL8/hpUrzjKNtBwdn+Up/2bNvpUx7Pxv50E3BRqcq1ifvvshvv1XpxB3P0IL8fYx
         a4jz4S37xIm6a/B59+aF8WeINPqHjuNWfz9pE=
Received: by 10.223.97.65 with SMTP id k1mr1329908fan.0.1307657105268;
        Thu, 09 Jun 2011 15:05:05 -0700 (PDT)
Received: from [192.168.1.15] (abvk161.neoplus.adsl.tpnet.pl [83.8.208.161])
        by mx.google.com with ESMTPS id h9sm817405fai.6.2011.06.09.15.05.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Jun 2011 15:05:04 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4DF13D00.2060000@alum.mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175579>

On Thu, 9 Jan 2011, Michael Haggerty wrote:
> On 06/09/2011 10:04 PM, Jeff King wrote:
> > I'm less sure about these new tokens, for a few reasons:
> > 
> >   1. You get less useful answers in some situations by treating each
> >      stage as a separate tree (e.g., lack of combined diff). So why
> >      would I want to use them?
> 
> Wouldn't it be nice to be able to do a combined diff between *any* two
> trees?  Then the nonuniform merge behavior of "git diff" would be a
> special case of a general concept:
> 
>     git diff3 OURS NEXT THEIRS
                ^^^^^^^^^^^^^^^^ -- ???

First, it is unnecessary power, unnecessary complication.  WTF. you are
doing comparing _abitrary_ trees?

Second, for files with merge conflicts "git diff" is the same as
"git diff3 OURS THEIRS WTREE", not "git diff3 OURS NEXT THEIRS".
As you can see it is very easy to construct wrong options to git-diff,
and end up with nonsense!

Third, "git diff" is not "git diff3 OURS THEIRS WTREE" in general,
because for resolved files it is "git diff NEXT WTREE", which is
very useful.  

I could agree with STAGE being possibly multi-stage thingy, so that
"git diff STAGE WTREE" in case of merge conflict is _exactly the same_
as "git diff".

> >   4. They're supposed to be simpler to understand than index stages. But
> >      are they? The latest definitions seem to be:
> > 
> >        OURS is a tree of each path in the index, either from stage 2 if
> >        it exists, or from NEXT otherwise.
> > 
> >        NEXT is a tree of each path in the index, either from stage 0 if
> >        it exists, or from HEAD otherwise.
> > 
> >      But that doesn't seem any simpler to me than just saying "the index
> >      has numbered stages, and they correspond to resolved, base, ours,
> >      and theirs".
> 
> There is no need to explain the pseudotrees in terms of the index
> stages; the pseudotrees are easier to understand and should therefore
> become the primary way to describe the index.  Let me give it a try, at
> tutorial level.  Assume that the concepts HEAD and WTREE have already
> been introduced:
> 
>   The "index" is a special area that can hold one or more temporary
>   snapshots of your version-controlled content.  Each snapshot is
>   called a "tree" because it is analogous to a filesystem tree such
>   as the working tree [1].
> 
>   Usually the index holds a single tree called "NEXT".  NEXT is a
>   snapshot of the state of the working tree that is ready to be
>   committed.  This usually consists of the contents from the commit
>   that was last checked out (HEAD), plus any changes that have been
>   staged for commit using "git stage".
> 
>   It is possible to use "git diff" to view the difference between any
>   two trees, whether they be trees in the index, trees in commits, or
>   the working tree.  For example, to see the difference between the
>   last commit and the working tree, use
> 
>       git diff HEAD WTREE

[cut very long explanation]
 
I won't repear the THIRD time simple and around *three times shorter*
explanation on _when_ to use which form: "git diff" for your own remaining
changes that can be "git add"-ef, "git diff --staged" for which changes
are staged i.e. what you have "git add"-ed, and "git diff HEAD" to compare
current with last.

Those pseudo-trees might be useful if you know what you want to compare,
but are not useful if you know what you want to see (you have to remember
what to compare with which).  Never mind they are longer to write...

-- 
Jakub Narebski
Poland
