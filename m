From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/4] push: add 'prune' option
Date: Thu, 23 Feb 2012 00:43:37 +0200
Message-ID: <1329950621-21165-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 23:45:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Kvi-0006Vf-NF
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 23:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044Ab2BVWox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 17:44:53 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:43465 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751461Ab2BVWow (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 17:44:52 -0500
Received: by lagu2 with SMTP id u2so658901lag.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 14:44:51 -0800 (PST)
Received-SPF: pass (google.com: domain of felipe.contreras@gmail.com designates 10.152.110.234 as permitted sender) client-ip=10.152.110.234;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of felipe.contreras@gmail.com designates 10.152.110.234 as permitted sender) smtp.mail=felipe.contreras@gmail.com; dkim=pass header.i=felipe.contreras@gmail.com
Received: from mr.google.com ([10.152.110.234])
        by 10.152.110.234 with SMTP id id10mr12806538lab.46.1329950691329 (num_hops = 1);
        Wed, 22 Feb 2012 14:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Jmk6QzuZqjUJ0SpzNepphnltwySct7G1NSE+KVlyR4A=;
        b=k3dJb3H22NI+U/PttOuB/J2HYf0mgZQyZAxJN3sccI7OeuhfLTzjqUXJXGIyIeFGA0
         RorjjhQ2B2mA8GH5EEFjMa/G/Orw4fOnHGKRz9d/xh3Uy/TIbG20fdxwto7MLH8ydMXb
         jRcD7ke2G/ottyfQbG35C4sLQaMXxoIgk6zhk=
Received: by 10.152.110.234 with SMTP id id10mr10796359lab.46.1329950691193;
        Wed, 22 Feb 2012 14:44:51 -0800 (PST)
Received: from localhost (a88-113-3-26.elisa-laajakaista.fi. [88.113.3.26])
        by mx.google.com with ESMTPS id o3sm33537149lbn.2.2012.02.22.14.44.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Feb 2012 14:44:50 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191304>

Hi,

As mentioned in a previous thread[1], git is lacking some functionality to
synchronize completely with remote repositories.

As an example I put my use-case; I want to backup *all* my local branches to a
personal repository, and I want to remove branches that I have removed from my
local repository. git push personal 'refs/heads/*' mostly does the job, but it
doesn't remove anything, and that's where 'prune' comes from.

Do not confuse the remote branches with the upstream ones; you could have two
repositories where you want to synchronize branches to:
% git push --prune --force backup1 'refs/heads/*'
% git push --prune --force backup2 'refs/heads/*'

I still think a 'git remote sync' would be tremendously useful, but it can
actually use this --prune option.

Cheers.

[1] http://article.gmane.org/gmane.comp.version-control.git/184990

Since RFC:

 - Most of comments addressed
 - Documentation and tests added

Felipe Contreras (4):
  remote: use a local variable in match_push_refs()
  remote: reorganize check_pattern_match()
  remote: refactor code into alloc_delete_ref()
  push: add 'prune' option

 Documentation/git-push.txt |    9 +++-
 builtin/push.c             |    2 +
 remote.c                   |  107 ++++++++++++++++++++++++++++----------------
 remote.h                   |    3 +-
 t/t5516-fetch-push.sh      |   16 +++++++
 transport.c                |    2 +
 transport.h                |    1 +
 7 files changed, 100 insertions(+), 40 deletions(-)

-- 
1.7.9.1
