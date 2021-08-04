Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8005FC4320A
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 09:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59CED601FC
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 09:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbhHDJ5x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 05:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236659AbhHDJ5v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 05:57:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65B3C0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 02:57:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id c25so2890395ejb.3
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 02:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=fK/fkhFILSR3hJ8sezfIuCxuPLs+yRMu9C2ngIhpvrU=;
        b=S+UePvjIUw04tvElc/U4nY8uBqo0IdoEMEIqATmPLyxgXi7Zjpb4v6QIVcUHYqGChx
         hbBC2681DoHxlgiTr398pasurOl1SydjC8ZXhllRHLYpKhTH2oAIcXoAeNf+eUb0LGFs
         lXIFB26eG1SM/LQEHpo0N1qOfiVR/a/Qav0BNC3i61whmETYEE84Ozfx/no51fjjXPtx
         rOkC+fKi0Ym2dOOJUcadA0FhBnrIdr5JQFa4EgO7wmyncqpi1SqmEeVJCScuXIqnTDD0
         HG6dAN3GjftviCYAiKLCUhFtbAfTaMha240jl3mJ8HfhcoLWlwCdgYJar6+RPyQ0rPjL
         gu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=fK/fkhFILSR3hJ8sezfIuCxuPLs+yRMu9C2ngIhpvrU=;
        b=KhqsqJxSZnCCf66DCpXh4drSDbtcn72dVQE1Rod+hemWWAv7gGeDw0qt4wGPhJKEnB
         QEhixmWbnh0Cte6eR1ssjrCLcU0Gm/S2u34xXvYgKAufW1h+LFZ9So+HWZLoCrCRA/8C
         O5a2SpbS5lss6hW9J4dgFskeTKHP7SUvc3yxZgZFUFK2Q3GcrTIJqZSEG5/tpyOeGsG+
         xmQNG3+lQBtTnRV8QrwO8s43xWjxEs+htmkjiyrF5cuZ7ICX4W/gRaL0Bvgq1CMmIqiY
         FrTpTbJm9ptvUrlXezUylCr5A+KUAnPwGFV5TbJZ5VeieCEFDve1sL6c6QmAzvW8ElNj
         6wXA==
X-Gm-Message-State: AOAM530MeGLK+gSIA69NE4J+cIIniWHKa3tYnM/HlVZVcc6D6kI8TdPu
        AMjUvnE6aY/OjXN9tiGYNQNJGHJxLNRpwg==
X-Google-Smtp-Source: ABdhPJxd6iMSrGNpZqMNI97SvGGDGlJlx6WCnPkywsqrw5QtV+Fk3B6nAJt2YnKeT+6W5BWUv2uPrg==
X-Received: by 2002:a17:906:b00c:: with SMTP id v12mr24548663ejy.222.1628071057405;
        Wed, 04 Aug 2021 02:57:37 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ca4sm528354ejb.1.2021.08.04.02.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 02:57:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 08/11] reflog expire: don't lock reflogs using
 previously seen OID
Date:   Wed, 04 Aug 2021 11:56:58 +0200
References: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
 <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
 <patch-08.11-c9c2da3599-20210726T234237Z-avarab@gmail.com>
 <xmqqeebbwyeo.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqeebbwyeo.fsf@gitster.g>
Message-ID: <8735rpo7lc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 02 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
> [...]
>> @@ -3111,6 +3113,7 @@ static int files_reflog_expire(struct ref_store *r=
ef_store,
>>  		}
>>  	}
>>=20=20
>> +	assert(!unused_oid);
>>  	(*prepare_fn)(refname, oid, cb.policy_cb);
>>  	refs_for_each_reflog_ent(ref_store, refname, expire_reflog_ent, &cb);
>>  	(*cleanup_fn)(cb.policy_cb);
>
> The preference in this codebase is
>
> 	ptr_to_function(params);
>
> over
>
> 	(*ptr_to_function)(params);
>
> Once it is written and committed, it is not worth changing, but just
> for the record...

Indeed, in this series I don't touch that (except items on the argument
list), so refactoring that just for changing the syntax here didn't seem
worth it.
