From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 0/2] rebase -i: Fix left-behind =?UTF-8?Q?CHERRY=5FPICK?=
 =?UTF-8?Q?=5FHEAD?=
Date: Thu, 18 Jun 2015 18:38:27 +0200
Organization: gmx
Message-ID: <cover.1434645436.git.johannes.schindelin@gmx.de>
References: <cover.1434627492.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, szeder@ira.uka.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 18 18:38:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5cq3-00028t-6H
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 18:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756090AbbFRQih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 12:38:37 -0400
Received: from mout.gmx.net ([212.227.15.19]:60447 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274AbbFRQia (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 12:38:30 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LfTVx-1YlvHm3jo1-00p69V; Thu, 18 Jun 2015 18:38:27
 +0200
In-Reply-To: <cover.1434627492.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:d4cEUPnhcEePiudvccNXbaKixghDsYS0rpxwLeBbllwSmXqplDg
 ebPUfvf3MeEkDJix1xcGd/HgwAGM3dQe42KDkA5BV8aFniotJsv96bu5CH6s0li8EGqR1fk
 EL6giz3ryqGmUXtGZYYWI/ZYPPr+0ljGXPv0jYFfDmfidPNPzDvgHPS1bO72lmeDR///A/Z
 g4g/zHRlzH2i2KAz62bXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jkWXN257irU=:zKRIe0lu2AwpPH++NFNZkc
 pqwpBrfFDAaC9ag0uyFPB4EuJziS2AyFuO0/BhwB6FP//TWAPtghZCb06yKfNE6CyWMDcu+am
 X6VeHDxP+lIRB91djZyN3DnI77rKuuSKyMWIQnfQLSHSQeUtfzNTXivHvekKyB6s1pfrknG0F
 N6evwaIzV0Ls+hd26DlBWRxad//yX1tQcPxS5OJneIofZ6og5115EKhEGhEYAgxAjXakdj9mK
 6o56YCBOLtXakAMyhc+a/rubikG1o//DWjmm0vlDmuEsmNhI3JOtrVXczH6WV4lhxyrU6F/tQ
 62J3Qlp/2evKB2U2sjlPEw5xJhjsqLQ50pbulI1lo7VqtEES38FOkLB3t/KrcNvOGNf/CAvLx
 TUaEjymM5igg6HtpPslzDcPUrw6B7ZXsucqLoAbYm4dXFi8/Max/eY/L83P9Z2BZrn5uiaP4v
 R9c8RUUAvDZpp8Azu29H4+dLEaHouRHq/5676cEwJTDKUMBfZt7xrc+G1rzJX8c1nI/a9y37Y
 En6GsBibRxFhk6+2/wuhBdrOG16HfeioEcjz6lTTUPnJbkoYRlNEJRRrbME96gCO9vfUQzVX5
 ZUnHlXmt3GYRBorcNy/gp18E+SzyT1RSlggtfbur2AFmM0PU9mP7qxB06MydngwVJQdc6tAWd
 h1BM66dcVLwieaR/0VqKqP6Kz8CDJ+sAda1mlvB3P/2M9a1FsXH5xV/55gg5Eje6Tlrk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272024>

These patches fix a bug that bites me often enough when rebasing Git for
Windows.

The symptom is that .git/CHERRY_PICK_HEAD is left behind after skipping
an already-merged patch with `git rebase --continue` instead of `git
rebase --skip`. I always prefer the former invocation because the latter
would also skip legitimate patches if there were merge conflicts, while
the former would not allow that.

Changes since v2:

- the test uses `--exit-code` to verify that the result of the rebase is
  correct

Interdiff below the diffstat.

Johannes Schindelin (2):
  t3404: demonstrate CHERRY_PICK_HEAD bug
  rebase -i: do not leave a CHERRY_PICK_HEAD file behind

 git-rebase--interactive.sh    |  6 +++++-
 t/t3404-rebase-interactive.sh | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f3337ad..6bcf18b 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1118,7 +1118,7 @@ test_expect_success 'rebase --continue removes CHERRY_PICK_HEAD' '
 	FAKE_LINES= test_must_fail git rebase -i seq-onto &&
 	test -d .git/rebase-merge &&
 	git rebase --continue &&
-	git diff seq-onto &&
+	git diff --exit-code seq-onto &&
 	test ! -d .git/rebase-merge &&
 	test ! -f .git/CHERRY_PICK_HEAD
 '
-- 
2.3.1.windows.1.9.g8c01ab4
