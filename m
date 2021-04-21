Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EF6C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 07:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 587EF6142E
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 07:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbhDUHQF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 03:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhDUHQE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 03:16:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03567C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 00:15:31 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id j7so11166908eds.8
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 00:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=jpyOEypET1rKVDGHcMoPMrBqW8FJWUrhCzjS2iJTyP4=;
        b=at94HRoOmt056trO7ZbWRpKlcFwnBfPmMfhbk+6f04XIGDKMCXpgNvOE14N8xQubzQ
         aMOJXOWCXuj6nORrvgEjEv8MKVnF73AU/hFe0E8rdmsqAVGPFUXeRTPTskxmitXhmKio
         22o5xvNhdA51SGNdGxS5lbdhgCz108Q2vBhfrrWo3Y3fDuFJ8szxJ1rzPWNYOpunb7Ty
         djVu77lJAgsLVE4btEmKBcqwMJKB3d4I22UWbKjtKkztV9cJldB2n0H2SOfADkxQSEXV
         164naZkt8kI0C8krhQc5u2sbQIuFXv3OK7rqrpK94wQghbCRVe485+0FOxwm9ap1QsWs
         W2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=jpyOEypET1rKVDGHcMoPMrBqW8FJWUrhCzjS2iJTyP4=;
        b=sUiGjRzbQUekQK+EhmmzeBp9resyHZw/oJkoZmIg77x4xnKIfD0gQhYaKBNpG65C6V
         g4tLYSNkF7gKw1Pj8Ll7R2FQTQ2l8N12Qxe0EApUGxk4wF2NvfFSCrEUvLkvhsa0fXj9
         b6WD7s2y9r5PM0lyKZXLl/zTPDoFp6ngZtZswegurgwHEIAUS3WdJVuJQAdk+iigGZHg
         cpJNbtVl4uNWM9wwKM4ONvoaoyy0AyosYBgloQEICt7nmECyQ9cV1Q/T3DMhoNijt3k2
         wtcgTR9CPGxDj9QU0KE41uMz1OBzclx+oUIYm1jQ7LKRm4e/G5i99DsKvWNgTs61M5eW
         wXew==
X-Gm-Message-State: AOAM531ellFGt0fx2+XtCbKXmThuNdvuBe66SrYuPp25kSRVqJchK01a
        pBLuAU6TrMZxT3mlLFONfQpaaaZwZ+FQqA==
X-Google-Smtp-Source: ABdhPJyR1LnH+avc/oKuZr0tN3v22n2cFagbBMgwX08K6JYbjEmBnthbaNbjPYLCUeyv6bBitzB6Xg==
X-Received: by 2002:a05:6402:154a:: with SMTP id p10mr34106595edx.77.1618989330402;
        Wed, 21 Apr 2021 00:15:30 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id gn19sm1342064ejc.68.2021.04.21.00.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 00:15:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 18/18] t1415: set REFFILES for test specific to storage
 format
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <0665edb1308b8cd4536d6922fd36315e1abdd9d1.1618829584.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <0665edb1308b8cd4536d6922fd36315e1abdd9d1.1618829584.git.gitgitgadget@gmail.com>
Date:   Wed, 21 Apr 2021 09:15:29 +0200
Message-ID: <87bla83y7i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 19 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t1415-worktree-refs.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
> index 7ab91241ab7c..a8083a0af3af 100755
> --- a/t/t1415-worktree-refs.sh
> +++ b/t/t1415-worktree-refs.sh
> @@ -16,7 +16,7 @@ test_expect_success 'setup' '
>  	git -C wt2 update-ref refs/worktree/foo HEAD
>  '
>=20=20
> -test_expect_success 'refs/worktree must not be packed' '
> +test_expect_success REFFILES 'refs/worktree must not be packed' '
>  	git pack-refs --all &&
>  	test_path_is_missing .git/refs/tags/wt1 &&
>  	test_path_is_file .git/refs/worktree/foo &&

So a na=C3=AFve:
=20=20=20=20
    diff --git a/refs/files-backend.c b/refs/files-backend.c
    index 3f29f8c143..01e2dc8bc3 100644
    --- a/refs/files-backend.c
    +++ b/refs/files-backend.c
    @@ -212,7 +212,7 @@ static void files_ref_path(struct files_ref_store *=
refs,
      */
     static void add_per_worktree_entries_to_dir(struct ref_dir *dir, const=
 char *dirname)
     {
    -       const char *prefixes[] =3D { "refs/bisect/", "refs/worktree/", =
"refs/rewritten/" };
    +       const char *prefixes[] =3D { "refs/bisect/", "refs/rewritten/" =
};
            int ip;
=20=20=20=20
            if (strcmp(dirname, "refs/"))

Will fail the test under non-reftable, i.e. we somehow conflate "is
packed" with correctly discovering these refs? A discussion of how
8aff1a9ca5 (Add a place for (not) sharing stuff between worktrees,
2018-09-29) relates to reftable would be valuable here.

But on the tip of "seen" currently this test fails entirely with
GIT_TEST_REFTABLE=3Dtrue, so I'm not sure if it got rid of the need for
this abstraction in the files backend or what...
