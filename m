From: Stefan Beller <sbeller@google.com>
Subject: Re: Make "git checkout" automatically update submodules?
Date: Fri, 23 Oct 2015 10:20:15 -0700
Message-ID: <CAGZ79kYMyU5h8uQkNEpMU558FgLrNM52_aQsXud6CrBAUgFSNA@mail.gmail.com>
References: <loom.20151016T001449-848@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Kannan Goundan <kannan@cakoose.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 19:20:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zpg0x-0005fB-9s
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 19:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbbJWRUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 13:20:19 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:33886 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbbJWRUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 13:20:16 -0400
Received: by ykdr3 with SMTP id r3so126901088ykd.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2015 10:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RQPTt7F6IlCTmv+Gpcrj5aXW3ULP+lFkGZKLSZweL+s=;
        b=bkNe+IULyvqwaYYXql0WTED9p8gEbxMuYVqhBKV8ig29HBtkdlydKToh9SWvOcZOfY
         peReongUc9dSoH5Rvo6z1T4D9xAu+X5P+RVH9oVKs2nnj2kB622sS5SzjKQCAPforc/I
         m1FjJZenCiNMjs/4vTiH6e5xKGn0tS+PbmSnwun+PGx5YeZTJRINvQWEX+hk6xdcdzP6
         RJ1QbdTH0IMnA6G7wwYpvHWdttHThmMJJtggdiL+uYeBndRDwrujJBvoaOoEHLis8y1J
         OCy1/kTSfpNrpiUzxyMVj86NGNSQ40fOxVoqwhHjOUsQbHHDJ9v7hPR7We4lIDyhfaDB
         CSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=RQPTt7F6IlCTmv+Gpcrj5aXW3ULP+lFkGZKLSZweL+s=;
        b=PjD8PlTkiAlcr8QBdfqQ2IIZUyivJ+xsHzopaY1tTz9k0+YpArmnRCW/WxMTmi0Hrp
         7tjCMq/OGKkq2j2bfUOJiuBBHTG4tEoTCt4kxeehwsBy/xODrjV1FtCKBV4l4oyhphMx
         z16Hgg1r6KZ8IBzacCUC6VDiX+x6pbmzIqmTp421Igr7faA3V9PQM+Y3p8PVOJ7EkoAT
         OgRuYJcT3lx22m3/boumTBrHW4NF12inwEjSsHASPAceluR3KGX5qsN8yfAhrp9AOuNZ
         elsZrb5WAvrvxfphj3FJu4Ey0jzVay2Ll4kLLBVU5TUBeuvUVu8I8hXMGKYRA80mT2fP
         LtHA==
X-Gm-Message-State: ALoCoQmttDQweDwObjURS2YEUB3+oNu7HupqCXz5oPYlq5v8tWw0RmTfMw6SU4W9UvCD8igE5DNC
X-Received: by 10.13.199.133 with SMTP id j127mr16259345ywd.176.1445620815385;
 Fri, 23 Oct 2015 10:20:15 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Fri, 23 Oct 2015 10:20:15 -0700 (PDT)
In-Reply-To: <loom.20151016T001449-848@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280102>

On Thu, Oct 15, 2015 at 3:50 PM, Kannan Goundan <kannan@cakoose.com> wrote:
> Git submodules seem to be a great fit for one of our repos.  The biggest
> pain point is that it's too easy to forget to update submodules.
>
> 1. I often forget since most repos don't need it.
> 2. Infrequent users of our repo almost never know to update submodules and
> end up coming to us with strange build errors.
> 3. Existing scripts that work with Git repos are usually not built to handle
> submodules.
>
> In the common case of the submodule content having no local edits, it would
> be nice if "git checkout" automatically updated submodules [1].  If there
> are local edits, it could error out (maybe override with
> "--ignore-modified-submodules" or something).
>
> I'm not a Git expert, though.  Is there a reason something like this isn't
> already implemented?  Maybe there's an existing write-up or mailing list
> thread I can read to get some background information?
>
> Thanks!
>
> [1] Our post-checkout procedure is:
>
>     git submodule sync
>     git submodule update --init
>     git submodule foreach --recursive \
>       'git submodule sync ; git submodule update --init'
>
> (Not sure if this is correct.  Different articles/blogs suggest a slightly
> different set of commands.)
>

Checkout [1]. There are lots of good patches, but hard to find.
(Including, but not limited to a recursive git checkout enhancement!)

That said I've recently started working on submodules, too.
I am trying to push my work upstream as fast as possible
as that works best for us.

[1] https://github.com/jlehmann/git-submod-enhancements/wiki
