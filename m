From: Alex Chiang <achiang@hp.com>
Subject: [StGit RFC PATCH 0/6] add support for git send-email
Date: Sat, 28 Nov 2009 12:50:11 -0700
Message-ID: <20091128194056.949.88791.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Karl Wiberg <kha@treskal.com>
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sat Nov 28 20:50:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NETJD-0000CL-Dy
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 20:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523AbZK1TuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 14:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753275AbZK1TuG
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 14:50:06 -0500
Received: from g1t0029.austin.hp.com ([15.216.28.36]:18453 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbZK1TuF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 14:50:05 -0500
Received: from g4t0018.houston.hp.com (g4t0018.houston.hp.com [16.234.32.27])
	by g1t0029.austin.hp.com (Postfix) with ESMTP id BEEFB3800F;
	Sat, 28 Nov 2009 19:50:11 +0000 (UTC)
Received: from ldl (linux.corp.hp.com [15.11.146.101])
	by g4t0018.houston.hp.com (Postfix) with ESMTP id 7353710057;
	Sat, 28 Nov 2009 19:50:11 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl (Postfix) with ESMTP id 4A7F0CF0009;
	Sat, 28 Nov 2009 12:50:11 -0700 (MST)
Received: from ldl ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ru+zpOYrXv3a; Sat, 28 Nov 2009 12:50:11 -0700 (MST)
Received: from eh.fc.hp.com (eh.fc.hp.com [15.11.146.105])
	by ldl (Postfix) with ESMTP id 34D58CF0007;
	Sat, 28 Nov 2009 12:50:11 -0700 (MST)
Received: by eh.fc.hp.com (Postfix, from userid 17609)
	id 1379626172; Sat, 28 Nov 2009 12:50:11 -0700 (MST)
X-Mailer: git-send-email 1.6.5.2.74.g610f9
User-Agent: StGit/0.15-6-g435b-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133973>

Hi Catalin,

This series starts down the path of eventually converting stg mail to
simply become a wrapper around git send-email.

The first 4 patches do some refactoring of internal APIs to set us up
for the money patch 5/6 which actually adds the call to git send-email.

Patch 6/6 shows a hint of the future, where we can start leveraging
some of the features in git send-email for our own purposes. With it,
you can now use mail aliases as supported by git send-email.

stg mail still has some nice features over git send-email, such
as the -v command line parameter and --prefix. Maybe at some point
in the future, we can migrate those features into git send-email and
continue thinning out stg mail.

But I wanted to get some feedback first to make sure I'm going in the
right direction before going too much further.

Disclaimer: I'm not really a python coder. Particularly, patch 5/6
is ugly in how we look at the various stg mail options. I'm sure there's
lots of room for improvement.

This mail was sent with:
	./stg mail -a --git --auto -e 

[Karl, sorry about the earlier accidental mail. That was a testing mishap.]

Thanks,
/ac

---

Alex Chiang (6):
      stg mail: Refactor __send_message and friends
      stg mail: reorder __build_[message|cover] parameters
      stg mail: make __send_message do more
      stg mail: factor out __update_header
      stg mail: add basic support for git send-email
      stg mail: don't parse To/Cc/Bcc in --git mode


 stgit/commands/mail.py |  205 ++++++++++++++++++++++++++++--------------------
 1 files changed, 121 insertions(+), 84 deletions(-)
