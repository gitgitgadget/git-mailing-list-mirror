From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v2 0/8] rebase: new cherry-pick mode
Date: Tue, 28 May 2013 23:16:32 -0500
Message-ID: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 06:18:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhXqE-00029A-CY
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 06:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913Ab3E2ESW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 00:18:22 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:55704 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab3E2ESV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 00:18:21 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so3081074obc.27
        for <git@vger.kernel.org>; Tue, 28 May 2013 21:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=AdlYS3jkIldDC15/OQfA6NRQmaL9jDhnguC3GU4JHzM=;
        b=X35hFbQzWh9KVwwfiH2UnXfnPNTOZBwn+Fhie6GYrhl5Sn6NnBF9aGytTjpvEtZ5ty
         MyxscFYmpINo8sDtod4xr3HrKwl1glT+SP4fYdGkoTG6s13Q31D4/iD54Lo6Ca57aVug
         qjnCQD+gDCDbWmmNlto98TZzkuqQCWjJ6UyxDKVOddmIny8sW84hwt1aKEGYKdoTQegd
         zqdjXHNrFjxAc75sZb1uppao3oH8n1CrAPOMQwoSPZuFn2dbx9mYV7+tegBdW1g+bMuX
         YgyBFkG2CDh+4sSE3JVe5Hb+CadAMu/4NgK6D1t/6R8Q3y2UTqov/mfZQgnDTSPpfV+Z
         0nyg==
X-Received: by 10.60.94.212 with SMTP id de20mr507028oeb.129.1369801101334;
        Tue, 28 May 2013 21:18:21 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ns4sm38406848obc.2.2013.05.28.21.18.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 21:18:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225723>

Hi,

After the fixes I did to cherry-pick, it's now fully usable for 'git rebase'
and can be used to replace 'git am' for most cases.

We already rely on cherry-pick for the 'am' mode, but only when using the
--keep-empty option, and when in such mode the behavior of 'git rebase' changes
completely; more specifically; it's completely broken. Manually enabling
--keep-empty to be the default and running the test-suite shows a huge lot of
failures.

After fixing the --keep-empty option by creating a new cherry-pick mode, this
patch series uses this new mode instead of the 'am' mode, and everything works.

There's only two tests that fail, one because the output of the shell prompt
changes a bit, and the other I have not yet investigated.

This brings us one step closer to replace scripts with C code.

Felipe Contreras (8):
  rebase: split the cherry-pick stuff
  rebase: cherry-pick: fix mode storage
  rebase: cherry-pick: fix sequence continuation
  rebase: cherry-pick: fix abort of cherry mode
  rebase: cherry-pick: fix command invocations
  rebase: cherry-pick: fix status messages
  rebase: cherry-pick: automatically commit stage
  rebase: use 'cherrypick' mode instead of 'am'

 .gitignore                             |  1 +
 Makefile                               |  1 +
 contrib/completion/git-prompt.sh       |  2 ++
 git-rebase--am.sh                      | 12 ++-----
 git-rebase--cherrypick.sh              | 64 ++++++++++++++++++++++++++++++++++
 git-rebase.sh                          | 11 ++++--
 t/t3407-rebase-abort.sh                |  2 +-
 t/t5520-pull.sh                        |  2 +-
 t/t9106-git-svn-commit-diff-clobber.sh |  2 +-
 9 files changed, 82 insertions(+), 15 deletions(-)
 create mode 100644 git-rebase--cherrypick.sh

-- 
1.8.3.rc3.312.g47657de
