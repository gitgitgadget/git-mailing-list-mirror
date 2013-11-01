From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [ANNOUNCE] git reintegrate 0.1; manager of integration branches
Date: Fri, 1 Nov 2013 06:35:39 -0600
Message-ID: <CAMP44s2cuHnW0cGEBRt2EmG8Wmav4athMLXRCh2cJ2KymeHmmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 01 13:35:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcDx4-0001IU-HZ
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 13:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979Ab3KAMfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 08:35:42 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:47835 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab3KAMfl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 08:35:41 -0400
Received: by mail-lb0-f177.google.com with SMTP id u14so3341799lbd.8
        for <git@vger.kernel.org>; Fri, 01 Nov 2013 05:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=EoLfowA0eDYZrhdtEDsDooEBXnMbVI2AEA56pkk3arI=;
        b=O3wuRSyS5uJ+45zYbAQTb0+LDB5tzESBHXDgDid7uoXUYtMaaPuA586zm7jMhU7GHK
         uN1FM/jG9WHfbrMlNrCA4xkeMtQmReUd9/3sCEpXeGHvrwgDCK+dlFwkIczOVq1l0n9h
         1YiQI2KnW8XOLPPTmRjRQBoOOLtgEnTaQp0l4PaUufQmCL4ravabtXp4p+qzJbz0G5+G
         wg+ozIiDNGOspeugqU15AAmwjHgtVHhQJWLAOJpmuM7ESRObUO1sHG1yVwLMELHEGyMe
         qHWAwml5p4wdre7TeuWfNoIS2K6UChbD2YXM0CPa19BUqdBC7xTsc3hHJdOY8FwqDBn1
         e5jg==
X-Received: by 10.112.140.137 with SMTP id rg9mr1415188lbb.19.1383309339605;
 Fri, 01 Nov 2013 05:35:39 -0700 (PDT)
Received: by 10.114.201.69 with HTTP; Fri, 1 Nov 2013 05:35:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237209>

Hi,

git reintegrate is a helper tool to manage integration branches, it
has all the options of other known tools.

This is a rewrite of John Keeping's git-integration in Ruby, it has
essentially the same features and passes all the git-integration
tests, but it has other features.

One feature that is missing from git-integration is the ability to
parse existing integration branches.

To give a try you can do:

  git clone https://github.com/gitster/git/
  cd git
  git fetch -u origin 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs/heads/*'
  git checkout pu
  git reintegrate --generate pu master

Which will generate the integration instructions for you:

  % git reintegrate --cat
  base master
  merge jl/submodule-mv

    Moving a regular file in a repository with a .gitmodules file was
    producing a warning 'Could not find section in .gitmodules where
    path=<filename>'.

  merge ap/remote-hg-unquote-cquote

    A fast-import stream expresses a pathname with funny characters by
    quoting them in C style; remote-hg remote helper forgot to unquote
    such a path.

  merge jk/for-each-ref-skip-parsing
  merge jk/pack-corruption-post-mortem
  merge jk/reset-p-current-head-fix

    "git reset -p HEAD" has codepath to special case it from resetting
    to contents of other commits, but recent change broke it.

  ...

It also has support for "evil merges", so it should be perfectly
usable for git.git maintenance.

You can edit the instructions with `git reintegrate --edit`.

The simplest way to begin an integration branch is with:

  git reintegrate --create pu master
  git reintegrate --add=branch1 --add=branch2 --add=branch3

To generate the integration branch run `git reintegrate --rebuild`, if
there are merge conflicts, solve them and continue with `git
reintegrate --continue`.

Despite having more features, the code is actually smaller thanks to
Ruby awesomeness.

Enjoy.

https://github.com/felipec/git-reintegrate

-- 
Felipe Contreras
