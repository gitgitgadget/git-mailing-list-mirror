Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB36C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 18:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239776AbhKWSi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbhKWSi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 13:38:27 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E218FC061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 10:35:18 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id s22-20020a056a0008d600b00480fea2e96cso72258pfu.7
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 10:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=zJCmovhiqY65lQnJq/p+Rs8PBoonqsD4lPVyplhBvEI=;
        b=Fj7gWLclgwtdYJgo4WxDylIMTkA3DHJLqHqD0QAWqz5o8uZfZ2yROfL+haQSzsWPNI
         clMJeSqO3VECLGAbRHrHn5wdXUdlJi151ZUwkXdt4M1yToZSywiyKTqcFyRH+6UwWKj4
         a9Bk17xBoR0OToAqymSeqHxLe08s+49FdSS0BeSujRi4UmJLHTVl1HdCtBVP07mI+37b
         3/4rj6meeSeaZbvXi2W479qyALeQ69vGu7BZgBe1MU0gx/P6S0hACBl+B7y896ZMrd0K
         oS+DTqgxPblEk9roFyCcXUw8VA2qrTP/ZymElp/uTB1sGbB7O1+Dhkq+FZGEfXW3H0eq
         Kk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=zJCmovhiqY65lQnJq/p+Rs8PBoonqsD4lPVyplhBvEI=;
        b=vw1Ye3XU/2VDJDT+hWJRdhYjT9Elw75WmMo98RXbQ6gNtIXRQ34Ozza3ANip4G45k2
         38zs7i/Ukyp5ym51Cpk9keNBYWf6yBgbvgZVb1POZJD7ZGKsCErrevsLVjC5SWvh69f2
         bCemiwNemtBKhnssizE5zm5c/HfTUVLm4GAJyZRFs9RzVL13YYjYDxVAcaL3lqid4Sz4
         FGR0j2hjMbBluYeEICDoFGxxZcjAhFU37Bfo2MoRmBxrPAvUFu4cmWnwTXg8WNM9Xx1U
         lLJYORVS/15yz1kmqZ6IyRJCrVY04nYsJhF1RRMkLgKES9u317oj+S9KXzS+3o8s4MzK
         S2FA==
X-Gm-Message-State: AOAM531abPWU7YPtqICUYwXExZlDn8gFQF59TfcvBFL/QXbVVLNbUM6p
        DDmZdlxxF4WXClWLLwwC6wh1k5q00Ocu5Q==
X-Google-Smtp-Source: ABdhPJxHp1evE/AxBYMkfMLAly8DEC5VHshN13ge8i8JFT4M4jH91dX2Dcn394xLLbjYX8kAESq3Fx5k2MYjYA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:4815:: with SMTP id
 a21mr5572677pjh.111.1637692518355; Tue, 23 Nov 2021 10:35:18 -0800 (PST)
Date:   Tue, 23 Nov 2021 10:35:16 -0800
In-Reply-To: <211123.86r1b7uoil.gmgdl@evledraar.gmail.com>
Message-Id: <kl6lk0gyk9ej.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211122223252.19922-1-chooglen@google.com> <20211122223252.19922-2-chooglen@google.com>
 <211123.86r1b7uoil.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH 1/4] submodule-config: add submodules_of_tree() helper
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Having skimmed through this topic isn't this in 4/4 the only resulting ca=
ller:
> =09
> 	+void create_submodule_branches(struct repository *r, const char *name,
> 	+			       const char *start_name, int force, int reflog,
> 	+			       int quiet, enum branch_track track)
> 	+{
> 	+	int i =3D 0;
> 	+	char *branch_point =3D NULL;
> 	+	struct repository *subrepos;
> 	+	struct submodule *submodules;
> 	+	struct object_id super_oid;
> 	+	struct submodule_entry_list *submodule_entry_list;
> 	+	char *err_msg =3D NULL;
> 	+
> 	+	validate_branch_start(r, start_name, track, &super_oid, &branch_point)=
;
> 	+
> 	+	submodule_entry_list =3D submodules_of_tree(r, &super_oid);
> 	+	CALLOC_ARRAY(subrepos, submodule_entry_list->entry_nr);
> 	+	CALLOC_ARRAY(submodules, submodule_entry_list->entry_nr);
> 	+
> 	+	for (i =3D 0; i < submodule_entry_list->entry_nr; i++) {
>
> I think it would be better to just intorduce this function at the same
> time as its (only?) user, which also makes it clear how it's used.

Yes that makes sense. That is the only user (for now).=20

> In this case this seems like quite a bit of over-allocation. I.e. we
> return a malloc'd pointer, and iterate with tree_entry(), the caller
> then needs to loop over that and do its own allocations of "struct
> repository *" and "struct submodule *".
>
> Wouldn't it be better just to have this new submodule_entry_list contain
> a list of not "struct name_entry", but:
>
>     struct new_thingy {
>         struct name_entry *entry;
>         struct repository *repo;
>         struct submodule *submodule;
>     }
>
> Then have the caller allocate the container on the stack, pass it to
> this function.

I thought about it as well. "struct new_thingy" is obviously the right
struct for create_submodule_branches(), but I'm not sure if it is the
right thing for other future callers e.g. "struct submodule" is only
used to give a submodule name to users in help messages.

But chances are, any caller that needs 'submodules of a tree' will need
very similar pieces of information, so it seems reasonable to do what
you said instead of over-allocating in all of the callers.

> Maybe not, just musings while doing some light reading. I was surprised
> at what are effectively two loops over the same data, first allocating
> 1/3, then the other doing the other 2/3...

The first loop validates all submodules before creating any branches
(and also happens to allocate). If we didn't have the validation step,
allocation + creating branches could just be one loop :)
