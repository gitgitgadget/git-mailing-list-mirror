From: William Swanson <swansontec@gmail.com>
Subject: Re: Avoiding broken Gitweb links and deleted objects
Date: Wed, 22 May 2013 08:41:57 -0700
Message-ID: <CABjHNoQEpjE8Da2qiU8o5LRWs7CrUW44XcV7T=tcnB_Z1z+Uvg@mail.gmail.com>
References: <CAJELnLFrfY=-gOFEe0cJHuyT4UNjbTm8hXMxAmzmQHVbz4iEbg@mail.gmail.com>
	<518C8EAC.6000106@viscovery.net>
	<7vzjw349y0.fsf@alter.siamese.dyndns.org>
	<CABjHNoT+Kvm5j4W+c2KOd+0mdu8tPCFDcEAWjxp0OcUXf1t4Lg@mail.gmail.com>
	<CAJELnLEGr7eG9W2WvcVjWi7rT6EUhBDVdtfx6Xjp15duB0E9kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Matt McClure <matthewlmcclure@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 17:42:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfBAx-0001ru-Vf
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 17:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756534Ab3EVPl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 11:41:59 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:39422 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409Ab3EVPl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 11:41:59 -0400
Received: by mail-we0-f170.google.com with SMTP id u59so755368wes.15
        for <git@vger.kernel.org>; Wed, 22 May 2013 08:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=y7jMLpNojbjkPYp0WojLs4ralGJm/l2Xdf1nUTF0B2o=;
        b=FQhGd1guvAF9o+fon16OX9rdwE7NJ7N4H1u3ZGyceCujGL52vRfthpQGcACAtA+ECv
         sAMs7vfiDCvuGe5E2kOLegTpCH5NZT+oUz1Z6xUDXiCheQkZwYpwZpE8B/X+Okael8Ty
         h0WN1QBIyYau8kT8YStEgme3gV7AbKBHvVcg4W2cFrVgxKGLyZdqlWV8tWMBbDQkjdFK
         wZZis4vbYI+JLEN1ehEv2sN2olAELxSZE2FgBjxbsap/Jxj4TAsF0LwTGrEcmzbVBmNj
         Fsi70gY/AVOqUJKCR22GaLe4fqn9d87yfKGikA2CV5MaQVFaTa//yDKU2MOc26GbDeeE
         BDwA==
X-Received: by 10.180.76.194 with SMTP id m2mr16064486wiw.4.1369237317579;
 Wed, 22 May 2013 08:41:57 -0700 (PDT)
Received: by 10.217.116.130 with HTTP; Wed, 22 May 2013 08:41:57 -0700 (PDT)
In-Reply-To: <CAJELnLEGr7eG9W2WvcVjWi7rT6EUhBDVdtfx6Xjp15duB0E9kw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225168>

On Wed, May 22, 2013 at 6:32 AM, Matt McClure <matthewlmcclure@gmail.com> wrote:
> Is there a way to push/pull reflogs among different repositories?

Not that I am aware of, at least not in core git.

> In my original scenario:
>
> 1. the commits are created on a developer machine
> 2. pushed to a central origin repository running Gitweb
> 3. the branch is rebased on the developer machine
> 4. the branch is push --force'd to the origin
>
> Later, git push tells me:
>
>     warning: There are too many unreachable loose objects; run 'git
> prune' to remove them.

You don't need to share reflogs in this case. Assuming the server were
to keep logs of its own, the forced update would create a new reflog
entry showing something like "<old-sha> <new-shaw> <date info> Forced
push", so the pre-rebase version would still be reachable from the
reflogs, keeping it around.

> or I want to delete old topic branch HEADs to improve performance.
>
> But I never want to let Git delete the underlying commit objects since
> there could be Gitweb links pointing at them.

The reflog thing won't help you in this case, since reflogs are
deleted when their branches are deleted. it sounds like you never want
to delete anything, so it would make more sense to just disable
garbage collection entirely.

-William
