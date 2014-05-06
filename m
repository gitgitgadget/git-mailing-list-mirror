From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 2/2] checkout.c: use ref_exists instead of file_exist
Date: Tue,  6 May 2014 15:45:53 -0700
Message-ID: <1399416353-31817-3-git-send-email-sahlberg@google.com>
References: <1399416353-31817-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 00:46:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Who7r-0001DO-5O
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 00:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634AbaEFWqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 18:46:03 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:61743 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549AbaEFWqB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 18:46:01 -0400
Received: by mail-ve0-f201.google.com with SMTP id db11so31261veb.4
        for <git@vger.kernel.org>; Tue, 06 May 2014 15:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Al+HInIiQbXGCzkjAwWb1vQvPXJtzY1tVXn0dzvQ2i4=;
        b=pJNbZJevnY/EZWqz3orHB3Rqc4n9gtSj67ose3WI+zF70/7PeIkyv0NrmoimqbEx9b
         xhymU35NeXl1AG8DmzcSVZThOMUa96piPfgINqCR3+Jk+aRCwZVTeKwS0vIAolwAmU9G
         i0FKmLUnI/9OraSfMdSZE+qzQ1g1yGvHC+eUAHeghUk4V6XnR9xNhkNuFRQl7tmmoE3P
         8P3cU81UNhCedCtvS3dxnFKpaBJ6+f2VNa6Ip+CvR+0I39V05HTqlSBsrWYoJr+dc9iZ
         gWAlsfnbP1ErBwE12k9SHR3DonDbu1cBzKVyay4VUnHnGuiaGL+zaD23ZhiYyHmJcB3z
         Qqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Al+HInIiQbXGCzkjAwWb1vQvPXJtzY1tVXn0dzvQ2i4=;
        b=flu3HHPnuGVSjuExAFZZrdFwneEANSfIViD2WWmYZivh8Nrf8xpj3dzofVGjmU7HQa
         kfb3351Wd547BHOpMHWuSZFTSJ2OfNDwm0cXiMas80YII+WrIB/vVLgVBNRapCHdv3JC
         ew7fAxQ/+8yulTrCmtoixk6ghdAfXupS5iCSwroA5kalFPgMoYngrAKqtPPeRdnBcCp/
         5ecfkrHcrevFSGFtLOLqXMg2X/wV+RaYsOEAmU7l4JP1pTWjVN7hq6LITQNZaBAlJxgk
         tEzBShNhjF/dvaZ/ZKl/oYf5mQQzyrkpgRTv/5Daq6wfCJOs2pPYhe8gg5x/Ns1RScuR
         peNg==
X-Gm-Message-State: ALoCoQmGQaWSUiFo2JEiuq3p1Y69c5Nb0z8JV6kjEkPIbAznP7OJ8Og3oMrE3GDJZ4vcl3lALIQj
X-Received: by 10.236.197.39 with SMTP id s27mr2365820yhn.36.1399416360446;
        Tue, 06 May 2014 15:46:00 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r79si601848yhj.2.2014.05.06.15.46.00
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 May 2014 15:46:00 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 4F34931C1CD;
	Tue,  6 May 2014 15:46:00 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0CA02E0ACF; Tue,  6 May 2014 15:45:59 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.354.g7561c2b.dirty
In-Reply-To: <1399416353-31817-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248265>

Change checkout.c to check if a ref exists instead of checking if a loose ref
file exists when deciding if to delete an orphaned log file. Otherwise, if a
ref only exists as a packed ref without a corresponding loose ref for the
currently checked out branch, we risk that the reflog will be deleted when we
switch to a different branch.

Update the reflog tests to check for this bug.

The following reproduces the bug:
$ git init-db
$ git config core.logallrefupdates true
$ git commit -m Initial --allow-empty
    [master (root-commit) bb11abe] Initial
$ git reflog master
    [8561dcb master@{0}: commit (initial): Initial]
$ find .git/{refs,logs} -type f | grep master
    [.git/refs/heads/master]
    [.git/logs/refs/heads/master]
$ git branch foo
$ git pack-refs --all
$ find .git/{refs,logs} -type f | grep master
    [.git/logs/refs/heads/master]
$ git checkout foo
$ find .git/{refs,logs} -type f | grep master
    ... reflog file is missing ...
$ git reflog master
    ... nothing ...

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/checkout.c | 5 +----
 t/t1410-reflog.sh  | 8 ++++++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 929f5bd..f1dc56e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -651,10 +651,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 			}
 		}
 		if (old->path && old->name) {
-			char ref_file[PATH_MAX];
-
-			git_snpath(ref_file, sizeof(ref_file), "%s", old->path);
-			if (!file_exists(ref_file) && reflog_exists(old->path))
+			if (!ref_exists(old->path) && reflog_exists(old->path))
 				delete_reflog(old->path);
 		}
 	}
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 236b13a..8cab06f 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -245,4 +245,12 @@ test_expect_success 'gc.reflogexpire=false' '
 
 '
 
+test_expect_success 'checkout should not delete log for packed ref' '
+	test $(git reflog master | wc -l) = 4 &&
+	git branch foo &&
+	git pack-refs --all &&
+	git checkout foo &&
+	test $(git reflog master | wc -l) = 4
+'
+
 test_done
-- 
2.0.0.rc1.354.g7561c2b.dirty
