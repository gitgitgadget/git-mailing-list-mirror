Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66BC61F667
	for <e@80x24.org>; Tue, 15 Aug 2017 11:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751494AbdHOLtc (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 07:49:32 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36255 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbdHOLtc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 07:49:32 -0400
Received: by mail-lf0-f66.google.com with SMTP id t128so462160lff.3
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 04:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=zoTRhjQmAD60az2pGRuXfLeZkIKY9jihl3rHJ3DUCxc=;
        b=t6bycY1tNY0m+UGxBk6pNLUzp5wFp2mFZO8VIuy34lyXKR3l/GaNUqKzeyP+VQ8ofW
         1itYRG+Ec+dPPIbzZZUTYvlRClo48tn2tRR62pADrfnG6d4ugkvrZGB3UTJGN4G3q85V
         mgrRumE7z7OhE87pDZZe/XBgnuOfCb0ku1nYAcpyaFLuWXROrAj/IvLFNYoPTeqBWmtF
         I5hZugu/6WddgkSQHmmzeAWrGE0IFhiFWeG+u4yn+iT0hjWsivspAAL6B+KDgO4q5iNk
         LSgUnAD4YEWc20Do1hMI6DUAsKattY1JeTnCuQJR7kF3jzypdZHDTajCnRaguxSXzoac
         CThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=zoTRhjQmAD60az2pGRuXfLeZkIKY9jihl3rHJ3DUCxc=;
        b=NsYTAaQ9N9PkGXCC0o3BgQSlFKPCfg5lPwdLhGaetT6eTgy3mQb7vn/HsuSzPZa09H
         GrxGV3KEga+wDTioV00uKpxvCltfuorKkXlsklObvHxQkx8RGES1rnhMmSjV6lqgSTdg
         yqhSydGZI+TRdepGXkwyOxBrZWOGXYMp7rTV8pd1JmvjelpmdwHNhFst0M7xhWCzRHEo
         E4sdliTsqgG2YfMHmcpQUm/l0zNp3LVZYOxtN+mpqZdzHlF/ldfXjk1w6KpQ0Z/dnirD
         a3Vk4Fvhas1yWR8gHvdv/pugK1bAKivfVy/GA9VamQHjmVF4UOLbISpMlBp9ywKukB4F
         5DiA==
X-Gm-Message-State: AHYfb5jEPf/C8v9TcD1N91XiwQySzwtZ4JLJffxlloBhCv6ZY85leYEf
        yVsX9Orq6yE7jGZpX9c=
X-Received: by 10.46.1.20 with SMTP id 20mr9056259ljb.5.1502797770398;
        Tue, 15 Aug 2017 04:49:30 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-225-26.play-internet.pl. [94.254.225.26])
        by smtp.gmail.com with ESMTPSA id z25sm1575317lja.1.2017.08.15.04.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Aug 2017 04:49:29 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Patryk Obara <patryk.obara@gmail.com>
Subject: [PATCH 0/5] Modernize read_graft_line implementation
Date:   Tue, 15 Aug 2017 13:49:01 +0200
Message-Id: <cover.1502796628.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I experimented with using a different hash algorithm (I am aware of
existing "Git hash function transition plan", I just want to push
things forward a bit) - and immediately hit a small issue - changing
the size of object_id hash buffer leads to compilation issues and
breaks graft-related tests.

I am sending patch 1 only to show a modification, that I did to
increase buffer size - it's not intended to be merged.

Patch 2 fixes trivial compilation issue.

Patches 3, 4, and 5 touch graft implementation to remove calculations
using GIT_SHA1_*, that lead to broken tests. I replaced FLEX_ARRAY of
object_id's representing parents with oid_array. New implementation
should be more future-proof, I think.

New implementation has tiny behaviour change: previously parents in
graft line needed to be separated with single space - now any number
of whitespace characters will do.

Alternative implementation approaches
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Strbuf could be replaced with string_list with
string_list_split_in_place instead of while loop in read_graft_line.
I didn't implement it this way because I learned
about string_list_split_in_place after finishing this implementation
draft. Right now I'm not sure which approach is better.

Another possibility is dropping graft feature altogether - that would
mean removing code for parsing grafts and 'parent' field in the struct,
but preserving the struct itself as a shallow clone marker. Grafts are
a little-known feature with modern replacement, but this seems like
bigger task and rather out of the scope of transition to the new
hashing algorithm.

I considered making function read_graft_line a static one and
read_graft_file non-static, but read_graft_line is used in
'builtin/blame.c' in function read_ancestry, which is almost a copy of
read_graft_file (difference of single boolean flag passed to
register_commit_graft). Removal of this duplication may be worthwhile,
but I think it's out of scope.

Patryk Obara (5):
  cache: extend object_id size to sha3-256
  sha1_file: fix hardcoded size in null_sha1
  commit: replace the raw buffer with strbuf in read_graft_line
  commit: implement free_commit_graft
  commit: rewrite read_graft_line

 builtin/blame.c |  2 +-
 cache.h         |  8 ++++++--
 commit.c        | 55 ++++++++++++++++++++++++++++++++-----------------------
 commit.h        |  5 +++--
 sha1_file.c     |  2 +-
 shallow.c       |  1 +
 6 files changed, 44 insertions(+), 29 deletions(-)

-- 
2.9.5

