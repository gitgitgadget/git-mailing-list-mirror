From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 09/13] refs: introduce an iterator interface
Date: Thu, 2 Jun 2016 17:08:17 +0700
Message-ID: <CACsJy8AZRJ_qa8KHTt_xcX5sDmJ2rCuMd6LpW+MB0MXKErDJQw@mail.gmail.com>
References: <cover.1464537050.git.mhagger@alum.mit.edu> <89634d216544d1102dafd5d18247bff2581d48a8.1464537050.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 02 12:08:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8PYf-0001yG-Oq
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 12:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbcFBKIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 06:08:48 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:38243 "EHLO
	mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbcFBKIs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 06:08:48 -0400
Received: by mail-it0-f49.google.com with SMTP id i127so47099974ita.1
        for <git@vger.kernel.org>; Thu, 02 Jun 2016 03:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sWIZFvNv9V4YD+2+0khyBe4n3auvWWfIzcg14VTU0Ps=;
        b=gh1I7zKGBZUFlNoSrYyZutoIMwwch9tyxnXTgiTTSHUKB4UqtRzvv6bTIVWjFCXbAD
         Tw54iq6Sn/1vt94GYJdDPjpWQrwxgbN0Wya1lvB5W6JYIDaJTfdLaWm7G77T/MVYX4ho
         UXhPRjYAnz1byLeSC5HjwPZIgVaRaf8+FH1kxadwbLMUd7oEIHTlWwZmdHMcPnu3FlPQ
         sKmSNXqsb15I7PU/VEj7rZcyFYa5aBw0wUl7lYdMYqDhz8HHo4fJc7DdR6NF3hXzisKV
         47qNJYqOk+geiQ/KQb12XWqG7BDD0S9pMY9zhdItIH/kgGgmqsyy0PI3m9iEOw05r0TD
         a+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sWIZFvNv9V4YD+2+0khyBe4n3auvWWfIzcg14VTU0Ps=;
        b=DlIdOhJe5vcL/p1KCoL4IPm+LaKboy7Gmvfcul5qtnmikT3pU/a7Aw0dyEerh7HBGh
         dHt9w6fzYfw1z07P2UIWjccGDPZQRgwSt8Gas8cVHWgP7YDJUCkDntu1DsmVIgmtZ2DL
         hGU5TQPvoTAPGcr9rl0gMSCJmVxa8u1hX00u83EQgIbSXcaitOzstxqCXPKXsNe4ppl2
         PAyL7n9FZvqUgwl04XmD4ea0TZ3dqX9j7RW4ZdcE5imDLnLiz0pGxER+PPCguHKma8yc
         vjN25JZeG2p5SQZsDn1PMIjnmz0fbtELMTb6AcAKcJ8n36Eso/9oeUz3xH0JOqMFUo8S
         X5Xw==
X-Gm-Message-State: ALyK8tLdvjAQRNY8d8lxjDBKHnqJBApdGtJOgFmCGSf1xcVm7IbTMkI4B6t3d7JqpHQjbtreLC6A80RLuHB3tA==
X-Received: by 10.36.130.130 with SMTP id t124mr2541993itd.42.1464862127310;
 Thu, 02 Jun 2016 03:08:47 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Thu, 2 Jun 2016 03:08:17 -0700 (PDT)
In-Reply-To: <89634d216544d1102dafd5d18247bff2581d48a8.1464537050.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296193>

On Mon, May 30, 2016 at 2:55 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Currently, the API for iterating over references is via a family of
> for_each_ref()-type functions that invoke a callback function for each
> selected reference. All of these eventually call do_for_each_ref(),
> which knows how to do one thing: iterate in parallel through two
> ref_caches, one for loose and one for packed refs, giving loose
> references precedence over packed refs. This is rather complicated code,
> and is quite specialized to the files backend. It also requires callers
> to encapsulate their work into a callback function, which often means
> that they have to define and use a "cb_data" struct to manage their
> context.
>
> The current design is already bursting at the seams, and will become
> even more awkward in the upcoming world of multiple reference storage
> backends:
>
> * Per-worktree vs. shared references are currently handled via a kludge
>   in git_path() rather than iterating over each part of the reference
>   namespace separately and merging the results. This kludge will cease
>   to work when we have multiple reference storage backends.

Question from a refs user. Right now worktree.c:get_worktrees() peeks
directly to "$GIT_DIR/worktrees/xxx/HEAD" and parses the content
itself, something that I  promised to fix but never got around to do
it. Will we have an iterator to go through all worktrees' HEAD, or
will  there be an API to say "resolve ref HEAD from worktree XYZ"?
-- 
Duy
