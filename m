Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A0AC433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 12:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6312613FE
	for <git@archiver.kernel.org>; Wed, 12 May 2021 12:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhELMMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 08:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhELMMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 08:12:16 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98253C06175F
        for <git@vger.kernel.org>; Wed, 12 May 2021 05:11:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l14so23378796wrx.5
        for <git@vger.kernel.org>; Wed, 12 May 2021 05:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7HBX/ga9olOwkAh64EOXqK+hG/zVfR/6sPXSngISR/g=;
        b=XPb5+nntsA1SGyH7L2ibJwoIgKQZHBdJ3fbiBATdu1asYOukvWt46vJgPqLES2Xt6p
         dNMQrKgUbhcplSAJjj7kwVKSQzsij1R5a/m6vKHgBbb0ap69cOOQo+IcGgQ0Rt2MjJTF
         Gyox8xEvzbbB2myG5dJAyMUfjsczXNouay2ELUOCqv1/sW1EW1AIXCbvH3BLseb3y9uk
         bwKyn1yhNvKjNb4VX7L4U1h6ffS/DxIfENMGDhHrN6o5wpU3H8QQRVB9PogfK5oBu6IH
         xpt2/s7ESeo5wE92UcKG2cgawnNtz8VCFGJyhj4J+joYsq9HtY6nYrNS+t/Up8uJHJf1
         +U7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7HBX/ga9olOwkAh64EOXqK+hG/zVfR/6sPXSngISR/g=;
        b=bSm+h7ikEynIn8XGnuCifwOPYcJ1S6KVKY9JjqynxDpqRzKLFovrqXhPQVfsj3FbMu
         gm4tbErCRov7mfzdJ/VQ9l+2bWQHSIzFtSZhA5hZCll8gAUfKLm3uLtgS8KBC9+pyYbk
         2MWPKB4JQajNV3GIZApwugi9x6mxaO8dA+eGyIFgbMsvaYWsAoIvVgbGEVtsM0eLc9IG
         Y+qjvr8OnKxi4/sBx89T6n2ENVTounByACQgn+15A4nbiJSF7tGlmUGScaUAckfrL3Dr
         5dmpHKHTms/z+QwnhcmaW7Xb/09OTw6WbBA1mD3poB/TUhNS63DE7K89dxC9BJh8RvkA
         wx4Q==
X-Gm-Message-State: AOAM530cHpoQ2L/X3SOJdrClAbEhlBIvABqeKYDZmzij+pNjbdtBZ7RF
        vT2ZCbDsED8sChYCjfCKG45tqvmMs80=
X-Google-Smtp-Source: ABdhPJyl4e96iLHFBhix2MAXDEZ2lIYjsv+zWnNdhMQUZlFZdeqyCyH/NqRuUywLG2qPan9xG4et9g==
X-Received: by 2002:a5d:58d0:: with SMTP id o16mr8444740wrf.420.1620821466373;
        Wed, 12 May 2021 05:11:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y5sm28805053wrm.61.2021.05.12.05.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 05:11:05 -0700 (PDT)
Message-Id: <pull.951.v3.git.1620821464.gitgitgadget@gmail.com>
In-Reply-To: <pull.951.v2.git.1620659000.gitgitgadget@gmail.com>
References: <pull.951.v2.git.1620659000.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 May 2021 12:11:02 +0000
Subject: [PATCH v3 0/2] [GSOC][RFC] ref-filter: introduce enum atom_type
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

Change from last version: Since used_atom obtains the index from valid_atom
as its atom_type after init in parse_ref_filter_atom(), here is the only
place where used_atom is initialized in the global, ATOM_INVALID and
ATOM_UNKNOWN seem to cause unnecessary trouble.

So remove ATOM_INVALID and ATOM_UNKNOWN, Use the original method of
traversing valid_atom.

ZheNing Hu (2):
  [GSOC] ref-filter: add objectsize to used_atom
  [GSOC] ref-filter: introduce enum atom_type

 ref-filter.c | 214 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 140 insertions(+), 74 deletions(-)


base-commit: 7e391989789db82983665667013a46eabc6fc570
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-951%2Fadlternative%2Fref-filter-atom-type-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-951/adlternative/ref-filter-atom-type-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/951

