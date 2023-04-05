Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAD7C7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 19:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjDETil (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 15:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbjDETiX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 15:38:23 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6DE7AA2
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 12:37:51 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so38356096pjz.1
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 12:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680723470;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTfI/fZISXlpPkW/OBzm8tUQj2Dur1rRA4qGlvG70uM=;
        b=f1+JvFrG4DD6jt/4TOFG1ZgMBT/x/hxOk2oMMZjC09iK/Hc+lFbYdyMimmRxjKxtFl
         wq8+Mu9yV/Sg7igX9TIQ1BCyitEJWo4XyX0caxB/JilRdUhH16GSXEycfie/ouc1DUxO
         Cp3ooHyOM/Zgg69byygJmL7kBrYxawNALNTyEiuJi/fOsX1WPoXIO+p1Vx7T9FzUVm2s
         3vYKG0hzRKSfZdGMvHSW0K7m3YS8M+tAf1cHSBBKlCmVFklW3GII1tKLAqQgxyn5NLtj
         h3VgkIYDneuYMuA8G4miZl2CWEkhT6qGPQxbZxc7DjFZvtrK/XBJ+caX7EgCRV/E9/wk
         s0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680723470;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTfI/fZISXlpPkW/OBzm8tUQj2Dur1rRA4qGlvG70uM=;
        b=286DOUx4SdlpD49p4ob90pUrr8IIkI/jO/71i6NHbtXbaQNh3UowZG4V4Eem/htC77
         THuu8ThAid1IropLhgbLgPKusknc6KkMIw335OPdY2IPlC/6lKelTov3/yN3GP2W1kRa
         /7TVUfaZYjh5huVemSkBkoJI2utGu+z0bEeYLQhVgHdy+U0Uqy5dj3UmuiGpg75LgiI/
         6KBKotwWJEMIOlCILzxIOTyD0WgM3Z8m1gjEfK+DSpRbPH7jRhyhI19+FhhIbUDxf3wt
         TYMvEsd1N753VIbx+pA/iP8h5GjVVojlrIldQOqizTDTNh+E60RdexXqOkLaZqaJQlZw
         vl2Q==
X-Gm-Message-State: AAQBX9eStzyzcs6a3XCpWaN/83v/RCGwK6H5VwID6+Q0VyaaspIbLVKy
        8ufUqqtVO4WsQjsf/mLQyAQ=
X-Google-Smtp-Source: AKy350YXcN80SrkZsGvKU62pKhIdePWRYuIHZk0iDdgSIYaikoeedNI1AvNAT+UloODxJnzxnS4JGQ==
X-Received: by 2002:a17:902:e884:b0:19a:a520:b203 with SMTP id w4-20020a170902e88400b0019aa520b203mr9034298plg.25.1680723470325;
        Wed, 05 Apr 2023 12:37:50 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902a40a00b001a01bb92273sm10432863plq.279.2023.04.05.12.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 12:37:49 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Eggert <eggert@cs.ucla.edu>
Cc:     Carlo Arenas <carenas@gmail.com>, demerphq@gmail.com,
        60690@debbugs.gnu.org, mega lith01 <megalith01@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?Q?Tukusej=E2=80=99s?= Sirs <tukusejssirs@protonmail.com>,
        pcre-dev@exim.org, Philip.Hazel@gmail.com
Subject: Re: bug#60690: -P '\d' in GNU and git grep
References: <2554712d-e386-3bab-bc6c-1f0e85d999db@cs.ucla.edu>
        <CAPUEspj1m6F0_XgOFUVaq3Aq_Ah3PzCUs7YUyFH9_Zz-MOYTTA@mail.gmail.com>
        <96358c4e-7200-e5a5-869e-5da9d0de3503@cs.ucla.edu>
        <xmqqttxvzbo8.fsf@gitster.g>
        <6d86214a-1b80-eb88-1efb-36e61fd3203e@cs.ucla.edu>
Date:   Wed, 05 Apr 2023 12:37:49 -0700
In-Reply-To: <6d86214a-1b80-eb88-1efb-36e61fd3203e@cs.ucla.edu> (Paul Eggert's
        message of "Wed, 5 Apr 2023 11:32:38 -0700")
Message-ID: <xmqqlej6unle.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Eggert <eggert@cs.ucla.edu> writes:

> Here are two ways forward to fix this incompatibility (there are other
> possibilities of course):
>
> (A) GNU grep adds a --no-ucp option that acts like 10.43 pcre2grep
> --no-ucp, and git grep -P follows suit. That is, both GNU and git grep
> act like 10.43 pcre2grep -u, in that they enable PCRE2_UTF, and also
> enable PCRE2_UCP unless --no-ucp is given. This would cause \d to
> match non-ASCII digits unless --no-ucp is given.
>
> (B) GNU grep -P and git grep -P mimic pcre2grep in both -u and
> --no-ucp. That is, they would both do 8-bit-only by default, and use
> PCRE2_UTF only when -u or --utf is given, and use PCRE2_UCP only when
> --no-ucp is absent. This would cause \d to match non-ASCII digits only
> when -u is given but --no-ucp is not.
>
> Under either (A) or (B), future pcre2grep -u, GNU grep -P, and git
> grep -P would be consistent.
>
> I mildly prefer (B) but (A) would also work. (One advantage of (B) is
> that it should be faster....)

For "git grep -P", I would like to hear from Carlo and Ævar; I agree
both (A) and (B) would be workable solutions, and have a slight
preference on a solution that does not add more options that take
only in effect when -P is given, simply because these options are
cumbersome to document and explain, but that is a very minor point.

Thanks.
