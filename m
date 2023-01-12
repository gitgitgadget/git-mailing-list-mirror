Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABF9C54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 09:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239589AbjALJyw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 04:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239134AbjALJyN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 04:54:13 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21FDE94
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:51:58 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id tz12so43400139ejc.9
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S1kaeBIAOxzalBlBpxSg/Dh5yxOb3VUWz6nZ41IaXPo=;
        b=NOnO8Tt4WdrTBGbBK8hQ1TW3DsM1NoErSZtTxpYhddnlLMNp5LJDdi3Hbfw2rCofph
         qF4A+YzvaNltZiw0LdRtjScbYWftLE9EB3sRCjEbn5jMIr4WbFYHNDivKK4tkpbNJkoU
         e6JxOf537kc22aMrgB8ufOSydUAQHWBw4nWwydfigmZyyVKjsgYK/mfwO0/5mWCF2V39
         wyU+UAsws9jYSBoWIXSsrrv29pMxnzfq+zd+cmuUSktMYvNJUdXW6LuXJIECqAs91ivF
         jqSJCbN3xnAHCSnkAGOahskXK3YfrtHsq0ozAak0WjZ/RBCl3hIWJwowNA4uQsofV4oi
         GKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1kaeBIAOxzalBlBpxSg/Dh5yxOb3VUWz6nZ41IaXPo=;
        b=B/zJW4xszz6/9Lcr92ZyYmavp0elPaA0gV1TgqctHB01M9+yF6D7jD4Tp8sYbQJBA8
         ZiIbeIIoXrbT9EJbRIprRZyyf4WhgcLGpbNqDqlSKlZQIB5pi/olp8+zZoRJIk6BSKsM
         2ab656iShaxNdzW6A74HbPs2OLn2urVCa9/Q+TaeEbn3vew2u+AZRhYTyudud4XbSmYa
         xvF+0+tvxCB+9CER/RpoxwGbNDsfe2/45NF5J0c15sC7a7Av07SXhzVqSv4s9t/NY2Cy
         GQKb8JVRfhT4QUIyw/wwSvqOeoSQ2cJwk66MBr1Wxfx9663/YSFn12xuA4t8GJiBA/jp
         VDKQ==
X-Gm-Message-State: AFqh2krhIaNOmnbeLUS/cWtLfMFI/XLO/dNW3/QQUlnwtt7vZRFoGdGF
        +A0fWnUBkKKc6Bpj7SOsx4U=
X-Google-Smtp-Source: AMrXdXtqQPaCLeM6OCtzff+gX5v/a07Ibw0Qi4gEI/xXpQJ7ZOxdMGu2cYVV5xn1J4Mor11QRm6XHw==
X-Received: by 2002:a17:907:d48e:b0:862:fc76:6f8e with SMTP id vj14-20020a170907d48e00b00862fc766f8emr3656725ejc.36.1673517117459;
        Thu, 12 Jan 2023 01:51:57 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id l15-20020aa7c3cf000000b00467481df198sm6979519edr.48.2023.01.12.01.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 01:51:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pFuFY-0006wG-1T;
        Thu, 12 Jan 2023 10:51:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, tenglong.tl@alibaba-inc.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v4 2/5] notes.c: cleanup for "designated init" and "char
 ptr init"
Date:   Thu, 12 Jan 2023 10:51:02 +0100
References: <cover.1673490953.git.dyroneteng@gmail.com>
 <29f7703b06dfecd1daedb72a7027aa953addfa3a.1673490953.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <29f7703b06dfecd1daedb72a7027aa953addfa3a.1673490953.git.dyroneteng@gmail.com>
Message-ID: <230112.867cxs2i83.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 12 2023, Teng Long wrote:

> From: Teng Long <dyroneteng@gmail.com>
>
> Let's do some cleanup for the following two places in "append_edit()".
>
> The first place is "char *logmsg;" need to be initialized with NULL.
> The second place is "struct note_data d = { 0, 0, NULL, STRBUF_INIT };"
> could be replaced with designated init format.
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  builtin/notes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index e57f024824..8ca55ec83e 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -566,9 +566,9 @@ static int append_edit(int argc, const char **argv, const char *prefix)
>  	struct notes_tree *t;
>  	struct object_id object, new_note;
>  	const struct object_id *note;
> -	char *logmsg;
> +	char *logmsg = NULL;

This change isn't needed, and the compiler will check that we have it
init'd.

It *is* needed when combined with your 3/5, but even then it's the wrong
solution. In that change you move the commit_notes() into that "if"
branch that needs the "logmsg", and it's correct that you need to
NULL-init it to safely pass it to free().

But let's just declare the "logmsg" in that if block then, and move the
free() over there, that reduces the scope it's in.

>  	const char * const *usage;
> -	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
> +	struct note_data d = { .buf = STRBUF_INIT };

This change is good, but then let's change the other such case in this
file to a designated init too, and make the commit message etc. be about
using designated init here.
