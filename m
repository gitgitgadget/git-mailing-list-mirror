From: Yiannis Marangos <yiannis.marangos@gmail.com>
Subject: [PATCH] Verify index file before we opportunistically update it
Date: Thu, 10 Apr 2014 01:06:36 +0300
Message-ID: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
Cc: Yiannis Marangos <yiannis.marangos@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 00:07:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WY0ek-0001Nk-Oa
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 00:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbaDIWHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 18:07:24 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:54389 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933776AbaDIWHU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 18:07:20 -0400
Received: by mail-ee0-f54.google.com with SMTP id d49so2411809eek.27
        for <git@vger.kernel.org>; Wed, 09 Apr 2014 15:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=tbehtgcnDb8dHxKMX4Rvgpw0W173MvyUdDvNdO54rYI=;
        b=QY73m5RvA+bnv1tURsiJP6e700leYzPnfveq39JIwMNyDLq6FfA0FkG5n4RLJxc8I+
         fSzKw8xgVS7W1Jhm/ZcLG40sVx+r2Bkd1475TGmpjT+xsmZcxPoVQfW0cKeVxLZNoXi+
         iMEJ7+j35y/Y5Z/Rv763k1ZFltvslQeud17VS4gBsdH9O65KptlQAasTAhuDoD0Fu+IQ
         fwqNHjaUgb62jtCQGkmnB+rnPP/qPLfJj7wZKaUKjw3r+Kc5GKCGOSRCah/tqCyEB1mQ
         H1R7eqTZ9WS3UHSTZ7l231+mWLF9pTWZlmGU6809BppQ9YZIVlTtZZndPdbfBIHzXVJU
         ///A==
X-Received: by 10.14.115.1 with SMTP id d1mr15204853eeh.30.1397081238821;
        Wed, 09 Apr 2014 15:07:18 -0700 (PDT)
Received: from abyss.hitronhub.home ([46.251.117.183])
        by mx.google.com with ESMTPSA id n41sm5217466eeg.4.2014.04.09.15.07.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Apr 2014 15:07:18 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246000>

This is a fix for the following bug:
http://thread.gmane.org/gmane.comp.version-control.git/245946/focus=245965

I added 2 functions: verify_index_from and verify_index. They return 1
if the sha1 is correct, otherwise 0. I choose to not die if any errors
are occurred because we just want to not proceed to "opportunistic
update".

Some questions:
1) Is it better to have these functions as static?
2) If the answer of (1) is no, should I define verify_cache*() also?
3) If something goes wrong in verify_hdr(), it will print an error
   message, should I make a "quietly" version of it?

Yiannis Marangos (1):
  Verify index file before we opportunistically update it

 cache.h      |  3 +++
 read-cache.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 71 insertions(+), 11 deletions(-)

-- 
1.9.1
