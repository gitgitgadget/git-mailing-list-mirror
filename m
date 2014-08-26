From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v6 0/6] Stream fd to clean filter; GIT_MMAP_LIMIT, GIT_ALLOC_LIMIT with git_env_ulong()
Date: Tue, 26 Aug 2014 17:23:19 +0200
Message-ID: <1409066605-4851-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	john@keeping.me.uk, schacon@gmail.com,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 17:24:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMIbX-0001KG-5h
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 17:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbaHZPYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 11:24:09 -0400
Received: from mailer.zib.de ([130.73.108.11]:35551 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932079AbaHZPYI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 11:24:08 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s7QFNe7r011295;
	Tue, 26 Aug 2014 17:23:40 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s7QFNcNZ011272;
	Tue, 26 Aug 2014 17:23:38 +0200 (CEST)
X-Mailer: git-send-email 2.0.1.448.g1eafa63
X-Miltered: at mailer.zib.de with ID 53FCA67C.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53FCA67C.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53FCA67C.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255912>

Changes since v5:

 - Introduce and use git_env_ulong().
 - Change copy_fd() to not close input fd, which simplified changes to convert.
 - More detailed explanation why filter must be marked "required" in commit
   message of 6/6.
 - Style fixes.

Steffen Prohaska (6):
  convert: drop arguments other than 'path' from would_convert_to_git()
  Add git_env_ulong() to parse environment variable
  Change GIT_ALLOC_LIMIT check to use git_env_ulong()
  Introduce GIT_MMAP_LIMIT to allow testing expected mmap size
  Change copy_fd() to not close input fd
  convert: stream from fd to required clean filter to reduce used
    address space

 cache.h               |  1 +
 config.c              | 11 +++++++++++
 convert.c             | 55 +++++++++++++++++++++++++++++++++++++++++++++------
 convert.h             | 10 +++++++---
 copy.c                |  5 +----
 lockfile.c            |  3 +++
 sha1_file.c           | 47 ++++++++++++++++++++++++++++++++++++++++---
 t/t0021-conversion.sh | 24 +++++++++++++++++-----
 t/t1050-large.sh      |  2 +-
 wrapper.c             | 15 +++++++-------
 10 files changed, 144 insertions(+), 29 deletions(-)

-- 
2.1.0.8.gf3a29c8
