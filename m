From: lists@haller-berlin.de (Stefan Haller)
Subject: git-update-index loses executable bit for unmerged files when core.filemode is false
Date: Fri, 22 Oct 2010 19:28:47 +0200
Message-ID: <1jqpu2f.1qxnixxtdqhreM%lists@haller-berlin.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 19:29:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9LQa-0000ts-5i
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 19:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758072Ab0JVR2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 13:28:53 -0400
Received: from mail.ableton.net ([62.96.12.115]:40319 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755694Ab0JVR2x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 13:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:To; bh=Q2hlCWMT2N2FrstVkCdH/dLtdsGYO0MB4NKNL+sohyg=;
	b=e5s3lfW+UwQWKOKe1zMzD/2NQ6Qq5dlUvpkVg++x31I5zyCZwbIgFPIZk8rKdwnt3UnwSpsMjkAI8CAcQnIE5N2qj6DG+m9vlzKcOa9B3ITpGpMacOzLc/r274RZY1cGUd2o4co3OlG7gcsMvZ4XOipTTBG44SIfRu6SNyOqDVE=;
Received: from macbook-stk.office.ableton.com ([10.1.12.43])
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1P9LQ8-0005KV-I6
	for git@vger.kernel.org; Fri, 22 Oct 2010 19:28:48 +0200
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159716>

There's a bug with the handling of the executable bit when core.filemode
is false: when you have an executable file that has unmerged changes,
and you stage it with "git update-index", the executable bit is lost.
If you stage it with "git add" instead, it works fine.

    git init test
    cd test
    git config core.filemode false
    touch foo
    git add foo
    git update-index --chmod=+x foo
    git commit -m "Initial revision"
    git branch br
    echo bla >foo
    git commit -a -m "Changed foo"
    git checkout br
    echo blubb >foo
    git commit -a -m "Changed foo"
    git merge master
    git update-index foo
    git diff --staged

See how the diff shows that the mode goes from 100755 to 100644.  If you
replace the second-to-last line with "git add foo", it doesn't.

I started to trace this down, but I didn't get very far, as I'm not
familiar enough with the git codebase yet; so any help would be
appreciated.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
