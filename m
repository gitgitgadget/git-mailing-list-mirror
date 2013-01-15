From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 00/19] reset improvements
Date: Mon, 14 Jan 2013 21:47:32 -0800
Message-ID: <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Matt Kraai <kraai@ftbfs.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 06:56:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuzVJ-0004aX-Fa
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 06:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950Ab3AOFzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 00:55:48 -0500
Received: from mail-ea0-f201.google.com ([209.85.215.201]:42525 "EHLO
	mail-ea0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755475Ab3AOFzr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 00:55:47 -0500
Received: by mail-ea0-f201.google.com with SMTP id e12so312214eaa.0
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 21:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=pK4blePXlWb2aNC2WNa2gU2YqQlo/fJnbg6mNhFsIZQ=;
        b=gFoiHNK59NiPciHb1PxKHcNJrtH78kvNz5/Pok2K4CrnZSl/3tGS9CibiwPEx85IFC
         JqaDx33l7ZBxK6ZgdZJehdTrYBxLImHCa29d7uCPL9LeJpF2E4zDHh3I6gOctKgy44mn
         ZIPtsWq+6EqK9x57wnxp6Cq1T6kWO2p7040pHmeiayMlOFvB+HxMLNusiBahgG/uIW3D
         c6s+ezF3pvLzzSzl8bz9YJnH6giTOXSiZGk46M/unQzckThpd3+cllvje9AuT+uY2fvm
         X6efpJYsn6jKkGyQZONnUEX3lq85kT7E20Nlewed2JUbVfIwwXMxUxt3F9kIDd6gPz/+
         wMVw==
X-Received: by 10.14.201.1 with SMTP id a1mr109753984eeo.3.1358228906929;
        Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id z44si5657510een.0.2013.01.14.21.48.26
        (version=TLSv1 cipher=AES128-SHA bits=128/128);
        Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 613C220004E;
	Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id A217010135F; Mon, 14 Jan 2013 21:48:25 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.454.gce43f05
In-Reply-To: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQnMddLQYFTZCKXFINOKqob/9W1ARStzvFVMoxaVKpp4MBkwGUWD1jF+4pE/2YhuZDJDYrv8bZBIx8q1+RqHL36IpgCIqxr6P8Weju/54WtN+cBF2NMLWu6lJh4LIsLpBX/nnIHyYG/zXVgbPlPrPHJCzbtMPXr6TptusD1AVe8lUuqWI30kw71dv8oxN2DMgMZt3Ifo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213591>

Changes since v1:

 - Spelling fixes.

 - Explained how "git reset -- $pathspec" in bare repo is broken.

 - Provided motivation for replacement of switch by if-else

 - Fixed argv/argc handling by removing use of argc.

 - Replaced "don't refresh index on --quiet" patch by one that just
   inlines update_index_refresh()

 - Incorporated fixes from Junio's repo

 - Provided some motivation for "replace switch by if-else" amd moved
   the patch later in the series.

Thanks for reviewing!


Martin von Zweigbergk (19):
  reset $pathspec: no need to discard index
  reset $pathspec: exit with code 0 if successful
  reset.c: pass pathspec around instead of (prefix, argv) pair
  reset: don't allow "git reset -- $pathspec" in bare repo
  reset.c: extract function for parsing arguments
  reset.c: remove unnecessary variable 'i'
  reset.c: extract function for updating {ORIG_,}HEAD
  reset.c: share call to die_if_unmerged_cache()
  reset --keep: only write index file once
  reset: avoid redundant error message
  reset.c: replace switch by if-else
  reset.c: move update_index_refresh() call out of read_from_tree()
  reset.c: move lock, write and commit out of update_index_refresh()
  reset [--mixed]: only write index file once
  reset.c: finish entire cmd_reset() whether or not pathspec is given
  reset.c: inline update_index_refresh()
  reset $sha1 $pathspec: require $sha1 only to be treeish
  reset: allow reset on unborn branch
  reset [--mixed]: use diff-based reset whether or not pathspec was
    given

 builtin/reset.c                | 283 +++++++++++++++++++----------------------
 t/t2013-checkout-submodule.sh  |   2 +-
 t/t7102-reset.sh               |  26 +++-
 t/t7106-reset-unborn-branch.sh |  52 ++++++++
 4 files changed, 203 insertions(+), 160 deletions(-)
 create mode 100755 t/t7106-reset-unborn-branch.sh

-- 
1.8.1.1.454.gce43f05
