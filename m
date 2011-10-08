From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 0/9] ref completion optimizations, fixes, and cleanups
Date: Sat,  8 Oct 2011 16:54:34 +0200
Message-ID: <1318085683-29830-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 16:55:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCYIx-0000CI-Tn
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 16:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549Ab1JHOzG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Oct 2011 10:55:06 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:52872 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433Ab1JHOzF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 10:55:05 -0400
Received: from localhost6.localdomain6 (p5B130863.dip0.t-ipconnect.de [91.19.8.99])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0MVHuk-1RcJyJ11Z8-00Yy0z; Sat, 08 Oct 2011 16:54:49 +0200
X-Mailer: git-send-email 1.7.7.187.ga41de
X-Provags-ID: V02:K0:iXsQGYY+vhIbqZUB+U9uzN7+7tM7nKETPKwLM4rP1QL
 lzXd8bCOvrlysya6VpHUWQudn7B/9uJua5MyuWQTWMFhszZ5Dj
 xNPU0xWMbv/8Xnj3id6NWPR7A+rGWYqVu7RUGLIMoqlAKPg2u7
 3eQ3FwnaDPXKlgbOjKv8AoGQCr7JJTqmWQhuwVXgfqn+ZOt6vw
 749OLincljUlD1P7O+YL6TRTl8of3X3TAgkmmljXVzyaLA1O+N
 8FAqfBzqobtUuYrABOTBhqi5XoS65vu8KzMPnd8k03jXXP/Xun
 +XRVUahWE2NKT0MtwLkHxLYzKByWle2UA8ScHQfq6urHS8BGTU
 vYGWMStOZX/+HbB4nStaWnXlH5BJ5uieP8gSvkF002vm+rSJqc
 zoc/0UjxUOeIQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183144>

Hi,

This series aims to improve the completion of refs & co.

This one is the most important in the series; it takes some shortcuts
to make completing large number of refs faster (it's also faster for
git.git, but it's unnoticeable).

  [2/9] completion: optimize refs completion

The following three make __git_refs() handle local and remote
repositories more consistently, and also clean up the remote-handling
code part of __git_refs().  They likely make things a bit faster, but
since the code path usually involves network communication I didn't
run any benchmarks.

  [3/9] completion: make refs completion consistent for local and remot=
e
          repos
  [4/9] completion: improve ls-remote output filtering in __git_refs()
  [5/9] completion: support full refs from remote repositories

The following two do similar cleanups in __git_refs_remotes() than 3/9
and 4/9 in __git_refs().

  [6/9] completion: query only refs/heads/ in __git_refs_remotes()
  [7/9] completion: improve ls-remote output filtering in
          __git_refs_remotes()

A silly while-at-it optimization; the delay eliminated by this one was
annoying when testing 6/9 and 7/9.

  [8/9] completion: fast initial completion for config 'remote.*.fetch'
          value

And finally remove some bitrotted code.

  [9/9] completion: remove broken dead code from __git_heads() and
          __git_tags()


This series is meant to be applied on the merge of master and 77653abd
(completion: commit --fixup and --squash, 2011-10-06) from pu, and the
patch in

  Message-ID: <20111008010634.GB11561@goldbirke>
  (http://article.gmane.org/gmane.comp.version-control.git/183131)

from last night applied.  There will be two easily fixable conflicts
when applied directly on top of current master.


Best,
G=C3=A1bor


SZEDER G=C3=A1bor (9):
  completion: document __gitcomp()
  completion: optimize refs completion
  completion: make refs completion consistent for local and remote
    repos
  completion: improve ls-remote output filtering in __git_refs()
  completion: support full refs from remote repositories
  completion: query only refs/heads/ in __git_refs_remotes()
  completion: improve ls-remote output filtering in
    __git_refs_remotes()
  completion: fast initial completion for config 'remote.*.fetch' value
  completion: remove broken dead code from __git_heads() and
    __git_tags()

 contrib/completion/git-completion.bash |  200 +++++++++++++++++-------=
--------
 1 files changed, 109 insertions(+), 91 deletions(-)

--=20
1.7.7.187.ga41de
