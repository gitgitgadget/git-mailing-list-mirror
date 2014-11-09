From: Onno Kortmann <onno@gmx.net>
Subject: [PATCH] Show number of commits being rebased interactively
Date: Sun, 09 Nov 2014 14:24:32 +0100
Message-ID: <545F6B10.5010505@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 09 14:24:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnSTv-0004MM-Ik
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 14:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbaKINYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 08:24:36 -0500
Received: from mout.gmx.net ([212.227.15.19]:62740 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788AbaKINYf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 08:24:35 -0500
Received: from [192.168.6.43] ([217.191.214.175]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0MKIEQ-1XloJz2982-001kt1 for <git@vger.kernel.org>;
 Sun, 09 Nov 2014 14:24:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-Provags-ID: V03:K0:s86MGB7rZZS7b1vwYp5yNywYJZhdqMzsP/LL8S6DAP23U7NLC2i
 ONgmEo4H6qbl2aj41MG7RXSzJjuXW9MSdm5bx1SAsRKpG6/Y6zoyc7/0Kdk+dpJW8qCL0TM
 FekqFnj52OOqDySbZgA4SWOTjbJOgpylriacgrzXpEEKRl00FhenCjsl5IZVrjE+3vqt8V7
 LGwSXRcMs+s7DEdmW7Bmw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During 'rebase -i', a wrong edit command might inadvertently drop
commits. This change shows the total number of commits in the comments below
the commit list. After a rebase edit, this number can be quickly compared to
the line number of the last commit in the rebase TODO list.

Signed-off-by: Onno Kortmann <onno@gmx.net>
---
 git-rebase--interactive.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b64dd28..b266dc0 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1031,9 +1031,11 @@ test -s "$todo" || echo noop >> "$todo"
 test -n "$autosquash" && rearrange_squash "$todo"
 test -n "$cmd" && add_exec_commands "$todo"
 +commitcount=$(git stripspace --strip-comments <"$todo"  | wc -l)
+
 cat >>"$todo" <<EOF
 -$comment_char Rebase $shortrevisions onto $shortonto
+$comment_char Rebase $shortrevisions onto $shortonto ($commitcount commit(s))
 EOF
 append_todo_help
 git stripspace --comment-lines >>"$todo" <<\EOF
-- 
2.2.0.rc1.1.gbab0d06
