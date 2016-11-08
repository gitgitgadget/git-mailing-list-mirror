Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4C542022A
	for <e@80x24.org>; Tue,  8 Nov 2016 20:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932676AbcKHUML (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 15:12:11 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34097 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932468AbcKHUMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 15:12:09 -0500
Received: by mail-pf0-f193.google.com with SMTP id y68so20732734pfb.1
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 12:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=6ijO4dfbBzvdBgI9sT9X6OWHf+jwfRqMpL9hOXdhzgM=;
        b=nLdY2c1JVs+P2XKuhtbHA35ko3JnljUM+VRgjF2QcfOdqElj+jlI0y83Iy0l3DNFFi
         x4Fq2ymOVuPkk/33JHW6FUqYh8nE6ZbD0QSsyjl+66nHdgG4fvW60CNWFILqpaSuRoJE
         Laq0c5RENtbam9qFpnAn2Ar2bCa36USTsNCi6tzby9NrB2dqoG8XrrBQAIbC3qesGJz8
         46FksvpMj7YPB/Jb7ms8XxFUhRFCbwndZ5OiN0A8V6SLDhc0w3P4Kt/1vHJxvhffFgQC
         8nF9eMyNCuFywhLpo+vlujuJ6gmXetpmkb4gTmtipSek/ODTlvHqU7K8z70IUmxPeRuT
         HXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6ijO4dfbBzvdBgI9sT9X6OWHf+jwfRqMpL9hOXdhzgM=;
        b=CAoHci1HmYUr77Dk6TdAWBepRGw4oZkzN9t6W7ludNSJ+eNc9LjrA2ps9frul+7vcg
         LavYTqcBRkeXfQr0n8yGOKCCVbvCvqk+I5dtYPa1eiQGDm3t61DAt6TS4V5RHXJLe1zH
         62DrtQMUlTfGLetH7eMgB6iGPMnHKVfd/yO06AZuAD8hMW39MKVOesVtt7aJY0mi43xu
         kl2AUMo7t0sYyApOkEq/x+3tI77uB+fribBlD62fBCaDC7jbmLxP7Cn5P/l3XWvyVgsh
         Rbi0CQFrqnHZC1m0qLddkmE7GYxt6pPCWndW9nMwN9lknSA9yjXdv0OYAJlmQDSZba/x
         DP6g==
X-Gm-Message-State: ABUngvf1GWZKEiGYZlYRXJPuqPK3P3KEBzpPjmSwPM04NjhGgXpo0XuZSXpyam23R+Lwog==
X-Received: by 10.98.99.68 with SMTP id x65mr22387255pfb.65.1478635928595;
        Tue, 08 Nov 2016 12:12:08 -0800 (PST)
Received: from localhost.localdomain ([27.5.65.216])
        by smtp.gmail.com with ESMTPSA id hv3sm50239466pad.30.2016.11.08.12.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Nov 2016 12:12:08 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v7 00/17] port branch.c to use ref-filter's printing options
Date:   Wed,  9 Nov 2016 01:41:54 +0530
Message-Id: <20161108201211.25213-1-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is part of unification of the commands 'git tag -l, git branch -l
and git for-each-ref'. This ports over branch.c to use ref-filter's
printing options.

Initially posted here: $(gmane/279226). It was decided that this series
would follow up after refactoring ref-filter parsing mechanism, which
is now merged into master (9606218b32344c5c756f7c29349d3845ef60b80c).

v1 can be found here: $(gmane/288342)
v2 can be found here: $(gmane/288863)
v3 can be found here: $(gmane/290299)
v4 can be found here: $(gmane/291106)
v5b can be found here: $(gmane/292467)
v6 can be found here: http://marc.info/?l=git&m=146330914118766&w=2

Changes in this version:

1. Rebased on top of master.

Karthik Nayak (17):
  ref-filter: implement %(if), %(then), and %(else) atoms
  ref-filter: include reference to 'used_atom' within 'atom_value'
  ref-filter: implement %(if:equals=<string>) and
    %(if:notequals=<string>)
  ref-filter: modify "%(objectname:short)" to take length
  ref-filter: move get_head_description() from branch.c
  ref-filter: introduce format_ref_array_item()
  ref-filter: make %(upstream:track) prints "[gone]" for invalid
    upstreams
  ref-filter: add support for %(upstream:track,nobracket)
  ref-filter: make "%(symref)" atom work with the ':short' modifier
  ref-filter: introduce refname_atom_parser_internal()
  ref-filter: introduce symref_atom_parser() and refname_atom_parser()
  ref-filter: make remote_ref_atom_parser() use
    refname_atom_parser_internal()
  ref-filter: add `:dir` and `:base` options for ref printing atoms
  ref-filter: allow porcelain to translate messages in the output
  branch, tag: use porcelain output
  branch: use ref-filter printing APIs
  branch: implement '--format' option

 Documentation/git-branch.txt       |   7 +-
 Documentation/git-for-each-ref.txt |  82 ++++++-
 builtin/branch.c                   | 277 +++++++---------------
 builtin/tag.c                      |   2 +
 ref-filter.c                       | 456 +++++++++++++++++++++++++++++++------
 ref-filter.h                       |   7 +
 t/t3203-branch-output.sh           |  16 +-
 t/t6040-tracking-info.sh           |   2 +-
 t/t6300-for-each-ref.sh            |  73 +++++-
 t/t6302-for-each-ref-filter.sh     |  94 ++++++++
 10 files changed, 725 insertions(+), 291 deletions(-)

-- 
2.10.2

