From: Roberto Eduardo Decurnex Gorosito <decurnex.roberto@gmail.com>
Subject: Re: `git log relative_path_to_object` does not respect the
 --work-tree path
Date: Mon, 29 Sep 2014 15:11:00 -0300
Message-ID: <CABj5xzdk38_W93kQAiS191XMp826endMdL9c5heCbLo9AZwA9w@mail.gmail.com>
References: <CABj5xzc0bVfyzR5PD5K3STSvdvWEOYeMkayB=GTfKbfij+G5Zw@mail.gmail.com>
 <xmqqy4t2ti75.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 20:11:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYfPz-0004uS-EU
	for gcvg-git-2@plane.gmane.org; Mon, 29 Sep 2014 20:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbaI2SLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2014 14:11:23 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:50036 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536AbaI2SLW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2014 14:11:22 -0400
Received: by mail-lb0-f181.google.com with SMTP id n15so4024767lbi.26
        for <git@vger.kernel.org>; Mon, 29 Sep 2014 11:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+1h0IMR0V/e6bh4LXA3ZO8io1U+46O+kKdleeDI0dj4=;
        b=UUXWb1rAUYmUj1aJ6o/fDsltui5wk5SX7EfxxEq74IRhquZ9Rzn9DkKc0w/2S0Cr9G
         BxDKXoUbcOYfM3zrYtU9DDRRwE1rW2/mfY4ih0UvTuYeT/mbjMQi1az7Asm0byBwRQd+
         FK+T6WlWsINcj0Veq3kK5nzjHX+mjnJClc4HNUC9nu9t5TUZyczA1R5GdtIpgVaGpwdP
         EwEJgSvyMfpxZJprWaA6JjLkxRwRPm80rdGCIPxU1r5ufo3zaviisNQXukxuX/nfB66W
         Pqk6G3QDscFrtLOl7GWPWGNriY/U5RbPT6dyGisdB/HaJNfiyHv8D+Lc0GMg0vONFkCc
         tgqA==
X-Received: by 10.112.16.129 with SMTP id g1mr38701366lbd.19.1412014280430;
 Mon, 29 Sep 2014 11:11:20 -0700 (PDT)
Received: by 10.25.42.131 with HTTP; Mon, 29 Sep 2014 11:11:00 -0700 (PDT)
In-Reply-To: <xmqqy4t2ti75.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257635>

Sorry, I left the --git-dir out of the example. I do set the --git-dir
(and $GIT_DIR sometimes) too.

It gives the same results. That's why I feels like it shouldn't be
working as it is.

In this specific case (log with object filter) the environment config
is completely ignored.

On Mon, Sep 29, 2014 at 3:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Roberto Eduardo Decurnex Gorosito <decurnex.roberto@gmail.com>
> writes:
>
>> ~/path$ git --work-tree=~/path/to_repo log README.md
>
> This does not seem to specify GIT_DIR explicitly (either with the
> $GIT_DIR environment variable or the --git-dir option), so I would
> assume that you are sitting in a directory that has ".git/"
> subdirectory or a subdirectory of such a directory, but that ".git/"
> is not a real repository that controls the working tree you have at
> the ~/path/to_repo directory.
>
> The --work-tree option and $GIT_WORK_TREE environment were primarily
> invented to solve this problem:
>
>     When a user gives $GIT_DIR or --git-dir to disable the
>     repository discovery (i.e. trying to see if the current
>     directory has ".git/" that looks like a repository, and if not
>     try the parent directory until we find one), traditionally we
>     assumed that the current directory is the top-level of the
>     corresponding working tree.  This makes it cumbersome to work
>     inside a subdirectory, and by allowing $GIT_WORK_TREE or
>     --work-tree to specify the top-level of the working tree,
>     working from a subdirectory of a working tree becomes usable
>     again.
>
> That is why it does not mix very well with repository discovery
> (i.e.  letting Git crawl upward from the current directory to find a
> directory with ".git/").  It is unclear if the auto-discovered
> ".git" is the one to be be consulted for the "log" operation you
> asked, or the other repository you have at ~/path/to_repo/.git (or
> one of its parent directories, e.g. ~/path/.git).  I _think_ the
> current implementation randomly chose to use the auto-discovered
> one, but it may have been better to forbid and always require both
> --git-dir and --work-tree to be given to avoid confusion.
>
>
>
>
>
