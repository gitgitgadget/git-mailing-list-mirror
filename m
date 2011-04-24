From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] Fix diff-files output for unmerged paths
Date: Sun, 24 Apr 2011 13:51:25 -0700
Message-ID: <1303678289-27627-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 22:51:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QE6HN-00071f-Tj
	for gcvg-git-2@lo.gmane.org; Sun, 24 Apr 2011 22:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757781Ab1DXUvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2011 16:51:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33031 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757743Ab1DXUvf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2011 16:51:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0066246B8
	for <git@vger.kernel.org>; Sun, 24 Apr 2011 16:53:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=dwKieVqmSCk9ULfSNeuBu29BZKY
	=; b=hnWoa4udpy7nGOaTsKxSx5k/OtBxSqieo2ZAQ9HKRVpewhbryy7k+jgEtjX
	MbRJ+zqwR1C+XMub3VcqjczI0g0rEC1j3u1ImHMDWqAmzk0lnpatjFvcAZMLMehr
	L6DG98BSdCwopP7wWBBZAQmdHVw+vSxH5UARkzCzKcDTbfHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=DYVey/k5IKFTctzqENhbnrH0UAFFv
	1oZ86O8BCJygOJ2Ni7dvJf7CHHikiz2FuPlqQCu7Bk94oFNFdEBQ4KNY76tv0JGf
	KZiStBOj4oD9rRXjxTlk6GTHbxo0SOP06cEOSe4dnSm0B3/AK27OJMCWJmJqhfjW
	/FZtDbC6H7U2iU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D84E046B7
	for <git@vger.kernel.org>; Sun, 24 Apr 2011 16:53:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6406346B6 for
 <git@vger.kernel.org>; Sun, 24 Apr 2011 16:53:33 -0400 (EDT)
X-Mailer: git-send-email 1.7.5
X-Pobox-Relay-ID: EB1073A4-6EB4-11E0-B6E3-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171999>

This is cleaned-up series of my previous attempts that were queued in 'pu'
late in the pre-1.7.5 cycle.

Junio C Hamano (4):
  test: use $_z40 from test-lib
  diff.c: return filepair from diff_unmerge()
  diff: remove often unused parameters from diff_unmerge()
  diff-files: show unmerged entries correctly

 diff-lib.c                       |   15 +++++--
 diff.c                           |   12 +++---
 diff.h                           |    5 +--
 t/t1400-update-ref.sh            |    2 +-
 t/t1501-worktree.sh              |    7 +--
 t/t2011-checkout-invalid-head.sh |    2 +-
 t/t2201-add-update-typechange.sh |    2 -
 t/t3200-branch.sh                |    4 +-
 t/t3600-rm.sh                    |    3 +-
 t/t4002-diff-basic.sh            |    5 +--
 t/t4020-diff-external.sh         |    2 -
 t/t4027-diff-submodule.sh        |    1 -
 t/t4046-diff-unmerged.sh         |   87 ++++++++++++++++++++++++++++++++++++++
 t/t7011-skip-worktree-reading.sh |    4 +-
 t/t7012-skip-worktree-writing.sh |    2 +-
 t/test-lib.sh                    |    3 +
 16 files changed, 120 insertions(+), 36 deletions(-)
 create mode 100755 t/t4046-diff-unmerged.sh

-- 
1.7.5
