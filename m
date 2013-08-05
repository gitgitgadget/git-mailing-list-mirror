From: Christian Couder <christian.couder@gmail.com>
Subject: Re: git replace: should it check for object type, and can it replace merges?
Date: Mon, 5 Aug 2013 12:57:05 +0200
Message-ID: <CAP8UFD3yHMKfBdjHc6CxeAXSdQ=ua1MddAb5rRXV3TU0ZW7g6w@mail.gmail.com>
References: <24928554D0C34B4696DAD74F569E2E17@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Aug 05 12:57:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6ITR-0006s2-9v
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 12:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197Ab3HEK5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 06:57:08 -0400
Received: from mail-ve0-f172.google.com ([209.85.128.172]:36583 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089Ab3HEK5H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 06:57:07 -0400
Received: by mail-ve0-f172.google.com with SMTP id oz10so2887227veb.31
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 03:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CnaCI2EYQ/HuWMVFvVsQrCKRPvBdeMYJ8ezm6hO9cT4=;
        b=M+fCLkUsqoYsUbz3M4sjDq3Vv29J97ZX82MzNPSGN0SlyG3YBypVAhFJvYE8kXBDKQ
         524Rh4lLH41lC/toNvGOrsp5CZWQ3/7wluGS5SA1nQI06oyAkGMII4CcAir7P8xvdOLV
         P0z1Hq/5s26lfnlaKkZjUlG0jRaMiYiD9Z5dCN1w7qd0+JN4w8nQvRnUSw+wyRNm1/PT
         7GabZP+XiwwHwSR48zIHaF139fYs0TVRM6jdpDRj4Fvd/ZCLH8FrtdadsAC5yAn3O6OV
         Bo5fBjS92A9o8d//3wMmqmZJSfJilme0Yi2fi8mObeHzYrZqA+YySdxhshaOXM+J033b
         YYnw==
X-Received: by 10.220.184.4 with SMTP id ci4mr5503368vcb.65.1375700226020;
 Mon, 05 Aug 2013 03:57:06 -0700 (PDT)
Received: by 10.58.240.102 with HTTP; Mon, 5 Aug 2013 03:57:05 -0700 (PDT)
In-Reply-To: <24928554D0C34B4696DAD74F569E2E17@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231643>

Hi,

On Sat, Aug 3, 2013 at 5:13 PM, Philip Oakley <philipoakley@iee.org> wrote:
> A recent comment http://stackoverflow.com/a/18027030/717355 on a question I
> asked two years ago about 'grafts' and 'replace' indicates that users think
> that 'git replace' can't replace a merge commit. The documentation doesn't
> have any examples and gives the naive impression that one should only
> replace a simple commit with another simple commit.

I am sorry if the documentation gives this impression.
I'd like to fix it, but I am not sure what should be changed.
Should adding an example be enough? Or do you want it to state that explicitely?

> Having looked at the code, I realised that anything can be replaced with
> anything, which is perhaps not what was intended.

The documentation says in the "BUGS" section:

"And of course things may break if an object of one type is replaced
by an object of another type (for example a blob replaced by a
commit)."

So yes it is a know bug.

> A simple thought is that
> the replace should be like-for-like with regard to object type, though that
> would not include replacing a sub-module for a tree (and vice versa).
>
> Should 'git replace' check the object types to ensure they are sensible?

It would probably be a good idea to do that, yeah.
But I don't know much about submodules, so I can't say if replacing a
sub-module for a tree (and vice versa) should be allowed.
Or if there should be a --force-different-objects option for these
kinds of special cases.

> Would it be reasonable to add examples to indicate the range of
> replacements, and how to prepare alternative merge commits, or is that a
> hostage to fortune?

Yeah, adding examples would be a good idea. I don't understand what do
you mean with "range of replacements", though.

I am not sure preparing alternative commits or merge commits should be
an important part of the examples.

There are many cases that could be interesting to different users:

- replacing a non merge commit with a merge commit (if someone forgot
to use --no-ff when merging for example)
- replacing a merge commit with a non merge commit (if a rebase should
have been done)
- and of course replacing a non merge commit with a non merge commit,
or a merge commit with a merge commit

So I think explaining how another commit can be created from existing
commits belongs to some other parts of the git documentation.
Perhaps there could be such examples in the git hash-object and git
filter-branch documentation and we could just point to them.

Best,
Christian.
