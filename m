Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBA2C636CD
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 13:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjBGNyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 08:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjBGNyF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 08:54:05 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D55FF4
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 05:54:04 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id m1so825947ejx.7
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 05:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b8rCc9uilHZyXF0cLovu/wn3OAT9xCdxAzPKRNAkADs=;
        b=LnHla4weIT/1NUPGC8hs1pO37TLa1laXjLEiGvQFsRHk7V+e4W58OBD9EnqWGjckMi
         YGxJ0mV86htxQJQm10KL/l5ZcsZh/gGeGxGI30JvUsW1YiWa80CzS9eeoVXDM0liFdOr
         Xr+vBxOwse1WQ2ggQEQwA7wB0MuUVuxlNiRg1nke7dgx39v54XG3pZFsZokLy+PnDssn
         M6pRv/XJONHe/wdtPb8b2zoneEaFFjj/Lc6dQYcNKnKbrp7HwfPQZBosO1vE+TJY/aCA
         5nEDS5PbgjMHL7/MLpm27O3NgSjR6ea7r/47lAWpNTymKKSyLDbmr/Vey8W+aBi61PbS
         Hy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b8rCc9uilHZyXF0cLovu/wn3OAT9xCdxAzPKRNAkADs=;
        b=KiFBnkh2eqsbk7JD8MZc0bWII0+A8wye6WF3RbJ6ihHpgsj0LwK9qat77uXut2QaAm
         t8p2MBgVrI3DLcEfoOfDhDqlYucqHh95VI1gqnZa2KRGzhFfhomaIoZi9t9xcK/tJGI2
         3MLiYz3IqSyj1FowKptTm/DbviH0AKjqPo8QN5un00h5nsc5xHemKj04xJ3OFuZQCrum
         LgNzIxdSA/UF//+0E+gyfkrjJvo31F2BS9MxIsfHbJwOkoo5FaTknAoEYZfFv5zMvk/6
         aLul1RifvuasRDwEG8SRyACtIuWcU5hvll0ljayHd20e4mQLU1pQj73ndVBmF4AFLI2s
         0tPA==
X-Gm-Message-State: AO0yUKWDSSpykN53x9x5eEZCTKhQoiGk6JafYR+OjILA+uvgV5q8AYxC
        W7CcfJlsvvBXhgrMTnujmLVOUDGMfyGc16Zg
X-Google-Smtp-Source: AK7set8ntn4/dos+2fasYiYeRCXm+wU0b/I+rWdyBbbgBwCjK5vk6XAf3xOtxUSIHQ8ZWGrPyqDYjw==
X-Received: by 2002:a17:906:5013:b0:89c:7298:2df0 with SMTP id s19-20020a170906501300b0089c72982df0mr3463508ejj.23.1675778043082;
        Tue, 07 Feb 2023 05:54:03 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id l21-20020a50d6d5000000b004aab36ad060sm2578041edj.92.2023.02.07.05.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 05:54:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPOQ5-000npD-2s;
        Tue, 07 Feb 2023 14:54:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] branch: fix die_if_checked_out() when
 ignore_current_worktree
Date:   Tue, 07 Feb 2023 13:58:26 +0100
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
 <02a15ebb-b927-1048-db2e-576abef9538b@gmail.com>
 <8670d6c6-b5cd-a1e3-8fbf-b948cb687388@gmail.com>
 <230206.861qn27mt9.gmgdl@evledraar.gmail.com>
 <1da499d6-3de3-ba34-1ca0-6f39e528b80b@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <1da499d6-3de3-ba34-1ca0-6f39e528b80b@dunelm.org.uk>
Message-ID: <230207.86wn4t37k6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 07 2023, Phillip Wood wrote:

> On 06/02/2023 16:56, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Sun, Feb 05 2023, Rub=C3=A9n Justo wrote:
>>=20
>>> -	wt =3D find_shared_symref(worktrees, "HEAD", branch);
>>> -	if (wt && (!ignore_current_worktree || !wt->is_current)) {
>>> -		skip_prefix(branch, "refs/heads/", &branch);
>>> -		die(_("'%s' is already checked out at '%s'"), branch, wt->path);
>>> +	for (int i =3D 0; worktrees[i]; i++) {
>> I see that there are existing "int i" for counting worktrees in
>> worktree.c, FWIW for new code I wouldn't mind if it's "size_t i"
>> instead, to make it future proof (and to eventually get rid of cast
>> warnings as we move more things from "int" to "size_t").
>
> This seems to be different from the usual worries about int/size_t
> comparisons/truncation. worktrees is NULL terminated so there is no
> signed/unsigned comparison here as we're not comparing it to
> anything.

Having looked at this again I think using "int" for now is the right
thing, sorry about the noise.

> The only concern would be that there are more than INT_MAX
> which seems unlikely.

My general concern isn't just with the code that we can prove doesn't
overflow in such cases, but that by having different types for such
things (which isn't the case here, I thought our "struct worktrees **"
would be alloc'd with a "size_t") we end up with coercion warnings.

Those warnings are so prevalent in this codebase that we've had to
suppress them, and consequently we make it harder to spot the real
issues.
