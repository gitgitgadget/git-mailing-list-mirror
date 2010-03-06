From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Add tests for git format-patch --to and format.to config
 option
Date: Sat, 6 Mar 2010 01:39:48 +0100
Message-ID: <20100306003946.GD27414@genesis.frugalware.org>
References: <7v7hptt0mr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Drake <sdrake@xnet.co.nz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 06 01:40:21 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nni44-0006sb-90
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 01:40:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289Ab0CFAkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 19:40:07 -0500
Received: from virgo.iok.hu ([212.40.97.103]:57391 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721Ab0CFAkG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 19:40:06 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 5F91B58098;
	Sat,  6 Mar 2010 01:40:01 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8409F42F09;
	Sat,  6 Mar 2010 01:40:00 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 60BA21240003; Sat,  6 Mar 2010 01:39:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v7hptt0mr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141602>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Wed, Mar 03, 2010 at 04:02:20PM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> * sd/format-patch-to (2010-02-17) 1 commit
>  - Add 'git format-patch --to=' option and 'format.to' configuration variable.
>
> Shouldn't be too hard to add tests to t4014; other than that looked ready
> for 'next'.

Here is a patch that does so.

 t/t4014-format-patch.sh |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index f2a2aaa..9305c98 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -531,6 +531,26 @@ test_expect_success 'format-patch --in-reply-to' '
 	grep "^References: <baz@foo.bar>" patch8
 '
 
+test_expect_success 'command line to' '
+
+	git format-patch --to="R. E. Cipient <rcipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch9 &&
+	grep "^To: R. E. Cipient <rcipient@example.com>" patch9
+'
+
+test_expect_success 'configuration to' '
+
+	git config --replace-all format.to "R. E. Cipient <rcipient@example.com>" &&
+	git format-patch --stdout master..side | sed -e "/^\$/q" >patch10 &&
+	grep "^To: R. E. Cipient <rcipient@example.com>" patch10
+'
+
+test_expect_success 'additional command line to' '
+
+	git format-patch --to="S. E. Cipient <scipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch11 &&
+	grep "^To: R. E. Cipient <rcipient@example.com>,\$" patch11 &&
+	grep "^ *S. E. Cipient <scipient@example.com>\$" patch11
+'
+
 test_expect_success 'format-patch --signoff' '
 	git format-patch -1 --signoff --stdout |
 	grep "^Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
-- 
1.7.0
