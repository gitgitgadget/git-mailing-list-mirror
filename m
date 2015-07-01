From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Wed, 1 Jul 2015 06:48:14 +0200
Message-ID: <CAHYJk3QFpaiCvYfZixtKac6nfrYOWrrewy=sLCVe123GTe+zBw@mail.gmail.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
	<CAPig+cT0a201MVTsvvLrndr40GsMkyvtao33Gt=AFhvShtr=Kg@mail.gmail.com>
	<xmqqtwtobzn0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 06:48:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZA9wb-0001vf-6c
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 06:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbbGAEsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 00:48:17 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33462 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbbGAEsO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 00:48:14 -0400
Received: by ieqy10 with SMTP id y10so27057238ieq.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 21:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4/Qrb7pGf/3wK9ASytsgRxVtxH/sZFzXO4n93dpmsSM=;
        b=aIlkc1PLvWnN+0uky6AdS8VmHuXjpgJjC/6u8TfVX5bgtRCpn53KgWuOxpdIbWGr5C
         U4xnP2gT0Is5Jmzy/NelYMCbj1SmvoFgFEkjLgQkMrVPulo/pm52btwLRQX64zipjHj6
         dgRZMZ1Mw0l9n37mfxtCjSJDUtiUef4V+2gIhFIxi2wWuARCZTTs7tJ6xwjitzAlIgwP
         QdCD9Vf74DdATV4+XQZSIZf0w1VHV+GHcPNHKUen8TlmGg/3gI9l5ox6afLwLvgftdBk
         6k7vPqoekAfuC74QhcGHWspHaHbfguavRQYHZgqF+oDO5+dCk+sSwQVhVOruSL/n4p5j
         SWUg==
X-Received: by 10.50.43.196 with SMTP id y4mr1967498igl.14.1435726094500; Tue,
 30 Jun 2015 21:48:14 -0700 (PDT)
Received: by 10.36.93.134 with HTTP; Tue, 30 Jun 2015 21:48:14 -0700 (PDT)
In-Reply-To: <xmqqtwtobzn0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273115>

On Wed, Jul 1, 2015 at 12:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Tue, Jun 30, 2015 at 12:56 AM, Eric Sunshine <sunshine@sunshineco.com> wrote
>> Speaking of "git worktree new --force", should we revisit "git
>> checkout --ignore-other-worktrees" before it gets set in stone? In
>> particular, I'm wondering if it makes sense to overload git-checkout's
>> existing --force option to encompass the functionality of
>> --ignore-other-worktrees as well. I don't think there would be any
>> semantic conflict by overloading --force, and I do think that --force
>> is more discoverable and more intuitive.
>
> "git checkout -f" is to throw-away local changes, which is a very
> sensible thing to do and I can see why that would be useful, but
> does --ignore-other-worktrees have the same kind of common-ness?
>
> It primarily is a safety measure, and if the user wants to jump
> around freely to different commits in multiple worktrees, a more
> sensible thing to do so without getting the "nono, you have that
> branch checked out elsewhere" is to detach HEADs in the non-primary
> worktrees that may want to have the same commit checked out as the
> current branch of the primary worktree.
>
> I would mildly object to make --ignore-other-worktrees more
> discoverable and moderately object to make that feature more
> accessible by overloading it into "--force".  I personally would not
> mind if we removed "--ignore-other-worktrees", but that might be
> going too far ;-)

This probably falls under "not common", but one of my uses for git
new-workdir is to check out the current branch in another directory,
rebase it to upstream, delete that worktree, and then git reset --hard
in the original checkout. The result is a rebased branch that touches
a minimum of source files so the rebuild is faster. (In some projects
I have a lot of local commits that get rebased, but maybe upstream
only touched a single .c file).

-- 
Mikael Magnusson
