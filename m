From: Niluge kiwi <kiwiiii@gmail.com>
Subject: git-svn metadata commands performance issue
Date: Tue, 13 Jan 2015 11:14:37 +0100
Message-ID: <CAKdxknyCQf6HpnTZ8BMVVpEX3vcVEoTo5BmpqrkgFuxV+k7wmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 11:14:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAyUn-00067E-Fq
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 11:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbbAMKOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 05:14:39 -0500
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36803 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbbAMKOi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 05:14:38 -0500
Received: by mail-wi0-f176.google.com with SMTP id ex7so20172061wid.3
        for <git@vger.kernel.org>; Tue, 13 Jan 2015 02:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=6Tf6RjhxuSG27NExbu/kPbOX/R4V1XZ2eTtyLEyKpzs=;
        b=ivdgPDMan0N1WxfD7D0dYiLfQPZZwyUo64xQM5cPDUW3cT5GD4Kt+ETrs3gZC90Qq/
         h6KUAYroABjZE6r1xEimJXIQTyn4zrlITNPQbVYP4e4d3NY5y37vgXod1QBqD8UNzVbL
         dJFHmzeVtXD6u5lKz+Sm/0dMyO6tEI9DYuI+oKYw7Nt9/sW+AR/oQEgxpi7TS1okQYvg
         prQHXLikHBC7ZG3lRu2bmvog/cndds4YFkD9r3VbzjzTBQc5sr6BTljaFTR4daFFYd5G
         RYRxSlMs9CVXZxQPb35IKNq3yQIpyC4p4wtMnJEe8sR+lNrY3WnI2RCOzOxgv7/KCk72
         IafA==
X-Received: by 10.194.203.234 with SMTP id kt10mr2827656wjc.88.1421144077244;
 Tue, 13 Jan 2015 02:14:37 -0800 (PST)
Received: by 10.27.130.211 with HTTP; Tue, 13 Jan 2015 02:14:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262332>

Hi all,

In magit (http://magit.github.io/), a popular git frontend within
emacs, there is a git-svn frontend.  With a recent refactoring, it was
discovered that git-svn metadata commands (like "git-svn info") are
much slower than git ones:
git svn info: 130-150ms (after warmup): get the svn revision and url.
git svn rebase --dry-run: 150-170ms (after warmup): get the remote
branch.

Whereas in pure git:
git rev-parse --abbrev-ref HEAD@{upstream}: 2-3ms (after warmup): get
the remote branch
Other git commands alike take all less than 10ms after warmup.

This is an issue for the magit developers and users: just getting a
git-svn status with some metadata easily take ~500ms, which is really
slow for a UI. The equivalent UI with a pure git repository in magit
takes much less than 100ms to generate although more than 30 git
process are forked for it.

A previous version of magit-svn was much faster because it
re-implemented the logic of git-svn from perl to elisp (the
programming language in emacs), and to get the 3 previously mentioned
values it took less than 10ms.


What could be done about this?
Could git-svn performance be dramatically improved?
Even git svn --version takes ~100ms, is perl the bottleneck?
Or should each git-svn frontend developer re-implement the git-svn
metadata commands themselves for better performance?
Also, wouldn't it be better for those frontend developers if there
were some git-svn porcelain commands like git has? Fast, easy to parse
and stable input & output format?

For reference, here is the discussion about the performance issue on
magit-svn: https://github.com/magit/magit-svn/issues/1

And I'm using git-svn version 2.2.1 (svn 1.6.17) on an ubuntu 12.04
64bits Intel machine with an HDD (no SSD).

Thanks,
Thomas Riccardi
