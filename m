Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92223C433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 03:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358087AbiFPDjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 23:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349153AbiFPDjS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 23:39:18 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75AF1EEEB
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 20:39:16 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id z14so347822pjb.4
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 20:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=50eAq0hn8mRSwmR8ttAheEO3T5nEsNAHlXw1JN3+TUU=;
        b=doLfORCdkzsoudR0nyn848cbS5UCZD3Wwi5HRdVjrbyiMzGRwENpthGv+00pGfRfiN
         iFsBNOZmH9uGH17Ud8pyQ7a+jDcsQgaTD9zeNkLc+0gM/f8NBvqwJ6lxK8h3OdLAmAwr
         /VpopquVoEA583z9jsARmdg5Si7HdrjOKLC5iL0rJtB2/fVoDbIt7WVickNuPrtr/zsc
         dvbyole6b4HRqMRnvtwdjtX0zFxK1qW8Be2MNS4FMq28iuEdnNyV+fS5HjtLlvDEL/js
         R4tntS3P0AVR7ooKJXK5I3dfYpBL1PE8C68uZYvhon5aC6Fac3lieJDsNm6ZJfFJ0Vkx
         aOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=50eAq0hn8mRSwmR8ttAheEO3T5nEsNAHlXw1JN3+TUU=;
        b=pt4o8SCCEjfSvCx2GKI/Qe/aEba3LLaL7yp57A3mB/dNB5F6FtJz8lpSJz9jIU4OxV
         K0EJnbXiVO4/cZT24Gs4jrqELdQA3ZJa4S1pYHt0J8E3seQ5G7el9I8kkxL/kSaPnLHM
         6+jyHw7wnBOMy0WCow1d5Bdv3DHDx+PLmOpC/Zv4i//h4tMuZwLmFCFGymf2QdWAC7T5
         n/CKWs62KzZmheYIEg+lVaEs6Q1vxHRK9WzJli1mQ6maku4+4Fqe2dT43oOOxdXhV5Iz
         I50ixV3uLnpRitJQr5phc4HhyHMmM8dTshtkbYJvufJDbnb099EY0zuCw/JOhUZoQ3Rs
         qaCQ==
X-Gm-Message-State: AJIora8tIjPQLo9+XqNw8hmFq/V/Z1qdx5MIgvXU9BOFaz0TezuiB+k6
        L1+JnwP83IVULGFZ/IK14WLLYSxSJovquQ==
X-Google-Smtp-Source: AGRyM1tfdbJNIAEVPQFjp4gmyGw0+PgI/eAUkt88IuZf0svtqp60Fe9sx0795fLkllbAU+jUYAB6tQ==
X-Received: by 2002:a17:90a:b797:b0:1ea:c49d:1070 with SMTP id m23-20020a17090ab79700b001eac49d1070mr2848293pjr.175.1655350755714;
        Wed, 15 Jun 2022 20:39:15 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm393163pll.194.2022.06.15.20.39.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jun 2022 20:39:15 -0700 (PDT)
From:   Han Xin <hanxin.hx@bytedance.com>
To:     me@ttaylorr.com
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, ps@pks.im,
        Han Xin <hanxin.hx@bytedance.com>
Subject: [RFC PATCH 0/2] Re: An endless loop fetching issue with partial clone, alternates and commit graph
Date:   Thu, 16 Jun 2022 11:38:31 +0800
Message-Id: <cover.1655350442.git.hanxin.hx@bytedance.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <YqlBjET0tf7V9/sg@nand.local>
References: <YqlBjET0tf7V9/sg@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 15, 2022 at 10:18 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> [+cc Stolee]
>
> On Tue, Jun 14, 2022 at 03:25:13PM +0800, Haiyng Tan wrote:
> > I think it's caused by using lazy-fetch in
> > deref_without_lazy_fetch_extended().  In lookup_commit_in_graph(),
> > lazy-fetch is initiated by repo_has_object_file() used.  has_object()
> > should be used, it's no-lazy-fetch.
>
> Hmm. Are there cases where lookup_commit_in_graph() is expected to
> lazily fetch missing objects from promisor remotes? If so, then this
> wouldn't quite work. If not, then this seems like an appropriate fix to
> me.
>
> Thanks,
> Taylor

We can see the use of has_object() in RelNotes/2.29.0.txt[1]：
   * A new helper function has_object() has been introduced to make it
     easier to mark object existence checks that do and don't want to
     trigger lazy fetches, and a few such checks are converted using it.

Let's see the difference between has_object() and repo_has_object_file():
    int has_object(struct repository *r, const struct object_id *oid,
            unsigned flags)
    {
        int quick = !(flags & HAS_OBJECT_RECHECK_PACKED);
        unsigned object_info_flags = OBJECT_INFO_SKIP_FETCH_OBJECT |
            (quick ? OBJECT_INFO_QUICK : 0);

        if (!startup_info->have_repository)
            return 0;
        return oid_object_info_extended(r, oid, NULL, object_info_flags) >= 0;
    }

    int repo_has_object_file_with_flags(struct repository *r,
                        const struct object_id *oid, int flags)
    {
        if (!startup_info->have_repository)
            return 0;
        return oid_object_info_extended(r, oid, NULL, flags) >= 0;
    }

    int repo_has_object_file(struct repository *r,
                const struct object_id *oid)
    {
        return repo_has_object_file_with_flags(r, oid, 0);
    }

Now we kown that has_object() add OBJECT_INFO_SKIP_FETCH_OBJECT to skip
fetch object.

I found that Ævar Arnfjörð Bjarmason added deref_without_lazy_fetch()
4 weeks ago[2]:
    static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
                            int mark_tags_complete)
    {
        enum object_type type;
        unsigned flags = OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK;
        return deref_without_lazy_fetch_extended(oid, mark_tags_complete,
                            &type, flags);
    }

But oi_flags is only used by oid_object_info_extended() and is missed by
lookup_commit_in_graph():
    static struct commit *deref_without_lazy_fetch_extended(const struct object_id *oid,
                                int mark_tags_complete,
                                enum object_type *type,
                                unsigned int oi_flags)
    {
        struct object_info info = { .typep = type };
        struct commit *commit;

        commit = lookup_commit_in_graph(the_repository, oid);
        if (commit)
            return commit;

        while (1) {
            if (oid_object_info_extended(the_repository, oid, &info,
                            oi_flags))

So, an appropriate fix can be that let lookup_commit_in_graph() pickup
oi_flags and pass it to oid_object_info_extended(), then the fetching
loop will be prevent by the given flag OBJECT_INFO_SKIP_FETCH_OBJECT.

1. https://github.com/git/git/blob/master/Documentation/RelNotes/2.29.0.txt
2. https://lore.kernel.org/git/2a563b5f18cc9c42cb71a9547344a5435f6bc058.1652731865.git.gitgitgadget@gmail.com/

Thanks
-Han Xin

Han Xin (2):
  commit-graph.c: add "flags" to lookup_commit_in_graph()
  fetch-pack.c: pass "oi_flags" to lookup_commit_in_graph()

 builtin/fetch.c                    |  4 ++-
 commit-graph.c                     |  5 ++--
 commit-graph.h                     |  3 +-
 fetch-pack.c                       | 10 +++----
 revision.c                         |  2 +-
 t/t5583-fetch-with-commit-graph.sh | 47 ++++++++++++++++++++++++++++++
 upload-pack.c                      |  5 ++--
 7 files changed, 64 insertions(+), 12 deletions(-)
 create mode 100644 t/t5583-fetch-with-commit-graph.sh

-- 
2.36.1

