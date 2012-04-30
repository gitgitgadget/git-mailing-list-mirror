From: Steve Bennett <stevage@gmail.com>
Subject: Re: Bug (or inconsistency) in git add
Date: Mon, 30 Apr 2012 16:46:20 +1000
Message-ID: <CADJEhEXtDZGav1Y5epZQ69NWptyVyPC1hmN6=YaNYrg3vYmBqg@mail.gmail.com>
References: <CADJEhEWC=mMManxi9Q6W9EvVKmTV=i1ZxbdW4QS_ou_DrBEb+Q@mail.gmail.com>
 <CADJEhEVNPj_FrRatjD7Jmbd7i_FYg9BzNNP48_4VAr6fgqBT8Q@mail.gmail.com> <CAA5Ydx9h6o=uppRk5zc9V4z1S831KGVRBzTw9oMqDjY34-noOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Victor Engmark <victor.engmark@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 08:46:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOkNi-0007rp-IN
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 08:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865Ab2D3Gqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 02:46:42 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:34025 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab2D3Gql (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 02:46:41 -0400
Received: by vcqp1 with SMTP id p1so1836881vcq.19
        for <git@vger.kernel.org>; Sun, 29 Apr 2012 23:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NDHe2ZYRug7MavxXywTJjrGEuneZg7VbduHleJuvKFc=;
        b=1BHYEaB1ecI8zDhYp9TCy31ddOArQp1JXR4y+dkgvE68BtQXbBYCVVeoVKHlvqoDfw
         9t2IT2CQVFVO5N0T+9cIauxo9TATjADwAbUxPlbsDoN67HW1fclwxuZgXFLUGG5bYuz4
         gPpWiUVhJcRhsAg9uHhmnRbH7Y15iMDs2Gr1a7mhWpsX6Eu2YmTNmNUmtlrbje4OqQjU
         yWCEuoQ0+ZG0hLnSChOXI5zIfxKnzR+axsChU/8aciuTABUYHX+bxP6/2jsr9gmGgneH
         VOz5b56iQITV40VHIm9zcB+BWYBqgjbvcBZZ2fqnxCHNCwOCUnrMuvIrZEIZTbD6qtyF
         4vQw==
Received: by 10.52.19.193 with SMTP id h1mr5504073vde.18.1335768401081; Sun,
 29 Apr 2012 23:46:41 -0700 (PDT)
Received: by 10.52.38.39 with HTTP; Sun, 29 Apr 2012 23:46:20 -0700 (PDT)
In-Reply-To: <CAA5Ydx9h6o=uppRk5zc9V4z1S831KGVRBzTw9oMqDjY34-noOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196542>

On 30 April 2012 16:23, Victor Engmark <victor.engmark@gmail.com> wrote:
> I can't answer for the absence of an error when no files are added, but
> globbing (resolving * in paths) is done by the shell, not by git. To verify
> a glob, just echo it:
>
> echo foo/**/*.py

Yes, it appears that the two cases are treated differently:
1) foo/**/*.py:  the shell expands the **, and interprets it the same
as "*",  so foo/**/*.py means any python file exactly one directory
deeper than foo
2) /**.py: the shell ignores this and passes it straight to Git.

So I guess the missing error message I reported originally is
logically correct in a kind of convoluted way: the ** is actually
matching real files (just not the ones you expected) and they don't
have any changes, so you don't get any output.

(Whether or not it makes sense for Git to produce identical output in
the case of both adding files with changes, and doing nothing at all,
is a debate I probably shouldn't start...)

> If you want to add recursively, you'll need to enable the special behavior
> for double stars:
>
> shopt -s globstar

Looks like I need a newer version of Bash.

In any case, it looks like Git does support some ** globbing natively.
I'm curious about the rules for that. They don't seem to be documented
in the git man page (http://schacon.github.com/git/user-manual.html).

Steve
