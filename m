Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC7AE1FAA8
	for <e@80x24.org>; Mon, 15 May 2017 11:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753234AbdEOLGM (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 07:06:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33238 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbdEOLGL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 07:06:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id y10so27472847wmh.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 04:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=azMTBq4WiJo+xcZwfrsTPBb20Q7nQvZgU/jcbqge25k=;
        b=jAkGeqkP5hNY0CK3CThQhcaAwOHH6oHebt0RG8fX1SHBOrfkqwDUc9xT2WZYqz67ct
         BB0/EyrjsV1nEZ1XHmyN0Cn/FQhquA6MFTXMOjqytXGdxztFKNRbcfhYF9HVqJgmv9SN
         28DZavjVoLS5L89DvIj+kkUD9rNDLSHjxW9om0I5sRdHo/2LvIx1wmf4N7Jql6icrZc9
         U9ebu6JCHVjC6epd7kwqGXNkYT+oYZJMslwZ8m3fIRZhbv9wWwdCEtaRv+CXQiQES/tx
         My8loVUA2s2LaBMkOip1thv41l8o8DhdUgSlko7VUWt2NO4tmABd4DdzjH7R1+Rp8ioA
         9rGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=azMTBq4WiJo+xcZwfrsTPBb20Q7nQvZgU/jcbqge25k=;
        b=Z4B1L3XwWCZDEcq5chMGN9nNfHmKwwmzQ+oUm1NBWFp2NQOGpR4kFMudxILJ9ke8Rs
         HoIqzdDgsoGdgeyAyJfZ3ORdAzAtEG/17Xr6SqaI5Z3E5miUac4hRzGVDvlg5KiohbDD
         fjn1gyqo1dT9FlCILgRTh+ymfeb2ZLM2Zi+O5F7zCTLzabtP+Z2QE8BYDJSEUlsflPmm
         9W//PWfnxfMcBnM2FgcBRnn5jh4Qg5cBRGn1vxCFPmEAgLblomIKy7PsE1j4ObqOY0DE
         8Tocsvb+jV3/JQ9vJlmMxx0Oee7Q7l8SFouIDIfWEA8+DKAthlgfTuL53ERL0var7Ohf
         K4xg==
X-Gm-Message-State: AODbwcCuMmtgv7K8eIwoIe/o8ZdUQ3x1YuJPFoKqR/LABO2uzpCMofFT
        LSEH5v3aiwGF2g==
X-Received: by 10.28.135.82 with SMTP id j79mr3132279wmd.10.1494846370119;
        Mon, 15 May 2017 04:06:10 -0700 (PDT)
Received: from localhost.localdomain (62-165-238-151.pool.digikabel.hu. [62.165.238.151])
        by smtp.gmail.com with ESMTPSA id 20sm10363191wmk.17.2017.05.15.04.06.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 May 2017 04:06:09 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv3 0/4] clone: respect configured fetch respecs during initial fetch
Date:   Mon, 15 May 2017 13:05:53 +0200
Message-Id: <20170515110557.11913-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.0.35.g14b6294b1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a reroll of sg/clone-refspec-from-command-line-config.
Sorry for the delay, family visit.

The first patch is the updated version of what is now the first commit
of that topic.  The changes are those mentioned in [1]:

 - updated commit message,
 - renamed 'refspec_count' to 'refspec_nr',
 - use the parsed fetch refspecs returned by remote.c:remote_get()
   instead of parsing them ourselves (look at the third hunk of the
   diff of builtin/clone.c, how much shorter it looks),
 - modified tests to check that refs matching the default refspecs are
   transferred as well, and
 - added a test for the combination of '-c
   remote.<remote>.fetch=<refspec> --origin=<name>'.

The second patch is a doc update to warn users that not all
configuration variables are supported via 'git clone -c ...' at the
moment.

Patches 3 and 4 are the last two patches from Peff from this morning
[2].  I picked those up, because his last patch required a bit of
variable name adjustments.  I didn't pick up his first patch, because
using remote_get() already factors out refspec parsing.

[1] - http://public-inbox.org/git/xmqq4lwu7r0s.fsf@gitster.mtv.corp.google.com/T/#u
[2] - http://public-inbox.org/git/20170515074617.wsdzogshc4ilnlsb@sigill.intra.peff.net/T/#m021eadff5d1e4351d99a27096090be39f53df961

Jeff King (2):
  remote: drop free_refspecs() function
  clone: use free_refspec() to free refspec list

SZEDER Gábor (2):
  clone: respect additional configured fetch refspecs during initial
    fetch
  Documentation/clone: document ignored configuration variables

 Documentation/git-clone.txt |  4 ++++
 builtin/clone.c             | 22 ++++++++++++++++------
 remote.c                    | 28 ++++++----------------------
 t/t5611-clone-config.sh     | 44 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+), 28 deletions(-)

-- 
2.13.0.35.g14b6294b1

