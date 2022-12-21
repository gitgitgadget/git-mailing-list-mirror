Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10498C4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 04:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiLUEFR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 23:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbiLUEFH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 23:05:07 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA47413E0C
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 20:05:06 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id y16so13777929wrm.2
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 20:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAGqdM6mMWWqmwGNAsP34AVE77AhosL+MFnWa25PoAU=;
        b=Mq+6rcfHUSQDQKoN5FGZybGA4waCFcrBGzc75o5+++y4Al8bkT9MsmWkTZ5ZMZEgMD
         txKvSckcJTdSQHr2RbGZ1Wp7Yyg2crtY0dlS/UO9fIVXmuakCjltbQNI+Z7bROeE5KPw
         GXS7OVPEieoZX9OJIYcbtY1nyTia8+jiyn5/YLYnmiRbD73MWDgYYoY5w70W6huUAOLg
         EiO1AkXPLRGzGxgOjg9JIQtKx0WIuiNcWxXLL7iD67qSTfDXYWS5CRzqSttH8d1m7FQD
         VVpQrAto0dHoUg3rzrH27ioxk2PhIzB5/mdJnHhdhKvfGvo/dTnoBv1K7r6p1MS44FOZ
         Pa7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAGqdM6mMWWqmwGNAsP34AVE77AhosL+MFnWa25PoAU=;
        b=rcyJ4DbRlxFx/28+bo1PmM0FzTGHQakgoatPyFOj1J8d59msC7+36jEPGp6l4H3hBt
         WUVTE0H1u2JPd1UC8r/sHq7yztTeiS3eynq4EQKwLhLWJD7OxaugVXkb4IiVRX5sJgKe
         /9zfUEMs/qvExSHLbNg79bGjVVab+ayDjIWIA6UUhgCyv7CrEbdBjQzL3UgktJm55qDH
         DntFjM5NuHEhnSvcV3Qis+sDnic/7ogRMCrKg84FIDG8bvKrY9O/wgNyDke/9oExBKAN
         +dFAxOOMy+W+fD8Kdqf5W52Mxr5RkBq4VVUTWniJ+B0hFtpRqsO6PJPeZt9niNXGc+zo
         QMBw==
X-Gm-Message-State: AFqh2kqVf9eRxR9a6WmLijpnkLXwkjXPkgoTOLwv1zmEJQa1WsVGrGcr
        Mj/m+1rjHfttAalvi08C2WqPASWoMRQ=
X-Google-Smtp-Source: AMrXdXtv2RvzLL/DJcblKTbW1xmPjeNxsOyieXpLdbZRQihjz/WdpEaSqekLSiUzqHD3Vrv3QCX+EA==
X-Received: by 2002:adf:e703:0:b0:242:15af:27f with SMTP id c3-20020adfe703000000b0024215af027fmr68994wrm.28.1671595504895;
        Tue, 20 Dec 2022 20:05:04 -0800 (PST)
Received: from Precision-5550.. ([2a04:cec0:1195:e411:35ab:b445:697e:1e87])
        by smtp.gmail.com with ESMTPSA id p9-20020a5d4e09000000b00236c1f2cecesm16462298wrt.81.2022.12.20.20.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 20:05:04 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 0/3] Implement filtering repacks
Date:   Wed, 21 Dec 2022 05:04:43 +0100
Message-Id: <20221221040446.2860985-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.39.0.59.g6bb98b4b00
In-Reply-To: <20221122175150.366828-1-christian.couder@gmail.com>
References: <20221122175150.366828-1-christian.couder@gmail.com>
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
the v2 removed those checks.

Taylor though asked what would happen to the 'remote.<name>.promisor'
and 'remote.<name>.partialclonefilter' config variables when a
filtering repack is run. As it seemed to me that we should just check
that a promisor remote has been configured and fail if that's not the
case, that was implemented in the third version of this patch series.

In the discussions following the first, second and third versions,
Junio commented that `git gc` was a better way for users to launch
filtering repacks then `git repack`, so in this v4 a new
'gc.repackFilter' config option is implemented that allows `git gc` to
perform filtering repacks. When this config option is set to a non
empty string, `git gc` will just add a `--filter=<filter-spec>`
argument to the repack processes it launches, with '<filter-spec>' set
to the value of 'gc.repackFilter'.

So the changes in this v4 compared to v3 are the following:

  - rebased on top of 57e2c6ebbe (Start the 2.40 cycle, 2022-12-14) to
    avoid a simple conflict,

  - simplified the test in patch 2/3 by using `grep -c ...` instead of
    `grep ... | wc -l`,

  - added patch 3/3 which implements a new 'gc.repackFilter' config
    option so that `git gc` can perform filtering repacks.

Thanks to Junio and Taylor for discussing the v1, v2 and v3, to John
Cai, who worked on the previous versions, to Jonathan Nieder, Jonathan
Tan and Taylor, who discussed this with me at the Git Merge and
Contributor Summit, and to Stolee, Taylor, Robert Coup and Junio who
discussed the versions John sent.

Range diff with v3:

1:  1e64cac782 < -:  ---------- pack-objects: allow --filter without --stdout
-:  ---------- > 1:  c2dca82dee pack-objects: allow --filter without --stdout
2:  7216a7bc05 ! 2:  1dcdba4b1d repack: add --filter=<filter-spec> option
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
     +                  write_promisor_file_1(line.buf);
                item->util = populate_pack_exts(item->string);
        }
    -   fclose(out);
    +   strbuf_release(&line);
     
      ## t/t7700-repack.sh ##
     @@ t/t7700-repack.sh: test_expect_success 'auto-bitmaps do not complain if unavailable' '
    @@ t/t7700-repack.sh: test_expect_success 'auto-bitmaps do not complain if unavaila
     +  git clone --bare --no-local server client &&
     +  git -C client config remote.origin.promisor true &&
     +  git -C client rev-list --objects --all --missing=print >objects &&
    -+  test $(grep "^?" objects | wc -l) = 0 &&
    ++  test $(grep -c "^?" objects) = 0 &&
     +  git -C client -c repack.writebitmaps=false repack -a -d --filter=blob:none &&
     +  git -C client rev-list --objects --all --missing=print >objects &&
    -+  test $(grep "^?" objects | wc -l) = 1
    ++  test $(grep -c "^?" objects) = 1
     +'
     +
      objdir=.git/objects
-:  ---------- > 3:  6bb98b4b00 gc: add gc.repackFilter config option


Christian Couder (3):
  pack-objects: allow --filter without --stdout
  repack: add --filter=<filter-spec> option
  gc: add gc.repackFilter config option

 Documentation/config/gc.txt  |  9 +++++++++
 Documentation/git-repack.txt |  8 ++++++++
 builtin/gc.c                 |  6 ++++++
 builtin/pack-objects.c       |  8 ++------
 builtin/repack.c             | 28 +++++++++++++++++++++-------
 t/t6500-gc.sh                | 19 +++++++++++++++++++
 t/t7700-repack.sh            | 15 +++++++++++++++
 7 files changed, 80 insertions(+), 13 deletions(-)

-- 
2.39.0.59.g395bcb85bc.dirty

