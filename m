Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81237C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 12:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F476613B6
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 12:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhDMM5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 08:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhDMM5C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 08:57:02 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FB7C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 05:56:42 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r9so25750363ejj.3
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 05:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=PYAROCQUREgBBtYjHq8qhrtBpB8A7Xfk4U9ga4g1Xnw=;
        b=CEydMgN6LGLsxTZVUPMe7rQxP19tgNUyK+iEFvn07p0Q7CZo2JTo3N7/bu/eQaxFiq
         Aisnt17exjqyFNyrTzCcNl4iO/fraP2Hn6pY+hGPUJmGceqJdp6BHe+0ytJVX/oMRxZa
         70Jl59+awcOQFk5zJeiENVQIm/ksRM77ot0TyA1Py4tROQq6gAKSXzQMuhu9ycG31VTO
         N9x1dka+OJUbgsjRBqbAQ09ROrvrLQ7efB3Z6N0V2SdB6Tq83ViMPg7e5kNmz3NhCqyI
         6MhBmMhdXFeE43r7sBhu+Qywbjuz01xeIF5W9U/+CrdRQSOYbP9FPhJ2/zQNWyOjoZyu
         XvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=PYAROCQUREgBBtYjHq8qhrtBpB8A7Xfk4U9ga4g1Xnw=;
        b=l21UNFIEfv63kJ3QoRqGLdzLC8TKVQUtZowdlmuWZz5qAWKKh61tn50ZGH1C9R0Ja3
         qtQWJy/K1MqMMhbhhJ5SC3yjlyTVC1AzT9veIlpgT1lLkMtgAEPreT3vbHioHqCA+TZl
         sCxIL1cpqVkwmMOsmF7fNwTWoG0TgOQqeioZuexWNAbiehqAozuGnkYtUl5SY+t5mXyt
         UObQ1pVbaRpK2F36XfWkPr9kX+RF4daNdRx1oGQKRnKCtBV09+DcoKPzBBWSxQHt3By3
         4yXXrzC0LCy1tgrlp07a4ULigLDfj8S72szfp1Ax77U8mobGwrG2dt2/ESSgt3wUq/6N
         2kjQ==
X-Gm-Message-State: AOAM533uGNxFS9WySd2HOJZhhKeMnIKe3ImLHhGld2PnvrXkhqPQn/Q/
        VgXLmuBx4530jwq+LfNOgGB0hcjvV7RxbQ==
X-Google-Smtp-Source: ABdhPJwIFR+Fy+2sis8gluj+rH1IZrORlUsm2ux1Y4WSwfCHdOEoD0uhhqHGX/oPrLVHHoSam6U40g==
X-Received: by 2002:a17:906:b6c5:: with SMTP id ec5mr21730081ejb.290.1618318601190;
        Tue, 13 Apr 2021 05:56:41 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p22sm7927865eju.85.2021.04.13.05.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 05:56:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v6 04/20] reftable: utility functions
References: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
 <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
 <df8003cb9a7d9e017d358251a2d22c0e72454e03.1618255552.git.gitgitgadget@gmail.com>
 <87czuyehnv.fsf@evledraar.gmail.com>
 <CAFQ2z_P7GjwjerP7S39xkdK20wzeE+z09NRpCnJuNCXFnJ=r8A@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAFQ2z_P7GjwjerP7S39xkdK20wzeE+z09NRpCnJuNCXFnJ=r8A@mail.gmail.com>
Date:   Tue, 13 Apr 2021 14:56:40 +0200
Message-ID: <87tuoa2vhz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 13 2021, Han-Wen Nienhuys wrote:

> On Tue, Apr 13, 2021 at 10:02 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Mon, Apr 12 2021, Han-Wen Nienhuys via GitGitGadget wrote:
>>
>> > +int strbuf_add_void(void *b, const void *data, size_t sz)
>> > +{
>> > +     strbuf_add((struct strbuf *)b, data, sz);
>> > +     return sz;
>> > +}
>>
>> Is that cast needed on your compiler? This compiles without warnings for
>> me without that.
>
> No! thanks.

Some more, a combination of redundant casting and casting early to
another variable being easier to read. The latter being a matter of
style/opinion. Some more like that in the code:

    git grep -W '\(\(struct .*\*'

diff:

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index 25d4d95b52b..91eb0b495f5 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -26,7 +26,7 @@ static void strbuf_close(void *b)
 static int strbuf_read_block(void *v, struct reftable_block *dest, uint64_=
t off,
 			     uint32_t size)
 {
-	struct strbuf *b =3D (struct strbuf *)v;
+	struct strbuf *b =3D v;
 	assert(off + size <=3D b->len);
 	dest->data =3D reftable_calloc(size);
 	memcpy(dest->data, b->buf + off, size);
@@ -36,7 +36,8 @@ static int strbuf_read_block(void *v, struct reftable_blo=
ck *dest, uint64_t off,
=20
 static uint64_t strbuf_size(void *b)
 {
-	return ((struct strbuf *)b)->len;
+	struct strbuf *buf =3D b;
+	return buf->len;
 }
=20
 static struct reftable_block_source_vtable strbuf_vtable =3D {
@@ -91,10 +92,11 @@ static void file_return_block(void *b, struct reftable_=
block *dest)
=20
 static void file_close(void *b)
 {
-	int fd =3D ((struct file_block_source *)b)->fd;
+	struct file_block_source *bs =3D  b;
+	int fd =3D bs->fd;
 	if (fd > 0) {
 		close(fd);
-		((struct file_block_source *)b)->fd =3D 0;
+		bs->fd =3D 0;
 	}
=20
 	reftable_free(b);
@@ -103,7 +105,7 @@ static void file_close(void *b)
 static int file_read_block(void *v, struct reftable_block *dest, uint64_t =
off,
 			   uint32_t size)
 {
-	struct file_block_source *b =3D (struct file_block_source *)v;
+	struct file_block_source *b =3D v;
 	assert(off + size <=3D b->size);
 	dest->data =3D reftable_malloc(size);
 	if (pread(b->fd, dest->data, size, off) !=3D size)
