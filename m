Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D68C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D39D220721
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bocoup-com.20150623.gappssmtp.com header.i=@bocoup-com.20150623.gappssmtp.com header.b="tGmF+iqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbgEDRUp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 13:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729667AbgEDRUp (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 13:20:45 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541ECC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 10:20:45 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e6so151850pjt.4
        for <git@vger.kernel.org>; Mon, 04 May 2020 10:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bocoup-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=L/q6f9OykPSqemYpjQ9AUD76NPcaIPPyKbbiQZotqLk=;
        b=tGmF+iqAeIVOLEJsr/gjslW7O8FlR8w+YIagOQ3KxgrRplS6zxnhpLKLVxsOptsrCA
         n05yu7oE07o3Re3+c98oEdg6fYcrUZ4uJ/7uQTgGTIZn3xJTHrVn+K8xLjotVG20KsjB
         QWicSogH/lsEwa3ybEf+2FSXkeNtzLvlKOt5hnEnukO8KupavrvHu6ORJzs/P5A2B2Fk
         OJ0YHCPSHgIdhIFbUqZrvR1yYdLLvGwpAANoPdQPvgjba6HWQYm+shWuLmJ5AqVbZtgp
         M08u/Mj5+OReSyxjI7TzXCDRB5cXRqD6FmQu3D10Nx+Ll4j2Rybp13okUrLz21Feqjgm
         eysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=L/q6f9OykPSqemYpjQ9AUD76NPcaIPPyKbbiQZotqLk=;
        b=CzK6MxCpfDgojPwlw/rCd23Deua5tt4nGHsoYxcJFJM4JrnIbK6PFMGmogbeVxlUYY
         WehVEsdxGe2QXffiRZs7AeCioBR4XJU7VDNB6RYfPB3nRy9tKpEYq1GhW8PKS9j0hSea
         /PyFFxMwxwj3FsZJ65ZcMMOZt5qutjDQO9uFiCMf08lkbGrgz9F6oBDSnwXscj1Rpq27
         Ykg62ssFcxL70COaE3V6wK1VKkUWTrDDJ0o5pkdTwegnG0AR52jW4fCNNotb5yInxi5Q
         yK9Npq69thsCDFO4E9iRdbR9Z2yghDd+X8893Pj9OWFG23oDBrDP8SU/9O4ET4ut0O/N
         hy8A==
X-Gm-Message-State: AGi0PuacFOArBiXls3SeYNDsfhxGQAKMDZAxG8LkyTW0q1arfBpLthoG
        OAasBEAvlfbNFA4x+pSzCep+UbH8LL7tXziUzSRGY7tjAlLMfA==
X-Google-Smtp-Source: APiQypLGm9YPwqJ/cYIHLPZOKb+c4DRrlIyYMaCp3ui1rgN/syI1D3+i4dlNrm5T1lcq5RcTUNXNE1GJpxik4sbjxx8=
X-Received: by 2002:a17:90a:4802:: with SMTP id a2mr44815pjh.66.1588612844527;
 Mon, 04 May 2020 10:20:44 -0700 (PDT)
MIME-Version: 1.0
From:   Simon Pieters <simon@bocoup.com>
Date:   Mon, 4 May 2020 19:20:33 +0200
Message-ID: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
Subject: Rename offensive terminology (master)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"master" is an offensive term, as it can be interpreted as being
slavery-origin terminology. See
https://en.wikipedia.org/wiki/Master/slave_(technology)#Terminology_concerns

The Python programming language, and various other projects, have
taken a stance and moved away from offensive terminology including
"master". See https://bugs.python.org/issue34605

When different projects using git decide to move away from "master" as
the name of their main branch, inconsistency ensues between projects.
See https://github.com/desktop/desktop/issues/6478 (and "Related
Issues and Projects").

To avoid offensive terminology and to avoid further inconsistency, I
think git should use a different branch name than "master" when
initiating a repo. I don't have a strong opinion, but I like "main"
since it shares the first two characters and it's shorter.

-- 
Simon Pieters
Bocoup https://bocoup.com/
