Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415BEC433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 12:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F4054610E7
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 12:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbhDJM5c (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 08:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbhDJM5a (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 08:57:30 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACD4C061762
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 05:57:15 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e7so9605909edu.10
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 05:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=CXeEkivyfa/SIqKJp02LCrD3URS00iKe3wAkgYLyKQA=;
        b=hZXoGrlTNngxpAFN+cYYDJPYqFENIBqpp3/dEX8yVvf5+8fhbzrncfKKsTR0BKLSSO
         MIBZibApo5tKU02+3VUv0ovnlMx4KedciemjrYdoLh2KJOn03/JM+1ujRHdDmhFHc5wZ
         uiEotUD/29ynP4hdOp9QCOGWyLndr3XzkH71a0ogE1e9vxWENuuHhT+jn8YB9C0BbbNA
         mr3o77+/sWANKH6t4dpxyipkK8ivzC62YhlyIbf3d9gH2TYjduF6BXSAny0bvp6E4k7Y
         bKGhBp/QoGLUgVBOA9zhqn2FN7os6EMv7gwkPqRXlOY79tt+YQrwHbNOma+WoUVoLgwm
         nHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=CXeEkivyfa/SIqKJp02LCrD3URS00iKe3wAkgYLyKQA=;
        b=AHGG47JDBeB1ZlNv81+ACEXnaFxDkidcWNACdikU4W5yxD0DlNID3ooihIHo75J+KS
         sfA7dQtHe74f2yUyiyz/JFAmmgNDSBVtBiJ03Y0EA4O0Y40B/XVuPgUX2P2E7oQgRtYW
         1gmH1Chy48CnCEon5Tt8FaevzC9KYqFxxUmT06Zqqvk+/hg1BzXCUF+I+LVmvpjvNYFy
         RQ2fojNPoTDruk1Krz9+7FYGB7Un6emCHTkXdJMsOO31JXnCtjL5YO6y3dNEvLOcvGH7
         d3mircnObVfaxJVlqODOrpEnCcVIQbukTDs8iy369NepJk9Sozpx2d5XxeJH1hLhsx3z
         mreQ==
X-Gm-Message-State: AOAM532WVum0Ftk2BZKXNREEYNbBf/2za9zhL2EPAI+AxxCUlUQx4RHt
        d3JXiuxiAhFx+88lqSvVgwE=
X-Google-Smtp-Source: ABdhPJzqQqJP5UJ9kSVAo8B3wwkeV2ow9EYrZdrBRFaLPE+uLOGTl9IpesOt2ZUYHWv7tJS4XG4lMw==
X-Received: by 2002:aa7:df95:: with SMTP id b21mr21179950edy.338.1618059433859;
        Sat, 10 Apr 2021 05:57:13 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v1sm3048997eds.17.2021.04.10.05.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 05:57:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] blob.c: remove buffer & size arguments to
 parse_blob_buffer()
References: <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
 <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
 <patch-1.3-68a7709fe5-20210409T080534Z-avarab@gmail.com>
 <YHCUFwZMitOXELpq@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YHCUFwZMitOXELpq@coredump.intra.peff.net>
Date:   Sat, 10 Apr 2021 14:57:12 +0200
Message-ID: <87y2dqfgbb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 09 2021, Jeff King wrote:

> On Fri, Apr 09, 2021 at 10:07:27AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> As noted in the comment introduced in 837d395a5c0 (Replace
>> parse_blob() with an explanatory comment, 2010-01-18) the old
>> parse_blob() function and the current parse_blob_buffer() exist merely
>> to provide consistency in the API.
>>=20
>> We're not going to parse blobs like we "parse" commits, trees or
>> tags. So let's not have the parse_blob_buffer() take arguments that
>> pretends that we do. Its only use is to set the "parsed" flag.
>>=20
>> See bd2c39f58f9 ([PATCH] don't load and decompress objects twice with
>> parse_object(), 2005-05-06) for the introduction of parse_blob_buffer().
>
> OK. Calling it parse_blob_buffer() is a little silly since it doesn't
> even take a buffer anymore. But I guess parse_blob() might imply that it
> actually loads the contents from disk to check them (which the other
> parse_foo() functions do), so that's not a good name.
>
> So this might be the least bad thing. Given that there are only two
> callers, just setting blob->object.parsed might not be unreasonable,
> either. But I don't think it's worth spending too much time on.
>
>> @@ -266,7 +266,7 @@ struct object *parse_object(struct repository *r, co=
nst struct object_id *oid)
>>  			error(_("hash mismatch %s"), oid_to_hex(oid));
>>  			return NULL;
>>  		}
>> -		parse_blob_buffer(lookup_blob(r, oid), NULL, 0);
>> +		parse_blob_buffer(lookup_blob(r, oid));
>>  		return lookup_object(r, oid);
>
> Not new in your patch, but I wondered if this could cause a segfault
> when lookup_blob() returns NULL. I _think_ the answer is "no". We'd hit
> this code path when either:
>
>   - lookup_object() returns an object with type OBJ_BLOB, in which case
>     lookup_blob() would return that same object
>
>   - lookup_object() returned NULL, in which case lookup_blob() will call
>     it again, get NULL again, and then auto-create the blob and return
>     it
>
> So I think it is OK. But there are a bunch of duplicate hash lookups in
> this code. It would be clearer and more efficient as:
>
> diff --git a/object.c b/object.c
> index 2c32691dc4..2dfa038f13 100644
> --- a/object.c
> +++ b/object.c
> @@ -262,12 +262,14 @@ struct object *parse_object(struct repository *r, c=
onst struct object_id *oid)
>  	if ((obj && obj->type =3D=3D OBJ_BLOB && repo_has_object_file(r, oid)) =
||
>  	    (!obj && repo_has_object_file(r, oid) &&
>  	     oid_object_info(r, oid, NULL) =3D=3D OBJ_BLOB)) {
> +		if (!obj)
> +			obj =3D create_object(r, oid, alloc_blob_node(r));
>  		if (check_object_signature(r, repl, NULL, 0, NULL) < 0) {
>  			error(_("hash mismatch %s"), oid_to_hex(oid));
>  			return NULL;
>  		}
> -		parse_blob_buffer(lookup_blob(r, oid), NULL, 0);
> -		return lookup_object(r, oid);
> +		parse_blob_buffer(obj, NULL, 0);
> +		return obj;
>  	}
>=20=20
>  	buffer =3D repo_read_object_file(r, oid, &type, &size);
>
> but I doubt the efficiency matters much in practice. Those hash lookups
> will be lost in the noise of computing the hash of the blob contents.

