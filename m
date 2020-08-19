Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71233C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 14:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 396512076E
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 14:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTBXai/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgHSO2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbgHSO2D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 10:28:03 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67229C061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 07:28:02 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g8so2294632wmk.3
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HLpcqXwOyUZzF2lUt9I9x3GJ+WqHN9yyOV9WRj6mfPk=;
        b=UTBXai/Z1fm3z0MtQTwkYZUbFJRSCq7gMpZk+nzAV2+UWjZvEmQpxqvtvsARq/pjNk
         a4E0xJr0WT9DdNSBWyir7jABteFzJVUTWPRZh2hfVzRaUruqMreI2LZFhMhIyomVMz22
         ushDTo09NFI/RMrBUCvg5ds0uE+hn+gVQqGue6I/RboE6t6ZXJLl7ZTWeBxLvbM4hgl+
         BPFiVM3QMcnYbQdrKN7WuKCG7cDjZSXWP/vnYxz5A/m9F+yHJrtAFbVrl16UTfTolsRF
         FQaJ6w93BAb2T4bWBrEhnbzbTo2m3Pn1Zi4B6VEX4sqWo2S3NKB7nAOuSmyP3f/LOiqS
         LjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HLpcqXwOyUZzF2lUt9I9x3GJ+WqHN9yyOV9WRj6mfPk=;
        b=as/xHA1McINA2VZqlT58uPQytWjSu2/qeOt0lCSfO3nvm98QyZ1Eu//E4O3JSkpn+h
         FDfkt0qlwKhq2EwKQNHgBuMn/kqTGX9i/cUVQyf2kBDE9Qxue4mHQ3/QLrJyqfvxf5FR
         0Oj8yYTbyEKaZDELauUCtMw0L3mqDU86vzbBcto7n9/B93oQOi7n4iWn+WghfqHYfmE4
         6wYlqVbsEdREYndwaGHVJPcpnSs/WwsAdlwcRPLMTOC1uSdpZFexwRGc+XWLx5H3a2h0
         0QYBShcwsjViKB3dv+sVm5l8Ld8+ydVulg/NrxnNLDsw/iFA/rd2Cr6LEG2RbUZd6x2p
         jQ+g==
X-Gm-Message-State: AOAM530nlOkHCdiehd2H2Yj33gkeuDNP9F4z43+8oF1hLGW8trDHOJIN
        spF3h8w2L1ezVla43n0oHwJRDHtLOhk=
X-Google-Smtp-Source: ABdhPJzIHqiOP3ADUbnNvs62PvIOjaNlChnpVwNZwppjgc/o0PQo9s9enpCdoj4RBQEoVMZZ7KzZIg==
X-Received: by 2002:a7b:c954:: with SMTP id i20mr5555816wml.189.1597847280169;
        Wed, 19 Aug 2020 07:28:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d14sm41966790wre.44.2020.08.19.07.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 07:27:59 -0700 (PDT)
Message-Id: <pull.705.v2.git.1597847278.gitgitgadget@gmail.com>
In-Reply-To: <pull.705.git.1597678796.gitgitgadget@gmail.com>
References: <pull.705.git.1597678796.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Aug 2020 14:27:54 +0000
Subject: [PATCH v2 0/4] Handle FETCH_HEAD and MERGE_HEAD generically
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This moves the FETCH_HEAD handling into refs.c as discussed in 
https://public-inbox.org/git/xmqq5z9pav01.fsf@gitster.c.googlers.com/

Han-Wen Nienhuys (4):
  refs: split off reading loose ref data in separate function
  refs: fix comment about submodule ref_stores
  refs: move gitdir into base ref_store
  refs: read FETCH_HEAD and MERGE_HEAD generically

 refs.c                | 28 ++++++++++++++++++++++++-
 refs/files-backend.c  | 49 ++++++++++++++++++++++---------------------
 refs/packed-backend.c |  1 +
 refs/refs-internal.h  | 11 +++++++++-
 4 files changed, 63 insertions(+), 26 deletions(-)


base-commit: 2befe97201e1f3175cce557866c5822793624b5a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-705%2Fhanwen%2Ffetch-head-generically-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-705/hanwen/fetch-head-generically-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/705

Range-diff vs v1:

 1:  10b333695e ! 1:  557727064d Split off reading loose ref data in separate function
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    Split off reading loose ref data in separate function
     +    refs: split off reading loose ref data in separate function
      
          This prepares for handling FETCH_HEAD (which is not a regular ref)
          separately from the ref backend.
 2:  52b397ec9e = 2:  6da0e62e73 refs: fix comment about submodule ref_stores
 3:  c624e17dc6 = 3:  6263b4b3f2 refs: move gitdir into base ref_store
 4:  d4e9c5f499 ! 4:  a3e903e4c0 refs: read FETCH_HEAD generically
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    refs: read FETCH_HEAD generically
     +    refs: read FETCH_HEAD and MERGE_HEAD generically
      
     -    The FETCH_HEAD ref must be stored in a file, regardless of the type of
     -    ref backend. This is because it can hold more than just a single ref.
     +    The FETCH_HEAD and MERGE_HEAD refs must be stored in a file, regardless of the
     +    type of ref backend. This is because they can hold more than just a single ref.
      
     -    To accomodate FETCH_HEAD for alternate ref backends, read FETCH_HEAD
     -    from a file generically in refs_read_raw_ref()
     +    To accomodate them for alternate ref backends, read them from a file generically
     +    in refs_read_raw_ref()
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     @@ refs.c: int for_each_rawref(each_ref_fn fn, void *cb_data)
       	return refs_for_each_rawref(get_main_ref_store(the_repository), fn, cb_data);
       }
       
     -+static int refs_read_fetch_head(struct ref_store *ref_store,
     -+				struct object_id *oid, struct strbuf *referent,
     -+				unsigned int *type)
     ++static int refs_read_special_head(struct ref_store *ref_store,
     ++				  const char *refname, struct object_id *oid,
     ++				  struct strbuf *referent, unsigned int *type)
      +{
      +	struct strbuf full_path = STRBUF_INIT;
      +	struct strbuf content = STRBUF_INIT;
      +	int result = -1;
     -+	strbuf_addf(&full_path, "%s/%s", ref_store->gitdir, "FETCH_HEAD");
     ++	strbuf_addf(&full_path, "%s/%s", ref_store->gitdir, refname);
      +
      +	if (strbuf_read_file(&content, full_path.buf, 0) < 0)
      +		goto done;
     @@ refs.c: int for_each_rawref(each_ref_fn fn, void *cb_data)
       		      struct strbuf *referent, unsigned int *type)
       {
      -	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent, type);
     -+	if (!strcmp(refname, "FETCH_HEAD")) {
     -+		return refs_read_fetch_head(ref_store, oid, referent, type);
     ++	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
     ++		return refs_read_special_head(ref_store, refname, oid, referent,
     ++					      type);
      +	}
      +
      +	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,

-- 
gitgitgadget
