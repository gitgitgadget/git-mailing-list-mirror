From: newren@gmail.com
Subject: A few fast export fixups -- round 3
Date: Thu, 25 Jun 2009 22:48:26 -0600
Message-ID: <1245991713-12782-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, kusmabite@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 26 06:50:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK3Ok-0003A8-NZ
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 06:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbZFZEum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 00:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbZFZEul
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 00:50:41 -0400
Received: from mail-pz0-f202.google.com ([209.85.222.202]:44971 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbZFZEuk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 00:50:40 -0400
Received: by pzk40 with SMTP id 40so3787pzk.33
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 21:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Ll6NVh9vk68cnKaXW4kubdgGDuW2ElAwlyH22PgleYU=;
        b=ezOFYWz2mGQZMy/a5+hPw/PZg58OQuJnWq5efwscyejiPPj2VC8b0lQkOB/n7nTZur
         ZbcJXp7qc32Of2QcgFuHykwnwWC4xtyO2IfkhALCIyUNq8EyQHKRUQj1MQPGAwu33Fy8
         dkMNN4nqEioS0275I12T5fwT6njcE2zX6qjF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=uNhyKDRntHEaIKSfEhaJ1ZtyA4V3ICCaF0sDjDXeECwXl+JhcTVTHlIaUrrw6rJmRY
         gWEknIT9YxhmLklpQD3dBd+EpphkGiummy+m6hGsY3rYn9oGmVIWaleQJx3RZByAqssg
         cUzvGUFgaVwzrJIACITUNesJNRhSXzngix8F0=
Received: by 10.142.222.19 with SMTP id u19mr1233760wfg.87.1245991843421;
        Thu, 25 Jun 2009 21:50:43 -0700 (PDT)
Received: from localhost.localdomain (c-68-35-108-93.hsd1.nm.comcast.net [68.35.108.93])
        by mx.google.com with ESMTPS id 27sm160173wff.6.2009.06.25.21.50.42
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 21:50:42 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3.341.g1a0a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122268>

This patch series fixes a few fast-export bugs I have come across,
plus some new testcases to verify the fixes, a testcase to document a
pre-existing failure, and finally a small addition to the
documentation.

Changes since v1:
  - fixed test issues identified by Johannes Sixt and Stephen Boyd
  - squashed patch #2 into patch #1

Changes since v2:
  - several changes and improvements suggested by Junio (moving code
    to different functions, avoiding exporting functionality from
    revision.c, improved commit messages)
  - new patch to ensure invariants created by setup_revisions are
    respected (set revs flags before calling setup_revisions, rather
    than after)
  - now also catches and omits tags of tags of trees, tags of tags of
    tags of trees, etc.
  - remove some now-obsoleted code
  - There are two new cases I'm aware of in which fast-export produces
    broken "(null)" refs; I'm not sure how/where to fix these (or even
    what correct behavior is in one of the cases), but they are no worse
    than before and I've at least added a test documenting that we know
    that there's a case that is (still) broken.

Elijah Newren (7):
      fast-export: Set revs.topo_order before calling setup_revisions
      fast-export: Omit tags that tag trees
      fast-export: Make sure we show actual ref names instead of "(null)"
      fast-export: Do parent rewriting to avoid dropping relevant commits
      fast-export: Add a --tag-of-filtered-object option for newly dangling tags
      Add new fast-export testcases
      fast-export: Document the fact that git-rev-list arguments are accepted

 Documentation/git-fast-export.txt |   17 +++++++
 builtin-fast-export.c             |   82 +++++++++++++++++++++++++++++---
 t/t9301-fast-export.sh            |   96 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 187 insertions(+), 8 deletions(-)
