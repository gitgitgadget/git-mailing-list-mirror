Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F12CC43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 16:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC21821D81
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 16:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aozabrgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbgIIQq0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbgIIQHr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 12:07:47 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBA2C06135A
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 07:01:09 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r9so3262613ioa.2
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 07:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZKEPOOWMutCOsLFlOO8l4TbKAUC6jG4sZQ0cI//MSjg=;
        b=aozabrgoK6NZmiqe5wkDSyTw6EcfgiK3f1yzl26F0/H8Cf1d4C9iHZPxan0iwXHu0K
         ejV6fvmD+SN3QPtpMO2G/SnosuZFh1RaJMwlCxl55sKp4xDQZrGV7Thh1bNQP5KD6hPr
         yWeiwqr+whcuNGeZLuL1jODVDPHTO9LE3oSUN2iQOOQgTnnoNOXpUm3r0O1B/SDSvN5n
         ZPIljLEYPGmN2RjgEQbXfPuNC43JyHyqD+pfYBkAQYjXpsbkQnhfAPXa/MtndnohNqrM
         6u5YpenmGgyCyZTDqEtOr96+v5h7Tw/kQBTZNfYGNycG7HP/idDTJymTXTh2Cnb6TBVm
         Atuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZKEPOOWMutCOsLFlOO8l4TbKAUC6jG4sZQ0cI//MSjg=;
        b=jooXV8gR730ZRrnEdWw/foIJ4dIMSQz1U4j2xR7ctCbRGVrr9D6bxS5UPavKiTZuWN
         uJyJY8YhPUA8QwneahPJGw0SEl+LLSNb9LFym4qT60pot2z7A5EpVfQQvVWLXVPJeyAM
         buK6GJ3x3TLz56IC4AbPGuWoJffhCLI1ytoqvDly4sFxoNplLG/dl9/RGNASmzzysAS5
         dj7Jc9Lop4q9iMb7S9xCfMciY1EjCthT2zLWLUrMBhe9SjHFGJTQN6XDO9zfCBWSfbZJ
         x5iAHAGr2IHmsVubFaFHbLnFy3DeMNLTQrge1dfL0Oi5Hu8ZLWWqadIRuVmdtyjCoOCn
         4lSg==
X-Gm-Message-State: AOAM533uquL/ldaA8W1FGsDNNdqsrBhmt7AP25CmP3jBUJvSMHNbXlOi
        J8WsLEn4olC7UjeI9R9b698C9k8mvBnq2OP5HoE=
X-Google-Smtp-Source: ABdhPJwK29agcp5YbVgy3jfnVFEmDu5JusD7xJUh+aSvO73v69Pib7Rmn2spgpJABbk+s+c6Ghxl43q7TiTGR6/mqhU=
X-Received: by 2002:a02:8782:: with SMTP id t2mr2545835jai.56.1599660068607;
 Wed, 09 Sep 2020 07:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200907171639.766547-1-eantoranz@gmail.com> <ce94b41f-e829-d7ca-a5f5-e41748caea81@gmail.com>
 <20200909091149.GB2496536@coredump.intra.peff.net>
In-Reply-To: <20200909091149.GB2496536@coredump.intra.peff.net>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Wed, 9 Sep 2020 08:00:57 -0600
Message-ID: <CAOc6etZS3mGxsPPh25XFi2-qR0TNzq0Gx1NrydgQwmHbsjxejA@mail.gmail.com>
Subject: Re: [PATCH] blame.c: replace instance of !oidcmp for oideq
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, whydoubt@gmail.com,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 9, 2020 at 3:11 AM Jeff King <peff@peff.net> wrote:
>
> Yeah, it looks obviously correct. I am puzzled why "make coccicheck"
> doesn't find this, though. +cc Ren=C3=A9, as my favorite target for
> coccinelle nerd-snipes. :)
>

I added this to contrib/coccinelle/object_id.cocci in v2.27.0

@@
identifier f !=3D oideq;
expression E1, E2;
@@
- !oidcmp(E1, E2)
+ oideq(E1, E2)

And it found it:

$ cat contrib/coccinelle/object_id.cocci.patch
diff -u -p a/blame.c b/blame.c
--- a/blame.c
+++ b/blame.c
@@ -1352,8 +1352,7 @@ static struct blame_origin *find_origin(
       else {
               int compute_diff =3D 1;
               if (origin->commit->parents &&
-                   !oidcmp(&parent->object.oid,
-                           &origin->commit->parents->item->object.oid))
+                   oideq(&parent->object.oid,
&origin->commit->parents->item->object.oid))
                       compute_diff =3D maybe_changed_path(r, origin, bd);

               if (compute_diff)


Do I need to add more things into the coccinelle definition so that it
is more restrictive in terms of the
expression we are hunting down?
