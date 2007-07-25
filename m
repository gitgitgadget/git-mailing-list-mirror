From: Andy Parkins <andyparkins@gmail.com>
Subject: bug: update hook failure doesn't prevent local deletion of a branch
Date: Wed, 25 Jul 2007 12:50:06 +0100
Message-ID: <200707251250.08166.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 25 13:50:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDfNv-00024i-QQ
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 13:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbXGYLuP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 07:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbXGYLuP
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 07:50:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:61115 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbXGYLuN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 07:50:13 -0400
Received: by ug-out-1314.google.com with SMTP id j3so330859ugf
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 04:50:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=h36qJT9H0SMot9XbGA3Frk9Trve0OE38txD8/qUTkVwr9PvAh7v+5gzxzi9xj2DxO7W9UvaewHLPRJ8t5N3kaLHbsKx1U2R8CMcH2Wz6+X+EH6+sSL7oDw0DrsYtUVOrN2M1znTy0si/DrcuEj1Bt98+piZLvy6m/u3ORYvh3rs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Rjc8lUn6DJb3U83QsaDWMamL5O0owkiWz5qrfxe/2xU+5MF1A+9Taju2GAlSTGvaYeJ3TaIct2fGH4uXh8L7BRnCveGREm+RcLiYlHRNFSFfwIwse/yaunl+iZTX/hcMOghJ8V2Zm+j/V/arWnVa8VnKCZS6epE6WAzrLzvS0DM=
Received: by 10.66.248.5 with SMTP id v5mr1347729ugh.1185364212031;
        Wed, 25 Jul 2007 04:50:12 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id c25sm1231780ika.2007.07.25.04.50.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Jul 2007 04:50:10 -0700 (PDT)
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53685>

Hello,

I wanted to delete a branch (let's call it "deleted-branch") from my public 
repository.  I ran this:

$ git push origin :deleted-branch
deleting 'refs/heads/deleted-branch'
 Also local refs/remotes/up/deleted-branch
*** Update hook: aborting
error: hooks/update exited with error code 1
error: hook declined to update refs/heads/deleted-branch
ng refs/heads/deleted-branch hook declined
error: failed to push to '/path/to/git/repo.git'

Coincidentally, my update hook happened to have a bug in it that prevented me 
from running the operation.

However, when I run the operation again...

$ git push origin :deleted-branch
deleting 'refs/heads/deleted-branch'
 Also local refs/remotes/up/deleted-branch
error: unlink(.git/refs/remotes/up/deleted-branch) failed: No such file or 
directory
error: Failed to delete

If the remote didn't get deleted, then it seems wrong that the local copy does 
get deleted.

Summary: when using git-push to delete a remote branch, and that deletion is 
disallowed by the update hook, the local tracking branch _is_ deleted.

Obviously, this isn't _that_ serious because it could be recovered again with 
a git-fetch; but it does make some scary looking errors.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
