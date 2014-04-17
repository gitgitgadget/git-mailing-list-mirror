From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 00/11] Use ref transactions from most callers
Date: Thu, 17 Apr 2014 12:46:16 -0700
Message-ID: <1397763987-4453-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 21:46:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WasGd-0002yH-39
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 21:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbaDQTqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 15:46:36 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:42748 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbaDQTqd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 15:46:33 -0400
Received: by mail-ig0-f202.google.com with SMTP id uq10so85118igb.5
        for <git@vger.kernel.org>; Thu, 17 Apr 2014 12:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kDGpO4ro9lDW2Mt0VA/P+GrMNRCX4vqKWRzv6G+ssTw=;
        b=Yc4KiGgWsov32rw/JMGT0K0dC7u5QTTupjQXLVVJuGuk7W3MI8l9CYbuCqgxY4DuuI
         ddRhWa1XZaNL6K2tkhRtOunQtC3QNRAVBtzU/GVGDwwT29zoY3jGLI/DZPe1dvBdCRxJ
         qkuVi+AXpxK2h3egZrEIdRooCq1mcFLo+aNu/o6sDWyna9jWqIFLwSUorZ4320tazp2K
         G+XoWtMHeZo7kHyVfbx+Bu4rehaR34Jmmm9ZwwEeaXAdIsxNLowX7XKzrdtbzGQ79B+V
         bmUkjEj1m2AJ1PbPz2s9GDC3TUvk4No3uCISjtOjdmaNBt/NbqDIrviEl5/19xcPwAoK
         DK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kDGpO4ro9lDW2Mt0VA/P+GrMNRCX4vqKWRzv6G+ssTw=;
        b=Mb4HoM63LJKWG9xzBogRwLMbRHUF0QJTpjBlcJ86HC1bYTwby3f7EII5FVl/BV4sBF
         2JQcJut2FwNRIeTQQrkDcPDPM/W3U7yzoxn69eLfiFz3kH+1lvFDWZM8qedQHIX8SNlv
         81sIGQSni0ayTCgfK3BAY4Y5eOsAYXOC6zs+PiBhK+mJWYVDaT9EG35FLGr8l+imO3js
         jMGz2105pA4VmNR3G73BHRPqoo+8DZtabD8CvpN+krUSR0YzxsnCfRDg7JhYk2tQNUm2
         eDQUm5LvLZ61+9bZxepbNPivgrkgXFZZINN0PwCGKNikMTOw7i3DokCGvduBtH9uA5Sd
         VW3g==
X-Gm-Message-State: ALoCoQn+OP7FC9y8WFFCjnelCxtIt14ITUQaZqfkjGAhqi7oiXeA4TAdkikPQ3LcPCcUIAXc/AQ/b7NgDhMkOXK1JgrBu4RNSKm9TWc/7qWBid8HI0egSwLcSEwo7mEyrwzyi/x4k72t86a/xKIUnOfNl2VmeBlPUQqqk+sPaW/nMTNMTtUS1wcJDEl0sK8rTgX1GuSP+mDE
X-Received: by 10.50.73.132 with SMTP id l4mr6545398igv.5.1397763992685;
        Thu, 17 Apr 2014 12:46:32 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si180231yhk.4.2014.04.17.12.46.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Apr 2014 12:46:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 7AE1A31C20C;
	Thu, 17 Apr 2014 12:46:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1E552E0967; Thu, 17 Apr 2014 12:46:32 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.513.gd486896
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246437>

This patch series changes most of the places where the ref functions for
locking and writing refs to instead use the new ref transaction API. There
are still three more places where write_ref_sha1() is called from outside
of refs.c but those all will require more complex work and review so those
changes belong in a different patch series.


Ronnie Sahlberg (11):
  refs.c: constify the sha arguments for
    ref_transaction_create|delete|update
  refs.c: change ref_transaction_update() to do error checking and
    return status
  refs.c: change ref_transaction_create to do error checking and return
    status
  refs.c: ref_transaction_delete to check for error and return status
  tag.c: use ref transactions when doing updates
  replace.c: use the ref transaction functions for updates
  commit.c: use ref transactions for updates
  sequencer.c: use ref transactions for all ref updates
  fast-import.c: change update_branch to use ref transactions
  branch.c: use ref transaction for all ref updates
  walker.c: use ref transaction for ref updates

 branch.c             | 16 ++++++++++------
 builtin/commit.c     | 22 ++++++++++++----------
 builtin/replace.c    | 15 +++++++++------
 builtin/tag.c        | 15 +++++++++------
 builtin/update-ref.c | 20 +++++++++++++-------
 fast-import.c        | 23 +++++++++++++++--------
 refs.c               | 44 ++++++++++++++++++++++++++++++--------------
 refs.h               | 25 +++++++++++++------------
 sequencer.c          | 17 +++++++++++++----
 walker.c             | 45 ++++++++++++++++++++-------------------------
 10 files changed, 144 insertions(+), 98 deletions(-)

-- 
1.9.1.513.gd486896
