Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D02C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00FC207FF
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ps8H+DMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfLILxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:53:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42632 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbfLILxF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 06:53:05 -0500
Received: by mail-wr1-f65.google.com with SMTP id a15so15827080wrf.9
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 03:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=26KtQ1aimK0UHqgVpVKdtSXgYFau8ljt9sODpSP7yqk=;
        b=ps8H+DMdnVR04J6cWfelTIx39Iym6VUuo2nhK6rYEA116lZR72U/SZvAEWtOmddG1h
         L7b8QpLNl927k4hLG6etNBLyIG/i/M3fKTJZiJv5ndnUMAulfS1PBRRp46SDXihfH+v+
         Yly5cEk2k2yQ9R4KxDuCgDGKbYg0S7e9LqgB9f33RuhHT4qV6S1HSn5/WohZlut5q3OS
         3isTiTt6rc4q8RWca8pxSYw9awdOxvjIWm6zcvUD9d+mVsNncoO5cVv5+Om8b/7FkdR3
         khql1iR3Mpylu5hMnmWZV/H33PkpK3iIjiX8QBcgP3LGo3s6TZlrjW+wQ82jslnXfTOe
         YgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=26KtQ1aimK0UHqgVpVKdtSXgYFau8ljt9sODpSP7yqk=;
        b=P2UfYPBQ6ye6/xYyBIZDk/pQNRdG+GqbAkIqhlYrTTx8KIjuyixcggrtSSt3yMu2nt
         UTkgkdit/o6QOLoDqh3l5NCEbXxMR9VvlvSpmy/TFWX2qaulLhXa7SNVhTbH8jjupBpd
         VxSzSbnOkjl9inTTVSV83cFYhQ+d9uR3IdKYL38rxIC32C4646x+hEh/hkaMucYffRVQ
         BoD/WQZCZqxglCALa6gC2SI582xXt0h7uS00k/Q4SpxiTL4MPQOlvM0DVyBS47PAZvGZ
         N3ekZV4L+6o06f6KT6PWggR4+S4LRSVxzAI0aQ+xSeHkfmMQTXspL8G94nm1g6JSAaZ9
         EGgQ==
X-Gm-Message-State: APjAAAWpydCw8hAh4st2PDBm3MfhV9Tq9iWluroI2obz4pVO6teDQhV+
        etDkUfCi3B4EQzbNdY5Q8ik=
X-Google-Smtp-Source: APXvYqzAHUJ0VC32NcZOHBo7w0mVvnh5zfyKYMaT6DFpGbNeESmDPVfUpU6oCos3vqUOmnRxqPKPFg==
X-Received: by 2002:a05:6000:1047:: with SMTP id c7mr1731014wrx.341.1575892382988;
        Mon, 09 Dec 2019 03:53:02 -0800 (PST)
Received: from localhost.localdomain (x4db55b9c.dyn.telefonica.de. [77.181.91.156])
        by smtp.gmail.com with ESMTPSA id k8sm27239621wrl.3.2019.12.09.03.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 03:53:02 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 00/14] name-rev: eliminate recursion
Date:   Mon,  9 Dec 2019 12:52:44 +0100
Message-Id: <20191209115258.9281-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.801.g241c134b8d
In-Reply-To: <20191112103821.30265-1-szeder.dev@gmail.com>
References: <20191112103821.30265-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git name-rev' is implemented using a recursive algorithm, and,
consequently, it can segfault in deep histories (e.g. WebKit), and
thanks to a test case demonstrating this limitation every test run
results in a dmesg entry logging the segfaulting git process.

This patch series eliminates the recursion.

