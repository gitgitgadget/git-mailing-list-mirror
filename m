From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 8 Apr 2013 00:07:05 +0530
Message-ID: <CALkWK0nSChFmYZJbaWVYsn5gdaPMrRQ7zOGbcsHvAKUmYvxtLQ@mail.gmail.com>
References: <7v61zz9fu3.fsf@alter.siamese.dyndns.org> <CALkWK0n64BW8zQXweR38T6DjT+iYBbsZDPCLZ-4igqGJHoFwKw@mail.gmail.com>
 <7vr4im7m1y.fsf@alter.siamese.dyndns.org> <CALkWK0=jrO9MQotB+anAn-5YtG1RBTLWEnGL5=K4wy=yi7E-CQ@mail.gmail.com>
 <20130407161209.GG2222@serenity.lan> <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan> <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
 <20130407175210.GI2222@serenity.lan> <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Apr 07 20:37:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOuTP-0004wD-3y
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 20:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934262Ab3DGShr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 14:37:47 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54712 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934259Ab3DGShq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 14:37:46 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so6094618iec.33
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 11:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Pbnz9Q3aWsbnw0K6+l29ZuKy6NMiag253P5bCaqhBMU=;
        b=0fY4xjDpUfND/1t2wu6xXNI51a6+6Wew0aWp+uGsHXB6QW43FV5OrxA83ix9Jas1wP
         OBMMUmNNCZtaalSLznLF/RrRCXukWSLNqP9ItfCWpG/gPCKaCsXVPYSt1eDpqqZvAu3y
         /WUcVzln1LEp9eSTfT3EgvUd8wkZVM6WCMmr+WyoXTd3MjSOw5fO4tWyEXdu4QttR7Dw
         qCTygEwlZWSCqLxULCwgnpDWnMXqM9PRChQHs26HKrwmCS5lWFFzAFVn2KN/dCZBtlag
         GPITwLjhneqWyEhwIh2eFoR1QBcQx2kmYFBuShJ7QxOWo8JoF0lyve5dvzHxX1YYyzr2
         PViw==
X-Received: by 10.50.108.235 with SMTP id hn11mr4597198igb.107.1365359866131;
 Sun, 07 Apr 2013 11:37:46 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 7 Apr 2013 11:37:05 -0700 (PDT)
In-Reply-To: <20130407182112.GJ2222@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220357>

John Keeping wrote:
> I can't see how this gets me a dirty working tree.  Since the link needs
> to be stored somewhere, I assume it's in the index; so I can have staged
> changes, but not unstaged changes.

If you have changes in the index, your worktree is classified as
"dirty".  See git-sh-setup.sh:require_clean_work_tree().  Yes, you
can't have unstaged changes, only untracked changes.  Linus: I made a
mistake here.

> But what happens if I make any changes on top?  With --rebase and
> --merge I can specify exactly what I want to happen (and obviously if I
> don't have any changes then whichever I choose simply sets my branch to
> the upstream ref).

Hm, that is a useful thing to support: we'll have to record both the
SHA-1 and the ref.

> So it would be something like per-submodule --untracked-files and
> --ignore-submodules settings?  I can see that being useful.

Yes.  Never mind; Jens just pointed out that I'm wrong about this.
