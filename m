From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 00/14] New remote-hg helper
Date: Tue, 30 Oct 2012 19:29:30 +0100
Message-ID: <CAMP44s3LY0m14LkuRHhbMTqsgD=t1Xw+KLsac9e=tgpnhGc+NA@mail.gmail.com>
References: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
	<20121030102526.GN4891@arachsys.com>
	<CAMP44s1g8rFGP7UOcvp9BEZ1oiSh3+-gYheciqO8Fmghipot8A@mail.gmail.com>
	<20121030180021.GX26850@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 19:29:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTGZN-0006Af-7K
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 19:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760040Ab2J3S3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 14:29:32 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:41818 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760051Ab2J3S3a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 14:29:30 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so578156oag.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 11:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wLkFIkxnJUwzdpOB6wIJ02TogRrC1g4hRomgXBc8m44=;
        b=lhCmTLI9GyGVhE7Kjzz7SbtkDDKsi2SsNdZ6TSCuKuJecn6+Yiiy03Ndmk8RjNSB+K
         mDBVgY5vSf4w3I2L+foWejUEb349StWr3Cfme5EQuMkSbD8T8lrE8P9s6xjJPW+AB3Jt
         3twKcNdApMLrZtucQqim19+k8SFFLXXMMM5HjBh8bdS2Fk0lFTrfO7NxR4PRfldlvozT
         vDHKKmnd2eZPVIBy1XoPqPXfqmA8g7+EgWBZeiiQW1BICmg4TXJYPUZ8hkupaMY3T0l3
         5CH862OQfJgwKCEQ5s3raf0AsGNrJcYr+USwOD1eeqO1K0bBtgqqY8UP+9hZTib7pgpi
         vY0g==
Received: by 10.60.31.241 with SMTP id d17mr29421053oei.107.1351621770142;
 Tue, 30 Oct 2012 11:29:30 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 11:29:30 -0700 (PDT)
In-Reply-To: <20121030180021.GX26850@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208720>

On Tue, Oct 30, 2012 at 7:00 PM, Chris Webb <chris@arachsys.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Yes, it seems this is an API issue; repo.branchtip doesn't exist in
>> python 2.2.
>
> Hi. Presumably this is a problem with old mercurial not a problem with old
> python as mentioned in the commit?
>
>> Both issues should be fixed now :)
>
> They are indeed, and it now works nicely on all the repos I've tested it
> with, including http://selenic.com/hg: very impressive!
>
> I wonder whether it's worth ignoring heads with bookmarks pointing to them
> when it comes to considering heads of branches, or at least allowing the
> hg branch tracking to be easily disabled?
>
> A common idiom when working with hg bookmarks is to completely ignore the
> (not very useful) hg branches (i.e. all commits are on the default hg
> branch) and have a bookmark for each line of development used exactly as a
> git branch would be.
>
> On such a repository, at the moment you will always get a warning about
> multiple heads on branches/default, even though you actually don't care
> about branches/default (and would prefer it not to exist) and just want the
> branches coming from the bookmarks.
>
> I've also seen repositories with no hg branches, but with a single
> unbookmarked tip and bookmarks on some other heads to mark non-mainline
> development. It would be nice for branches/default to track the unbookmarked
> tip in this case, without warning about the other, bookmarked heads.
>
> Finally, on a simple repo with no branches and where there's no clash with a
> bookmark called master, I'd love to be able to a get a more idiomatic
> origin/master rather than origin/branches/default.

Sounds like you might want to try this:
% git config --global remote-hg.hg-git-compat true

This would match the behavior of hg-git, which seems to be what you
are looking for: branches will be ignored. But additionally there will
be other obtrusive changes:

 1) Extra information will be stored in the commit message: branch,
renames, extra info.

Personally I don't like this, which is why it's only enabled with the
hg-git compat mode. Eventually there will be support for this in the
normal mode through git notes, and eventually (hopefully), hg-git will
use notes as well.

 2) Authors will be fixed trying to preserve as much information as possible


The problem with this mode is what happens when there are no
bookmarks, and what I decided to do is create a fake bookmark to the
current branch (e.g. default), so you would get 'origin/default', but
you will be warned if there are multiple heads. We could try to create
a 'master' ref to the 'tip', but that might not be what the user
wants: (s)he might switch to a certain branch, and clone the
repository in git; currently the result working directory would be the
same as in hg, but if we point to 'tip', then it would not.

Maybe we should have a branch pointing to 'tip' either way.

The reason I decided on having 'branches/default' on the normal mode
is that users unfamiliar with mercurial might expect to see all the
branches somewhere. But perhaps that should happen only for other
branches, while 'default' gets a special treatment and gets promoted
to 'origin/master' but only if there's no 'master' bookmark, as you
say. Now the tricky part would be handling the case where there was no
'master' bookmark, and suddenly one gets created, but it might be
overkill to think about that right now.

Either way, try the hg-git-compat mode, should be close :)

Cheers.

-- 
Felipe Contreras
