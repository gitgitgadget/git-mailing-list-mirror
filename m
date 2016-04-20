From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 00/12] fix checking out a being-rebased branch
Date: Wed, 20 Apr 2016 20:24:41 +0700
Message-ID: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
References: <1460897965-486-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 15:26:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ass8m-0004gz-Hm
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 15:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbcDTNZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 09:25:51 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33700 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097AbcDTNZg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 09:25:36 -0400
Received: by mail-pf0-f175.google.com with SMTP id 184so18573282pff.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 06:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lS96f89z67Or6Ox8q4Bd7s/RswBZhb3v+9k9/DHlD7o=;
        b=zLH4OpEulvBP5RFyeRdkZ6CBm7FFnc5P2P9SvMiHr3HljW92divi1P2wAjQF4ehoqU
         W7TH4Wr2E5Ds10qtkKuYHr3cXkllx8AFu4ZPy84nmKkZWAdlJ7pndhsgy6FO0+BwNCaY
         QcNB5oNaQgByktMW+rDCwn8ujP86Lov00zBUB9Dk/f34JOX1pKesfMtDDf7Lycjs+Rf2
         Zgd31Cav22jgJbOLlRhiR1x3sdc/xQ8hQI6jIy39EAq0C/MGrDi/hWjOVPoEzaeCqoxU
         ApNj+4+8xOC13jpnjBHBqJCcP7usII6d8YI2w6lcZar92NfzREf6Y/PtLKLOgVaj+ebB
         WvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lS96f89z67Or6Ox8q4Bd7s/RswBZhb3v+9k9/DHlD7o=;
        b=LUqrxCo4HEB0PIy/B+wD1vpzz8hVfNK59Jfw/7lXkhIjXinJd4YfIHkLP19TbxEHYU
         Ltlk87klHluxlK1n7/WuQeTjtnDH72D0biqF23PfCyFrFk9uXf5+MGrUrethcsZ+DQBt
         CXf2I2j80FCYIhbQK/nL6qzy+4TJJjK29o3KnFtLOUTr4cOU9K8WJr+xHqjpIzNO2k18
         VCbT03hWg4Xayo1+leK+0ex2iAidoPo86VmixgeK5uKxP/6LvKJ5fmXSjmLAquOItoZs
         wUGStU61gmGD/dJBtiOlGjisWBPcPabDcrQYV/J7smlEVD/KkcEQHhlK1rykhGhXteXu
         63eg==
X-Gm-Message-State: AOPr4FWaQAMjM8o3FUZUnJYI0VPLJhceCgqWtvrKHLCQ4RB336YUo5OLILh1GPP5wVwN1Q==
X-Received: by 10.98.7.153 with SMTP id 25mr12305353pfh.38.1461158735970;
        Wed, 20 Apr 2016 06:25:35 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id p7sm88046660pay.7.2016.04.20.06.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Apr 2016 06:25:34 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Apr 2016 20:25:47 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460897965-486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292011>

Much happier with this version. This makes

 - git checkout refuse if a branch is under rebase or bisect
   elsewhere

 - git worktree add refuse if a branch is under rebase or bisect

 - git branch -D refuse if a branch is under rebase or bisect.
   This applies for single worktree case as well.

 - git branch -M refuse if a branch is under rebase or bisect
   (single worktree case as well)

  [01/12] path.c: add git_common_path() and strbuf_git_common_path()
  [02/12] worktree.c: store "id" instead of "git_dir"
  [03/12] worktree.c: make find_shared_symref() return struct worktree *
  [04/12] worktree.c: mark current worktree
  [05/12] path.c: refactor and add worktree_git_path()
  [06/12] wt-status.c: split rebase detection out of wt_status_get_state()
  [07/12] wt-status.c: make wt_status_check_rebase() work on any worktree
  [08/12] worktree.c: avoid referencing to worktrees[i] multiple times
  [09/12] worktree.c: test if branch being rebased in another worktree
  [10/12] wt-status.c: split bisect detection out of wt_status_get_state()
  [11/12] worktree.c: test if branch being bisected in another worktree
  [12/12] branch: do not rename a branch under bisect or rebase

Total 13 files changed, 335 insertions(+), 67 deletions(-)
