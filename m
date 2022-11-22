Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54CAC433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 17:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbiKVRzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 12:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbiKVRyd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 12:54:33 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CA62EB
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 09:52:27 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z18so21671116edb.9
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 09:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLUwOCH7WDYxezrRKS3HfNIEj7igwKquMG5n5rwUwFw=;
        b=bu16EiUe4nrNREqwh2a9stio9xg4ny2wPtmn40fLzKLNrj1paDZcCyTXl5NeGauhoF
         ZHsSlIFLGhR4QnOzqyBP332uRkUn5kz8/eE5xnNiIuLwaAYOxesjo02/9RxrFumMIYeb
         +SPFEnLNOCnOLjZop4ikU81xwTM0qZl1Hp3FutAKnzC5Be6t2cwCCJW4mLK51ex/EOaq
         EfvRFw50XNdQP054pYuhNTWIp4+9koIYv7CKG3JiV1SxdM+5MIEyHEEGK0nB1/xmzj1p
         C0gpkHmEPIPHLpEPDfWRWRu5rzWCvKXsJqVzKDvP004Ydjuoto68QG+0nClS3L/bUJKf
         upRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLUwOCH7WDYxezrRKS3HfNIEj7igwKquMG5n5rwUwFw=;
        b=5FYrCeY/WXX2PYXF1d3HSP4Fd83uAn8Ooau+Ex0OB1dY59C2bP0gaZ4oO818sGRKqA
         lBd5nKLqmKoHTZde63sDlR6qx/IUy62j+OA2CsOcE9zHpfUbMnbQnjFE+F34LgL1cnKW
         VxP0L97hKSkTSAZrUqMyYv+ltUqPov6w/IAc1elWyHR2KWdMEjWkSR2RV39SRV4fY8LK
         GyWEgak1JAuQXdZ6AOmcm5pY1TMOup3ZYeZGmwH0bbR2gATtyWiDmfCd8cvvqmp6+Z8G
         YTqdxjK3DFWmpQWrSI2CxCEXkHV7SK8zVhgH3IgD8LuxSndze2u99Hrs4y54fM7Zv//3
         n6zQ==
X-Gm-Message-State: ANoB5plK6g28pt4nN5YB2CJb2y82/uQArExygZm0SMH/URjZ87MD+7WF
        jxq283xBI3zLf3gOkubCB0UvttBj+PU=
X-Google-Smtp-Source: AA0mqf5lcz5pjO0iu49QnbXjs1ymFklAx/244XGNd6Q0+67CLj/2YQDirznSXq51WgSQdsa/GTSetg==
X-Received: by 2002:a05:6402:ea8:b0:462:67bf:c64e with SMTP id h40-20020a0564020ea800b0046267bfc64emr8289499eda.20.1669139545330;
        Tue, 22 Nov 2022 09:52:25 -0800 (PST)
Received: from Precision-5550.. ([2a04:cec0:1182:5ffb:b420:3bec:4f4c:e712])
        by smtp.gmail.com with ESMTPSA id i10-20020aa7c9ca000000b00461a6997c5dsm6618204edt.83.2022.11.22.09.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 09:52:24 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 0/2] Implement filtering repacks
Date:   Tue, 22 Nov 2022 18:51:48 +0100
Message-Id: <20221122175150.366828-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.38.1.475.g7216a7bc05
In-Reply-To: <20221025122856.20204-1-christian.couder@gmail.com>
References: <20221025122856.20204-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Earlier this year, John Cai sent 2 versions of a patch series to
implement `git repack --filter=<filter-spec>`:

https://lore.kernel.org/git/pull.1206.git.git.1643248180.gitgitgadget@gmail.com/

We tried to "sell" it as a way to use partial clone on a Git server to
offload large blobs to, for example, an http server, while using
multiple promisor remotes on the client side.

Even though it is still our end goal, it seems a bit far fetched for
now and unnecessary as `git repack --filter=<filter-spec>` could be
useful on the client side too.

For example one might want to clone with a filter to avoid too many
space to be taken by some large blobs, and one might realize after
some time that a number of the large blobs have still be downloaded
because some old branches referencing them were checked out. In this
case a filtering repack could remove some of those large blobs.

Some of the comments on the patch series that John sent were related
to the possible data loss and repo corruption that a filtering repack
could cause. It's indeed true that it could be very dangerous, so the
first version of this patch series asked the user to confirm the
command, either by answering 'Y' on the command line or by passing
`--force`.

