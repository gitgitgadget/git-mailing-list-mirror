Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826DCC2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 23:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3749122206
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 23:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ASNXTTUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgIVX05 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 19:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgIVX05 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 19:26:57 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B319C061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 16:26:57 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id x13so5980205plm.5
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 16:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=H00Rwb6tvTw4NApCPcHlVzU2dIoz0pze9ZfB/1dQnkg=;
        b=ASNXTTUjdQqXYq0g6CC5hIxgiy4U9i+ivtauG0+++AKbTL36imgxZtwLGwtVo5H/G4
         PyOAl8cFPP+kuz9C4Fbg7VahchuEfduAhTC2dNl7SXGdw3wWSn+mUyk5QB+oL6f4wXb/
         uql9sHS8N04YZCT33gMJNsdpLKRQUYZvvpVEOKHf5YRL7lWrM2pUU/t3pTQ7xazXz1fd
         YE5iQ4qTtlI+NN38s/ATEz5qsStz7ewTx1EyAWAf13IIjKyCoL7O/lS3w6DYUHDjFbaP
         XJsFlkZn54sOQlGjW95oWhD4f4T7tqZxAjfWydDnXDfmdQRLvK/Cklv5qAWS0LtJwBtb
         xgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H00Rwb6tvTw4NApCPcHlVzU2dIoz0pze9ZfB/1dQnkg=;
        b=m7GMDoMqdEH3kH8eJVa9D7RLl0X6lzqLkzSPXof9DWadctqIFNIQxm82bDK2L5Phrx
         bbkh3dMCxmBJWLZIyqcVusYuncwnhCTTqzVVOOhxBxjQJh6Pq012Hxs1DKNg3EGAw1Ax
         ZO0prs1Tkzc9lkXN3W1EYxdSBqfBVssYFA0ZiciR5UtN7kOgCYRsnmchx41w3Zpnvslj
         YdtyJ1YRHJc+HkVsEAm5bX6ZowBO674UGpU6/OO34rZ9cmtTg/VIRDDJTTAMTzjZsBxJ
         VLyLWGrkjRVeumaoXaVzHHGtOd/lUktKGnyvdE+9Zz24bquy35nz/LhH+8fXSciBMhel
         KXag==
X-Gm-Message-State: AOAM533vnbqfA7BpMjIkd9EZnxzEKORZTPgdpv/AzFvv1+OHiLATiNpP
        yOs0n/C5DgLtb9be8pOONbZhCODumBMSn52SXM7k
X-Google-Smtp-Source: ABdhPJzCYxqQtiYFB+qjNminjV3//8hfrTDro/ml8DBYP3/CDRlWIJY1c+yFXr87sLXRlJ7WSv69YkqRUO14gfnL3Eh8
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:9f99:0:b029:13e:d13d:a134 with
 SMTP id z25-20020aa79f990000b029013ed13da134mr6101584pfr.28.1600817216502;
 Tue, 22 Sep 2020 16:26:56 -0700 (PDT)
Date:   Tue, 22 Sep 2020 16:26:54 -0700
In-Reply-To: <0dd26bb584bb7e8b9616eb32f7b1235462df77fa.1598380599.git.gitgitgadget@gmail.com>
Message-Id: <20200922232654.914862-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <0dd26bb584bb7e8b9616eb32f7b1235462df77fa.1598380599.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: Re: [PATCH v3 6/8] maintenance: add incremental-repack task
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com, derrickstolee@github.com,
        dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +incremental-repack::
> +	The `incremental-repack` job repacks the object directory
> +	using the `multi-pack-index` feature. In order to prevent race
> +	conditions with concurrent Git commands, it follows a two-step
> +	process.

[snip]

> First, it deletes any pack-files included in the
> +	`multi-pack-index` where none of the objects in the
> +	`multi-pack-index` reference those pack-files; this only happens
> +	if all objects in the pack-file are also stored in a newer
> +	pack-file. Second, it selects a group of pack-files whose "expected
> +	size" is below the batch size until the group has total expected
> +	size at least the batch size; see the `--batch-size` option for
> +	the `repack` subcommand in linkgit:git-multi-pack-index[1]. The
> +	default batch-size is zero, which is a special case that attempts
> +	to repack all pack-files into a single pack-file.

This lacks the detail of what happens to the selected group of packfiles
(in the second step) - in particular, that a new packfile is created and
the MIDX is rewritten so that all references to the selected group are
updated to refer to the new packfile instead, thus making it possible to
delete the selected group of packfiles in a subsequent first step. All
this is explained in the documentation of git-multi-pack-index (expire
and repack), though, so it might be better to refer to that. E.g.

  First, it calls `multi-pack-index expire` to delete packfiles
  unreferenced by the MIDX file. Second, it calls `multi-pack-index
  repack` to select several small packfiles and repack them into a
  bigger one, and then update the MIDX entries that refer to the small
  packfiles to refer to the big one instead, thus preparing it for
  deletion upon a subsequent `multi-pack-index expire` invocation. The
  selection of the small packfiles is such that the expected size of the
  big packfile is at least the batch size; see the ...

> diff --git a/midx.c b/midx.c
> index aa37d5da86..66d7053d83 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -37,7 +37,7 @@
>  
>  #define PACK_EXPIRED UINT_MAX
>  
> -static char *get_midx_filename(const char *object_dir)
> +char *get_midx_filename(const char *object_dir)
>  {
>  	return xstrfmt("%s/pack/multi-pack-index", object_dir);
>  }
> diff --git a/midx.h b/midx.h
> index b18cf53bc4..baeecc70c9 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -37,6 +37,7 @@ struct multi_pack_index {
>  
>  #define MIDX_PROGRESS     (1 << 0)
>  
> +char *get_midx_filename(const char *object_dir);
>  struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local);
>  int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
>  int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result);

Do we need get_midx_filename() to be global?
