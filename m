From: Nathan Collins <nathan.collins@gmail.com>
Subject: [BUG?] Patches created with 'diff.noprefix=true' don't 'git apply'.
Date: Wed, 30 Apr 2014 18:36:22 -0700
Message-ID: <CAO8RVvdgN3U5hUEsJjYY9urfeVUDWwHiEur4NQp=H93W37RRnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 01 03:37:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wffvz-0004ph-BI
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 03:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbaEABhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 21:37:05 -0400
Received: from mail-qa0-f48.google.com ([209.85.216.48]:45135 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbaEABhE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 21:37:04 -0400
Received: by mail-qa0-f48.google.com with SMTP id j15so2487438qaq.35
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 18:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=JPXOo1KbMuJmYR17S7JljIhmnA4hvXkI7RquqZ9sioc=;
        b=GMVJJ6wT4m2ltYKqPVY2MKCadMMNNWYXuoalFA+nwnaIxK3Rll7GGcDpVRu/QOnxrx
         yHdHAq/vVoQo5xTM32Po6Rg3lEhIMsE4gKRSHz5fsQv9mbh2m8oKqbICBS4pDQBCHpXm
         T5dxiBSa9cA9nXwc5fpejuezhfn+nYABJVNCpQCBXUmyS20GfJi30wnINFZ4lqN2dJId
         QFT3NgZZ9VIk6129ddC677WaQTmefZy20+uW9qe6UwzB2c9kxSb7i7XTTZ8ojMhj4j72
         Yb5AMJKTV3K5RhqXiEpc+gCXT4CTW6QVyBZoOQFJu2J0cefDhKd+F7Z4hwPEwEBxTpRm
         VI2Q==
X-Received: by 10.140.106.66 with SMTP id d60mr9734776qgf.44.1398908222647;
 Wed, 30 Apr 2014 18:37:02 -0700 (PDT)
Received: by 10.229.150.208 with HTTP; Wed, 30 Apr 2014 18:36:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247804>

Bug?
====

Patches created with 'diff.noprefix=true' don't 'git apply' without
specifying '-p0'.

I'm not sure this is a bug -- the 'man git-apply' just says "Reads the
supplied diff output (i.e. "a patch") and applies it to files" -- but
I would expect patches I create locally to apply cleanly locally. In
real life the 'diff.noprefix=true' is in my ~/.gitconfig, so this was
pretty confusing.

Here's an old bug that's kind of related:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=607044

I'm using Git 1.9.2.

Example
=======

Create a repo with a test commit:

  git init bug.git
  cd bug.git
  git add test
  git commit test -m Test

Revert the test commit in a contrived way (like
'git revert HEAD --no-commit; git reset'). This works:

  git -c diff.noprefix=false show | git -c diff.noprefix=false apply --reverse

And this works:

  git reset --hard
  git -c diff.noprefix=true show | git -c diff.noprefix=true apply -p0 --reverse

But this fails:

  git reset --hard
  git -c diff.noprefix=true show | git -c diff.noprefix=true apply --reverse

    fatal: git diff header lacks filename information when removing 1
leading pathname component (line 12)

Use Case
========

Partially reverting a commit:

http://git.661346.n2.nabble.com/Revert-a-single-commit-in-a-single-file-td6064050.html#a6064406

Cheers,

-nathan
