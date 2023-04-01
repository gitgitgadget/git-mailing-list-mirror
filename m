Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDBCCA9EB6
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 21:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjDAV3F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 17:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjDAV3E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 17:29:04 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BCD93C2
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 14:29:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e18so25692663wra.9
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 14:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680384541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6TiIutWsoIh47Em/42NpBcF7oKKsL07wRV3PrpObV6k=;
        b=gbmPUR/QwgnKbWamSUKD9I3t7EaJbT+dTDgt88MlOQFPXWwfdI/1by9jRwvsqEGFpD
         EFWUsciUx1JZaNu7XohBMwENHyW2stffnfrPABupOwlPeMIUXrAoZUDoIP/3rHQX+GTi
         9eev7hD6CvATvALgxYtK8ARWvqG80pToDfsqGZIfutyGjJHbkHCGBUnP9DIsM3s1hCCr
         24Pq6rEjRlnn2x4vwVGyFVR8F33IZUYzOMHm497Jh6nsDQXsdobj6bKN4cOFx+G+TKxp
         JrB/sn6YWt95xEr4mnyLsMLHLSWmkW2rr76xI7ss6bTv4tQUeXOvahQtNljOqRwVbvvK
         nVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680384541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6TiIutWsoIh47Em/42NpBcF7oKKsL07wRV3PrpObV6k=;
        b=oSAQnJ29lB8zaZClBSw6XjPnKoI1kLLxy4+bDi1ErLbAA2F5F/aTaBpPFHvlJ6Ya1F
         mKl98zD5aZzjptNA10RU7Tqj6ZH6+MNUKsbzHaKC4EPIjYNr704eusW8CYfj7Ucu6bny
         ibYKLV6pRANxvgcJwYVC89LkmFluaHVPmHFj76mepxQJNsgbH8ymLCyJkHn2W9KF6vqk
         YAo04ibM9rq5ikWdsOO+S5MWQZunmjdK4WARxXvVJsuYp8aiGC7duHf8wfOEnzs09tUF
         ayWsziUT/URKtMjZjyth3tuzBCtaqNVG3kg0DDHtEdbCs0MBmcUufK+p2qriRF/GaqbC
         hExA==
X-Gm-Message-State: AAQBX9fH/1wsfDOZ52pu6lBugROvz8oAWEMqBS/TqHKCpVTQUu/gfeCD
        H8zB1AW8bVjfcCgmMr9T5/Y3hRrDQcoohioG
X-Google-Smtp-Source: AKy350ZqLmnpiNfcZaRPazVLp7s2+FGEtFFC8EcfU0HgHIc/JorgAlhs1JPkXRkg3J1Zw4dojM/5bA==
X-Received: by 2002:adf:f3d1:0:b0:2d5:9500:26 with SMTP id g17-20020adff3d1000000b002d595000026mr8775099wrp.19.1680384540962;
        Sat, 01 Apr 2023 14:29:00 -0700 (PDT)
Received: from titov.fritz.box ([212.102.57.24])
        by smtp.gmail.com with ESMTPSA id i12-20020a5d55cc000000b002c3f81c51b6sm5738364wrw.90.2023.04.01.14.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 14:29:00 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Martin Stenberg <martin@gnutiken.se>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v1 0/6] t: fix unused files, part 2
Date:   Sat,  1 Apr 2023 23:28:52 +0200
Message-Id: <20230401212858.266508-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Creation of files from redirecting output of Git commands in tests has been
removed for files which aren't being used for assertions.  CC'ed are authors of
the affected tests.

This is a continuation of part 1:
  https://lore.kernel.org/git/20230312201520.370234-1-rybak.a.v@gmail.com/T/#u

Overall, this is similar to part 1, except that additionally in patch 4/6
creation of an unused file that isn't output of a git command has been removed.
Patch 2/6 fixes broken comments, found during development of this series.

Since part 1 I've upgraded my 'check_unused_files.py' script (invoked in the
same way as in part 1) and found a bit more issues in t0??? and t1???, and
overall have gone up to t2???.

Upgraded script:

    from sys import argv
    import re

    script = argv[1]

    git_with_outputs_pattern = re.compile('git [^&\"]*?[>](?!/)([-a-z_./]*)( 2[>](?!/)([a-z_.-]*))?')

    out_read_index = -1
    err_read_index = -1

    def clean_up_filename(fn):
        if fn and '/' in fn:
            from os import path
            return path.basename(fn)
        return fn

    while True:
        res = git_with_outputs_pattern.search(script)
        if res is None:
            break
        end_index = res.span()[1]
        out_filename = clean_up_filename(res.group(1))
        err_filename = clean_up_filename(res.group(3))

        script = script[end_index:]

        if out_filename:
            out_read_index = script.find(out_filename)
            if out_read_index < 0:
                print("File '" + out_filename + "' is unused")
                print("Script: ")
                print(script)
                from sys import exit
                exit(1)
        if err_filename and err_filename != '&1':
            err_read_index = script.find(err_filename)
            if err_read_index < 0:
                print("File '" + err_filename + "' is unused")
                print("Script: ")
                print(script)
                from sys import exit
                exit(2)
        if out_read_index >= 0:
            script = script[out_read_index + len(out_filename):]
        elif err_read_index >= 0:
            script = script[err_read_index + len(err_filename):]

Andrei Rybak (6):
  t0300: don't create unused file
  t1300: fix config file syntax error descriptions
  t1300: don't create unused files
  t1450: don't create unused files
  t1502: don't create unused files
  t2019: don't create unused files

 t/t0300-credentials.sh            |  2 +-
 t/t1300-config.sh                 | 10 +++++-----
 t/t1450-fsck.sh                   |  5 +----
 t/t1502-rev-parse-parseopt.sh     |  6 +++---
 t/t2019-checkout-ambiguous-ref.sh |  4 ++--
 5 files changed, 12 insertions(+), 15 deletions(-)

-- 
2.40.0