Changes since v2:

  - Add the new patch 12 to use 'name->tip_name' instead of
    'tip_name', to make the patch eliminating the recursion a bit even
    easier to follow (only with '--ignore-all-space', though, without
    that option that patch's diff is still mostly gibberish).
    The end result is the still same, see the empty interdiff.

  - Minor commit message updates (a typofix and René's signoff).

v2: https://public-inbox.org/git/20191112103821.30265-1-szeder.dev@gmail.com/
v1: https://public-inbox.org/git/20190919214712.7348-1-szeder.dev@gmail.com/T/#u

René Scharfe (1):
  name-rev: use strbuf_strip_suffix() in get_rev_name()

SZEDER Gábor (13):
  t6120-describe: correct test repo history graph in comment
  t6120-describe: modernize the 'check_describe' helper
  name-rev: avoid unnecessary cast in name_ref()
  name-rev: use sizeof(*ptr) instead of sizeof(type) in allocation
  t6120: add a test to cover inner conditions in 'git name-rev's
    name_rev()
  name-rev: extract creating/updating a 'struct name_rev' into a helper
  name-rev: pull out deref handling from the recursion
  name-rev: restructure parsing commits and applying date cutoff
  name-rev: restructure creating/updating 'struct rev_name' instances
  name-rev: drop name_rev()'s 'generation' and 'distance' parameters
  name-rev: use 'name->tip_name' instead of 'tip_name'
  name-rev: eliminate recursion in name_rev()
  name-rev: cleanup name_ref()

 builtin/name-rev.c  | 147 +++++++++++++++++++++++++++++---------------
 t/t6120-describe.sh |  72 +++++++++++++++++-----
 2 files changed, 153 insertions(+), 66 deletions(-)

Interdiff against v2:
Range-diff against v2:
 1:  8d70ed050d =  1:  8d70ed050d t6120-describe: correct test repo history graph in comment
 2:  3720b6859d !  2:  d2091869c8 t6120-describe: modernize the 'check_describe' helper
    @@ Commit message
         'test_expect_success' blocks, with extra hand-rolled code to record
         and examine its exit code.
     
    -    Update this helper and move the 'git decribe' invocation inside the
    +    Update this helper and move the 'git describe' invocation inside the
         'test_expect_success' block.
     
         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
 3:  ad2f2eee68 !  3:  9d13032871 name-rev: use strbuf_strip_suffix() in get_rev_name()
    @@ Commit message
         string to the strbuf and then use strbuf_strip_suffix(), making the
         code more idiomatic.
     
    -    [TODO: René's signoff!]
    +    Signed-off-by: René Scharfe <l.s.r@web.de>
         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
     
      ## builtin/name-rev.c ##
 4:  c86a2ae2d0 =  4:  b1a8d7ce03 name-rev: avoid unnecessary cast in name_ref()
 5:  4fc960cc05 =  5:  3497d0bc42 name-rev: use sizeof(*ptr) instead of sizeof(type) in allocation
 6:  1493cb4484 =  6:  43cba1a369 t6120: add a test to cover inner conditions in 'git name-rev's name_rev()
 7:  fc842e578b =  7:  7053fc707c name-rev: extract creating/updating a 'struct name_rev' into a helper
 8:  7f182503e2 =  8:  28d957df88 name-rev: pull out deref handling from the recursion
 9:  0cdd40b75b =  9:  5bd4dede3d name-rev: restructure parsing commits and applying date cutoff
10:  e1733e3c56 = 10:  92f3897ff3 name-rev: restructure creating/updating 'struct rev_name' instances
11:  bd6e2e6d87 = 11:  cd24270f23 name-rev: drop name_rev()'s 'generation' and 'distance' parameters
 -:  ---------- > 12:  f33c0bbfd0 name-rev: use 'name->tip_name' instead of 'tip_name'
12:  0cf63c6d64 ! 13:  e5d7d291bd name-rev: eliminate recursion in name_rev()
    @@ builtin/name-rev.c: static struct rev_name *create_or_update_name(struct commit
     +				distance = name->distance + 1;
     +			}
      
    --			strip_suffix(tip_name, "^0", &len);
    +-			strip_suffix(name->tip_name, "^0", &len);
     -			if (name->generation > 0)
    --				new_name = xstrfmt("%.*s~%d^%d", (int)len, tip_name,
    +-				new_name = xstrfmt("%.*s~%d^%d",
    +-						   (int)len,
    +-						   name->tip_name,
     -						   name->generation,
     -						   parent_number);
     -			else
    --				new_name = xstrfmt("%.*s^%d", (int)len, tip_name,
    +-				new_name = xstrfmt("%.*s^%d", (int)len,
    +-						   name->tip_name,
     -						   parent_number);
     -			generation = 0;
     -			distance = name->distance + MERGE_TRAVERSAL_WEIGHT;
     -		} else {
    --			new_name = tip_name;
    +-			new_name = name->tip_name;
     -			generation = name->generation + 1;
     -			distance = name->distance + 1;
     +			if (create_or_update_name(parent, new_name, taggerdate,
13:  316f7af43c = 14:  0b556389a3 name-rev: cleanup name_ref()
-- 
2.24.0.801.g241c134b8d

