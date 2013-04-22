From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Mon, 22 Apr 2013 21:16:40 +0530
Message-ID: <CALkWK0kgQqhG_ojuxZ85mTF8rhLf=wv5dGamU8z+cFxpN7QWYQ@mail.gmail.com>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
 <87ppxmogdv.fsf@linux-k42r.v.cablecom.net> <CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
 <87wqruk2pj.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 22 17:47:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUIxp-0004Yp-C1
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 17:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414Ab3DVPrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 11:47:21 -0400
Received: from mail-ia0-f172.google.com ([209.85.210.172]:46309 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946Ab3DVPrU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 11:47:20 -0400
Received: by mail-ia0-f172.google.com with SMTP id i20so1373576ian.17
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 08:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=gvamIXLmn7/ZxAb2AokbxFBhFcxMrzJp19d6re6DIS4=;
        b=ATXn6ogymg7nkOnbEZ20Vf2B/Gp3UkKRYGkPJApYONvVfbo3mBiI2RMKWpTMJlX3ya
         KEaEoksE27Gfu1qYpC5kwsVUEU+Wrw3FJRJxqZrdavuMDJsiEknlV124EsMz6vBWUGIn
         mDHSMd9miTDBMrR+rclQUFuAequFK2EoqEkUzHHiFRqE/vFIxnragzN+jzmHhd9W2aek
         fZy6HYT20g1g284x0xybkYwyyFLkXMHVXuvl7NOtyerBLX6FgHF1ZXpcMwjPlCxScVkp
         YIF6E0W4b2zRxLRQRDc6JT277JJpmNI7opKj1RhLV60gEYQJbQSR6Uq2c2HtyiTqptfo
         nZ9g==
X-Received: by 10.50.108.235 with SMTP id hn11mr15120479igb.107.1366645640190;
 Mon, 22 Apr 2013 08:47:20 -0700 (PDT)
Received: by 10.64.63.48 with HTTP; Mon, 22 Apr 2013 08:46:40 -0700 (PDT)
In-Reply-To: <87wqruk2pj.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222030>

Thomas Rast wrote:
> So (I think?) in the above you claim that $USER interprets
>
>   git log -- README.md
>
> as
>
>   Show me the history of README.md.
>
> But there's no such thing as the history of a file!

I made no such claims.  I might not know as much as you or the others
on the list about git, but I can certainly grok how git stores
history.

There needs to be some amount of mutual respect for a healthy
conversation: if you start assuming midway that I don't understand
what history is, we have a problem.

> So please don't write tests that go contrary to that definition, because
> they're *wrong*.  The current implementation precisely matches the
> current definition of pathspec filtering.

Who said anything about changing any definitions?  Where are you
getting all this from?

How does "git log HEAD~3 -- README" work?  It sets up a revision walk
to start from HEAD~3 going all the way down to the root commit.  In
each of these commits, it looks for the entry "README" in the
corresponding tree.  It then runs diff-tree with the previous commit's
tree to see if the object (blob) corresponding to the "README" entry
is different: if so, it selects the commit and displays it.

Now, what am I saying?  I'm saying that this approach assumes that all
trees are read into /.  A pathspec "subproject/README" is _only_
present in the subtree-merge commit^{tree} and nowhere else.  The
current log algorithm might try to look for the entry
"subproject/README" (your pathspec) in all the commit^{tree}s of the
commits leading up to M^2.  That is _not_ the problem, as I have
already illustrated that --follow follows over merges.  The problem is
looking for the pathspec "subproject/README" in the first place: those
commit^{trees}s have the entry stored as "README".

Am I making any sense, or are you going to accuse me of not
understanding trees now?
