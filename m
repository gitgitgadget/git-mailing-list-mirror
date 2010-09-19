From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: Find out on which branch a commit was originally made
Date: Sun, 19 Sep 2010 18:03:09 -0400
Message-ID: <201009192203.o8JM39PE011067@no.baka.org>
References: <1jp0h7e.lgk0kp19qe5bbM%lists@haller-berlin.de> <201009192030.21659.robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 00:27:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxSLf-0006N8-KT
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 00:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104Ab0ISW0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 18:26:44 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:57270 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241Ab0ISW0n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 18:26:43 -0400
X-Greylist: delayed 1411 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Sep 2010 18:26:43 EDT
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id o8JM3A1h000901
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sun, 19 Sep 2010 18:03:11 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id o8JM39PE011067
	for <git@vger.kernel.org>; Sun, 19 Sep 2010 18:03:10 -0400
In-reply-to: <201009192030.21659.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156517>


>>>                A---B---C topic
>>>               /         \
>>>          D---E---F---G---H---I---J---K---L---M---N master
>>>                                   \         /
>>>                                    O---P---Q another-topic

>> No, that's not what I need either.  After thinking about it more, I
>> think what I want is "of all merges in the ancestry path from B to
>> master, show only those whose first parent can't reach B."  The result
>> is the list of all merges that were involved in bringing B to master.


> This would work, and i don't see a way to optimize it in git-speak,
> given that you don't want to see any extra trailing merges. [...]

The provided command actually doesn't work for me for all cases.  It
works for the simple case of "B", but does not work for "F", because F
saw merge H & M.  I think we need --not --first-parent, except that
doesn't actually work in this case either.  However, if we get the
full --first-parent rev-list and look for our commit, that works.
This is incredibly painful, though.

----------------------------------------------------------------------
#!/bin/sh
TARGET=`git rev-list -n 1 $1`
git branch -a --contains $1 | sed 's/^\** *//' | grep -v ' -> ' |
while read br; do
 if git rev-list --first-parent $br | grep -q "$TARGET"; then
  echo $br
 fi
done
----------------------------------------------------------------------

					-Seth Robertson
