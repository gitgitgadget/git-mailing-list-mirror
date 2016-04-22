From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v2 0/4] rev-parse: adjust results when they should be relative
Date: Fri, 22 Apr 2016 17:53:08 -0400
Message-ID: <1461361992-91918-1-git-send-email-rappazzo@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com, pclouds@gmail.com,
	Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 23:53:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atj0k-0001lV-AL
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 23:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbcDVVxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 17:53:04 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33187 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbcDVVxC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 17:53:02 -0400
Received: by mail-yw0-f193.google.com with SMTP id o63so17215895ywe.0
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 14:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=cDQZKIZSIxTzGOubqBy+Y1IhOrI5SCWJjX9Nl0SqgyU=;
        b=M5sa52DZ9H04lz+LlCWP6AU1UcWXL0maNsNBOV/yF0u/uBwqKRmL1RrwRiFaW1ksRX
         5yxitFUGPbHZaomwtzgyycAqRoRLxEwgRu4/6DrEWqgRsKrfmX3ZWCsLWJbTA8bxmliI
         oSu0ED1X5LiYqx2kkTjbFLR2e7CgKSX7uk3A7REMaqnbMM7tv/C4BxscxWXVoAUNwoHU
         w0M7uZ7HThK7IUJeogKZ23xohp0u756Qvq/pmxeE6PY5vAg4MqHBoDaX9JRD56WoX6ah
         TsHIKjHOe3RNkOifSBwZNJ9XXiGDXOvZDZXZCyctEVeGHA9P2LMsAl/yOsphfhft6Pqx
         LLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cDQZKIZSIxTzGOubqBy+Y1IhOrI5SCWJjX9Nl0SqgyU=;
        b=Cf+YzpULP7sXupz6xPFMDlmkIx55tGc7cfxMMGg14m05u1aKPzELIVaHTpFYpukyeD
         vHlv/7QKXK3SOwfSfEt4NShTH2WLXfaObhK3NWapJYhEdpU0u0u8e7xjzn7bpOTXGEB2
         hrhfLR2YbpEd7LpYsyQ0emWOFxGEAVVPdVcecQzemNnjh3dHlA+RVX2X0MxlyOikj7mO
         9I1a8XNp3IkxBv5/4uI5SAvqruabpcr9MhTIgLyFqZfObYVrYjUTnwhy42gMd1kuweaf
         nR9fGcklRqd9gQBFyHLi73ONPjKi3BbWu4PpGJHusxb2EWf4ZdD4xu5ufsjikoP5WtNQ
         ukDA==
X-Gm-Message-State: AOPr4FWBtaQxdpaN0vD2ImElk0kLLWcl8WRA+n1fkqFRnKoyAgB71u3JbpzopS76EkpAYw==
X-Received: by 10.37.65.12 with SMTP id o12mr14540999yba.170.1461361980848;
        Fri, 22 Apr 2016 14:53:00 -0700 (PDT)
Received: from MRappazzo-8.local.com (pool-100-35-125-216.nwrknj.fios.verizon.net. [100.35.125.216])
        by smtp.gmail.com with ESMTPSA id m141sm5542104ywd.2.2016.04.22.14.52.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 14:53:00 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292272>

Differences from v1[1]:
 - Simplify implementation based on review comments
 - Included similar changes in rev-parse for --git-path and --shared-index-path
 - Added tests and separated them into individual commits

[1] http://thread.gmane.org/gmane.comp.version-control.git/290669

Michael Rappazzo (4):
  rev-parse: fix some options when executed from subpath of main tree
  t1500-rev-parse: add tests executed from sub path of the main worktree
  t2027-worktree-list: add and adjust tests related to git-rev-parse
  t1700-split-index: add test for rev-parse --shared-index-path

 builtin/rev-parse.c      | 19 ++++++++++++++-----
 t/t1500-rev-parse.sh     | 37 +++++++++++++++++++++++++++++++++++++
 t/t1700-split-index.sh   | 17 +++++++++++++++++
 t/t2027-worktree-list.sh | 10 +++++++++-
 4 files changed, 77 insertions(+), 6 deletions(-)

-- 
2.8.0
