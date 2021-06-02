Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16845C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 04:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF5861168
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 04:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhFBEy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 00:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhFBEy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 00:54:57 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C70C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 21:53:15 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id s20-20020a4ae9940000b02902072d5df239so294936ood.2
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 21:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=jDkOxuHkErw1Jata4eaY5YGAz+YNjIM1eYiCBwk4h1s=;
        b=WiRylDea7N/+MpGArnX35m5gCTJOucLrl4d8bCZx7O67/FYnPnmT5SzsyZ6PnRbzpM
         AJKlcAxCPq13K06br2oP+otfH1a0u1dHXOz+uUDZmB3tDI2fc0hUdWud80U70T/ieRck
         VF++BtExgCfPWquBZbTyhatRAcQfXlYVIl3KEYaCqsozOrSBqYSUogkso9+P6tcVK20n
         4WJOT6DWGFqi5CR0qdTogcskyDMbivbffj+zAeE6px4pu9IPg7XkcNlVaKeGPK++rLIl
         8Adh9HD8RdU4ulEmKBdqNYTnDVDyf4phOdudq1jwbwAywxb0F2L7x/IEujEvqMP2gojj
         U4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=jDkOxuHkErw1Jata4eaY5YGAz+YNjIM1eYiCBwk4h1s=;
        b=p04iJ/clLi1OUDyj85f4a+eF/sq34e+l0pOcKjXI30vBqGHwEa+/FF5UxGEJjrcgN/
         fwJBlU/5CEcQbRJG3hWxV8AHuJpq/hm1wBL8f9cwZ8aWz3co9n90Hl1F/vs5EV/E7gaa
         ze25ZR+PAIX3K3cVVg9uCy3zjXYG/sqETavm+Vn6TauqeCG3V1kB/k5sLdWV27AICFEf
         sqA3moYMCt07o8ZH8XPapPGCG/NzF/fbzK1ELfS0shPA7qbGbbeLvOecimK4lecMU7Gv
         yfXxfEtSo1fKTDs1uaa0xni8ve4T1Fbh1iCucQ9eLRAY+x2vD8pPTXwFFBqdghpCNd36
         AQjQ==
X-Gm-Message-State: AOAM532/uc6aWWqAOSWjQZmtOpdiquF02coVEidWJiaLxGnGM6EAGCGJ
        FsGKSas3cBlCgFxyHKTRQmE=
X-Google-Smtp-Source: ABdhPJxNWJ55lc5fwtpTO5coCIoOgEQV8M1+YMCJXUEn1ac2xtr+SCPxhW4cvmiU2Fq5YtNYtu6+Tg==
X-Received: by 2002:a4a:6c1e:: with SMTP id q30mr4083774ooc.15.1622609594706;
        Tue, 01 Jun 2021 21:53:14 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id q22sm4136867otl.11.2021.06.01.21.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 21:53:14 -0700 (PDT)
Date:   Tue, 01 Jun 2021 23:53:13 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <60b70eb930614_4abd208ad@natae.notmuch>
In-Reply-To: <YLcFU+ORZTzAsyBy@danh.dev>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <YLXl5+ronWhcGh13@danh.dev>
 <60b61089ba63d_e40ca20894@natae.notmuch>
 <YLcFU+ORZTzAsyBy@danh.dev>
Subject: Re: The git spring cleanup challenge
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> On 2021-06-01 05:48:41-0500, Felipe Contreras <felipe.contreras@gmail.c=
om> wrote:
> > > How about alias? It's part of my muscle memory.
> > =

> > No aliases.
> > =

> > If a new user doesn't have them, neither should you.
> > =

> > All VCSs have default aliases, and I advocated for git to do the same=

> > [1], but it wasn't accepted.
> > =

> > The whole point is to suffer like them.
> =

> Get back to the alias topic.
> I also agree with other people's opinion in that thread.
> IOW, I support the decision to not accept those default alias ;)

Why?

> It's not required to be different people to have alias defined to
> different command. I have alias conditionally defined to different
> command based on git-dir. For example, I had ci alias to "commit" by
> default, and "commit -s" on other repositories.

So? They would still work.

> So, Git decides alias for me will not only break my current alias, but
> also break my conditional alias.

No it wouldn't. They are *default* aliases, not overriding aliases. They
would be used only if you haven't set the same alias yourself.

Try it.

--- a/alias.c
+++ b/alias.c
@@ -28,13 +28,27 @@ static int config_alias_cb(const char *key, const cha=
r *value, void *d)
        return 0;
 }
 =

+struct config_alias_data default_aliases[] =3D {
+       { "co", "checkout" },
+       { "ci", "checkout" },
+       { "rb", "rebase" },
+       { "st", "status" },
+};
+
 char *alias_lookup(const char *alias)
 {
        struct config_alias_data data =3D { alias, NULL };
+       int i;
 =

        read_early_config(config_alias_cb, &data);
+       if (data.v)
+               return data.v;
+       for (i =3D 0; i < ARRAY_SIZE(default_aliases); i++) {
+               if (!strcmp(alias, default_aliases[i].alias))
+                       return xstrdup(default_aliases[i].v);
+       }
 =

-       return data.v;
+       return NULL;
 }
 =

 void list_aliases(struct string_list *list)


> Anyway, remotes/branches are all configuration values.
> Would you prefer:

I meant global configurations. If it's a per-repository setting surely
it wouldn't be something amenable for the Git project to set as default.

-- =

Felipe Contreras=
