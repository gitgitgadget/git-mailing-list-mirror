From: Bill Lear <rael@zopyra.com>
Subject: Possible kinder GIT-VERSION-GEN?
Date: Mon, 4 Feb 2008 14:28:48 -0600
Message-ID: <18343.30080.67524.3427@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 21:29:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM7wd-0004lF-JA
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 21:29:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757642AbYBDU2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 15:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757374AbYBDU2x
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 15:28:53 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61182 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755445AbYBDU2w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 15:28:52 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id m14KSqo08395;
	Mon, 4 Feb 2008 14:28:52 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72558>

I have my home directory under git control, and I have a build
directory (not tracked by git) under my home directory into which I
untar files and then in which I build things, including git.

When doing this, the version reported always contains the '-dirty'
suffix, which I find annoying (and potentially misleading).  I traced
this to the GIT-VERSION-GEN script, and I "fixed" it by checking
if there is a '.git' directory present before invoking git diff-index,
something like this:

dirty=$(sh -c 'test -f .git && git diff-index --name-only HEAD' 2>/dev/null) || dirty=
case "$dirty" in
'')
        ;;
*)
        VN="$VN dirty" ;;
esac

If someone of authority here thinks this seems reasonable (or has a
better way), I will test this (along with any suggested improvements)
with the git repo itself (to ensure it puts '-dirty' when it really
should), and submit a patch.


Bill
