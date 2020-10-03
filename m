Return-Path: <SRS0=BObu=DK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91400C41604
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 13:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C370206CD
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 13:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYcFWQx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgJCN3Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Oct 2020 09:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgJCN3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Oct 2020 09:29:16 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DE9C0613D0
        for <git@vger.kernel.org>; Sat,  3 Oct 2020 06:29:15 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v12so4482013wmh.3
        for <git@vger.kernel.org>; Sat, 03 Oct 2020 06:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YXfuSFPFq4W6ILkAyxyQ+mbE2uukA/C38/Q7YsktYB4=;
        b=IYcFWQx+s6VSH0Jhh1L/2whZTMkbopS5tczftcrMgdB3v98NQ9eKDO0APvVTa3dNum
         gYyGSdDbsN17KyanVAA3WzZLLZ07gGuTtIdPVsvPI+n8qSzf0cHJTO1OLnO3BBUn2yop
         jqHlqTPlTAbNvm2AUlbSeLy55ne5l7M+UN9sFLQp285oMXLm0PGztZKqcGX1g1qlMS4N
         kUR6caclN4kFn5XQb9CqvrCzU1y8oP1m9RcSZ4D7mpp8xFNqEsUr5+UkwESm5yuhTaQn
         gYkPgFOz6YfkT6Ifdkmexn0hvdPpetedyzA1fVlzJ13nHukCZhwMrq3FnR6fpfS1ZoXq
         YhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YXfuSFPFq4W6ILkAyxyQ+mbE2uukA/C38/Q7YsktYB4=;
        b=SFHDP4OI7JBl0ZWUnigiG6CVtAcXFC4kk4ji0kUMc98ZMJUXN4wYBoj9D8Ci8JRGio
         hFXpVB/jVuFXY1LwKMQrjsxtMsd0diwcJRHx8AqWvBbwV5XRbw1f+WAlrbhrb2rpxP8T
         FmsG5EO42VM/oDOi0AJarNRejMLSV03XQCvIPlIPaskFmdfCuuMllhuVBUpBMIKBbF1H
         hPnKCJTvE4JV+rjeuGxL4JzUuUe9nlCyQ8TvWzyDqrpjj8M4D+fbUW+4cadL5NnsZKyw
         kfaCF9SH29+gbhjfNaU6lycLCV19MI2i/F3G1sp7yBogsm94Gir/hQrU2nLJR/Z3YtH1
         R0KQ==
X-Gm-Message-State: AOAM531Ce+tu6jzU36jrBj/9g/OWAC2J6z6/WhtRc6SG7J/UiY3Odrz3
        xyb9PSu8GUrIefUCzrNXmONiB1sw0H8=
X-Google-Smtp-Source: ABdhPJxV9qYWELGW2KdWEPoG6/gv5bFrfroaudgXThem+U8w3XEVucwxeCNl78bYEuLSR8WhiwFxgA==
X-Received: by 2002:a1c:8093:: with SMTP id b141mr5689750wmd.139.1601731753688;
        Sat, 03 Oct 2020 06:29:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b8sm5241038wmb.4.2020.10.03.06.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 06:29:13 -0700 (PDT)
Message-Id: <pull.710.v3.git.git.1601731752695.gitgitgadget@gmail.com>
In-Reply-To: <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com>
References: <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 03 Oct 2020 13:29:12 +0000
Subject: [PATCH v3] credential: treat CR/LF as line endings in the credential
 protocol
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nikita Leonov <nykyta.leonov@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nikita Leonov <nykyta.leonov@gmail.com>

