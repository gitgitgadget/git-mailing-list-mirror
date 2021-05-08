Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47659C433ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 15:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25C3361261
	for <git@archiver.kernel.org>; Sat,  8 May 2021 15:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhEHPXi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 11:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhEHPXh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 11:23:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBDFC061574
        for <git@vger.kernel.org>; Sat,  8 May 2021 08:22:35 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x5so12125962wrv.13
        for <git@vger.kernel.org>; Sat, 08 May 2021 08:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=wo8GV6diCsgQ79rGAEP+Eok0/05V2zNhqhcBIaPsUsY=;
        b=D7ztKUstZmR9OMol4wszJOnPk1ymjGYlucIlm3uAie83bcttCVZDquG/cNL2CqQyUk
         UnR/YCKlcV/rQucVDdxYOe3SfrnJJNkdoVKIdPCWizvNwTLubuDPXD3bK6i1TUn5Eawr
         uTKODJfiN3GYLbEa0LNnTjEPTbscUSDv1RPR932BRn7uArMozLS3FGXH6qqPXIuAazeg
         3L5XrmclHl1u93cEPSzvn63oL+5vHPY7lJlL3XY2p9JaC7HOyzQlrotGdA1twhHlr611
         y2QYLmloSEQ7BZRSC2yU++Q6MXfVm7mRu72WYMnK1iUfkI0j/HTwphQcPG07tq07nca3
         4Bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wo8GV6diCsgQ79rGAEP+Eok0/05V2zNhqhcBIaPsUsY=;
        b=e+FHbOtyLzlcDbc6uToivoxV7lz3K28v04f5+p0zGTDBj4/xRNUdNQZ3AdgRntaCmC
         3K+oAzf+CIKDiuPe0OFH/3cIFZ82lBr3aZ5WrU4JttPEcmP1b9NOO14wa/jwxW3UWapv
         BEYuUKR+R+DKehdoshKz5SMrJUIevrEVZmh7JVxWeH/imhAy3i33Zn8ENJnQr++anqOD
         4PodRBjZk72KxNJTecpMqvHb8NZobiyhtssY2V3PFn3iVFdCe+Pzkh0nK4HIYlDPWZOY
         H4x32MtPxD/UlLVBI266xIC8Td+WkbxFQRtwX6dDTqRnTgTSf/GoirAtlHalVLR+TcUQ
         xjOQ==
X-Gm-Message-State: AOAM530oVDg8Vcsqq9wU+yRjpSyuBTR3VsonNxR5eFdWzz+SLV/CSEai
        joHmTvWGmAWSrvr+fzM+sQ6i4j9WJC0=
X-Google-Smtp-Source: ABdhPJwstaQmmzRUCEGFw0lNUacelNCUYPQnNCbf25hSadydx+eJ4JuMrEGUic/w+CiEaD8ShZGXQA==
X-Received: by 2002:adf:e552:: with SMTP id z18mr19095015wrm.226.1620487354419;
        Sat, 08 May 2021 08:22:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15sm13731293wru.42.2021.05.08.08.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 08:22:33 -0700 (PDT)
Message-Id: <pull.951.git.1620487353.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 May 2021 15:22:30 +0000
Subject: [PATCH 0/2] [GSOC][RFC] ref-filter: introduce enum atom_type
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Firstly, let the union used_atom.u add a member "objectsize",which learn to
record the attributes of "objectsize", this will bring an extension line for
atom "%(objectsize)". Next patch will base on this feature to better support
its functions.

Secondly, In
https://lore.kernel.org/git/CAOLTT8RhVZQJX8z1gY5UM1jv0imZ4K9UnD14MgJFfvqBBiAZQg@mail.gmail.com/
I and Junio discussed the use of enum atom_type in used_atom to represent
the specific type of union used_atom.u, which can correctly distinguish atom
types and reduce the overhead of string matching.

But after my attempts, I found that our used_atom is better using enum to
remember the type of valid_atom item instead of remember type of
used_atom.u, which can be used throughout the ref-filter, easily distinguish
different types of atoms through a used_atom[i].atom_type, and reduce the
overhead of string matching.

What's left: some function like grab_oid() or grab_person(), they can also
take advantage of this feature, but require some additional modifications.

What's for future: Let used_atom entry can index directly by enum atom_type,
In order to reduce the very many loops in ref-filter.

E.g.

static struct used_atom_cache { enum atom_type atom_type; struct used_atom
*used_atom; } used_atom_cache[] = { {ATOM_REFNAME, NULL}, {ATOM_OBJECTTYPE,
NULL}, ... };

If want check whether used_atom entries have a atom "%(refname)", we can
just check if
used_atom_cache[ATOM_REFNAME].used_atom is equal to NULL, the time
complexity is O(1) and the complexity of the original method is O(n). This
will once again get a performance boost for ref-filter.

ZheNing Hu (2):
  [GSOC] ref-filter: add objectsize to used_atom
  [GSOC][RFC] ref-filter: introduce enum atom_type

 ref-filter.c | 209 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 135 insertions(+), 74 deletions(-)


base-commit: 7e391989789db82983665667013a46eabc6fc570
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-951%2Fadlternative%2Fref-filter-atom-type-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-951/adlternative/ref-filter-atom-type-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/951
-- 
gitgitgadget