In the discussion with Junio following that first version though, it
appeared that asking for such confirmation might not be necessary, so
the v2 removed those checks. Taylor though asked what would happen to
the remote.<name>.promisor and remote.<name>.partialclonefilter config
variables when a filtering repack is run. I replied that it seems to
me that we should just check that a promisor remote has been
configured and fail if that's not the case.

In the discussions with Junio and Taylor following the first and
second versions, Junio suggested adding `--filter=<filter-spec>` to
`git gc` and I am still Ok with doing it, either later in a followup
patch or in a v4. I haven't done it yet, as it's not clear how to
implement it efficiently only in `git gc`.

`git gc` is already running `git repack` when it's passed some options
(either on the command line or via the config), so it would be just
simpler for `git gc` to just pass on the --filter=<filter-spec> it
would be given to `git repack`. If `git gc` would implement that by
calling `git pack-objects` directly, then `git pack-objects` would
possibly be called twice from `git gc`: once throught `git repack` and
once triggered by the --filter option.

So the only changes in this v3 compared to v2 are the following:

  - rebased on top of a0789512c5 (The thirteenth batch, 2022-11-18) to
    avoid a simple conflict,

  - patch 2/2 uses has_promisor_remote() to check if a promisor remote
    is configured and die() otherwise.

Thanks to Junio and Taylor for discussing the v1 and v2, to John Cai,
who worked on the previous versions, to Jonathan Nieder, Jonathan Tan
and Taylor Blau, who discussed this with me at the Git Merge and
Contributor Summit, and to Stolee, Taylor, Robert Coup and Junio who
discussed the versions John sent.

Range diff with v2:

1:  d1c65ff1f5 = 1:  1e64cac782 pack-objects: allow --filter without --stdout
2:  ac21b4ec8f ! 2:  7216a7bc05 repack: add --filter=<filter-spec> option
    @@ Commit message
         repo unless ALL the removed objects aren't already available in
         another remote that clients can access.
     
    +    To mitigate that risk, we check that a promisor remote has at
    +    least been configured.
    +
         Signed-off-by: John Cai <johncai86@gmail.com>
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    @@ builtin/repack.c: static void prepare_pack_objects(struct child_process *cmd,
        if (args->no_reuse_delta)
                strvec_pushf(&cmd->args, "--no-reuse-delta");
        if (args->no_reuse_object)
    -@@ builtin/repack.c: static unsigned populate_pack_exts(char *name)
    -   return ret;
    +@@ builtin/repack.c: static struct generated_pack_data *populate_pack_exts(const char *name)
    +   return data;
      }
      
     +static void write_promisor_file_1(char *p)
    @@ builtin/repack.c: static void repack_promisor_objects(const struct pack_objects_
     -          write_promisor_file(promisor_name, NULL, 0);
     -
     +          write_promisor_file_1(line.buf);
    -           item->util = (void *)(uintptr_t)populate_pack_exts(item->string);
    +           item->util = populate_pack_exts(item->string);
     -
     -          free(promisor_name);
        }
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
                OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
                                N_("repack objects in packs marked with .keep")),
                OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
    +@@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
    +                   die(_("options '%s' and '%s' cannot be used together"), "--cruft", "-k");
    +   }
    + 
    ++  if (po_args.filter && !has_promisor_remote())
    ++          die("a promisor remote must be setup\n"
    ++              "Also please push all the objects "
    ++              "that might be filtered to that remote!\n"
    ++              "Otherwise they will be lost!");
    ++
    +   if (write_bitmaps < 0) {
    +           if (!write_midx &&
    +               (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
                if (line.len != the_hash_algo->hexsz)
                        die(_("repack: Expecting full hex object ID lines only from pack-objects."));
    -           string_list_append(&names, line.buf);
    +           item = string_list_append(&names, line.buf);
     +          if (po_args.filter)
     +                  write_promisor_file_1(line.buf);
    +           item->util = populate_pack_exts(item->string);
        }
        fclose(out);
    -   ret = finish_command(&cmd);
     
      ## t/t7700-repack.sh ##
     @@ t/t7700-repack.sh: test_expect_success 'auto-bitmaps do not complain if unavailable' '


Christian Couder (2):
  pack-objects: allow --filter without --stdout
  repack: add --filter=<filter-spec> option

 Documentation/git-repack.txt |  8 ++++++++
 builtin/pack-objects.c       |  6 +-----
 builtin/repack.c             | 28 +++++++++++++++++++++-------
 t/t7700-repack.sh            | 15 +++++++++++++++
 4 files changed, 45 insertions(+), 12 deletions(-)

-- 
2.38.1.475.g7216a7bc05

