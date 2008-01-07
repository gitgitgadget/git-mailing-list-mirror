From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: git-rev-parse incorrectly uses --default parameter when invalid
 revision is supplied
Date: Mon, 7 Jan 2008 17:38:42 -0600 (CST)
Message-ID: <Pine.LNX.4.64.0801071653460.31161@torch.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 00:39:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC1Yo-0007F3-Ix
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 00:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755793AbYAGXir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 18:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755758AbYAGXir
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 18:38:47 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55876 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222AbYAGXiq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 18:38:46 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m07NchlV001592
	for <git@vger.kernel.org>; Mon, 7 Jan 2008 17:38:43 -0600
Received: from torch.nrlssc.navy.mil ([128.160.25.59]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 7 Jan 2008 17:38:43 -0600
X-OriginalArrivalTime: 07 Jan 2008 23:38:43.0302 (UTC) FILETIME=[70625860:01C85186]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15652001
X-TM-AS-Result: : Yes-1.836200-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjY4LTcwMzc4OC03MDIw?=
	=?us-ascii?B?MzctNzAyNjA5LTcwMjcyNi03MDE2MTgtNzAyOTIwLTcwMDM3My03?=
	=?us-ascii?B?MDIxMjYtNzAxMjAyLTcwNDQxMC03MDMzNTUtNzA5NTg0LTcwMDc1?=
	=?us-ascii?B?Ni03MDIzNTgtNzA3NDUxLTcwMzI4My03MDgzMjUtNzAyMDQ0LTcw?=
	=?us-ascii?B?MTczOC03MDgxNzktNzA0MjU3LTcwNTE3OC0xNDgwMzktMTQ4MDUw?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69827>


When rev-parse is called with an invalid revision parameter and
--default has been used to set a default revision, the output
will be based on the parameter to --default.

For example:

  This likely fails:
    $ git rev-parse --verify foobar
    fatal: Needed a single revision

  This likely succeeds but probably should fail:
    $ git rev-parse --verify --default refs/heads/master foobar
    b2e62a7dc6ba20a354d7590bf6a1d9264de7efe3


The documentation for rev-parse says:
   --default <arg>::
         If there is no parameter given by the user, use `<arg>`
         instead.


git-stash uses this command, so a typo could cause the wrong stash
to be applied.

   git stash apply stsh@{1}

If stash@{0} exists, it will be applied which is definitely not
what the user would want.

It is not straight forward to me how to modify builtin-rev-parse.c
to fix this.

-brandon
