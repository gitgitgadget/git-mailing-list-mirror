From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: Problem: staging of an alternative repository
Date: Wed, 30 Apr 2014 14:22:44 -0700
Message-ID: <CAKpPgveXqraM4bXb499mJm5Ls+EinihfEJ6VgOFikC0_Qp8iTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 23:23:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfbyD-0007Dv-9D
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 23:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945941AbaD3VXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 17:23:08 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:48617 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965185AbaD3VXF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 17:23:05 -0400
Received: by mail-oa0-f48.google.com with SMTP id i4so1959141oah.21
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 14:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=Fg8aB6e1TaJa5/OBT7K9nIHngDYHrRCEmMmVJ87ot4I=;
        b=uChAZfe7TWCuHOEqwWLnJ7TaUEZKj/k+L9D6e/nmZems3QKU6dOXE/L1VqMf9tGDhv
         sHnPWue0Lsz0NeGcbM+6P6FG44UBD7VJX/AQAI939ccwDgoC2Y3TXmP6+LhmKikf1ZlM
         mUpaVL7qXvTfEppMdyIF5bbcDZaNiV9fUvSEa2CN4KxPMsDqciqlJ6lT7lhMFF+6+OQ8
         FX+l2ySROBiWqcFc8EUM0ZTjHTFzAO5S+Aoi8NJnQVmfMv9u3a+PHz3brv2oy/daezCz
         7ZFaRtIHPvaQnOBHOWgvkZ3UouCkdxWD3yhZMRpvREQwBzUbp74iscH/0aTSljb0OTVv
         sZSg==
X-Received: by 10.182.24.69 with SMTP id s5mr6122708obf.35.1398892984441; Wed,
 30 Apr 2014 14:23:04 -0700 (PDT)
Received: by 10.60.246.130 with HTTP; Wed, 30 Apr 2014 14:22:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247781>

        Hi

    It turns out Git treats the directory '.git' differently enough
from everything else. That may be ok, but here's one place where I
encountered an unpleasant (and imho unexpected) behaviour:

    if you supply a different repository base name, say, '.git_new',
by either setting GIT_DIR or using the '--git-dir' option, Git 'add'
will not make any exception for it and think of it as a new (weird)
directory. In particular, 'git add -A' with a consequent commit will
add this repository into itself with all its guts.

    Now I know, the '--git-dir' option may usually be meant to use
when the repository is somewhere outside of the work tree, and such a
problem would not arise. And even if it is inside, sure enough, you
can add this '.git_new' to the ignores or excludes. But is this really
what you expect?

    I come forward to offer my own will to fix this behaviour (which
is rooted in 'dir.c'). However there are uncertainties, and I'm asking
for an opinion.

    Apparently, the assumption that the repository is in '.git' has
propagated far enough. In particular, every '.git' within the working
tree seems to be ignored for the purpose of staging. Is this a
consistent behaviour? And, perhaps there are a million more places
where the name '.git' is hard-coded, and it might be reasonable to
question the legitimacy for that. Or, in contrast, to what degree or
depth (in the source code) does one *expect* Git to rename all its
hard-coded '.git's into '.gut's when a "GIT_DIR=.gut" is supplied?

   cheers
Pavel