I was trying to keep the changes smaller, but what about just doing this?:

diff --git a/blob.c b/blob.c
index 182718aba9..69293e7d8e 100644
--- a/blob.c
+++ b/blob.c
@@ -5,16 +5,16 @@
=20
 const char *blob_type =3D "blob";
=20
+struct blob *create_blob(struct repository *r, const struct object_id *oid)
+{
+	return create_object(r, oid, alloc_blob_node(r));
+}
+
 struct blob *lookup_blob(struct repository *r, const struct object_id *oid)
 {
 	struct object *obj =3D lookup_object(r, oid);
 	if (!obj)
-		return create_object(r, oid, alloc_blob_node(r));
-	return object_as_type(obj, OBJ_BLOB, 0);
-}
+		return create_blob(r, oid);
=20
-int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size)
-{
-	item->object.parsed =3D 1;
-	return 0;
+	return object_as_type(obj, OBJ_BLOB, 0);
 }
diff --git a/blob.h b/blob.h
index 1664872055..ad34f0e9cc 100644
--- a/blob.h
+++ b/blob.h
@@ -9,10 +9,9 @@ struct blob {
 	struct object object;
 };
=20
+struct blob *create_blob(struct repository *r, const struct object_id *oid=
);
 struct blob *lookup_blob(struct repository *r, const struct object_id *oid=
);
=20
-int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size);
-
 /**
  * Blobs do not contain references to other objects and do not have
  * structured data that needs parsing. However, code may use the
diff --git a/object.c b/object.c
index 78343781ae..2699431404 100644
--- a/object.c
+++ b/object.c
@@ -195,8 +195,7 @@ struct object *parse_object_buffer(struct repository *r=
, const struct object_id
 	if (type =3D=3D OBJ_BLOB) {
 		struct blob *blob =3D lookup_blob(r, oid);
 		if (blob) {
-			if (parse_blob_buffer(blob, buffer, size))
-				return NULL;
+			blob->object.parsed =3D 1;
 			obj =3D &blob->object;
 		}
 	} else if (type =3D=3D OBJ_TREE) {
@@ -262,12 +261,16 @@ struct object *parse_object(struct repository *r, con=
st struct object_id *oid)
 	if ((obj && obj->type =3D=3D OBJ_BLOB && repo_has_object_file(r, oid)) ||
 	    (!obj && repo_has_object_file(r, oid) &&
 	     oid_object_info(r, oid, NULL) =3D=3D OBJ_BLOB)) {
+		struct blob *blob;
+		if (!obj)
+			blob =3D create_blob(r, oid);
 		if (check_object_signature(r, repl, NULL, 0, NULL) < 0) {
 			error(_("hash mismatch %s"), oid_to_hex(oid));
 			return NULL;
 		}
-		parse_blob_buffer(lookup_blob(r, oid), NULL, 0);
-		return lookup_object(r, oid);
+		obj =3D &blob->object;
+		obj->parsed =3D 1;
+		return obj;
 	}
=20
 	buffer =3D repo_read_object_file(r, oid, &type, &size);
