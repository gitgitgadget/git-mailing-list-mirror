Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EDDD1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 22:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeJFFqw (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 01:46:52 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:35083 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeJFFqv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 01:46:51 -0400
Received: by mail-ua1-f73.google.com with SMTP id v22so2371688uam.2
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 15:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=aNRQ88WazEIlepoFwXXhPWW4px7cSUUe7mzJqItawsA=;
        b=I+gMSlx3nfRIHA+7ksPmgwv5GYB/AZ7NNHpHmOn151x/Nu/G3KuFgmrjOYh551feu4
         /+MhBdVOJ8tHjfIv8AN/5lLJvcB2VpH3lcMylPUcOg+ZYu3JpjPrQcPQOsPVH1Fl3E7j
         E5vOt4+E6dI8ZAlkg1p3ODTjwbumLj6D+bDGaXttb4Oqjb685Ls1nwjGFmsx4+1YEasf
         g529y4z5UEr3rmcX2gPMri17exJl/yMsjGXHkWvrGPLYRveY8osqJ1earINf+HRXkUEQ
         0dInJsc1MpwxEu2rtQjwobVZv7n8pzLA2BKvxEWGr3ZAyViATjWkBLgMk+z6IAZqFdUh
         ajNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=aNRQ88WazEIlepoFwXXhPWW4px7cSUUe7mzJqItawsA=;
        b=hBZUP1rhFzw59fmB7cRfQBy69eCbwGSK1IoEpBLSJNPNXAELS1RWa918WXv+Cll8tf
         hm3W8Wuy2wFxD4OfTlQYydEm2eqGG7E+93XDDxQyp69sqNH83B29Nf0y8X4ZSNdzRUBx
         TbRAJn5C6YbfAzh/auJc+GpKG7Efog8Z7WEkg3ihRpe//u7KgOFuSZThCj4PtzqI2+sO
         ntsGVTtaGZxmahxn0q3Ew+SmB+KaRCxS+xQm2u22VZSe2gdkVJncmPXQ/MRrR5nIN1mW
         SynKExs0HbkZZDx5wdTgNh7431WI1/QRwlXrfM+xWw7weD3lPAJDxq24Uvs7XDG97j88
         Ansg==
X-Gm-Message-State: ABuFfogVIlyj/JjOJfeeJO+UBC+fSmyvMHpswwrJCLOz1vR1KrYquOky
        dsC6HTH165ftm0ZJONSC3DC6aI9STsgZYHZemiBtkPiVy7x0ETF7q42CXze/btleLE/XybWouUH
        jiJH/XL7sArM9qDA3VPkh/1cYn5Q7kI2xU3CimbXgcBL6VWxAPNKnNk7ysZWx
X-Google-Smtp-Source: ACcGV62emdeww27ZgoBNgZSVeYgZty2hgw5mSTsadMVnparTceodeEiQ57eReA2314rOt0CxTHAPw4SEbf7l
X-Received: by 2002:a67:4551:: with SMTP id s78mr8180395vsa.12.1538779561717;
 Fri, 05 Oct 2018 15:46:01 -0700 (PDT)
Date:   Fri,  5 Oct 2018 15:45:57 -0700
Message-Id: <20181005224557.31420-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0
Subject: [PATCH] builtin/grep.c: remote superflous submodule code
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     ao2@ao2.it, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In f9ee2fcdfa (grep: recurse in-process using 'struct repository',
2017-08-02), we introduced a call to repo_read_gitmodules in builtin/grep
to simplify the submodule handling.

After ff6f1f564c4 (submodule-config: lazy-load a repository's .gitmodules
file, 2017-08-03) this is no longer necessary, but that commit did not
cleanup the whole tree, but just show cased the new way how to deal with
submodules in ls-files.

Cleanup the only remaining caller to repo_read_gitmodules outside of
submodule.c

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Antonio Ospite writes:
> BTW, with Stefan Beller we also identified some unneeded code which
> could have been removed to alleviate the issue, but that would not have
> solved it completely; so, I am not removing the unnecessary call to
> repo_read_gitmodules() builtin/grep.c in this series, possibly this can
> become a stand-alone change.

Here is the stand-alone change.

The patch [1] contains the lines as deleted below in the context lines
but they would not conflict as there is one empty line between the changes
in this patch in [1].

[1] https://public-inbox.org/git/20181005130601.15879-10-ao2@ao2.it/


 builtin/grep.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 601f801158..a6272b9c2f 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -427,8 +427,6 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 	if (repo_submodule_init(&submodule, superproject, path))
 		return 0;
 
-	repo_read_gitmodules(&submodule);
-
 	/*
 	 * NEEDSWORK: This adds the submodule's object directory to the list of
 	 * alternates for the single in-memory object store.  This has some bad
-- 
2.19.0

