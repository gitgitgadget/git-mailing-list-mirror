From: "Daniel Berlin" <dberlin@dberlin.org>
Subject: git-svn goes into infinite loop rebuilding rev_map
Date: Fri, 16 May 2008 13:15:56 -0400
Message-ID: <4aca3dc20805161015l28d1e4a2u318c1bc23bb5b925@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 16 19:16:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx3Y2-0005e1-7M
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 19:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbYEPRP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 13:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbYEPRP7
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 13:15:59 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:19030 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbYEPRP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 13:15:58 -0400
Received: by wx-out-0506.google.com with SMTP id h29so754950wxd.4
        for <git@vger.kernel.org>; Fri, 16 May 2008 10:15:57 -0700 (PDT)
Received: by 10.90.91.9 with SMTP id o9mr5274881agb.95.1210958156964;
        Fri, 16 May 2008 10:15:56 -0700 (PDT)
Received: by 10.90.49.12 with HTTP; Fri, 16 May 2008 10:15:56 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82307>

Starting last night, for no particularly obvious reason, git-svn fetch
(or git-svn rebase or any command that does naything interesting) on
gcc.gnu.org's repo causes git-svn to do the following:

-bash-3.00$ git-svn fetch
Rebuilding .git/svn/trunk/.rev_map.138bc75d-0d04-0410-961f-82ee72b054a4 ...
Done rebuilding .git/svn/trunk/.rev_map.138bc75d-0d04-0410-961f-82ee72b054a4
Rebuilding .git/svn/trunk/.rev_map.138bc75d-0d04-0410-961f-82ee72b054a4 ...
<repeat forever>


I checked the obvious things. There is no permissions problem, strace
doesn't show the writes failing, etc.
git-fsck shows nothing as being obviously wrong.


This just suddenly started happening with no obvious reason (we fire
off git-svn fetch and rebase on the repo when cvs commits happen).

git-log shows the last processed rev was:

commit e66b310fb9a3ddc7ed5143db3c468711c8a36d08
Author: uros <uros@138bc75d-0d04-0410-961f-82ee72b054a4>
Date:   Thu May 15 14:38:23 2008 +0000

        * config/i386/sse.md (*vec_concatv2sf_sse4_1): Add "m" constraint
        to alternative 4 of operand 2.


    git-svn-id: svn+ssh://gcc.gnu.org/svn/gcc/trunk@135364
138bc75d-0d04-0410-961f-82ee72b054a4


I'm happy to provide anything i can to get the problem fixed, but not
being a git expert, i have no idea what is up here.
