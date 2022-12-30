Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB46FC4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 06:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiL3GHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 01:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbiL3GHM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 01:07:12 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE13FCC3
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 22:07:11 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id k137so9134614pfd.8
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 22:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAenKjPtIkMlG+C4Hef1goi7QqbXfz/ONzW4GA2f1Q0=;
        b=kgdgfGiv9VOedKr10BipH7IcM7vh6Pu4+bGFqDAIi4Mp8lDKxfxSxzvVFuABCJ73FB
         KqbmXdsOdCNUixiiwfy44qhdYEiXhh4Ph5VM6oW6ASDDT27FNTfRT59d2fgs31fnmMnE
         VaYVcCh9Rp75wRTc2a3XDNvUZh94LCDgod2JrydPIaj1+5G/Blm1ClHd62nGvF1TmHDv
         EMZU53M8fDTOvJEmp59pFyoezkc+EXRuBMFMhJdrujtAeiB2hhCMDXAOXKFqUwAjtskv
         B1NRkbERbr0C5tzTfVPevgpmzTlwHhciRwY3qRI43LE3pzvl7ADsxRjottlaQlhJFZB9
         qj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AAenKjPtIkMlG+C4Hef1goi7QqbXfz/ONzW4GA2f1Q0=;
        b=dKi7HBIwSamHI5yhZneS37OIyrljxlNodpLqGMqE8fhL3rf79jSCiGK5xsKlFi39ud
         EHOXSk7WlNO5fqgZDhB3yPeDpiIXWNsHGn4yAHUd4T3fOL5yof15kSacnb8TYs2BUPyw
         bxcC3EJfDtiBfa71uB5XzHyxG8eEzRZZV+xWKqmZI1oa9X4azBiFtOH9nhWWQeZnRfnY
         jbJ0NzSz1KWz+Nb9Zs1n8Fv7zSAbwAy+MerYNlZgAAzKHhL4ejwrzmg8/HbgNjC7Vn2L
         UaciMOxJanA+LXijNfLN90jOTkyUp4HSMzovEdE+NjbQGHiR94LmjuONyxL1bP8/0oq6
         19oQ==
X-Gm-Message-State: AFqh2krUUO72avJveiRPyBvIijdjKZpS12HlOOqPg4K40C8B2nYPtGwn
        k6ckrIpklSYzFlpX0mUMih4=
X-Google-Smtp-Source: AMrXdXtLHGqrHwAHMFkZ3sHZtnifebaWyY6U+HvC0CbHwAZHprh1oE9PhI0EJMsAaFPsZmqMeiH6jw==
X-Received: by 2002:a62:ee0e:0:b0:578:f6f:efab with SMTP id e14-20020a62ee0e000000b005780f6fefabmr35869995pfi.11.1672380430780;
        Thu, 29 Dec 2022 22:07:10 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id g7-20020a625207000000b00573a9d13e9esm9655773pfb.36.2022.12.29.22.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 22:07:10 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Kousik Sanagavarapu <five231003@gmail.com>
Subject: Re: [PATCH v2 2/3] tag: don't misreport type of tagged objects in
 errors
References: <cover-0.4-00000000000-20221118T113442Z-avarab@gmail.com>
        <cover-v2-0.3-00000000000-20221230T011725Z-avarab@gmail.com>
        <patch-v2-2.3-96398731841-20221230T011725Z-avarab@gmail.com>
Date:   Fri, 30 Dec 2022 15:07:09 +0900
In-Reply-To: <patch-v2-2.3-96398731841-20221230T011725Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 30 Dec
 2022 02:52:15
        +0100")
Message-ID: <xmqqsfgxjugi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> diff --git a/blob.c b/blob.c
> index 8f83523b0cd..d6e3d64213d 100644
> --- a/blob.c
> +++ b/blob.c
> @@ -5,12 +5,19 @@
>  
>  const char *blob_type = "blob";
>  
> -struct blob *lookup_blob(struct repository *r, const struct object_id *oid)
> +struct blob *lookup_blob_type(struct repository *r,
> +			      const struct object_id *oid,
> +			      enum object_type type)
>  {
>  	struct object *obj = lookup_object(r, oid);
>  	if (!obj)
>  		return create_object(r, oid, alloc_blob_node(r));
> -	return object_as_type(obj, OBJ_BLOB, 0);
> +	return object_as_type_hint(obj, OBJ_BLOB, type);
> +}
> +
> +struct blob *lookup_blob(struct repository *r, const struct object_id *oid)
> +{
> +	return lookup_blob_type(r, oid, OBJ_NONE);
>  }

Between lookup_blob() and lookup_blob_type(), the distinction is
that the latter calls object_as_type_hint() to ensure that the real
type of the given object is of the type, which is given as "hint"?

Very confusing naming.  Perhaps because "hint" argument given to
"as-type-hint" is playing a role that is FAR stronger than "hint"?
It sounds more like enforcement.  Perhaps s/hint/check/ or something?

I am not sure exactly why, but lookup_blob_type() does look
confusing.  A natural question anybody would ask after seeing the
function mame and the extra parmater is: "If we want/expect to see a
blob, why do we give an extra type?"  To answer that question, "_type"
at the end of the function name and "type" that is an extra argument
should say what that thing is used for.  "enum object_type" is enough
to say what the extra argument is---we should use the parameter name
to convey what it is there for.

> +void *object_as_type_hint(struct object *obj, enum object_type type,
> +			  enum object_type hint)
> +{
> +	if (hint != OBJ_NONE && obj->type != OBJ_NONE && obj->type != type) {
> +		error(_("object %s is a %s, not a %s"), oid_to_hex(&obj->oid),
> +		      type_name(type), type_name(obj->type));
> +		obj->type = type;
> +		return NULL;
> +	}

There must be something utterly wrong in the above implementation.
As long as "hint" is ANY type other than OBJ_NONE, "check if type
and obj->type match and otherwise complain" logic kicks in, and the
actual value of "hint" does not contribute anything to the outcome.

IOW, the "hint" parameter is misleading to be "enum object_type", as
it is only used as a Boolean "do we bother to check?".

> +	return object_as_type(obj, type, 0);;

Stray extra semicolon at the end.

> +}
