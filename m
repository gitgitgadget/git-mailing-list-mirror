From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Tue, 30 Jun 2015 15:27:31 -0700
Message-ID: <xmqqtwtobzn0.fsf@gitster.dls.corp.google.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
	<CAPig+cT0a201MVTsvvLrndr40GsMkyvtao33Gt=AFhvShtr=Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 00:29:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZA41e-0000aK-R8
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 00:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814AbbF3W3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 18:29:06 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35364 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753548AbbF3W1e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 18:27:34 -0400
Received: by igblr2 with SMTP id lr2so85393349igb.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 15:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=6LgSuGqBsmdV/pSVxRVh/nkvHD4NBUT0hE6sgLMKwgM=;
        b=dlGp3gmWdCQMOF4Wrz3Pyv3A0RKqDmep2TDnCVxFwhOco8GicC4meduP6QmbUP75BF
         +GsT9p+01xfJAh6402BKIzFpIOkkzgCLGMVyWnCeLkPcBshyBpiKpBnAbA/HNeF+m0Pk
         tSpjyrohBb3LRPjOlN69IGWOmPw9DjZRU9IreHci3A1xL0bGSR8bhC41WWVM4zLeqvoc
         DPO+b3aKuonAFOQKala3a4aC6WmCX7hhWhloxlFK/pQcUjXWT/CIb6+YI6nrgigGvOhL
         ehf5WGe0nYrSFeMz7lqJOBRyS1WCtGXcT3xnvuht2rvu3+ThKJs6FQz2OhgsIwfwBE6L
         YfJw==
X-Received: by 10.42.48.83 with SMTP id r19mr14970icf.3.1435703252691;
        Tue, 30 Jun 2015 15:27:32 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id e10sm233184igy.11.2015.06.30.15.27.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 15:27:32 -0700 (PDT)
In-Reply-To: <CAPig+cT0a201MVTsvvLrndr40GsMkyvtao33Gt=AFhvShtr=Kg@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 30 Jun 2015 18:11:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273108>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Jun 30, 2015 at 12:56 AM, Eric Sunshine <sunshine@sunshineco.com> wrote
> Speaking of "git worktree new --force", should we revisit "git
> checkout --ignore-other-worktrees" before it gets set in stone? In
> particular, I'm wondering if it makes sense to overload git-checkout's
> existing --force option to encompass the functionality of
> --ignore-other-worktrees as well. I don't think there would be any
> semantic conflict by overloading --force, and I do think that --force
> is more discoverable and more intuitive.

"git checkout -f" is to throw-away local changes, which is a very
sensible thing to do and I can see why that would be useful, but
does --ignore-other-worktrees have the same kind of common-ness?

It primarily is a safety measure, and if the user wants to jump
around freely to different commits in multiple worktrees, a more
sensible thing to do so without getting the "nono, you have that
branch checked out elsewhere" is to detach HEADs in the non-primary
worktrees that may want to have the same commit checked out as the
current branch of the primary worktree.

I would mildly object to make --ignore-other-worktrees more
discoverable and moderately object to make that feature more
accessible by overloading it into "--force".  I personally would not
mind if we removed "--ignore-other-worktrees", but that might be
going too far ;-)
