From: John Butterfield <johnb003@gmail.com>
Subject: Proposal: Write git subtree info to .git/config
Date: Thu, 13 Mar 2014 16:18:42 -0700
Message-ID: <CAJ2ZDL+HuBCv_xJCXEBb3Pex-qt86ocEX9yu=uV+CzdvqwECDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 00:18:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOEtk-0001zI-PW
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 00:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366AbaCMXSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 19:18:44 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:40689 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601AbaCMXSo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 19:18:44 -0400
Received: by mail-wi0-f171.google.com with SMTP id hn9so4638167wib.4
        for <git@vger.kernel.org>; Thu, 13 Mar 2014 16:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=08n51Fy3c97cAl4q0M4bPPDfJYhiT4ANL0Y0wsOaPPw=;
        b=MYNMBcIfwPSiHRxJ9FJpeDdCMQdqaLEyMc54jA5Nx3Dc8gTnu9xA5oqINyNmYvwPEK
         6Vi+f4LAxQEmKw9puz2qh4f2yfsltijYdWZFNc+NrXOP6cvswG9UYyRC95L3KdD6eH3x
         H20gBAhrZFKHVR1D71pGhig6fGHpHOO7YkoIi7DAyzXXbw8uHGlMJ8ahkqAtlkehq4xd
         6BaSVo5IOlogSeldhPl3e6XP8Y0kPpgBo4wsNIp50jO5aRoxcEk/xgDKiuoFtM0ZIfoX
         AMk8lvDym6gQZGswOVxhdr09wdVbvLFxrzGNm1a2dj1A8ck/FRsfwbm4qEjq0vj9C1z3
         hURQ==
X-Received: by 10.180.106.167 with SMTP id gv7mr3686475wib.40.1394752722925;
 Thu, 13 Mar 2014 16:18:42 -0700 (PDT)
Received: by 10.194.174.226 with HTTP; Thu, 13 Mar 2014 16:18:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244060>

Has there been any talk about adding a stub for git subtrees in .git/config?

The primary benefits would be:

1. Determine what sub directories of the project were at one time
pulled from another repo (where from and which commit id), without
having to attempt to infer this by scanning the log.
2. Simplify command syntax by providing a predictable default (ie.
last pulled from, last pushed to), and not requiring the repo argument
optional.
3. Improvement for default commit id to start split operations over
using --rejoin which creates blank log entries just so the log scan
can find it (afaict). It's a default either way, so it can still
always be explicitly specified.

If this information were available in the config, I think additional
features could be added as well:

- The command 'git subtree pull' for instance could be made to pull
*all* subtrees, similar to the way 'git submodule update' works.
- An option -i (interactive), or -p (prompt), etc. could be added that
confirms the defaults read from the config before actually executing
the command with implicit arguments, and the ability to modify the
arguments before the command actually executes.
- If the current working directory from which the command is run
happens to be a subtree specified in the config, the --prefix could
even be implied.


None of these ideas would break the way the command currently works
since it can still always take explicit arguments. There's a comment
in the documentation about the command that says:

> Unlike submodules, subtrees do not need any special constructions (like .gitmodule files or gitlinks) be present in your repository

It would still be true that subtrees do not *need* any special config
settings, but that doesn't mean they are bad, and by having them the
command could be improved and made easier to use.

I'm happy to contribute the changes myself if this proposal is acceptable.
