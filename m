From: Scott Bronson <bronson@rinspin.com>
Subject: Interpreting git merge failures
Date: Thu, 7 Jul 2011 11:45:57 -0700
Message-ID: <CAKmUPx5Qt2K+7F+BsW3WTmRjodBSrteuyG8p9oRHZuhApTu4+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 20:46:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QetaN-00065C-Fm
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 20:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755777Ab1GGSp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 14:45:58 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61538 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755113Ab1GGSp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 14:45:57 -0400
Received: by qwk3 with SMTP id 3so601279qwk.19
        for <git@vger.kernel.org>; Thu, 07 Jul 2011 11:45:57 -0700 (PDT)
Received: by 10.224.109.3 with SMTP id h3mr977863qap.104.1310064357187; Thu,
 07 Jul 2011 11:45:57 -0700 (PDT)
Received: by 10.224.45.66 with HTTP; Thu, 7 Jul 2011 11:45:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176768>

What is the best way to determine why a git merge failed?
I'm writing a script that needs to do different things depending
on what went wrong.

Right now I'm parsing error messages.  It's obviously a bad
idea and prone to breakage but it does work.   Example:

    `git fetch origin #{tag || :master}`
    output = `git merge --ff-only FETCH_HEAD 2>&1`

    # warning, bad idea:
    if output =~ /Not possible to fast-forward/
      log "has different ancestry from upstream, removing and re-cloning."
      remove_and_reclone
    elsif msg =~ /You have unstaged changes/ ||
          msg =~ /Your local changes [a-z ]* would be overwritten/ ||
          msg =~ /commit your changes or stash them before you can merge/
      log "has unsaved changes, invalid doc/tags file in upstream repo?"
      work_around_tagsfile
    elsif msg =~ /untracked working tree files would be overwritten/
      log "has conflicting file, removing and re-cloning."
      abort  # don't blow away unknown file
    else
      log msg
      abort
    end

There's got to be a better way!  I could special-case each check
beforehand using git ls-files and friends but that seems almost as
ugly...  Hoping a smarter solution exists.

This is for https://github.com/bronson/vim-update-bundles

Thanks!

    - Scott
