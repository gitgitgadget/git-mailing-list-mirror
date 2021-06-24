Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75732C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57875613CE
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhFXTeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhFXTeE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:34:04 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE66AC061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:31:43 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w13so4172646edc.0
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=PbB3jLfaCrMXMTlLJYnKdZz97gLK6E5WRbkbLB+Tjrc=;
        b=lDZgjZGrjTJfPKtd5sLYQB+Rp7jiHmTc+WQNh4U/HiRzPAHhS7rsrr7FqmhZT3xX1d
         T1YaZQCcRjjS+yvzJQb/xidlH6o7T+KY/oUEJQvXFmPK3/qrLBvi2CY6+XoPiL+FaVUW
         kOWTHVbG9P3tNoaVQ9axfnn+Sfn75dwwL+ncdbKhMjOr+yYkqfwigMoDLkgQA9vrUUof
         sb6Hsj3RtKoO6SoWLShb5I4aRelTqI8Z3EPlduGNU6waHlr3wL4m0GBjG9PR0nXPHx9a
         /P83osKtDbYG/zsOusBiJjdKEFEvIP+D2I6oyjI31arVIMCMdO9KDRZKlNMPA1O2RCJa
         L08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=PbB3jLfaCrMXMTlLJYnKdZz97gLK6E5WRbkbLB+Tjrc=;
        b=sQqeLpB9xZtezeP+HWcVmH0Sg+wN1Et53R0AVUWCLTg5ehrAk/OUNHaUnx4kWdoidv
         /8OHl1mNzFS65yumdVRzBMv3GEDmUUHcfLYOjEYWW3m25OkpVig+gHeIuukB0wnKJngz
         ofo9bX/RBNtmKn56SPz/w+i/SdzDVEumOhmIxV5qpCUhwwjJKUhVfXR9OyAKPEcgCnHB
         BBAuiGYgCfEVDVnkO9REJJYOlkJQYHQQHfNJt4SXUZPu2awim8xppkPO8NqR9WDayxMu
         ft7Vu7jQgdxjf5aJBPi414C9TiAgAveCxF9FLf3894ST8WZRBrcXmZQKK9YX8rjE95DA
         BIkg==
X-Gm-Message-State: AOAM533swuE960hxjTG5y4u0pPKXI3V/8JchTgOJrENqpfb8oeyQP7y/
        /4Ll/4wgPs2ACNbevy1Pjao=
X-Google-Smtp-Source: ABdhPJwjoWL2okYtmn8XZ+vnwt3nnpqbF43xMpC+yF4XFwh7zD50eIWy7qtOi0jikxk5mziovj1iUA==
X-Received: by 2002:aa7:c857:: with SMTP id g23mr9278121edt.100.1624563102497;
        Thu, 24 Jun 2021 12:31:42 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id du7sm2417290edb.1.2021.06.24.12.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:31:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v2 3/3] bundle: remove "ref_list" in favor of
 string-list.c API
Date:   Thu, 24 Jun 2021 21:31:02 +0200
References: <cover-0.3-0000000000-20210617T111934Z-avarab@gmail.com>
 <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com>
 <patch-3.3-9d9cb5aaf9e-20210621T151357Z-avarab@gmail.com>
 <YNS8vzPc1KyRaSR5@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <YNS8vzPc1KyRaSR5@coredump.intra.peff.net>
Message-ID: <87sg17ys82.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 24 2021, Jeff King wrote:

> On Mon, Jun 21, 2021 at 05:16:14PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Move away from the "struct ref_list" in bundle.c in favor of the
>> almost identical string-list.c API.
>>=20
>> That API fits this use-case perfectly, but did not exist in its
>> current form when this code was added in 2e0afafebd (Add git-bundle:
>> move objects and references by archive, 2007-02-22), with hindsight we
>> could have used the path-list API, which later got renamed to
>> string-list. See 8fd2cb4069 (Extract helper bits from
>> c-merge-recursive work, 2006-07-25)
>
> I think this is a good direction, and I didn't see any errors in the
> code. It's slightly sad that we end up with more lines than we started
> with, but I think that's mostly because you're actually freeing the
> memory now.
>
> Two small nitpicks:
>
>> @@ -103,19 +94,22 @@ static int parse_bundle_header(int fd, struct bundl=
e_header *header,
>>  		 * Prerequisites have object name that is optionally
>>  		 * followed by SP and subject line.
>>  		 */
>> -		if (parse_oid_hex_algop(buf.buf, &oid, &p, header->hash_algo) ||
>> +		oid =3D xmalloc(sizeof(struct object_id));
>> +		if (parse_oid_hex_algop(buf.buf, oid, &p, header->hash_algo) ||
>>  		    (*p && !isspace(*p)) ||
>>  		    (!is_prereq && !*p)) {
>>  			if (report_path)
>>  				error(_("unrecognized header: %s%s (%d)"),
>>  				      (is_prereq ? "-" : ""), buf.buf, (int)buf.len);
>>  			status =3D -1;
>> +			free(oid);
>>  			break;
>>  		} else {
>
> This would be slightly simpler if you kept a local "struct object_id",
> and then called:
>
>   string_list_append(list, string)->util =3D oiddup(&oid);
>
> later when you know you want to save it. And then you don't have to
> worry about the extra cleanup here. That does require an extra oidcpy()
> under the hood, but I suspect that is lost in the noise.
>
> I'm OK with it either way.

That sounds simpler indeed, thanks.

>> -			if (is_prereq)
>> -				add_to_ref_list(&oid, "", &header->prerequisites);
>> -			else
>> -				add_to_ref_list(&oid, p + 1, &header->references);
>> +			const char *string =3D is_prereq ? "" : p + 1;
>> +			struct string_list *list =3D is_prereq
>> +				? &header->prerequisites
>> +				: &header->references;
>> +			string_list_append(list, string)->util =3D oid;
>
> I'm usually a big fan of the ternary operator, and using variable
> indirection to make it clear that we always call a function.  But here I
> think it makes things more confusing.  The two sides of the if/else are
> sufficiently simple that it's easy to see they both make the same
> function call. And because there are two variables, we check is_prereq
> twice, making it much harder to see the two cases.
>
> I.e., I think:
>
>   if (is_prereq)
>           string_list_append(&header->prerequisites, "")->util =3D oid;
>   else
>           string_list_append(&header->references, p + 1)->util =3D oid;
>
> is much more obvious.

Hah, that's actually the exact code I wrote to begin with, before
thinking "hrm, someone will probably say I should just use a ternary
here". I'll change it back :)
