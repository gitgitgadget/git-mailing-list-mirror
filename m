From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 0/7] gitweb: allheads feature
Date: Thu, 16 Sep 2010 11:30:58 +0200
Message-ID: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 16 11:31:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwAoV-0007Cg-Cx
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 11:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522Ab0IPJb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 05:31:26 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34856 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab0IPJbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 05:31:25 -0400
Received: by wwe15 with SMTP id 15so130944wwe.1
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 02:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=7P0UMC1FxCv3Ut5hIM2zgjOCf0lT0j+r+udAbl4cAYU=;
        b=fCjJt9DFhGYJP9F3dtwOzCkXDFnM/GPPk4NYn3Z0rPa+kMMuS33LbkWdjMnMRRtJYd
         umdPSBGMOVWrF5uZog3pXalKrNLA/qh9svKkUilA4pi1nxyh3ohJB+3M2b3qipJs5nvt
         5RKC7t0M5OjBAPNFcFWrS90DWeEH7fXepyYtk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=jmyqbHbWB1rFbIBlGdlcsv8IONu7aczqSRDyRoCmNCo457QQ7t6ciTDvUUc9GTcdqB
         bQfjbSBGHzbbkI6XwJQfBOyvQ8R20Ivklc34kAI6qWvqJsU77twQsv77VHTsFnc3P56w
         weTwpkufV6yV2mUb+OhGGBi2/DRDw4+22mUVk=
Received: by 10.227.196.1 with SMTP id ee1mr2418654wbb.98.1284629482877;
        Thu, 16 Sep 2010 02:31:22 -0700 (PDT)
Received: from localhost ([151.60.177.109])
        by mx.google.com with ESMTPS id b23sm2126726wbb.16.2010.09.16.02.31.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Sep 2010 02:31:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.230.g8b572
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156303>

This is a rehash of an old patchset of mine that got stalled waiting for
other independent patches to go in first, and then for me to get the
time to work on it again.

The first 4 patches are IMO ready for inclusing in gitweb, and their
purpose is to introduce a new view (and a new summary block) that
display all the remote heads (assuming the feature is enabled).
Somebody suggested via email that this could even the basis for some
kind of 'social graph' for gitweb repositories, in a way similar to what
is found on sites like github or gitorious, but for me the feature in
itself can already be useful.

The last three patches are more of the RFC side, in particular the last
one. The idea is to group remote heads 'by remote' instead of just
listing them serially. So I first introduce code and styling to have
'blocks of stuff' in gitweb, and then use this concept to group together
remote heads belonging to the same remote.

The final result is rather curious and you can see it in action at
<http://git.oblomov.eu/rbot/remotes>, although it would be nice to find
a way to layout the blocks in a smarter way. What I really don't like
(at the moment) is the way things come out in summary view instead.

The issue there is that we only gather 16 remote heads, so some remotes
might have no branches displayed, but it becomes difficult to detect and
indicate when remotes have incomplete information being displayed. A
possible solution would be to call show-ref N times (N being the number
of remotes) with a limit of 16/N heads, but that can be a lot of calls.
So I'm open to suggestions on how to improve this part (maybe just show
a flat view in the remotes section of summary view?)

Giuseppe Bilotta (7):
  gitweb: introduce remote_heads feature
  gitweb: git_get_heads_list accepts an optional list of refs.
  gitweb: separate heads and remotes lists
  gitweb: link heads and remotes view
  gitweb: auxiliary functions to group data
  gitweb: group styling
  gitweb: group remote heads

 gitweb/gitweb.perl       |  100 ++++++++++++++++++++++++++++++++++++++++++---
 gitweb/static/gitweb.css |    6 +++
 2 files changed, 99 insertions(+), 7 deletions(-)

-- 
1.7.3.rc1.230.g8b572
