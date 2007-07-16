From: David Kastrup <dak@gnu.org>
Subject: Can someone explain this git-blame/git-rev behavior to me?
Date: Mon, 16 Jul 2007 12:43:26 +0200
Message-ID: <86sl7oaasx.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 12:43:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAO3K-0000uh-Sb
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 12:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbXGPKnj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 16 Jul 2007 06:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755014AbXGPKnj
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 06:43:39 -0400
Received: from main.gmane.org ([80.91.229.2]:58889 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752924AbXGPKnj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 06:43:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IAO3B-0000XY-96
	for git@vger.kernel.org; Mon, 16 Jul 2007 12:43:33 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 12:43:33 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 12:43:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:e8qXzhk9kLYtgBHhdH9X3AKnAnU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52657>


Try the following (assuming you have a clone of the git master):

git-blame tags/v1.4.2-rc1~87 -- contrib/emacs/vc-git.el | grep b5dd
b5dd9d20 (Ville Skytt=E4      2006-07-05 01:35:52 +0300 164) (defun vc-=
git-print-log (file &optional buffer)
b5dd9d20 (Ville Skytt=E4      2006-07-05 01:35:52 +0300 167)     (vc-do=
-command buffer 'async "git" name "rev-list" "--pretty" "HEAD" "--")))
b5dd9d20 (Ville Skytt=E4      2006-07-05 01:35:52 +0300 169) (defun vc-=
git-diff (file &optional rev1 rev2 buffer)
b5dd9d20 (Ville Skytt=E4      2006-07-05 01:35:52 +0300 170)   (let ((n=
ame (file-relative-name file))
b5dd9d20 (Ville Skytt=E4      2006-07-05 01:35:52 +0300 171)         (b=
uf (or buffer "*vc-diff*")))
b5dd9d20 (Ville Skytt=E4      2006-07-05 01:35:52 +0300 173)         (v=
c-do-command buf 0 "git" name "diff-tree" "-p" rev1 rev2 "--")
b5dd9d20 (Ville Skytt=E4      2006-07-05 01:35:52 +0300 174)       (vc-=
do-command buf 0 "git" name "diff-index" "-p" (or rev1 "HEAD") "--"))

Ok, now do

git-name-rev b5dd9d20
b5dd9d20 tags/v1.4.2-rc1~88

So what is it I am doing wrong here?  The problem I have is that in
Emacs, one can go to the "next version" in an annotated file, and I
get stuck in a loop here, since tags/v1.4.2-rc1~88 delivers

git-rev-list HEAD --not tags/v1.4.2-rc1~88 --parents contrib/emacs/vc-g=
it.el|tail -1|git-name-rev --stdin

d87b90e47f7430455385edcf8506288b9a73d3b5 (tags/v1.4.2-rc1~87) b5dd9d202=
7c1bd5758033c7baf6d087752b0263d (tags/v1.4.2-rc1~88) 280242d1cc1fe2847f=
649d2f16b273e168fcbc48 (tags/v1.4.2-rc1~92)

So we have tags/v1.4.2-rc1~87 listed as successor again, so I get into
a loop of blame.

Is there something I don't understand about merges?

=46WIW,
git-fsck --unreachable b5dd9d20
git-fsck --unreachable d87b90e47f
do not return anything.


--=20
David Kastrup
