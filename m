From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [ANNOUNCE] git reintegrate v0.3; manager of integration branches
Date: Sun, 18 May 2014 19:33:57 -0500
Message-ID: <53795175664d5_10da88d308ce@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 19 02:45:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmBhY-0007bJ-02
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 02:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbaESApF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 20:45:05 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:38518 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbaESApD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 20:45:03 -0400
Received: by mail-oa0-f53.google.com with SMTP id m1so5510386oag.12
        for <git@vger.kernel.org>; Sun, 18 May 2014 17:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:subject:mime-version:content-type
         :content-transfer-encoding;
        bh=elZEW5C/9C4XCl9Kk65GVYAce2s0QZN1YeTVpFkTE6I=;
        b=ltEfo6im7LG3pgp/+Y/9S9zi/xRF1vqcEMosoy3U1xJ9Iw5u/oBbyoep9pIXedix2N
         J1AX6XRbWsaWX3uOZHA+r5Q6+DePhc3NKwmjhS5PDSormm2eeuembRhHXyFEyRK8iOs3
         TiKH2+VKEpbatp/BBk8jxfoybsGYYC6cvw1/dmVzn8fQ6GW3/GfXUvV+DVBHYFx9vjvP
         I7XSSYF9yRCpR11SxlSpzQ3xzFb+FfI/NT+Mo1JEs3bpa+D8/Z3IklSwsPh2e9hAtVyS
         dZ6ft1+yV/VWKkray4ZgzPsJt6shLj5Gl5q3BCv/JWzffRT4l9wnRjWB4ES5pHK8Hlru
         VnXA==
X-Received: by 10.182.104.101 with SMTP id gd5mr31808500obb.54.1400460302675;
        Sun, 18 May 2014 17:45:02 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ml5sm22068529oeb.2.2014.05.18.17.45.01
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 May 2014 17:45:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249554>

Hi,

git reintegrate is a helper tool to manage integration branches, it
has all the options of other known tools.

This is a rewrite of John Keeping's git-integration in Ruby, it has
essentially the same features and passes all the git-integration
tests, but it has more features.

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

Changes since v0.1:

 * Add support for empty commits
 * Add support for pause command
 * Update manpage
 * Add bash completion

Felipe Contreras (26):
      Add copyright and license notices
      Fix EDITOR support with arguments
      Trivial style cleanup
      Improve command regex
      Add support for empty commits
      test: improve check_int()
      Add support for 'pause' command
      doc: rename manpage file
      doc: update options
      doc: add description
      doc: add missing instruction commands
      doc: cleanup . command
      Verify branches after parsing
      test: fix test names
      Remove unused statements
      Update README
      test: cleanup instruction sheets
      Update copyright notices
      Add bash completion
      build: add installation stuff
      readme: add installation instructions
      Add gitignore for documentation
      trvis: initial configuration
      travis: add verbosity
      test: add test-lib helper
      travis: remove Ruby 1.8

-- 
Felipe Contreras
