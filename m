Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F926E82CD6
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 20:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjI0UmR convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 27 Sep 2023 16:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjI0UmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 16:42:16 -0400
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A88D6
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 13:42:15 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4527ba546d2so4721448137.2
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 13:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695847334; x=1696452134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPX4f/tvee8s1CphGNeUUfAm5TYoxImnAFfDsrTCZME=;
        b=AE4nV165rSG1K3RJCsHNuZpl7JRZEglCvt3YOfC7VvRPRFeTUf1JTPP6BtJOHMBkJn
         MVl7CyaE2c+LBCJN+6ncxfYd0/Zo9xEzehNzqBmGEcevcg43ZSUQUMJ0fYSDZNoabo+i
         IEFP59aUfNwIWLyxOC3/auoh2uNccXI5MXAvTREHBehcIKKUG7MW7To0n7CVwpAeJdB3
         nkIOVBy/2VWwKIqMlmHndvCN3++5Ml/M8bL+nxQ7dKZk1wP4UnJc+FM9+PMkSkorH1KW
         SxhGB9IV4EJqnadF4b3c99FMQbKjGqbMztecuPDADJJuGB6KQTyYrcHigSiy1QP9m3Ra
         kdwQ==
X-Gm-Message-State: AOJu0Yyzn0wGgkZLOloV4JLf7V6l5WFJQkjqjKvs5EZkVyug8UezfccY
        onl/OxS6L0BK7OsxZVo5XLzdHZOOX/AVJ3HTEdA=
X-Google-Smtp-Source: AGHT+IFCnK6CQn5xeWPfKpc5i+jsFvbUVy4ZTY2uzpSKI57hKX9uDqefJuJKOi19Urz8ByIfxU+IPEKQifjOGVMc3Rw=
X-Received: by 2002:a05:6102:50a:b0:452:77f1:f1e8 with SMTP id
 l10-20020a056102050a00b0045277f1f1e8mr2601912vsa.33.1695847334159; Wed, 27
 Sep 2023 13:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org> <20230927195537.1682-1-ebiederm@gmail.com>
In-Reply-To: <20230927195537.1682-1-ebiederm@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 27 Sep 2023 16:42:03 -0400
Message-ID: <CAPig+cRshiUNXfU=ZY4nZXgBgTJ_wF0WVDxWpqkEKPAT9pjX_w@mail.gmail.com>
Subject: Re: [PATCH 01/30] object-file-convert: Stubs for converting from one
 object format to another
To:     "Eric W. Biederman" <ebiederm@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2023 at 3:55 PM Eric W. Biederman <ebiederm@gmail.com> wrote:
> Two basic functions are provided:
> - convert_object_file Takes an object file it's type and hash algorithm
>   and converts it into the equivalent object file that would
>   have been generated with hash algorithm "to".
>
>   For blob objects there is no converstion to be done and it is an
>   error to use this function on them.

s/converstion/conversion/

>   For commit, tree, and tag objects embedded oids are replaced by the
>   oids of the objects they refer to with those objects and their
>   object ids reencoded in with the hash algorithm "to".  Signatures
>   are rearranged so that they remain valid after the object has
>   been reencoded.
>
> - repo_oid_to_algop which takes an oid that refers to an object file
>   and returns the oid of the equavalent object file generated
>   with the target hash algorithm.

s/equavalent/equivalent/

> The pair of files object-file-convert.c and object-file-convert.h are
> introduced to hold as much of this logic as possible to keep this
> conversion logic cleanly separated from everything else and in the
> hopes that someday the code will be clean enough git can support
> compiling out support for sha1 and the various conversion functions.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Just some minor comments below, many of which are subjective
style-related observations, thus not necessarily actionable, but also
one or two legitimate questions.

> diff --git a/object-file-convert.c b/object-file-convert.c
> @@ -0,0 +1,57 @@
> +int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
> +                     const struct git_hash_algo *to, struct object_id *dest)
> +{
> +       /*
> +        * If the source alogirthm is not set, then we're using the
> +        * default hash algorithm for that object.
> +        */

s/alogirthm/algorithm/

> +       const struct git_hash_algo *from =
> +               src->algo ? &hash_algos[src->algo] : repo->hash_algo;
> +
> +       if (from == to) {
> +               if (src != dest)
> +                       oidcpy(dest, src);
> +               return 0;
> +       }
> +       return -1;
> +}

On this project, we usually get the simple cases out of the way first,
which often reduces the indentation level, making the code easier to
digest at a glance. So, it would be typical to write this as:

    if (from != to)
        return -1
    if (src != dest)
        oidcpy(dest, src);
    return 0;

or even:

    if (from != to)
        return -1
    if (src == dest)
        return 0;
    oidcpy(dest, src);
    return 0;

This way, for instance, the reader doesn't get to the end of the
function and then have to scan backward to understand the condition of
the `return -1`.

> +int convert_object_file(struct strbuf *outbuf,
> +                       const struct git_hash_algo *from,
> +                       const struct git_hash_algo *to,
> +                       const void *buf, size_t len,
> +                       enum object_type type,
> +                       int gentle)
> +{
> +       int ret;
> +
> +       /* Don't call this function when no conversion is necessary */
> +       if ((from == to) || (type == OBJ_BLOB))
> +               die("Refusing noop object file conversion");

Several comments...

Style: we usually reduce the noise level by dropping the extra parentheses:

    if (from == to || type == OBJ_BLOB)

Does this condition represent a programming error or a runtime error
triggerable by some input? If a programming error, then use BUG()
rather than die().

If a triggerable runtime error, then...

* start user-facing messages with lowercase rather than capitalized word

* make the user-facing message localizable so readers of other
languages can digest it

    die(_("refusing do-nothing object conversion"));

On the other hand, don't make BUG() messages localizable.

> +       switch (type) {
> +       case OBJ_COMMIT:
> +       case OBJ_TREE:
> +       case OBJ_TAG:
> +       default:
> +               /* Not implemented yet, so fail. */
> +               ret = -1;
> +               break;
> +       }
> +       if (!ret)
> +               return 0;
> +       if (gentle) {
> +               strbuf_release(outbuf);
> +               return ret;
> +       }

This function appears to be a mere skeleton at the moment, so it's
difficult to judge at this point whether you are using `outbuf` as a
bag of bytes or as a legitimate string container. If the latter, then
the API may be reasonable, but if you're using it as a bag-of-bytes,
then it feels like you're leaking an implementation detail into the
API.

> +       die(_("Failed to convert object from %s to %s"),
> +               from->name, to->name);

s/Failed/failed/

For people trying to diagnose this problem, would it be helpful to
present more information about the failed conversion, such as object
type and perhaps even its OID?

> diff --git a/object-file-convert.h b/object-file-convert.h
> @@ -0,0 +1,24 @@
> +int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
> +                     const struct git_hash_algo *to, struct object_id *dest);

I suppose the function name is pretty much self-explanatory to those
familiar with the underlying concepts, but it might still be helpful
to add a comment explaining what the function does.

> +/*
> + * Convert an object file from one hash algorithm to another algorithm.
> + * Return -1 on failure, 0 on success.
> + */
> +int convert_object_file(struct strbuf *outbuf,
> +                       const struct git_hash_algo *from,
> +                       const struct git_hash_algo *to,
> +                       const void *buf, size_t len,
> +                       enum object_type type,
> +                       int gentle);
