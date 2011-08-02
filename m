From: Christian Jaeger <chrjae@gmail.com>
Subject: [ANNOUNCE/RFC] cj-git-patchtool: a "rebase -i" with more interaction
Date: Tue, 2 Aug 2011 15:22:26 -0400
Message-ID: <CAEjYwfUY9tF_9frkaS7Aw26CPJA02Cr3HDN5Qpkup1rfHYacXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 02 21:22:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoKYG-00060j-9W
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 21:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440Ab1HBTWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 15:22:48 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:56670 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754223Ab1HBTWq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 15:22:46 -0400
Received: by yia27 with SMTP id 27so65600yia.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 12:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=UsGC5F0lVmlss2NHLBUnbi6iVu6kNqx1U58aWCMJATE=;
        b=YOHB9OYyW3Us2WJdNfmcBiR+zh48bzHS9gGpCWBB1qujx2febCYCxtp2ztWIh5UwZJ
         lxoAd3eaMPQFc8t5nnfa+TNemIyYXPRpmmPNDW8BZgCIHrNsL6Hq2s0EO5g2oD34ry4B
         /3sOB2fAGJ80UmrQVG9iWgZ4JwWsk/g0MOpbI=
Received: by 10.150.135.14 with SMTP id i14mr2235888ybd.71.1312312966074; Tue,
 02 Aug 2011 12:22:46 -0700 (PDT)
Received: by 10.150.137.6 with HTTP; Tue, 2 Aug 2011 12:22:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178503>

Hi

I've always been a frequent user of git rebase -i to clean up private
branches before publication. I like committing without thinking while
coding and then grouping the commits sensibly afterwards. But git
rebase -i didn't scale for me for this purpose, cleaning up several
days (or even weeks) of work would become a pain because frequently
I'd make some error, like when dealing with conflicts, and then
multiple rebase -i runs are needed, requiring to partially redo the
work.

So I've written a set of tools[1] that separates the acts of editing
and applying history changes. It does this by turning the history in
question into a set of git patch files and a file containing the list
of the patches (and optionally new commit messages), and allows to
edit both the list and the patch files themselves incrementally until
they can be applied cleanly again in the new order. In other words, an
(attempted) application (cj-git-patchtool's "app" command) will not
remove these files, and if there's a problem the existing files can be
further refined. There's also a command "wig" that uses "wiggle" (by
Neil Brown) to try to apply a patch automatically when git or patch
wouldn't accept it, and if successful, stores the result back into the
patch file so that it will be reused on subsequent "app" runs. For
convenience, these files, which are put inside a newly created
directory, are automatically checked into their own git repository,
too, so when doing something really complicated, the state of work can
be committed and reverted easily when reaching a dead end.

For more information see the README on Github.[1]

This works well for me, I'm now always using it whenever I need to do
more than a couple trivial changes to a Git history.

I don't know whether there are other tools offering the same now.
Also, I have written this "just for myself", and for this reason made
use of a set of never-before released Perl libraries of mine. If
there's general interest in this tool, I'll be glad to help get rid of
the dependency on these libraries (or clean them up and publish them
properly, too).

I welcome your comments.

Christian.

[1] https://github.com/pflanze/cj-git-patchtool
