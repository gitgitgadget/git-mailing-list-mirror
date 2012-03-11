From: David Bremner <david@tethera.net>
Subject: problem with merging notes.
Date: Sun, 11 Mar 2012 14:17:02 -0300
Message-ID: <87boo3m50x.fsf@zancas.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 11 18:49:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6mt8-0007iy-A1
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 18:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630Ab2CKRsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Mar 2012 13:48:53 -0400
Received: from tesseract.cs.unb.ca ([131.202.240.238]:34909 "EHLO
	tesseract.cs.unb.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574Ab2CKRsx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 13:48:53 -0400
X-Greylist: delayed 1904 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Mar 2012 13:48:53 EDT
Received: from fctnnbsc30w-142166230117.dhcp-dynamic.fibreop.nb.bellaliant.net ([142.166.230.117] helo=zancas.localnet)
	by tesseract.cs.unb.ca with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <bremner@unb.ca>)
	id 1S6mOJ-0000Y3-U3; Sun, 11 Mar 2012 14:17:08 -0300
Received: from bremner by zancas.localnet with local (Exim 4.77)
	(envelope-from <bremner@unb.ca>)
	id 1S6mOE-0004Vk-Cx; Sun, 11 Mar 2012 14:17:02 -0300
User-Agent: Notmuch/0.11.1+267~g4d13699 (http://notmuchmail.org) Emacs/23.3.1 (x86_64-pc-linux-gnu)
X-Spam-Score: -1.0
X-Spam_bar: -
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192817>


Hi;

It seems to me there is a bug (or at least some missing documentation)
for git notes merge --commit. If the working directory is
.git/NOTES_MERGE_WORKTREE, then all notes for the conflicting commit are
silently dropped.

A test script follows. Have I missed something?  

David

P.S. Please CC me, I'm not subscribed.


tmpdir=$(mktemp -d)
cd $tmpdir
git init
git commit --allow-empty -m'empty commit'
git notes add -m 'foo' HEAD
git notes --ref=other add -m 'bar' HEAD 
git notes merge refs/notes/other
cd .git/NOTES_MERGE_WORKTREE
echo "foo\nbar\n"> $(git rev-parse HEAD)
git notes merge --commit
cd ../..
git notes list | wc -l
