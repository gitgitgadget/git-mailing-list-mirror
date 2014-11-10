From: Onno Kortmann <onno@gmx.net>
Subject: [PATCH] Show number of commits being rebased interactively
Date: Mon, 10 Nov 2014 17:32:19 +0100
Message-ID: <5460E893.7080003@gmx.net>
References: <md5:H/n6RCGs7zvP8Sp7z7ElnQ==>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 10 17:32:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnrtD-0001JV-G1
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 17:32:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbaKJQcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 11:32:23 -0500
Received: from mout.gmx.net ([212.227.15.19]:64168 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966AbaKJQcX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 11:32:23 -0500
Received: from [192.168.6.43] ([217.191.199.173]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MCcvy-1XfaQp0ONm-009NGg for <git@vger.kernel.org>;
 Mon, 10 Nov 2014 17:32:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <md5:H/n6RCGs7zvP8Sp7z7ElnQ==>
X-Provags-ID: V03:K0:SulX7Lac8zrS06WDd9jM/x55k2vPceRi7YtuY6mHLADOnGiwrsl
 ZPkOjgaQz5BxTg/UT+sN9lGp5hd/4WeCx9Yg+en8BbVgwcN4xVCnj9xHPpS4ZsSX3t/+FXs
 chCWQx1wGkYICHPA1LwjXYeo8K6T7A6uyyffcMlVzGIUUf+7pJ86s5eJ1F2xnGPoY0+08mB
 gLBjLvRWBahMG/3S1eiaQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again,

oops, I realized that my MUA mangled the patch, even though it
shouldn't. Here it is again, with a bit more description.
---

During 'rebase -i', one wrong edit in a long rebase session might
inadvertently drop commits. This change shows the total number of
commits in the comments below the commit list. After the rebase
edit, the number can be quickly compared to the line number of
the last commit - by scrolling to the last entry in the rebase
TODO list. This gives peace of mind that no commits have been
lost in the edit.

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
