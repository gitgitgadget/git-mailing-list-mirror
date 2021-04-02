Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B84C433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 09:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B8D261105
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 09:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbhDBJ1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 05:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhDBJ1d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 05:27:33 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A71C0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 02:27:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a7so6667346ejs.3
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 02:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Y6fRk/Rr1OX4jh+XQdh+OOhhtI5w6/UZQfkI8gXA0Is=;
        b=pzyf7+cr3kxYlc1jRbPpeRS0SJITyiWMCaDFNU117ytjPiTCKGhhN1FNu9Konu6orN
         Wpo0+Qb+RixVwtwtgJ+YUl96EWdjwlAG1ma3LierR3nkspFKMwu9xpaiCHybdBCpRvNW
         zBpVPtMue9ypydgzBDvsW5QGjxO3ZQSC+kMM7bhGJvIDKs34MFGx7a0fFEKhB30IzQF8
         9B4yUfpmS9HxcNxND2lgjrOotSVAHm+jaXvud7LSCP/R9mycMU7uhC/nOoZWdJMkm50/
         FAzHJ8JkM/zNYa4a4QNbQCqysirGXMX5wIxB3Dd5p01roy6NDKtgGvrJuFLLpPVHTKnm
         TTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Y6fRk/Rr1OX4jh+XQdh+OOhhtI5w6/UZQfkI8gXA0Is=;
        b=f2M1PMNDIK+5F8V2oyfs0mARHHmg15Z/HWQ9XtUUkhblzoYnxFj5TocH9T3YHwtEe4
         g291GDtfG23mVM3xuObPmGW38MWPt5eNscs+YblLCFVxYS7XYgNcJ0/iNoTmztPovYuX
         hj4+1IRAmaOSlCEx5XCV91e4rhf/ncUcK+Cc26xSt1Tw2ezB/JC8E4aUTUoKvc0KqCzW
         5L1fglFbTpCACaiFtUEWXAWBrtgzf0HZBdBoaEDy52yqePGnBlPITjVbMfU29DsuTPFk
         NVTM6/wXQWSuFNVeRwDZLLAj/7drFpa/DReAtvqbcy6WLEivgrarT1btkBX86aF4edJC
         odPw==
X-Gm-Message-State: AOAM532CwUEnUEzU/1EGyPEDUbnc6wgzBDgihhJm8NPcyJ7qukshS7tY
        +w67lOy/x0mzEjLs0FAJ7Z2mzQhkPGerCQ==
X-Google-Smtp-Source: ABdhPJzfetG5tJxopTO9vI4ylssWRTCyZ7fiA+23jVT4J4mqmXEJXsViqxSZrMGt/zEfSqQYGXVNxw==
X-Received: by 2002:a17:906:ad4:: with SMTP id z20mr12887467ejf.496.1617355651040;
        Fri, 02 Apr 2021 02:27:31 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r24sm5012949edw.11.2021.04.02.02.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 02:27:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 14/18] tree-walk.h API doc: improve documentation of
 get_tree_entry()
References: <87o8fcqrg8.fsf@evledraar.gmail.com>
 <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
 <patch-14.19-44f16d74426-20210331T190531Z-avarab@gmail.com>
 <xmqq4kgp3fyh.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqq4kgp3fyh.fsf@gitster.g>
Date:   Fri, 02 Apr 2021 11:27:30 +0200
Message-ID: <878s61kpdp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 01 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change a mention of sha1 to OID and change the comment to a listing of
>> functions discussed below, right now there's only one function, but
>> subsequent commits will add more.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  tree-walk.h | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/tree-walk.h b/tree-walk.h
>> index 09e40d9221d..cd8da84f56c 100644
>> --- a/tree-walk.h
>> +++ b/tree-walk.h
>> @@ -166,11 +166,13 @@ struct traverse_info {
>>  };
>>=20=20
>>  /**
>> - * Find an entry in a tree given a pathname and the sha1 of a tree to
>> + * Find an entry in a tree given a pathname and the OID of a tree to
>>   * search. Returns 0 if the entry is found and -1 otherwise.
>>   *
>> - * The third and fourth parameters are set to the entry's sha1 and
>> - * mode respectively.
>> + * You always need a pointer to an appropriate variable to fill in
>> + * (NULL won't do!). That variable is:
>> + *
>> + * get_tree_entry(): unsigned short mode
>
> The last part after "That variable is:" makes no sense.  Sent before
> completing?

It's meant to refer to the "unsigned short mode", but I'll rephrase.

> The function takes a repository, tree object name, a path in that
> tree as input, and find the entry in the tree at the given path.
> Its finding is returned in the fourth and fifth parameters as
>
>     struct object_id *oid
>     unsigned short *mode
>
> By the way, I think somebody forgot to update the description while
> inserting the "struct repository *" as the first parameter and that
> is where the "third and fourth" in the original comes from.

Also as a fix for this...
