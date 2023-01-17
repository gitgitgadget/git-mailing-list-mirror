Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0618C63797
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 15:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjAQPUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 10:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjAQPTl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 10:19:41 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C923EFCE
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 07:19:40 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id p24so33829677plw.11
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 07:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4aSWBaX3H1R5QYnglk4e21Xc+U0JhWeYcllemK1hp8=;
        b=qH0J9MD6/F3XsUwimzLzR6j1Hi/i5lkgROPvz6III+TtC6ekPwAc2xAQ0M/Gddb5wk
         KEdnofYpi2/MF8tMsezXOL167l9JzYyqqfidGNzl7CDU+X82SmE/iurF0m2dGZaE6ls1
         5wEtCfo0nKnrauaOacbFLGfepQf75XVRv0U38CuwP2KmQvBgGITg82U/81z4M2VBswIL
         BoUjsCPQ4OjowWJ5koRCoyYJl8hO6fEJwtFYmxEeP4xntFxUpbkbEZtF6P6/cFLCivNJ
         2fdVrISaV6dRr1knTzWQZ1LS69yA5KJZH+qHR6jxIOJEQhgq12A/yYmS33OB57tcKWIJ
         MUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4aSWBaX3H1R5QYnglk4e21Xc+U0JhWeYcllemK1hp8=;
        b=eWjAMiARfwUxjWx35IRulGB431yU/mPtMu21jHCCrYGvjHsBhuIF6OtmA93Cc68B2p
         TT2qAv4zoCE8KURi9WmmtRIhFOP80VxVIZwpCIyX5W4rimSuGbHDzwQIvK0Zy88TKT3C
         nmYvieKUYWqPFg6tjhXHbUlsGawy9zhoX02A2pqES7urIMFSciaMUWjQjsjvQnVDh+Vh
         G1csX8o8xQkhopuILhwgmVqzIfz6sbAcT8shuPTmVoZNQ6EAMYlBczh4IMN9sLJIvE/z
         6NxIzxQRduTL9/gaDk2Bdg2tqn22tubkoaZ1PpQ4zOmYmVqK+TRkj23EExK0HRnt9sLs
         OXFA==
X-Gm-Message-State: AFqh2kqydO5y0TVnCB9RVbks70Zt6vJJ16W2CQXJB2XwCLRwpoTYDQNH
        Q5myD5uGlLj8e5pImfc0OnTmnQ73nE8=
X-Google-Smtp-Source: AMrXdXtbcq4O4GvObOx2pXUPRfC9b2yT2ynTmW8ZYdp6ZgWDN57WEqSnvykVDNxap3QD/mzl4RorIg==
X-Received: by 2002:a17:902:b48f:b0:189:b4d0:aee with SMTP id y15-20020a170902b48f00b00189b4d00aeemr2403200plr.67.1673968779493;
        Tue, 17 Jan 2023 07:19:39 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a7-20020a1709027e4700b00192740bb02dsm20012529pln.45.2023.01.17.07.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 07:19:39 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, Diomidis Spinellis <dds@aueb.gr>
Subject: Re: [PATCH v3] grep: correctly identify utf-8 characters with
 \{b,w} in -P
References: <20230108155217.2817-1-carenas@gmail.com>
        <20230117105123.58328-1-carenas@gmail.com>
        <230117.865yd5z4ke.gmgdl@evledraar.gmail.com>
Date:   Tue, 17 Jan 2023 07:19:38 -0800
In-Reply-To: <230117.865yd5z4ke.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 17 Jan 2023 13:38:50 +0100")
Message-ID: <xmqqr0vt9oj9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> To argue with myself here, I'm not so sure that just making this the
> default isn't the right move, especially as the GNU grep maintainer
> seems to be convinced that that's the right thing for grep(1).

OK.

> I think calling this e.g.:
>
> 	grep.perl.Unicode=<bool>
> 	grep.patternTypePerl.Unicode=<bool>
>
> Or even:
>
> 	grep.patternTypePerl.Flags=u
>
> Would be better, i.e. PCRE's C API is really just mapping to the flags
> you can find in "perldoc perlre" (https://perldoc.perl.org/perlre). In
> this case the /u flag maps to the "PCRE2_UCP" API flag.
>
> That we happen to use PCRE to give ourselves "Perl" semantics is an
> implementation detail we should avoid exposing, so we could either give
> our config generic names, or literally map to the perl /flags/.
>
> For now we could just die on any "Flags" value that isn't "u".
>
> Of course all of this is predicated on us wanting to leave this as an
> opt-in, which I'm not so sure about. If it's opt-out we'll avoid this
> entire question,

Making it opt-out would also require a similar knob to turn the
"flag" off, be it a configuration variable or a command line option,
wouldn't it?  I tend to agree with you that it makes sense to make
it a goal to take us closer to "grep -P" from GNU---do they have
such an opt-out knob?  If not, let's make it simple by turning it
always on, which would be the simplest ;-)

Again, thanks for a careful review with concrete points.