Range-diff vs v2:

 1:  91ca57c9d04a = 1:  91ca57c9d04a [GSOC] ref-filter: add objectsize to used_atom
 2:  a1f70b39b7ef ! 2:  43400cac58e7 [GSOC] ref-filter: introduce enum atom_type
     @@ Commit message
          `used_atom.atom_type` will record corresponding enum value
          from valid_atom entry index, and then in specific reference
          attribute filling step, only need to compare the value of
     -    the `used_atom.atom_type` to judge the atom type.
     -
     -    the enum value of `ATOM_UNKNOWN` is equals to zero, which
     -    could ensure that we can easily distinguish such a struct
     -    where the atom_type is known from such a struct where it
     -    is unknown yet.
     -
     -    the enum value of `ATOM_INVALID` is equals to the size of
     -    valid_atom array, which could help us iterate over
     -    valid_atom array using something like:
     -
     -    for (i = ATOM_UNKNOWN + 1; i < ATOM_INVALID; i++)
     -            /* do something with valid_atom[i] */;
     +    the `used_atom[i].atom_type` to judge the atom type.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
     +    Helped-by: Christian Couder <christian.couder@gmail.com>
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
       ## ref-filter.c ##
     @@ ref-filter.c: static struct ref_to_worktree_map {
      + * In the atom parsing stage, it will be passed to used_atom.atom_type
      + * as the identifier of the atom type. We can judge the type of used_atom
      + * entry by `if (used_atom[i].atom_type == ATOM_*)`.
     -+ *
     -+ * ATOM_UNKNOWN equals to 0, used as an enumeration value of uninitialized
     -+ * atom_type.
     -+ * ATOM_INVALID equals to the size of valid_atom array, which could help us
     -+ * iterate over valid_atom array like this:
     -+ *
     -+ * 	for (i = ATOM_UNKNOWN + 1; i < ATOM_INVALID; i++) {
     -+ *		int len = strlen(valid_atom[i].name);
     -+ *		if (len == atom_len && !memcmp(valid_atom[i].name, sp, len))
     -+ *			break;
     -+ *	}
      + */
      +enum atom_type {
     -+ATOM_UNKNOWN,
     -+ATOM_REFNAME,
     -+ATOM_OBJECTTYPE,
     -+ATOM_OBJECTSIZE,
     -+ATOM_OBJECTNAME,
     -+ATOM_DELTABASE,
     -+ATOM_TREE,
     -+ATOM_PARENT,
     -+ATOM_NUMPARENT,
     -+ATOM_OBJECT,
     -+ATOM_TYPE,
     -+ATOM_TAG,
     -+ATOM_AUTHOR,
     -+ATOM_AUTHORNAME,
     -+ATOM_AUTHOREMAIL,
     -+ATOM_AUTHORDATE,
     -+ATOM_COMMITTER,
     -+ATOM_COMMITTERNAME,
     -+ATOM_COMMITTEREMAIL,
     -+ATOM_COMMITTERDATE,
     -+ATOM_TAGGER,
     -+ATOM_TAGGERNAME,
     -+ATOM_TAGGEREMAIL,
     -+ATOM_TAGGERDATE,
     -+ATOM_CREATOR,
     -+ATOM_CREATORDATE,
     -+ATOM_SUBJECT,
     -+ATOM_BODY,
     -+ATOM_TRAILERS,
     -+ATOM_CONTENTS,
     -+ATOM_UPSTREAM,
     -+ATOM_PUSH,
     -+ATOM_SYMREF,
     -+ATOM_FLAG,
     -+ATOM_HEAD,
     -+ATOM_COLOR,
     -+ATOM_WORKTREEPATH,
     -+ATOM_ALIGN,
     -+ATOM_END,
     -+ATOM_IF,
     -+ATOM_THEN,
     -+ATOM_ELSE,
     -+ATOM_INVALID,
     ++	ATOM_REFNAME,
     ++	ATOM_OBJECTTYPE,
     ++	ATOM_OBJECTSIZE,
     ++	ATOM_OBJECTNAME,
     ++	ATOM_DELTABASE,
     ++	ATOM_TREE,
     ++	ATOM_PARENT,
     ++	ATOM_NUMPARENT,
     ++	ATOM_OBJECT,
     ++	ATOM_TYPE,
     ++	ATOM_TAG,
     ++	ATOM_AUTHOR,
     ++	ATOM_AUTHORNAME,
     ++	ATOM_AUTHOREMAIL,
     ++	ATOM_AUTHORDATE,
     ++	ATOM_COMMITTER,
     ++	ATOM_COMMITTERNAME,
     ++	ATOM_COMMITTEREMAIL,
     ++	ATOM_COMMITTERDATE,
     ++	ATOM_TAGGER,
     ++	ATOM_TAGGERNAME,
     ++	ATOM_TAGGEREMAIL,
     ++	ATOM_TAGGERDATE,
     ++	ATOM_CREATOR,
     ++	ATOM_CREATORDATE,
     ++	ATOM_SUBJECT,
     ++	ATOM_BODY,
     ++	ATOM_TRAILERS,
     ++	ATOM_CONTENTS,
     ++	ATOM_UPSTREAM,
     ++	ATOM_PUSH,
     ++	ATOM_SYMREF,
     ++	ATOM_FLAG,
     ++	ATOM_HEAD,
     ++	ATOM_COLOR,
     ++	ATOM_WORKTREEPATH,
     ++	ATOM_ALIGN,
     ++	ATOM_END,
     ++	ATOM_IF,
     ++	ATOM_THEN,
     ++	ATOM_ELSE,
      +};
      +
       /*
     @@ ref-filter.c: static struct {
       	/*
       	 * Please update $__git_ref_fieldlist in git-completion.bash
       	 * when you add new atoms
     -@@ ref-filter.c: static int parse_ref_filter_atom(const struct ref_format *format,
     - 	atom_len = (arg ? arg : ep) - sp;
     - 
     - 	/* Is the atom a valid one? */
     --	for (i = 0; i < ARRAY_SIZE(valid_atom); i++) {
     -+	for (i = ATOM_UNKNOWN + 1; i < ATOM_INVALID; i++) {
     - 		int len = strlen(valid_atom[i].name);
     - 		if (len == atom_len && !memcmp(valid_atom[i].name, sp, len))
     - 			break;
     - 	}
     - 
     --	if (ARRAY_SIZE(valid_atom) <= i)
     -+	if (i == ATOM_INVALID)
     - 		return strbuf_addf_ret(err, -1, _("unknown field name: %.*s"),
     - 				       (int)(ep-atom), atom);
     - 	if (valid_atom[i].source != SOURCE_NONE && !have_git_dir())
      @@ ref-filter.c: static int parse_ref_filter_atom(const struct ref_format *format,
       	at = used_atom_cnt;
       	used_atom_cnt++;

-- 
gitgitgadget
