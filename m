From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 0/7] Add --graft option to git replace
Date: Sat, 28 Jun 2014 20:11:09 +0200
Message-ID: <20140628171731.5687.30308.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 20:20:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0xEF-0007b1-Q1
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 20:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756792AbaF1STw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2014 14:19:52 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:59204 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754785AbaF1STr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2014 14:19:47 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 083AE64;
	Sat, 28 Jun 2014 20:19:43 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252610>

Here is a small patch series to implement:

        git replace [-f] --graft <commit> [<parent>...]

This patch series goes on top of the patch series that
implements --edit.

The changes since v4, thanks to Junio and Peff, are:

- The series has been rebased on top of Peff's series
  to store the commit buffer length
  (jk/commit-buffer-length). This changes patch 1/7
  and fixes the problem that we lost everything after
  a NUL byte in the commit buffer. 

- Patches 5/7, 6/7 and 7/7 have been added to lose
  a gpg signature in the original commit buffer.
  
Notes:

- Maybe patches could be reordered or squashed, but
  I prefered not to do it in this round so that
  changes compared to previous version are easier to
  spot.

- Junio suggested to drop the merge-tag of a parent
  we are not going to keep, but to keep the merge-tag
  of a parent we are keeping. This has not yet been
  done. It is unfortunate that merge-tags don't use
  a format like the trailer format, because we could
  have factorised droping a merge-tag in the
  "git interpret-trailers" command.

Christian Couder (7):
  replace: add --graft option
  replace: add test for --graft
  Documentation: replace: add --graft option
  contrib: add convert-grafts-to-replace-refs.sh
  replace: refactor replacing parents
  replace: remove signature when using --graft
  replace: add test for --graft with signed commit

 Documentation/git-replace.txt             | 10 ++++
 builtin/replace.c                         | 79 ++++++++++++++++++++++++++++++-
 commit.c                                  | 34 +++++++++++++
 commit.h                                  |  2 +
 contrib/convert-grafts-to-replace-refs.sh | 28 +++++++++++
 t/t6050-replace.sh                        | 34 +++++++++++++
 6 files changed, 186 insertions(+), 1 deletion(-)
 create mode 100755 contrib/convert-grafts-to-replace-refs.sh

-- 
2.0.0.421.g786a89d.dirty
