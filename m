From: Daniel Hahler <git@thequod.de>
Subject: "git-rebase -i --autostash" will leave dangling stash when editor is
 aborted
Date: Wed, 15 Jun 2016 23:56:17 +0200
Message-ID: <1b5e2f4b-7a3d-7554-3aa0-79231bee039e@thequod.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 16 00:04:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDIvZ-0007Ox-Kf
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jun 2016 00:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbcFOWEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 18:04:43 -0400
Received: from hahler.de ([188.40.33.212]:39784 "EHLO elfe.thequod.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753340AbcFOWEm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2016 18:04:42 -0400
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jun 2016 18:04:41 EDT
Received: from localhost (amavis [10.122.1.24])
	by elfe.thequod.de (Postfix) with ESMTP id 6665662111
	for <git@vger.kernel.org>; Wed, 15 Jun 2016 23:56:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thequod.de; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:user-agent:date:date:message-id:subject:subject:from:from
	:received:received; s=postfix2; t=1466027778; bh=nPJeKrBnhVpSI10
	mX25ieVlsA9b8bmekh3mH9O1DhCM=; b=UC5K+YPu1MFSdJVpalCMNgM6WrQ/3BN
	TJ79TQQ61COsvy0ueaJF15HCdQgHmToWn6+7hSgpPlVaN6apTkvLr73dWsAIXaDD
	IYGxyhvRoDbfBazJSSsTC6J12utfmHW6bZIlEcsqkmdzTjOQCAxuAV1yVw4R+Sgc
	X0AnFWk6eDDU=
Received: from elfe.thequod.de ([10.122.1.25])
	by localhost (amavis.thequod.de [10.122.1.24]) (amavisd-new, port 10026)
	with ESMTP id ocYFiAieZfvG for <git@vger.kernel.org>;
	Wed, 15 Jun 2016 23:56:18 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297404>

TEST CASE:

1. Modify a file that need to get stashed on rebasing
2. Run "EDITOR=vim git rebase -i --autostash"
3. Abort with ":cq", which will make Vim exit non-zero

Git then will create an autostash, but aborts with "Could not execute
editor", via the following code in git-rebase--interactive.sh, and does
not restore the autostash - it does not show up with the regular
stashes, like when there is a conflict during the rebase:

    git_sequence_editor "$todo" ||
        die_abort "Could not execute editor"

Step 2 and 3 and probably merged into a single one for a test case, but
that's how I keep triggering it.

Instead of adding it to the list of stashes, it should probably get
restored/re-applied right away, since no rebase actions have been triggered.


Please CC me in replies.


Cheers,
Daniel.