This fix makes using Git credentials more friendly to Windows users: it
allows a credential helper to communicate using CR/LF line endings ("DOS
line endings" commonly found on Windows) instead of LF-only line endings
("Unix line endings").

Note that this changes the behavior a bit: if a credential helper
produces, say, a password with a trailing Carriage Return character,
that will now be culled even when the rest of the lines end only in Line
Feed characters, indicating that the Carriage Return was not meant to be
part of the line ending.

In practice, it seems _very_ unlikely that something like this happens.
Passwords usually need to consist of non-control characters, URLs need
to have special characters URL-encoded, and user names, well, are names.

However, it _does_ help on Windows, where CR/LF line endings are common:
as unrecognized commands are simply ignored by the credential machinery,
even a command like `quit\r` (which is clearly intended to abort) would
simply be ignored (silently) by Git.

So let's change the credential machinery to accept both CR/LF and LF
line endings.

While we do this for the credential helper protocol, we do _not_ adjust
`git credential-cache--daemon` (which won't work on Windows, anyway,
because it requires Unix sockets) nor `git credential-store` (which
writes the file `~/.git-credentials` which we consider an implementation
detail that should be opaque to the user, read: we do expect users _not_
to edit this file manually).

Signed-off-by: Nikita Leonov <nykyta.leonov@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Prepare git credential to read input with DOS line endings
    
    This contribution came in via Git for Windows
    [https://github.com/git-for-windows/git/pull/2516].
    
    Sadly, I did not find the time to go through all the changes of 8f309aeb
    ("strbuf: introduce strbuf_getline_{lf,nul}()", 2016-01-13) (as Junio
    asked
    [https://public-inbox.org/git/xmqqmu9lnjdh.fsf@gitster-ct.c.googlers.com]
    ). Rather than delaying this patch indefinitely, I admit defeat on that
    angle.
    
    Changes since v2:
    
     * Dropped the credential-cache--daemon and credential-store changes
       again.
     * Enhanced the commit message (also explaining why we don't touch the
       daemon and the store).
    
    Changes since v1:
    
     * Added a commit to adjust credential-daemon and credential-store in
       the same manner.
     * Adjusted the documentation accordingly.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-710%2Fdscho%2Fcrlf-aware-git-credential-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-710/dscho/crlf-aware-git-credential-v3
Pull-Request: https://github.com/git/git/pull/710

Range-diff vs v2:

 1:  27f6400a21 ! 1:  f6eeb18d3a credential.c: fix credential reading with regards to CR/LF
     @@ Metadata
      Author: Nikita Leonov <nykyta.leonov@gmail.com>
      
       ## Commit message ##
     -    credential.c: fix credential reading with regards to CR/LF
     +    credential: treat CR/LF as line endings in the credential protocol
      
     -    This fix makes using Git credentials more friendly to Windows users. In
     -    previous version it was unable to finish input correctly without
     -    configuration changes (tested in PowerShell, CMD, Cygwin).
     +    This fix makes using Git credentials more friendly to Windows users: it
     +    allows a credential helper to communicate using CR/LF line endings ("DOS
     +    line endings" commonly found on Windows) instead of LF-only line endings
     +    ("Unix line endings").
      
     -    We know credential filling should be finished by empty input, but the
     -    current implementation does not take into account CR/LF ending, and
     -    hence instead of the empty string we get '\r', which is interpreted as
     -    an incorrect string.
     +    Note that this changes the behavior a bit: if a credential helper
     +    produces, say, a password with a trailing Carriage Return character,
     +    that will now be culled even when the rest of the lines end only in Line
     +    Feed characters, indicating that the Carriage Return was not meant to be
     +    part of the line ending.
      
     -    So this commit changes default reading function to a more Windows
     -    compatible reading function.
     +    In practice, it seems _very_ unlikely that something like this happens.
     +    Passwords usually need to consist of non-control characters, URLs need
     +    to have special characters URL-encoded, and user names, well, are names.
     +
     +    However, it _does_ help on Windows, where CR/LF line endings are common:
     +    as unrecognized commands are simply ignored by the credential machinery,
     +    even a command like `quit\r` (which is clearly intended to abort) would
     +    simply be ignored (silently) by Git.
     +
     +    So let's change the credential machinery to accept both CR/LF and LF
     +    line endings.
     +
     +    While we do this for the credential helper protocol, we do _not_ adjust
     +    `git credential-cache--daemon` (which won't work on Windows, anyway,
     +    because it requires Unix sockets) nor `git credential-store` (which
     +    writes the file `~/.git-credentials` which we consider an implementation
     +    detail that should be opaque to the user, read: we do expect users _not_
     +    to edit this file manually).
      
          Signed-off-by: Nikita Leonov <nykyta.leonov@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
 2:  f69076036f < -:  ---------- credentials: make line reading Windows compatible
 3:  61baea1061 < -:  ---------- docs: make notes regarding credential line reading


 credential.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/credential.c b/credential.c
index efc29dc5e1..e5202fbef2 100644
--- a/credential.c
+++ b/credential.c
@@ -202,7 +202,7 @@ int credential_read(struct credential *c, FILE *fp)
 {
 	struct strbuf line = STRBUF_INIT;
 
-	while (strbuf_getline_lf(&line, fp) != EOF) {
+	while (strbuf_getline(&line, fp) != EOF) {
 		char *key = line.buf;
 		char *value = strchr(key, '=');
 

base-commit: 9bc233ae1cf19a49e51842c7959d80a675dbd1c0
-- 
gitgitgadget
