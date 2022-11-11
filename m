Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F6EC433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 00:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiKKAkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 19:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiKKAkk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 19:40:40 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54A261BA2
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 16:40:39 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id r126-20020a632b84000000b004393806c06eso1786019pgr.4
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 16:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgTDYMoCNBB5OnJGoyKuujCxncAC2l9PDyychwFUuks=;
        b=NNDIh4WElwj7gc35B+3wsFhR7wiKStklrtbb0jRwzTE1dwnLYWQRE4apYuo5denOfC
         etJDxQSk23Fjg+YX/pF/4hD59LqtY9K3TmTAay816mQSNFlKaN1oAbUTIL7u0pEzmUQD
         mJZeLNycpAFMA8utAiR5SstJ0CIJOQJk2h9kHFRjVatQ8GW3ayDiA3LxPBmTCFkbLYac
         TTso16nxLMA7Ba74qzrMjhHx/tNVpNH8/No8lGoJo0tmrNR1F9NWGLdiccG0/PYhYjW+
         O9BERKJtuywAWmfS4T6zvd2wah2htwL9OLZy00CIL/uNWBankPvzWWeH8TIaO6fB5zpT
         rLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zgTDYMoCNBB5OnJGoyKuujCxncAC2l9PDyychwFUuks=;
        b=GvVrpi8ivpGd6DPVsyK+cOJyRh75hM63eiO6Fsv6VeG/WASoaAy6e7+DU7cbVXI1rD
         sDKXLk7SCUhLZL1YmbDgGlRtgffg0Se08A+5/a5kWiQLbcv/bZIPob5AyR1yltTZKiWd
         K+XOFU4FP9rRed0zkb/wcVtf8TWJYcBgkRlO03aMx/5NsOcuhOUuw7IWsNPZSkmgzct9
         VR7Nf1CQ9H9dX0PkHQlPUTg8IzAZwt5kC6By8FLQSdc6VsONOZWI02PV8fdUjQ14hv8V
         29mOCNlmka2FJC8UaYb8JIBI/BMKQ85Oy1UGOxtmM0cDp/9HLNo9kgm2hvIjyTTVFQcX
         xF3g==
X-Gm-Message-State: ANoB5pmnaoZ0+2YSMafIQr4QwZte02pd3/qzm/iothZ5X3Hy39H9ms2+
        p4aA+xdpc5fvdsQrDx1zkjstBAGGY0kH8A==
X-Google-Smtp-Source: AA0mqf5JQOQp5UZ5DRAVupAfWRoci2bOsCTg/B8tpfhEqkxXPofuq+p/VURXQDZg2ZPbXyQs5jXEb5YHcEqPwA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:db0a:b0:186:acb1:891d with SMTP
 id m10-20020a170902db0a00b00186acb1891dmr17723plx.160.1668127239236; Thu, 10
 Nov 2022 16:40:39 -0800 (PST)
Date:   Thu, 10 Nov 2022 16:40:37 -0800
In-Reply-To: <RFC-patch-8.8-3ba894a6698-20221109T192315Z-avarab@gmail.com>
Mime-Version: 1.0
References: <20221109004708.97668-1-chooglen@google.com> <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <RFC-patch-8.8-3ba894a6698-20221109T192315Z-avarab@gmail.com>
Message-ID: <kl6l8rki2uii.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH 8/8] read-tree: add "--super-prefix" option, eliminate global
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> That "submodule_move_head()" function was then only invoked by
> "read-tree" itself, but now rather than setting an environment
> variable to pass "--super-prefix" between cmd_read_tree() we:
>
> - Set a new "super_prefix" in "struct unpack_trees_options". The
>   "super_prefixed()" function in "unpack-trees.c" added in [5] will now
>   use this, rather than get_super_prefix() looking up the environment
>   variable we set earlier in the same process.
>
> - Add the same field to the "struct checkout", which is only needed to
>   ferry the "super_prefix" in the "struct unpack_trees_options" all the
>   way down to the "entry.c" callers of "submodule_move_head()".
>
>   Those calls which used the super prefix all originated in
>   "cmd_read_tree()". The only other caller is the "unlink_entry()"
>   caller in "builtin/checkout.c", which now passes a "NULL".
>
> 1. 74866d75793 (git: make super-prefix option, 2016-10-07)
> 2. e77aa336f11 (ls-files: optionally recurse into submodules, 2016-10-07)
> 3. 89c86265576 (submodule helper: support super prefix, 2016-12-08)
> 4. 0281e487fd9 (grep: optionally recurse into submodules, 2016-12-16)
> 5. 3d415425c7b (unpack-trees: support super-prefix option, 2017-01-17)
> 6. 188dce131fa (ls-files: use repository object, 2017-06-22)
> 7. f9ee2fcdfa0 (grep: recurse in-process using 'struct repository', 2017-=
08-02)
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

[...]

> diff --git a/submodule.h b/submodule.h
> index e5ee13fb06a..36a7f7c5b32 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -150,9 +150,8 @@ int validate_submodule_git_dir(char *git_dir, const c=
har *submodule_name);
> =20
>  #define SUBMODULE_MOVE_HEAD_DRY_RUN (1<<0)
>  #define SUBMODULE_MOVE_HEAD_FORCE   (1<<1)
> -int submodule_move_head(const char *path,
> -			const char *old,
> -			const char *new_head,
> +int submodule_move_head(const char *path, const char *super_prefix,
> +			const char *old_head, const char *new_head,
>  			unsigned flags);
> =20
>  void submodule_unset_core_worktree(const struct submodule *sub);

This signature change turned out to be far less disruptive than I
expected, nice. It helps that we already had a natural home for these,
i.e. "struct checkout" and "struct unpack_trees_options".
