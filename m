From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/7] fix checking out a being-rebased branch
Date: Sun, 17 Apr 2016 19:59:18 +0700
Message-ID: <1460897965-486-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8BOwzJSmS3PPeeRuaRwq=+kYLH8NX0i7P_wfDW9gLt6bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 14:59:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1armIs-000727-Qh
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 14:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbcDQM7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 08:59:50 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36604 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbcDQM7t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 08:59:49 -0400
Received: by mail-pa0-f66.google.com with SMTP id i5so82158pag.3
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 05:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+O5mD+uc4KFl64VdDsSQkteX8fsFQCoix/g6ss4nzzM=;
        b=Pu+K+CIU1oOvAmUr3lCMnrlq5oex5ruzYTrC7Ag2WGtmnpToDG5raw/Jk5vbBGqDUR
         1jmpfrFwNC7/3TgeiDfopTQvM6Ok6h1YLXkHhLNCEv2ZHgtJcNJC3Z4qULKu5wUPss2O
         KgHT4Edh2R5rIq/k+V/SVBCySjvwF1/zEG6YV6oROlbDJPY1O8qUf+gOEf05kLSdyDda
         ap02bEp44HOXDDoe0S+r5ZN2sKmQj0WP4JTwNPJ1orjRVjFGMeMIcmJblfkdJLFB0+Xi
         Enr11uiHcNm0MQHa3W9/uFpwACjmh8f7lORciVzgUDhpmNPaSgxh+ysBECbGnOa9nc4r
         TvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+O5mD+uc4KFl64VdDsSQkteX8fsFQCoix/g6ss4nzzM=;
        b=haMaBNVPMWfHu918WvJ0UtyyXLWK6MvkccmH/tp7zThSn+iZlnwUjoPCR/gr2KvPqZ
         Z02tKPlVWuMdURS2pQq752ZT24AMP+rxponvGgG2G1vI7PdR9uGPKNMso2skwyHcp31c
         F9GFRNlJLFz/fWpDJD0AgcUb3VMZK309W5yDhE/A+VO9HV3sxzpwhEkTpu/twlBOXPBN
         XH/ouEUiqtzD2h8Z+TwAlQhEowI4tyjRJ1VtqG6bXq4/44u2ULiMJqh8p4MLmN6heSlH
         8kpuIWkC3IDtqgO45ACN3ZOK1ZwxCcxkjle1gJi/AduYNv9RrZxXFg31APW/YGvn2SS2
         LiwA==
X-Gm-Message-State: AOPr4FXdLSTrBaeyXNmrZHyvdyincSb9JL4PCdm3m92MTLCrXw59F16zUWi0jcoibjQqGA==
X-Received: by 10.66.65.109 with SMTP id w13mr42394961pas.142.1460897988332;
        Sun, 17 Apr 2016 05:59:48 -0700 (PDT)
Received: from lanh ([171.232.186.84])
        by smtp.gmail.com with ESMTPSA id rw2sm77055307pab.30.2016.04.17.05.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Apr 2016 05:59:47 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 17 Apr 2016 19:59:56 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <CACsJy8BOwzJSmS3PPeeRuaRwq=+kYLH8NX0i7P_wfDW9gLt6bA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291750>

First cut. I need opinions on 05/07, which converts
wt_status_get_state() to support selecting any worktree. I'm not super
happy with leaving "TODO: not supported yet" comments, even though
strictly speaking this series does not need it.

The reason it's left unsupported is, in order to add
worktree_get_sha1() or similar, resolve_ref() will be touched. But
that function is going under some changes for quite some time now, for
lmdb backend support, and I don't want to create more code conflicts
there, potentially delaying lmdb backend further.

Another option is leave wt_status_get_state() alone, factor out the
rebase-detection code and use that for worktree/checkout. We save a
few syscalls this way too.

Comments?

  [01/07] path.c: add git_common_path() and strbuf_git_common_path()
  [02/07] worktree.c: store "id" instead of "git_dir"
  [03/07] path.c: refactor and add worktree_git_path()
  [04/07] worktree.c: add worktree_git_path_..._head()
  [05/07] wt-status.c: make wt_status_get_state() support worktree
  [06/07] worktree.c: avoid referencing to worktrees[i] multiple times
  [07/07] checkout: prevent checking out a branch being rebased in another worktree

Total 6 files changed, 167 insertions(+), 38 deletions(-)
