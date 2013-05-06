From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 0/7] Make "$remote/$branch" work with unconventional refspecs
Date: Tue, 7 May 2013 01:42:58 +0200
Message-ID: <CALKQrgeegzzJ-2QNvdmeeugS0Aw7jrE4SM8S7zk+qPdfgRCMyg@mail.gmail.com>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
	<7vr4hmuk20.fsf@alter.siamese.dyndns.org>
	<CALKQrgdp9DVDBLNwCAmQHbEfZDvhdsmSW3sh1BRo1XEnyqPPaA@mail.gmail.com>
	<7v8v3tuu6i.fsf@alter.siamese.dyndns.org>
	<CALKQrgf6NcT2tEGMTczxR2WspOi4NjrN_kxmKN-QyE2Py3iSaQ@mail.gmail.com>
	<7vhaigrqay.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 07 01:43:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZV3o-0006dt-93
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 01:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761405Ab3EFXnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 19:43:06 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:63010 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760222Ab3EFXnE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 19:43:04 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UZV3e-000Kcb-CL
	for git@vger.kernel.org; Tue, 07 May 2013 01:43:02 +0200
Received: from mail-ob0-f169.google.com ([209.85.214.169])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UZV3e-0009Ak-0g
	for git@vger.kernel.org; Tue, 07 May 2013 01:43:02 +0200
Received: by mail-ob0-f169.google.com with SMTP id tb18so3580054obb.28
        for <git@vger.kernel.org>; Mon, 06 May 2013 16:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=LsYohRAJGlOlHXE1xvbP1wY60RFkjyDbXJmjQamtOjg=;
        b=kKeoznJuYIHhBzqIhSoAy94TVSW/fMTLhHhMyK0Gy8GLTM+RBAmAYO/J17eg0IKHn7
         YmttBhV+viNcOTtFxyP8BupuiiourSJFe2kWzGK28qYrV6HqZlTJP99MH5kPR9fJcWv9
         Mlw8cMn7S1sJEbEOpy4CO+Zn1erJiyhSBDwEq3HVNFaGe+VVL063C6CHGllPw4eQJZ0g
         JnJYGK6hdKkkE/I9YBSTI0zc/Gy2BSg5Ngd8oGAZCjIgey4nHmrvmNOKN628qhUQt3aa
         OVu1YClIw0mIlKcH52kzcVJzaJ7FXdBFXIFYua48D766i4C/B6Fpi4hyDa8w1XjxO+9v
         LInA==
X-Received: by 10.60.63.50 with SMTP id d18mr6183688oes.65.1367883778413; Mon,
 06 May 2013 16:42:58 -0700 (PDT)
Received: by 10.182.129.110 with HTTP; Mon, 6 May 2013 16:42:58 -0700 (PDT)
In-Reply-To: <7vhaigrqay.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223514>

On Mon, May 6, 2013 at 7:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>> Let me try to summarize my views on how refnames should work in Git, to
>> see if we can identify where we differ on the principles (or if we, in
>> fact, differ at all):
>
> Thanks; I think I already said where I think we differ in a separate
> message, but a short version is that the point of remote.$nick.fetch
> mapping is to solve "The remote may call a ref $this, which is not
> the refname I want to or can use in my repository, so here is the
> rule to use when importing it in my local namespace.  With the
> mapping, I can name the ref in my local namespace conveniently."
> E.g. their "refs/heads/master" cannot be our "refs/heads/master" at
> the same time, so use "refs/remotes/origin/master".
>
> The result of the above mapping, be it remotes/origin/master or
> remotes/origin/heads/master, should be designed to be useful for the
> local use of the ref in question.  If you further need to remap it
> when using it locally, there is something wrong in the mapping you
> defined in your remote.$nick.fetch mapping in the first place.

Ok, so whereas I consider the refspec to be "king", and that the expansion
from convenient shorthands to full remote-tracking refnames should be
derived from the chosen refspec, you would (if I understand you correctly)
rather have a constant (i.e. independent of remotes and refspecs) set of
rules for expanding shorthands to full refnames, and if the user chooses
refspecs that don't mesh well with those rules, then that is the user's
problem, and not Git's.

> We do not force any structure under refs/remotes/; it is left
> entirely up to the user, even though we would like to suggest the
> best current practice by teaching "clone" and "remote add" to lay
> them out in a certain way.

If we were to suggest +refs/heads/*:refs/remotes/origin/heads/* as the
best practice, I assume you do want "origin/master" to keep working. And
since you do not want to use the configured refspec when expanding
"origin/master" into "refs/remotes/origin/heads/master", then I assume
you would rather add a hardcoded (what I call a "textual expansion" in
my patches) rule that would map "$nick/$name" into

  /refs/remotes/$nick/heads/$name

But isn't the existence of such a rule evidence of us trying to impose
(or at least hint) at a certain structure for refs/remotes/*?

In light of this, I'm interested in your thoughts about the following
related problem that I've just started looking at:

git branch -r shows the remote-tracking branches in this repo. Currently,
AFAICS, this just spits out all refs under refs/remotes/*. This behavior
must clearly be modified if we are to allow remote-tracking tags at
refs/remotes/$remote/tags/* (they currently show up in "git branch -r",
but shouldn't). One could say that the filter should merely change from
refs/remotes/* to refs/remotes/*/heads/*, but this would break for
existing (old-style) remotes. Should we add a heuristic for detecting when
to use refs/remotes/* vs. refs/remotes/*/heads/* as a filter?

My approach would be to iterate through the configured remotes, and for
each remote list all refs that match the RHS of the refspec whose LHS is
refs/heads/*. This would work for both old- and new-style remotes with
no heuristics.

If you agree that my approach is correct for enumerating remote-tracking
branches, then what is different about using the refspec when expanding
remote-tracking refs in general?

In other words, given the following configuration:

  [remote "origin"]
          +refs/heads/*:refs/foo/bar/baz/*
  [remote "foo"]
          +refs/heads/*:refs/remotes/origin/heads/*

1. In your opininon, is refs/foo/bar/baz/master a remote-tracking branch?

2. Should refs/foo/bar/baz/master be listed by "git branch -r"?

3. Should the "origin/master" shorthand notation expand to
   refs/remotes/origin/heads/master from remote foo, or
   refs/foo/bar/baz/master from remote origin?


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
