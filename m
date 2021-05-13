Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45441C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 15:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14DF761438
	for <git@archiver.kernel.org>; Thu, 13 May 2021 15:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbhEMPQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 11:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbhEMPQw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 11:16:52 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8854C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 08:15:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x8so4960111wrq.9
        for <git@vger.kernel.org>; Thu, 13 May 2021 08:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6UxIOnFU1qOytimG2j8gi1Ps6gIdY7MQMfTV02HPq88=;
        b=izzR6CmvtJTzG76WS73D3LYAEoQW/2Y/QTmA6nyiUsG62J4RWW+4BDeH4bbCyovuMf
         WsJTuCel17FzPh+EiryRe6QS2JThAHBtsDtLGvui70wQ1CMQOL7AvgebmlO51kjtWwbd
         KiO4ZO7aC5Y5v+6jvQOsiIN6IkjmsyNcnqaJzemFjiZMl88ykplZMDhl9jXEuzrFxgzV
         97Vh3QxaoQ+8NlIkbqZq/bvo5wvRdAdAtnDHkBacR3IXdXm+s9a8HhsLvsV4U1jdZHQB
         l8lp+M3ucdfjFsjWt485cKUMq2B2j07FjjM3mPxRZVHZK6u7Yv1UmTaC61W3akJ8tFzL
         Yeag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6UxIOnFU1qOytimG2j8gi1Ps6gIdY7MQMfTV02HPq88=;
        b=eiYuCy5Y5t1I3ly86N/XJK06yBW3Ta4HVPWZ2DBZBcYXVZDJVz0Qcz9DeKPpBL6IY4
         3e+IAGjmc3wZNxaitgTVrvubEn5xpt6s2gUnEn8RVJN4ek6pXr4kwYw6Em9iTT4zmBqt
         sM6/3HKRzYLN6SCECJo8KjlBRNZR0i+QQ0rA98Yd6hIkUbtiglwnQ24eulBgEVJ2002r
         3bUMKkg9djt6nfjfTVYIHH2Sp84EfPo+1SFR9ExXSDMi2Bd3cfs45ibKuknL5bn+HN3h
         yO1eLbWOQk1Q/CRRqWb3WAW7WEs3vW3hYeyu7vXGTElbWwq1V1jih2oet326rPU8Bdki
         IvIg==
X-Gm-Message-State: AOAM530ZHaJAZOejugbgKIfUqX3DwaXr/JWLKc/A16DOo9iCkenXhUiG
        ZPRcOZlWViVRr6Jo+FPHPvMFFKqAbIQ=
X-Google-Smtp-Source: ABdhPJwVwCa0q/iEOgjpzKSuWDmxkslR0LBJTfie3rKAa2UFKK2bFHvSlzg/n1fX4SiXyAWayZMqaw==
X-Received: by 2002:a5d:45c6:: with SMTP id b6mr37057196wrs.333.1620918940588;
        Thu, 13 May 2021 08:15:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k7sm3221343wro.8.2021.05.13.08.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 08:15:39 -0700 (PDT)
Message-Id: <pull.951.v4.git.1620918939.gitgitgadget@gmail.com>
In-Reply-To: <pull.951.v3.git.1620821464.gitgitgadget@gmail.com>
References: <pull.951.v3.git.1620821464.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 May 2021 15:15:36 +0000
Subject: [PATCH v4 0/2] [GSOC][RFC] ref-filter: introduce enum atom_type
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Hariom Verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change from last version: fix some typo error and change commit message with
Junio's help.

ZheNing Hu (2):
  [GSOC] ref-filter: add objectsize to used_atom
  [GSOC] ref-filter: introduce enum atom_type

 ref-filter.c | 214 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 140 insertions(+), 74 deletions(-)


base-commit: 7e391989789db82983665667013a46eabc6fc570
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-951%2Fadlternative%2Fref-filter-atom-type-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-951/adlternative/ref-filter-atom-type-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/951

Range-diff vs v3:

 1:  91ca57c9d04a ! 1:  23fc04f7eb23 [GSOC] ref-filter: add objectsize to used_atom
     @@ Metadata
       ## Commit message ##
          [GSOC] ref-filter: add objectsize to used_atom
      
     -    Since "objectsize:size" is composed of two parts,
     -    "type:attribute". However, the original implementation
     -    did not decouple the two parts "type" and "attribute" well,
     -    we still need to judge separately whether the atom is
     -    "objectsize" or "objectsize:disk" in `grab_common_values()`.
     +    When the support for "objectsize:disk" was bolted onto the
     +    existing support for "objectsize", it didn't follow the
     +    usual pattern for handling "atomtype:modifier", which reads
     +    the <modifier> part just once while parsing the format
     +    string, and store the parsed result in the union in the
     +    used_atom structure, so that the string form of it does not
     +    have to be parsed over and over at runtime (e.g. in
     +    grab_common_values()).
      
          Add a new member `objectsize` to the union `used_atom.u`,
     -    so that we can separate the judgment of atom type from the
     -    judgment of atom attribute, This will bring scalability to
     -    atom `%(objectsize)`.
     +    so that we can separate the check of <modifier> from the
     +    check of <atomtype>, this will bring scalability to atom
     +    `%(objectsize)`.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
 2:  43400cac58e7 ! 2:  50cfe1f0c6c1 [GSOC] ref-filter: introduce enum atom_type
     @@ Commit message
          `used_atom.atom_type` will record corresponding enum value
          from valid_atom entry index, and then in specific reference
          attribute filling step, only need to compare the value of
     -    the `used_atom[i].atom_type` to judge the atom type.
     +    the `used_atom[i].atom_type` to check the atom type.
      
          Helped-by: Junio C Hamano <gitster@pobox.com>
          Helped-by: Christian Couder <christian.couder@gmail.com>
     @@ ref-filter.c: static struct ref_to_worktree_map {
       } ref_to_worktree_map;
       
      +/*
     -+ * The enum atom_type is used as the coordinates of valid_atom entry.
     ++ * The enum atom_type is used as the index of valid_atom array.
      + * In the atom parsing stage, it will be passed to used_atom.atom_type
     -+ * as the identifier of the atom type. We can judge the type of used_atom
     ++ * as the identifier of the atom type. We can check the type of used_atom
      + * entry by `if (used_atom[i].atom_type == ATOM_*)`.
      + */
      +enum atom_type {

-- 
gitgitgadget
