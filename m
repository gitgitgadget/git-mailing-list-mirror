Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D62C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 20:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383071AbhLCUVP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 15:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbhLCUVO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 15:21:14 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE18C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 12:17:50 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id r11so15894403edd.9
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 12:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=R0AvS4p5qMRFy9o/v8zsBt/HLq+vKxxapnEL8AUV8C0=;
        b=XgeEUFs3gEbEjiM8gqWqCJXnvj+RFNJAYT97qp8NoSqceFvZoZrPZjN/U6PLeSZcBy
         nZ05WwuiodBiKXMjCE6Eg/+tHOXHgd2gcqaUfmnjT6Kumse22/15baXQC8cYTv0FFbdK
         V7z5UakHFuOHl7gSOLmTAxsuC6cvutqGV9cRiweo/Q4ZIPob3VQ47B/IYhi4+06ilCHY
         zMRzKecRC2b40CKMxnNQkr3DdmCSPmOqIlheM9IKdUmUtPjBO5Nb57LhZDOTZ1lxv4p/
         sK2v7KrhmRzW52Yp4ALkceDDV+nWT8X8cAvUfPDUO7TZzV4JskEPuL978Tl9eKiCxm3K
         959Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=R0AvS4p5qMRFy9o/v8zsBt/HLq+vKxxapnEL8AUV8C0=;
        b=zXyHETFy3DF9SINQ3eF0UdIkdZRmMKx1HXAua3Tdtkpnrvw15wPDtOf9twnB3sX7jk
         Tl/XNZdsCQpVUPfKd0ocjSKxnO/aduKOJcCwDmrdGrBnQgEy7n3RYS2m29ZIrnSQ8UBc
         vVDw9zph/BIVPpclJcoKmKrIZB+2iJ7b0fJTBtjU5UrWJLL+3jNhtgzyD/gpEvT4UsMW
         5Dvbams1nqNyq7JJ0LcDKUiN1tyAghUXDllpBRG6nCbEA1KxuVuw+2bZZGunlX3LTMXm
         f0ZooQWhTEWo6yK6InQDWiT9P1/vC3il4Lg00jggvtrZa5TLGdlnPJq8XSVHQdQ+QRTP
         DLJw==
X-Gm-Message-State: AOAM533MOFe2k1tBbcqqCWHqVpluH0HYyhPESeolKX3L2fCQQvQmR8OG
        NssMcfJ2XkFfOpyYfTai9KrOdBYADkAUgA==
X-Google-Smtp-Source: ABdhPJwFViEcr2Yi9cEs0m60Z698EO8NGx3OEc/zB+96VYBw+qNNTyDE3N2lop7PEMJuVyTHKMh/7g==
X-Received: by 2002:a17:906:f748:: with SMTP id jp8mr26772424ejb.513.1638562668945;
        Fri, 03 Dec 2021 12:17:48 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r3sm2552099ejr.79.2021.12.03.12.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 12:17:48 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mtF07-000InT-GT;
        Fri, 03 Dec 2021 21:17:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        christian.couder@gmail.com, git@vger.kernel.org,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: Re: [PATCH v3 0/9] submodule: convert the rest of 'update' to C
Date:   Fri, 03 Dec 2021 21:15:42 +0100
References: <20210916103241.62376-1-raykar.ath@gmail.com>
 <20211013051805.45662-1-raykar.ath@gmail.com> <xmqqczo8eahl.fsf@gitster.g>
 <YWiXL+plA7GHfuVv@google.com> <xmqqfsr9secx.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqfsr9secx.fsf@gitster.g>
Message-ID: <211203.86o85xqw7o.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 03 2021, Junio C Hamano wrote:

> Emily Shaffer <emilyshaffer@google.com> writes:
>
>> On Wed, Oct 13, 2021 at 05:05:58PM -0700, Junio C Hamano wrote:
>>> 
>>> Atharva Raykar <raykar.ath@gmail.com> writes:
>>> 
>>> > I have attempted to make a version of this series that is based on that topic [2],
>>> > and added the superproject gitdir caching code in C [3]. It passes the tests,
>>> > but I am not too confident about its correctness. I hope that branch can be
>>> > helpful in some way.
>>> ..
>>> The "C rewrite" of the code [3] that unconditionally sets of the
>>> submodule.superprojectgitdir varible seems straightforward enough.
>>> 
>>> Emily, how solid do you think your "superproject aware submodule"
>>> topic already is?  Would it be stable enough to build other things
>>> on top, or is it a bit too premature?
>>
>> As of the version I sent today
>> (https://lore.kernel.org/git/20211014203416.2802639-1-emilyshaffer%40google.com)
>> I think it is stable enough to build on top of. There was general
>> consensus on the semantics of submodule.superprojectgitdir as it's sent
>> in v4.
>
> Does the above statement still hold true today?
>
> And more importantly, Atharva, are you on board with the plan Emily
> suggested to have this one built on top of her series?

I think the current state of it is that Emily & I were having a
discussion about the semantics of that series. See [1] and [2].

That's still outstanding. I.e. I haven't been able to reproduce cases
where we actually need this caching for performance reasons (which is
the reason it exists), but even if we end up keeping it I'd think we'd
want something picked from the RFC patches I sent[1] to test the
"caching" v.s. "non-caching" behavior, and assert that they're the same.

1. https://lore.kernel.org/git/RFC-cover-0.2-00000000000-20211117T113134Z-avarab@gmail.com/
2. https://lore.kernel.org/git/211124.86a6hue2wk.gmgdl@evledraar.gmail.com/
