Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C6EC6FD1C
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 05:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjCZFMN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Mar 2023 01:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCZFML (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 01:12:11 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A4630E8
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 22:12:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id i5so23503833eda.0
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 22:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679807527;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Apl5YA2yo0Z8bZ6cMuZSkXBDgFUgHJ5KyjqW+ljBVAw=;
        b=HD6JW8kYtaiMTEbaMu8UdSNiozodOI71D/9IQK582OvGX3arMvHSuDiPrLCm1bK31Z
         bi3WFcDBTUTt/5lk9tis6r6DeuME7s15/ZQQCsuxh8wPUYdsIX5UWIPFK51HbTcqzkLn
         WKtL+km6Jf6PcLv6bfEfwzqz1jZuLJvhpvhbVW7dOL3Cv28IBJcCAqrdXYGE4UdmX7Kl
         zLwQiNuoClqmxStIaJdB/Mq9nLF2SUjranKolUQd5gTHHaGFjPQbVyhB3Sb0FnqaBcHQ
         DD+qzIrhQA6XgiIce1X0e1hlYYpDervbKGanjIwvkFkXRAKepW7sTE3sFbC+GgEfO4gW
         z9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679807527;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Apl5YA2yo0Z8bZ6cMuZSkXBDgFUgHJ5KyjqW+ljBVAw=;
        b=krZZe+wdxNvNuJ2neRyMAaqNLzFNnY5YJXuuTI8eGVIZmJmhWzXxlVhKgt+zY7P5Rk
         395KL9o2XjLO8FkdjbYpjjDHvJUSqSQrKjNEjP8VCFwBtzqaOotGHSkAhvLdAcs6g4Pr
         RNCeXlfODWUjZzEEOOijVmpv2R3gDgmvDsjc8Nwfyq6OAtFtyz2/pGNwxGl2Y7KRgQl7
         vC0tZvn8dADxYXkzNglWAnQXMGsKwxAv+D4RTSHrYvksDZNhFo1dlUTWenPHSrGs4Lei
         NJjo+oMWbWS2BvCQScVEBp8DjJgmwBbi6fxY3JWH8JxImJiIoJg2D4jE0w9JE0LsbTis
         fdAg==
X-Gm-Message-State: AAQBX9eNTFPdEQp5W0sE/wqgZ8xSCwIFm3IWA4RKf87JyEngpAJ2XLZv
        Z+/cGGV4i7wCII4g04GziDV9knCXj7Q=
X-Google-Smtp-Source: AKy350YoitfA7refRJBQ+aGJhT4Nu/UtNcICgJH3JsBCFdKNXqkGKPV2waqbRvs+8ia8fIaeey3Bmg==
X-Received: by 2002:a17:906:5850:b0:935:3028:ff58 with SMTP id h16-20020a170906585000b009353028ff58mr7630893ejs.55.1679807527137;
        Sat, 25 Mar 2023 22:12:07 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090668cc00b008d044ede804sm10476735ejr.163.2023.03.25.22.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 22:12:06 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pgIfm-004Jaw-0p;
        Sun, 26 Mar 2023 07:12:06 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/17] cocci: fix incorrect & verbose "the_repository"
 rules
Date:   Sun, 26 Mar 2023 07:02:55 +0200
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
 <patch-02.17-1b1fc5d41f5-20230317T152724Z-avarab@gmail.com>
 <kl6ledpge75s.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <kl6ledpge75s.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <230326.86edpcw0yh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 22 2023, Glen Choo wrote:

> Every time I try to read cocci and spatch docs, I'm impressed at how
> impenetrable they are ;)

FWIW you should ignore the manpage, which and instead read the
"Coccinelle User=E2=80=99s manual", and particularly "The SmPL Grammar", bo=
th of
which are available as PDFs on their website.

But their docs are rather terse, and sometimes even incomplete. I've
often resorted to grepping their own test cases to figure out how
something works.

> Nevertheless, I'd still like to understand how
> the pattern works. I'll take a stab in the dark, and perhaps you can
> correct me.
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason         <avarab@gmail.com> writes:
>
>> +(
>> +- read_object_file
>> ++ repo_read_object_file
>> +|
>> +- has_object_file
>> ++ repo_has_object_file
>> +|
>> +- has_object_file_with_flags
>> ++ repo_has_object_file_with_flags
>> +|
>> +- parse_commit_internal
>> ++ repo_parse_commit_internal
>> +|
>> +- parse_commit
>> ++ repo_parse_commit
>> +|
>> +- get_merge_bases
>> ++ repo_get_merge_bases
>> +|
>> +- get_merge_bases_many
>> ++ repo_get_merge_bases_many
>> +|
>> +- get_merge_bases_many_dirty
>> ++ repo_get_merge_bases_many_dirty
>> +|
>> +- in_merge_bases
>> ++ repo_in_merge_bases
>> +|
>> +- in_merge_bases_many
>> ++ repo_in_merge_bases_many
>> +|
>> +- get_commit_buffer
>> ++ repo_get_commit_buffer
>> +|
>> +- unuse_commit_buffer
>> ++ repo_unuse_commit_buffer
>> +|
>> +- logmsg_reencode
>> ++ repo_logmsg_reencode
>> +|
>> +- format_commit_message
>> ++ repo_format_commit_message
>> +)
>
> I assume that `|` characters in parentheses are a logical OR, and each
> of the expressions checks for the `-` side in the original and replaces
> it with the `+` side.

Yes, just a simple "replace A with B".

>> +  (
>> ++ the_repository,
>> +  ...)
>
> Then this is another expression that matches literal `()` after the
> previous expression? `+the_repository` adds `the_repository` right after
> the opening `(`, then leaves the uninteresting `...` in place.
>
> If so, I don't know how cocci/spatch tells the difference between
> literal `()` vs an expression in the syntax (preceding whitespace?).

Yes, whitespace is significant in the coccinelle syntax, generally its
own "()" grouping goes at the beginning of a line, wheras you indent
program text in the "diff" with whitespace.

E.g. our equals-null.cocci has two rules that use "(" and ")" in a way
that would be ambiguous if this whitespace-disambiguation weren't being
used.
