From: Tim Janik <timj@gtk.org>
Subject: git-commit broken with GIT_INDEX_FILE
Date: Wed, 31 Oct 2007 16:02:32 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0710311549380.21251@master.birnet.private>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 31 16:24:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InFQQ-0005Cf-8y
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 16:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759623AbXJaPX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 11:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759624AbXJaPX6
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 11:23:58 -0400
Received: from mx02.hansenet.de ([213.191.73.26]:32802 "EHLO
	webmail.hansenet.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759611AbXJaPX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 11:23:57 -0400
X-Greylist: delayed 1258 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Oct 2007 11:23:56 EDT
Received: from birnet.org (85.176.204.131) by webmail.hansenet.de (7.3.118.12)
        id 47207D130092E1D4 for git@vger.kernel.org; Wed, 31 Oct 2007 16:02:56 +0100
Received: from master.birnet.private (localhost [127.0.0.1])
	by birnet.org (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l9VF2XMj022495
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 31 Oct 2007 16:02:33 +0100
Received: (from timj@localhost)
	by master.birnet.private (8.13.4/8.13.4/Submit) id l9VF2Wuq022494;
	Wed, 31 Oct 2007 16:02:32 +0100
X-X-Sender: timj@master.birnet.private
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62844>

hey All.

i'm maintaining my own git porcelainen, and as part of that had to
(re-)implement my own commit command:
   http://blogs.gnome.org/timj/2007/10/13/13102007-yummy-yummy-porcelain-version-08/

i've read through git-commit and cg-commit, and would really like to avoid
reimplementing the hook and utf8 encoding handling. thus, my tool calls
git-commit once it has created an index file with all the files that
need comitting.
ideally, it'd construct a temporary index, e.g. $GIT_DIR/next-index$$ and
then invoke:
   GIT_INDEX_FILE=$GIT_DIR/next-index$$ git-commit -F commitmsg.txt
this is not working as expected however.

when GIT_INDEX_FILE=tmpindex is specified for git-commit-1.5.3.4, it will
construct a commit message for tmpindex, but it'll still use the standard
index file $GIT_DIR/index for git-write-tree.

(so my current implementation saves and restores the standard index file
around committs.)

for consistent commit messages, the index file used for commit message
construction should be the same index used for git-write-tree.
ideally however, GIT_INDEX_FILE=tmpindex git-commit would work correctly
in using tmpindex for git-write-tree as well.

---
ciaoTJ
