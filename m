Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC560C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 18:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiLISdY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 13:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiLISdX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 13:33:23 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833E854359
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 10:33:21 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3d2994e2d7dso58742117b3.9
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 10:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wvEo21boEtvtR5UrAx4KVym7l0GUAU1UwkpDD0d3wr4=;
        b=hBtC0Yi8k0wWK+guLVjUjnofNk3YrcXySpylIXfwnBEExePVLoq20VJaNc/LOQKf8E
         xO97RrD9AFlFRVml38d1lYn787/rK/Mz3Z1QtJAt6SWLATqRnR1jjJC44G1i7bgOBDuX
         H5d8zsB/7PJJca+wgrdrmoTL1kA+nnNhqKS94YZMYZV1UOD8qqFMRjdFno6HDyLZHNH6
         5hbqNTH1mIIpjZkwhrgtXHc45VcEBGpAxwImPbf/Opz9xrq55Z6GPRhMJ4lYqOxOXwbs
         Md5Xnb9mJS5Y/K1tbJBjIcAbxIt1s9zopEb61e5LUmHMqyHjoAvhZPc0Yk5yscIZQiBI
         Skow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wvEo21boEtvtR5UrAx4KVym7l0GUAU1UwkpDD0d3wr4=;
        b=Jn1LkzRqxwaH5PA8NDWsSMZMQmvBpjN6Eh6L+lRhvbDOgTSW/qJhXAVX+IhRBjnGtt
         MhE8mp3HiWuWUlwOM8uujdTHQpTgfDP/Bd6yFHKfF7j5kmg/j8q16WFwW5HmUe67SexI
         VDqR1YVo2lZ2vQT02MBI4gwPABbcKqbHwFDsCL4HIxDmsA+Ig2sChEewZrI3/efjsSIq
         jlMHGswZOFMsEMHTBpZV9r/1FCri1pRtSOFB+cJko2J7Glvx0JkPHTKVdkpmLowQsGO3
         cErI/GJQ/phIHC5+wVpz0ZYSE+kV5Kj/204Vv0kq8VurAzPCQq4j7HeTiSvk3yNaG0Wi
         vvGg==
X-Gm-Message-State: ANoB5pnya1Qew7PA2TEe6OjOlkYGFDwYka2oJad4NyFO6k6SGEoHtqb/
        lHZ+Bw0SJFentG1XqPt80FcxGDOMM3Kp/rHM6UER
X-Google-Smtp-Source: AA0mqf4B+T/fQQT6sjRV5RUs3VttpclKF4Q8dZ+KW1TboEmAqQU/a7MolbPg/lW2R2AAvK2ByVpIRu5OhOBhN/0/FhvE
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:1455:0:b0:6d3:6bf4:d946 with
 SMTP id 82-20020a251455000000b006d36bf4d946mr72180853ybu.373.1670610800744;
 Fri, 09 Dec 2022 10:33:20 -0800 (PST)
Date:   Fri,  9 Dec 2022 10:33:18 -0800
In-Reply-To: <221209.86y1rg63tt.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221209183318.394294-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 3/4] object-file: emit corruption errors when detected
From:   Jonathan Tan <jonathantanmy@google.com>
To:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        peff@peff.net, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> > @@ -1433,6 +1433,7 @@ static int loose_object_info(struct repository *r=
,
> >  {
> >  	int status =3D 0;
> >  	unsigned long mapsize;
> > +	const char *path =3D NULL;
>=20
> I think the NULL assignment here should either go, or it's incomplete.

[snip]

> So init-ing it didn't help us, but just helps to hide that potential
> (and much worse) bug.

Good catch. I'll remove the assignment.

=20
> I think this change should also remove the existing "const char *path"
> in this function from the "if"'d scope omitted in this context.
>=20
> The C compiler won't care, but to the human reader it's easier to reason
> about not shadowing the variable now, for as it turns out no reason, as
> they're effectively independent.

Makes sense.

> >  	git_inflate_end(&stream);
> >  cleanup:
> >  	munmap(map, mapsize);
> > @@ -1611,6 +1616,15 @@ static int do_oid_object_info_extended(struct re=
pository *r,
> >  			continue;
> >  		}
> > =20
> > +		if (flags & OBJECT_INFO_DIE_IF_CORRUPT) {
> > +			const struct packed_git *p;
>=20
> Nit: add an extra \n here, between decls and code.

OK.

> > -	if (oid_object_info_extended(r, oid, &oi, 0) < 0)
> > +	if (oid_object_info_extended(r, oid, &oi,
> > +				     die_if_corrupt ? OBJECT_INFO_DIE_IF_CORRUPT : 0)
> > +	    < 0)
> >  		return NULL;
> >  	return content;
> >  }
>=20
> This is a very odd coding style/wrapping, to not even end up with a line
> shorter than 79 characters. You can instead do:
>=20
> 	if (oid_object_info_extended(r, oid, &oi, die_if_corrupt
> 				     ? OBJECT_INFO_DIE_IF_CORRUPT : 0) < 0)
>=20
> Which is in line with our usual style, and does wrap before 79 characters=
...

I didn't want to split the ternary expression, but OK, I'll follow your
wrapping.=20

> > diff --git a/object-store.h b/object-store.h
> > index b1ec0bde82..98c1d67946 100644
> > --- a/object-store.h
> > +++ b/object-store.h
> > @@ -445,6 +445,9 @@ struct object_info {
> >   */
> >  #define OBJECT_INFO_FOR_PREFETCH (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJE=
CT_INFO_QUICK)
> > =20
> > +/* Die if object corruption (not just an object being missing) was det=
ected. */
> > +#define OBJECT_INFO_DIE_IF_CORRUPT 32
>=20
> Personally I wouldn't mind a short cleanup step in this series to change
> these to 1<<0, 1<<1 etc., as we do for almost everything els.
>=20
> I.e. in an earlier step you removed the "16", and changed that "32" to
> "16", now we're adding a "32" again.
>=20
> I also notice that you didn't just add a "4" here, which is an existing
> gap, which turns out to be a leftover bit from your 9c8a294a1ae
> (sha1-file: remove OBJECT_INFO_SKIP_CACHED, 2020-01-02) ~2 years ago :)

Ah...I didn't notice the 4 missing. But I think the series has gone over
enough iterations now that I'd rather leave this as-is and maybe change
this in a future patch.
