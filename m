From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [HELP] Corrupted repository
Date: Fri, 21 Jun 2013 09:22:32 -0700
Message-ID: <7v7ghno2lz.fsf@alter.siamese.dyndns.org>
References: <CALkWK0mQj+x3bxbxWKuwpeMj8E8bfvyK-c2bAWna6a9Xe=nBOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 18:22:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq46h-0007Ty-Sk
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 18:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423088Ab3FUQWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 12:22:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40552 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423018Ab3FUQWf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 12:22:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA4EA2A3D8;
	Fri, 21 Jun 2013 16:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FagK8Hx3EEUUp+2iX4W6Cw2V53Y=; b=f/KMHD
	ZSgTjwitjKik7eCBVByBpQBrxCgYtmhLOmCrFXqIth32N416OhQve/vi3edCYS29
	0jqsSEdlw2WGtfp6Yx1OibXtS3hmGIbuqvhbK5C3YR4J4GqmFzk0A/GYOyGwPDHD
	xN3964yUF1XF/ODJCumpO+YPZ0tbeREX92bZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kr+LuyVAf3ohPAr/mWdFU/EbkIPUZSDQ
	yq03yiXYo3vMFdAgRTK2JDnvBKIt4gm2xVLo1P9Acpi4pTLlM2bh2aS+gB5FhPgg
	1j8TjShr3SJmDm3m3ToTAEICF6n9tW6ZBQc2dwkgFENQlSlHx40PaTQO/HYH9pzF
	Qy+qBwhbun8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A21232A3D6;
	Fri, 21 Jun 2013 16:22:34 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EFA4B2A3D4;
	Fri, 21 Jun 2013 16:22:33 +0000 (UTC)
In-Reply-To: <CALkWK0mQj+x3bxbxWKuwpeMj8E8bfvyK-c2bAWna6a9Xe=nBOQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 21 Jun 2013 16:19:20 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C762DE2C-DA8E-11E2-9327-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228626>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>   $ ~/src/git
>   error: object file
> .git/objects/8e/6a6dda24b017915449897fcc1353a9b848fd2f is empty
>   error: object file
> .git/objects/8e/6a6dda24b017915449897fcc1353a9b848fd2f is empty
>   fatal: loose object 8e6a6dda24b017915449897fcc1353a9b848fd2f (stored
> in .git/objects/8e/6a6dda24b017915449897fcc1353a9b848fd2f) is corrupt

So fsync() and close() thought that the filesystem stored this loose
object safely, but it turns out that the data is not on disk.

>   artagnon|remote-cruft*+:~/src/git$ rm
> .git/objects/8e/6a6dda24b017915449897fcc1353a9b848fd2f

As you know it is empty, removing (as long as you do not forget what
the object name was, which may later become useful when untangling
the mess further) does not hurt very much.

>   artagnon|remote-cruft*+:~/src/git$ git prune
>   artagnon|remote-cruft*+:~/src/git$ git status
>   fatal: bad object HEAD
>   fatal: bad object HEAD

And the value in the HEAD was???

>   artagnon|remote-cruft*+:~/src/git$ git symbolic-ref HEAD refs/heads/master
>   artagnon|master*+=:~/src/git$ git status
>   ## master
>   MM Documentation/git-ls-remote.txt
>   MM remote.c
>   MM t/t5505-remote.sh
>   MM t/t5510-fetch.sh
>   MM t/t5515-fetch-merge-logic.sh
>   MM t/t5516-fetch-push.sh
>   ?? lib/
>   ?? outgoing/
>
> That status is completely bogus, by the way.

... which may suggest that your index file may have been corrupted
on the filesystem.

>   artagnon|master*+=:~/src/git$ git reset --hard

... and using that known-to-be-corrupt index, the working tree state
is discarded.

>   artagnon|master*+=:~/src/git$ git checkout remote-cruft
>   fatal: reference is not a tree: remote-cruft
>   artagnon|master=:~/src/git$ git reflog
>   21ff915 HEAD@{10 minutes ago}: rebase -i (finish): returning to
> refs/heads/remote-cruft
>
> What happened to the rest of my reflog?!

On the filesystem known to not record the last consistent state of
the repository, the answer to that question may be rather obvious,
no?

>   artagnon|master=:~/src/git$ git branch -D remote-cruft
>   error: Couldn't look up commit object for 'refs/heads/remote-cruft'

The command would want to report what was at the tip, so it is
understandable it may want to look up that commit before removing
the ref.

>   artagnon|master=:~/src/git$ rm .git/refs/heads/remote-cruft
>   artagnon|master=:~/src/git$ git checkout -b remote-cruft
>   Switched to a new branch 'remote-cruft'
>
> Huh?  What happened to my upstream?
>
>   artagnon|remote-cruft:~/src/git$ git branch -u ram/remote-cruft
>   warning: ignoring broken ref refs/remotes/ram/remote-cruft.

So remotes/ram/remote-cruft is also broken.

> Fine, let's fetch.

Why?

"fetch" walks the ancestry graph on both ends to minimize transfers.
It's not something you would expect to work when you know refs at
your end does not even record what you do have.  It _may_ appear to
work if your refs are intact but you are missing objects, as they
will not be transferred again from the good copy if you let your
repository's ref claim that you have _all_ objects behind it when
you actually don't.

What would have been a better starting point to untangle is to make
a separate clone, pretending as if this repository did not even
exist, and copy the resulting packfile into this repository.  That
would at least give you a known good copies of objects that you
already have pushed out.

And the next step would have been (without doing any of the above
"remove this branch, recreate this one anew") to compare the tips
of refs in this broken repository and the clone.  The same ones you
can trust, and different ones you dig further.

> Was I being stupid, or is fixing corrupted repositories really this
> non-trivial?  Comments appreciated.

I think "Let's fetch first" was the step that took you in a wrong
direction that requires unnecessary work.
