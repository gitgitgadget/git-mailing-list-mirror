Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C1CC54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 15:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240337AbjALPPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 10:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjALPOq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 10:14:46 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3566818E2E
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 07:05:50 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id vm8so45455383ejc.2
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 07:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wkTQP2ZWDBKLiX5YRl/zAKg6jTyNh6G199vv5PB514c=;
        b=AX2IttOfbqWl6Im9ZkMMk4xV/d3ZO3VtuwcjXvS4SEuo0Grl6/Ye1ZXHjBOVWsEpO/
         BkM7OtdfRFpUk9yi5lVoNLaXy/HNqhf/h5gkD+0LBjcyW3aZplKcnQpk1dbIij5UUirl
         Z/3Y/6ULJjsknheK/iHkmLLKK86TEtVaDR6ozTCttqV+XdaajmnglocmF68H+NSV4K4Q
         Em1BKXKJRDq/AaB7giz1Xqo81MVQAwm45zSuk6zELzZqlvhClVkyrLOcD+GgI6gn0tHM
         d2eOoetswzlQd7m9cv6ZGjhfoPz/ekwGOGv35EqRRDHfclUDJasrm3cW8Tj4eDhDdbUN
         SNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wkTQP2ZWDBKLiX5YRl/zAKg6jTyNh6G199vv5PB514c=;
        b=KMlGdAIgg/nguizCuiNZhWNSlc/ujYKzV7eS6Nk7QLakuMJZiMBtu1E6y98NrfhsOO
         6qpeOg9dRpTp4WOh1O32YCbnlZzoZE8V8QTK9gUESnbIqvcvckHTgVD/rlQgKmwiGhE8
         8o44dG3AcurEJ7oFW5B5NbtPuGX8u1+VuXRgocj6HtWNX9/hd/IdFUweSMN1DDxPK3pJ
         dx4E8j34lcID5DdILJKZYJkCMRs/NdtMHFKTuuM5NHRXLMYhyS/CbjbEbauUGUvyBdfj
         kgxgunxt4Li3vfCephIqHnQWSci8UqeUh9WptAsDa9cgI/YuGHgRMslt3eiUAi693mi1
         d/Ng==
X-Gm-Message-State: AFqh2kp9LYRO/pt+XBBcF74nhwkccuPeS4ajW2Bih1F17T1aYtE+XjDG
        s32alvk9zKBB4hY3nEow8IM=
X-Google-Smtp-Source: AMrXdXvZdupkiAVGVE84ByBNiswdEp7K1auDipbowvNLykV6f8mr+CzL2xjQDGRjf2v4Uc21HwfHoQ==
X-Received: by 2002:a17:907:9394:b0:84d:3adc:7e42 with SMTP id cm20-20020a170907939400b0084d3adc7e42mr14189485ejc.52.1673535948593;
        Thu, 12 Jan 2023 07:05:48 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id u21-20020a1709064ad500b00855d6ed60desm3529495ejt.192.2023.01.12.07.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:05:48 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pFz9H-000Hcr-23;
        Thu, 12 Jan 2023 16:05:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH 0/6] ls-tree.c: clean-up works
Date:   Thu, 12 Jan 2023 16:02:13 +0100
References: <20230112091135.20050-1-tenglong.tl@alibaba-inc.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230112091135.20050-1-tenglong.tl@alibaba-inc.com>
Message-ID: <230112.868ri723p0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 12 2023, Teng Long wrote:

> From: Teng Long <dyroneteng@gmail.com>
>
> This patchset aims to do works on refactoring and cleanup
> of ls-tree.c.
>
> The patches can be viewed as two parts:
>
>       * Part 1: from =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason which mention=
ed in
>       his RFC patchset[1] and =C3=86var suggests to submit a separate cle=
an-up
>       series. After I read them, I accept them all.
>
>       * Part 2: f=C3=86varrom me which introduced in my RFC patchset[2] a=
nd after
>       I accepted =C3=86var's patches, I keep two patches from [2], the le=
ft
>       patches in [2] may no longer be needed.
>
> [1] https://public-inbox.org/git/RFC-cover-0.4-00000000000-20221117T13452=
8Z-avarab@gmail.com/
> [2] https://public-inbox.org/git/20221117113023.65865-1-tenglong.tl@aliba=
ba-inc.com/
>
> Thanks.

Thanks for picking this up. It would be great to have this queued up.

It looks good to me, although that's mostly self-approving, as the
range-diff between this and my [1] (and your description, but I wanted
to sanity check it) shows it's mostly the same changes:
=09
p	1:  a7f86973d57 ! 1:  5004f03c4d2 ls-tree: don't use "show_tree_data" for=
 "fast" callbacks
	    @@ Commit message
=09=20=20=20=20=20
	         1. https://lore.kernel.org/git/cover-0.7-00000000000-20220310T134=
811Z-avarab@gmail.com/
=09=20=20=20=20=20
	    +    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com>
	    +    Signed-off-by: Teng Long <dyronteng@gmail.com>
	    +
	      ## builtin/ls-tree.c ##
	     @@ builtin/ls-tree.c: static int show_tree_fmt(const struct object_id=
 *oid, struct strbuf *base,
	      	return recurse;
	2:  b046e6f5692 ! 2:  de5b4d0767a ls-tree: use a "struct options"
	    @@ Commit message
	         before, now it's just being brought to the surface.
=09=20=20=20=20=20
	         Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com>
	    +    Signed-off-by: Teng Long <dyroneteng@gmail.com>
=09=20=20=20=20=20
	      ## builtin/ls-tree.c ##
	     @@
	3:  329bc581b79 ! 3:  8f4b59183f6 ls-tree: fold "show_tree_data" into "cb"=
 struct
	    @@ Commit message
	         we'll use only for that callback.
=09=20=20=20=20=20
	         Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com>
	    +    Signed-off-by: Teng Long <dyroneteng@gmail.com>
=09=20=20=20=20=20
	      ## builtin/ls-tree.c ##
	     @@ builtin/ls-tree.c: struct ls_tree_options {
	4:  de4f89645fa ! 4:  d701aceb101 ls-tree: make "line_termination" less ge=
neric
	    @@ Commit message
	         API itself does much the same thing.
=09=20=20=20=20=20
	         Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com>
	    +    Signed-off-by: Teng Long <dyroneteng@gmail.com>
=09=20=20=20=20=20
	      ## builtin/ls-tree.c ##
	     @@ builtin/ls-tree.c: static void expand_objectsize(struct strbuf *li=
ne, const struct object_id *oid,
	-:  ----------- > 5:  72bf99a1c74 ls-tree: cleanup the redundant SPACE
	-:  ----------- > 6:  978b89e5ea8 t3104: remove shift code in 'test_ls_tre=
e_format'

I approve of that addition of the missing Signed-off-by (which I just
forgot about).

I left comments on the 2x new patches, but they were both nit-y
suggestions for maybe rephrasing the commit messages a bit, but as noted
I don't think it's worth another re-roll (just maybe if others comment
on the other patches and/or find other issues worth re-rolling).
