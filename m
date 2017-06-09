Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60C9E1FAED
	for <e@80x24.org>; Fri,  9 Jun 2017 08:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbdFIIyE (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 04:54:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35304 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbdFIIyB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 04:54:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id g15so10700591wmc.2
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 01:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ltfsI4oDtMeys98zLrLKRVfK/qGnEbYHV+o6cCmoutI=;
        b=NkDxI/n8KZCDCtL+STdbfLizkKpD4Golzm53xo/I5zkqAo7ZLQ1VACLef3b7ifiLRU
         N+SVYefGFj78SXIcWITQYNJa2/W13TY28UcKlEj+/9ZP4IzZsg6E+DnkLYTV0jbserEb
         z9cmBHtFJBDv5tIfUThWShAPDvAbFM1yAgj5JP8zR2URWlQ96iRclZagT/7rB0gehgus
         I5xre5SbxrRqDpEy3qPnRFASYMBFtgIM85hySkHxgRgtL4Nw/CaPcrBia6VmeVs/xHtU
         Gso8jQa19kbwatB0fjFkO5TEcn03ktYywdsI68ShH99t+JX6INv1JRpBdd/XPIp+zIIw
         lxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ltfsI4oDtMeys98zLrLKRVfK/qGnEbYHV+o6cCmoutI=;
        b=TLo2GfziPwizMhND1tlTi/2cpEzSmOc59rQMzCS2XSCu1GwoMMYXXEJnlV1L+2BDZ+
         zJoTGgTJOhwaQa39Vv1Q0gIvhQCjIQf+mpJacCgttdt2Wb0RTb3S8txuBgbz6BoPhcdN
         2bb8aFq8L9X7LwW6Fxs7tqBaliXKUhDPwfyviu82cSatT8uZz0zmE/u95NrO2A93JmD5
         c0Uq088nHjl1wbjE6uTrUGsLzK96qs9yL0+N6/u/ptLrZso5nr5qzBbOsLYMCtTWpzr1
         aHmE/AJ3NFZFKA+UGa6D+67jBe2MjmbxtqFqIFeakicUR12tdoEcl/201/zLEeD8iboQ
         ER8g==
X-Gm-Message-State: AODbwcAimcG2IbZ0PRWT01RNseugwJRM/PDgyts8663nan35x+XeUqHa
        PdO7sONmQZb5Nu/OD4U=
X-Received: by 10.80.144.132 with SMTP id c4mr30532618eda.139.1496998439967;
        Fri, 09 Jun 2017 01:53:59 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w48sm399405edb.49.2017.06.09.01.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jun 2017 01:53:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] Add a freez() wrapper
Date:   Fri,  9 Jun 2017 08:53:44 +0000
Message-Id: <20170609085346.19974-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.506.g27d5fe0cd
In-Reply-To: <20170608234100.188529-8-bmwill@google.com>
References: <20170608234100.188529-8-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 9, 2017 at 1:40 AM, Brandon Williams <bmwill@google.com> wrote:
> Introduce the repository object 'struct repository' which can be used to
> hold all state pertaining to a git repository.
> [...]
> +static void repo_clear_env(struct repository *repo)
> +{
> +       free(repo->gitdir);
> +       repo->gitdir = NULL;
> +       free(repo->commondir);
> +       repo->commondir = NULL;
> +       free(repo->objectdir);
> +       repo->objectdir = NULL;
> +       free(repo->index_file);
> +       repo->index_file = NULL;
> +       free(repo->graft_file);
> +       repo->graft_file = NULL;
> +       free(repo->namespace);
> +       repo->namespace = NULL;
> +}

When seeing this I wondered if it couldn't be less noisy as:

> +       freez(repo->gitdir);
> +       freez(repo->commondir);
> +       freez(repo->objectdir);
> +       freez(repo->index_file);
> +       freez(repo->graft_file);
> +       freez(repo->namespace);

It's not a problem with your patch, but something I thought would be
nice to have in general, so here's a patch series to implement that.

Ævar Arnfjörð Bjarmason (2):
  git-compat-util: add a freez() wrapper around free(x); x = NULL
  *.[ch] refactoring: make use of the freez() wrapper

 alias.c                  |  6 ++----
 apply.c                  |  3 +--
 attr.c                   |  6 ++----
 blame.c                  |  3 +--
 branch.c                 |  3 +--
 builtin/am.c             | 18 +++++-------------
 builtin/clean.c          |  6 ++----
 builtin/config.c         |  6 ++----
 builtin/index-pack.c     |  6 ++----
 builtin/pack-objects.c   | 12 ++++--------
 builtin/unpack-objects.c |  3 +--
 builtin/worktree.c       |  6 ++----
 commit-slab.h            |  3 +--
 commit.c                 |  3 +--
 config.c                 |  3 +--
 credential.c             |  9 +++------
 diff-lib.c               |  3 +--
 diff.c                   |  6 ++----
 diffcore-rename.c        |  6 ++----
 dir.c                    |  9 +++------
 fast-import.c            |  6 ++----
 git-compat-util.h        |  1 +
 gpg-interface.c          | 15 +++++----------
 grep.c                   | 12 ++++--------
 help.c                   |  3 +--
 http-push.c              | 24 ++++++++----------------
 http.c                   | 15 +++++----------
 imap-send.c              |  3 +--
 line-log.c               |  6 ++----
 ll-merge.c               |  3 +--
 mailinfo.c               |  3 +--
 object.c                 |  3 +--
 pathspec.c               |  3 +--
 prio-queue.c             |  3 +--
 read-cache.c             |  6 ++----
 ref-filter.c             |  3 +--
 refs/files-backend.c     |  3 +--
 refs/ref-cache.c         |  3 +--
 remote-testsvn.c         |  3 +--
 rerere.c                 |  3 +--
 sequencer.c              |  3 +--
 sha1-array.c             |  3 +--
 sha1_file.c              |  3 +--
 split-index.c            |  3 +--
 transport-helper.c       | 27 +++++++++------------------
 transport.c              |  3 +--
 tree-diff.c              |  6 ++----
 tree-walk.c              |  3 +--
 tree.c                   |  3 +--
 49 files changed, 98 insertions(+), 197 deletions(-)

-- 
2.13.0.506.g27d5fe0cd

