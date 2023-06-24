Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A0BEB64DC
	for <git@archiver.kernel.org>; Sat, 24 Jun 2023 21:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjFXVX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jun 2023 17:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjFXVXx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2023 17:23:53 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B5F171A
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 14:23:51 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-40097b0a124so5654031cf.0
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687641831; x=1690233831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++mYGqruhPdHRWmfvKW3xWkLZrlx1pxG0HibzvkyXjg=;
        b=SmlRrUt9YjAcD8DkezQVcRjiCP/pEhOumZJLCpHEQ5+ody+K2T4/9U+PX6fWqmnyLB
         a5M2iJ4qDO996WAglqz/izPZBZ9JYuz6kF6qHqMDDNuIab+7rWmBrVjLa9a2nOQuPNed
         pR5+emdyqIXhqrM+ohmXkoX9H9jyZR//LJ3M3jiuqaXHGqRiHmKPoOk+JHnKFtVJwaF2
         Q2NJraK9toF6rHqISVsS5y8c7DrSyBRMY1Fen/fzsLBqVGTEuVL63DMYlsQVGAWEPvXg
         UWHMsyNTa2fVDc0ojUdqr6RkOSjNS/QvX/DnAca/hp8z3EpUGp300ft1hUEYkEV+GDiD
         ApTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687641831; x=1690233831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++mYGqruhPdHRWmfvKW3xWkLZrlx1pxG0HibzvkyXjg=;
        b=TybP8AWSYVOhkq6N48WG28wKVug7OD00ndTdJ8aKaoVIV6BghBSIj/A6sBKdVcs4vd
         he+3J8TqWaRY3LiNRlDU9lHYmVz9ynsOeAolRxbgSGkffdA8FQCT3L1ek4fcYy+LSvvm
         VH/sB2njuZWPzT2u7PrH7UejVlJ91GI8obgky1t/Bw0xxJbJk+v+2VsgjSSGJCgV7sOK
         hPx6ZyeCGR3fT5/3+3jbUBafT7vE+lbZjWwXqoCZM5ZJRasvHWMKy0iqVDtcqwnRLwv4
         RQqSh4g00LajPJEVqhBwNOX2sY7R9Wl99SCumgj4RxFUDNlQ2yR8NmWEyej8Jen5niAT
         iokA==
X-Gm-Message-State: AC+VfDyDvzAbZBKFG0SY7wMaqhgGxa73jIyx54MgFvN9ryMHH4QipEbl
        8ntPlnUNlF2/ofGaAVuSVGJUR7OS8yZVRw==
X-Google-Smtp-Source: ACHHUZ56GSCQjujBMtDPVLXvkleRrw7VvpdrxkqXg29/2s9/PxW3K9jgJKmwlaLnly4qLuZynyL+0w==
X-Received: by 2002:ac8:5956:0:b0:3fd:e8e9:a67 with SMTP id 22-20020ac85956000000b003fde8e90a67mr24904042qtz.39.1687641830839;
        Sat, 24 Jun 2023 14:23:50 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:266e:4d00::387])
        by smtp.gmail.com with ESMTPSA id x15-20020ac87ecf000000b003fdd34c6babsm1118182qtj.76.2023.06.24.14.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 14:23:50 -0700 (PDT)
From:   Mark Levedahl <mlevedahl@gmail.com>
To:     git@vger.kernel.org
Cc:     adam@dinwoodie.org, me@yadavpratyush.com,
        johannes.schindelin@gmx.de, Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v0 3/4] git-gui - use cygstart to browse on Cygwin
Date:   Sat, 24 Jun 2023 17:23:46 -0400
Message-ID: <20230624212347.179656-4-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.41.0.99.19
In-Reply-To: <20230624212347.179656-1-mlevedahl@gmail.com>
References: <20230624212347.179656-1-mlevedahl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pre-2012, git-gui enabled the "Repository->Explore Working Copy" menu on
Cygwin, offering open a Windows graphical file browser at the root
working directory. The old code relied upon internal use of Windows
pathnames, while git-gui must use unix pathnames on Cygwin since 2012,
so was removed in a previous patch.

A base install of Cygwin provides the /bin/cygstart utility that runs
arbtitrary Windows applications after translating unix pathnames to
Windows.  Adding the --explore option guarantees that the Windows file
explorer is opened, regardless of the supplied pathname's file type and
avoiding possibility of some other action being taken.

So, teach git-gui to use cygstart --explore on Cygwin, restoring the
pre-2012 behavior of opening a Windows file explorer for browsing.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index b5dba80..523770a 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2276,6 +2276,8 @@ proc do_git_gui {} {
 proc get_explorer {} {
 	if {[is_Windows]} {
 		set explorer "explorer.exe"
+	} elseif {[is_Cygwin]} {
+		set explorer "/bin/cygstart.exe --explore"
 	} elseif {[is_MacOSX]} {
 		set explorer "open"
 	} else {
-- 
2.41.0.99.19

