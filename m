Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDC0C38A30
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 12:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B6521841
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 12:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCc09bhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgDSMcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 08:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgDSMcu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Apr 2020 08:32:50 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DDBC061A0C
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 05:32:50 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m8so6890556lji.1
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 05:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aqtzusbuJkMl1SnVg8j+gYlmf4l7pNSYwFTY80l2bLU=;
        b=gCc09bhOyrKJph18ugpPvQYXUjkZI9ItMyn9cpDFxaDwdNydeRqu5HdE6LaeJ8PVt7
         qJquLhp84/x9lF3OJuhytpGa101tj2lGiyiEt6WxV4hh16acVJIyiSN6ZBn6steNdpiV
         APtjiUppitcpL6A6ObUW5GaRRD3dFnY3lHRerRapV5SDGNxrpQpRARdePl1Neco4cvsb
         HstOgLXbRuud2E8mDZbKdxVkeHvoklDRR3l6uf+wE2qXXZr9APTdxJ648hM3/KVrIJKZ
         MiTCJBneVXUOjGzR99KLF3F7Xm/S2y+bT9R992jFJ09jDmGd0p6q5G8SiEzHOBuBl4nP
         ObBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aqtzusbuJkMl1SnVg8j+gYlmf4l7pNSYwFTY80l2bLU=;
        b=lZUG+zq56V6Izc+OT8IXV8VGqqSJj4WuOiEZINnZca4OrjuATpRDEyqVi15zUGdN+F
         18zLeqXxyve5Qd2AdIpGYMZKfAonhoh9AjDgokeT6hWZALI0GztvUEScJy4JBJlsreNs
         93pCFARIcXBXVSzvuew/r4GsTQzlV4ryIRAD7Tb8dQAPnxdxiiemEMKLZ11Jd7AARwrt
         wvN2ef22lGOG4lGQIM9HOWWsIfcBaFpOJjB66eo7417ZsZVfrjgXRUWlL+5tIReCVahj
         1IbpUAzm9sfxHsOMgKeiEIUSNKLRbcHmSBJd65n2w8ff5eLBJYagOmOKtDHMsYWCFlJU
         6nog==
X-Gm-Message-State: AGi0PuajwlqvhdwXdcu4M+/t1tIJUhDd+F4z5owsIWehsiPyWKMcHUeg
        07kz8CGHN7xr/xpUP7aDNcTSHE5k
X-Google-Smtp-Source: APiQypJrf4FUCSfbJ4RQaZycOjEHBE2UOxQs/tiKbqE7oSmW8t+U/0YDuPUFpXXo29zTt/lPwwctvA==
X-Received: by 2002:a2e:95d2:: with SMTP id y18mr2792154ljh.65.1587299568316;
        Sun, 19 Apr 2020 05:32:48 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id 73sm1843547ljj.72.2020.04.19.05.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 05:32:47 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 0/4] strbuf: fix doc for `strbuf_attach()` and avoid it
Date:   Sun, 19 Apr 2020 14:32:26 +0200
Message-Id: <cover.1587297254.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587240635.git.martin.agren@gmail.com>
References: <cover.1587240635.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v2 of my attempt to look into how `strbuf_attach()` works, how
it's documented and how it's actually used.

This is based on top of Danh's series [1]. Both their patch 2/3 and my
4/4 reason about "NUL" at a particular spot. In short, they conflict
about whether to use function "A" or "B" at one spot and a merge should
(in my opinion) use function "C". That seemed odd enough to me that I
decided to build on top instead.

`strbuf_attach()` has always handled `mem == len`. This was intentional.
When the function was eventually documented, this usage was incorrectly
documented as being wrong.

That documentation didn't stop lots of callers from using it
"incorrectly", though. I first fix the documentation. I then try to
avoid such usage anyway, partly because it can be confusing, partly
because if we know we have enough memory, there's no need to reallocate
a larger buffer.

Martin

[1] https://lore.kernel.org/git/cover.1587289680.git.congdanhqx@gmail.com/

Martin Ågren (4):
  strbuf: fix doc for `strbuf_attach()`
  strbuf: introduce `strbuf_attachstr_len()`
  strbuf: introduce `strbuf_attachstr()`
  strbuf_attach: prefer `strbuf_attachstr_len()`

 strbuf.h             | 40 ++++++++++++++++++++++++++++++++++++----
 apply.c              |  2 +-
 archive.c            |  2 +-
 blame.c              |  2 +-
 builtin/am.c         |  2 +-
 convert.c            |  4 ++--
 fast-import.c        |  2 +-
 imap-send.c          |  2 +-
 mailinfo.c           |  2 +-
 merge-recursive.c    |  2 +-
 path.c               |  3 +--
 pretty.c             |  4 ++--
 refs/files-backend.c |  3 +--
 trailer.c            |  2 +-
 14 files changed, 51 insertions(+), 21 deletions(-)

-- 
2.26.1

