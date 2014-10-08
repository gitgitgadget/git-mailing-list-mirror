From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: [BUG?] `config branch.autosetuprebase true` breaks `rev-parse --is-inside-work-tree`
Date: Wed, 8 Oct 2014 13:22:33 +0200
Message-ID: <CAD77+gTuqbZimEK-=gXY8o4wFqOicFvnQ5MnV6Fq1npuckwYFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 08 13:23:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbpKd-0008KC-LC
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 13:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756102AbaJHLWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 07:22:55 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:48963 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755931AbaJHLWy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 07:22:54 -0400
Received: by mail-wi0-f174.google.com with SMTP id cc10so10291349wib.7
        for <git@vger.kernel.org>; Wed, 08 Oct 2014 04:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=Z4EclySN3lOzcyE7A0Gd+FoqqMCzP+38+Tarm/InHVU=;
        b=tJlGuLVlqB35+t4y/c3HNTQM819LEQHNWuz3VNWjGlsZ7T+z4iMnKaoAesVdn8CGcc
         0EB3KVSBTr6HVhBXm1K7qqyot6GEZYOJ7+61Ucy0f/CeoFuEex6EN6R6jOejfkD7kGHa
         j5xvxvBscXVx5ygBxOYX3jzaHpXw+JZWhZYYassGynvq/FcI2PPsI2myFErQPGHD8Vj4
         /LWb1GVW+OjIuDgYAs3PJfRbMv/Zrog9+hXyiy6CSYHvxasW9LBYB4Gf6TfSW6IwUClO
         IQVscoycR33GH4BevB99JFpjcJw+YHkDpBlUbuKIP/g8EA2bk56URSpM0zQqrFBJYuGk
         0aug==
X-Received: by 10.180.76.209 with SMTP id m17mr10598807wiw.78.1412767373908;
 Wed, 08 Oct 2014 04:22:53 -0700 (PDT)
Received: by 10.194.5.197 with HTTP; Wed, 8 Oct 2014 04:22:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all,

I am not sure if this is an actual bug or just a corner case that's
not worth to be fixed.

This was not tested with HEAD or even 2.1.2, but 2.1.1.

Notwithstanding if the setting is correct, shouldn't rev-parse be
resilient enough to at least be able to tell if we're in a work tree?
I understand why `git status` and the like would need to parse the
full config, but determining if you're in a work tree should be
possible in most if not all cases.
Unless detached work trees get you into a situation where you really
need to parse the whole config...

So this is not a real bug report, more of a "is this intended this way?"

As you can see, my custom prompt (via vcs_info in Zsh) breaks due to
that which is how I noticed.


richih@titanium  ~ % mkdir git_test
richih@titanium  ~ % cd git_test
richih@titanium  ~/git_test % git init
Initialized empty Git repository in /home/richih/git_test/.git/
richih@titanium (git)-[master] ~/git_test % git rev-parse --is-inside-work-tree
true
richih@titanium (git)-[master] ~/git_test % git config
branch.autosetuprebase true
richih@titanium  ~/git_test % git rev-parse --is-inside-work-tree
error: Malformed value for branch.autosetuprebase
fatal: bad config file line 8 in .git/config
richih@titanium  ~/git_test % cat .git/config
[core]
repositoryformatversion = 0
filemode = true
bare = false
logallrefupdates = true
[branch]
autosetuprebase = true
richih@titanium  ~/git_test % git --version
git version 2.1.1
richih@titanium  ~/git_test %


Thanks,
Richard
