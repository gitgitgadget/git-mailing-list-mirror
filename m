Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE07BC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 17:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBFRBN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 12:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjBFRBL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 12:01:11 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F21A2B2BB
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 09:00:53 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id mc11so36022924ejb.10
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 09:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gJuSxUYTCH2vZlSACCaMoFOWMf5Yua3UEbZ7a4+HdiA=;
        b=PZgPEFCfcTTMSKbFHFWIcbFWoL+yLV9osIhk+VPoIAX0JTpLyz2HVpZcBjWkrN0ovy
         arOSGiLh0Y5LXIPrb9BN1jkzNCoVNG/vN+Y6p8+KXMfvRg71uFOP9sCcITeEbUsbPx5Q
         5FcSj/d/L3hGUaWY/A4UNR8N26UgXXA+d8aJMXh/EUFDYlG89ZBfz/2jo3SRJvrX/a4+
         8+0Atrf8LjDrGZhlPDC2SEWkDKG1mUrtoZCtfZM+30s0BmXknmO9O04Rw6I77u5sRSlf
         qzaQChXq3dIeuA+cz8fMKKUoNf1vq5t4ILFF+t9+Ol9Ao1GIdTq4fH3JjKG+lOWLiaoe
         XzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gJuSxUYTCH2vZlSACCaMoFOWMf5Yua3UEbZ7a4+HdiA=;
        b=XIzUxN6XD0HEemsbiJJ4yQ9bLdTBo3XQrPSYZdnls/9NNVJaGhkXrGznKWNBd4v7eM
         XiCncw1N8IYIUVgID1xcIGBAGLMHpVCkpRyf5UESku3+Vuw0me1lJkVZgOZByr104OXS
         aaVvKixn5JbbRIhAX35UgT4zKq8nVeBWf1Q0hwwqKs+UrGd0zzB/7OY3/OTVhH/0oXmB
         5YZD/jBhXvx7GO7khoLyp5YXB9N45VSXgHlO2q91wOcAUYdUCD0R0HSrEMySxrOZlroC
         1crkk4esb+XqZV6xpaBXAyYMWCu6KeUnCUQdbgM7hKrfQOJEpx7UCQFL+36OWkTj/VGc
         M2TQ==
X-Gm-Message-State: AO0yUKXqlYzGPoj0DsKW5+q6TWLAQhW9yqBOcOdYExk+/1tpJPVcVSM6
        6rfRoER4X68s6yH7j7C5UHXpI+yQbas8muk3
X-Google-Smtp-Source: AK7set+b8D79/1fERONgGo9Sgg5YrxolZhIr2ofctVl/W5M/kkznqY4PM0ZEwX4zHbfqKak7Otintg==
X-Received: by 2002:a17:907:8dcd:b0:878:6b39:6d2a with SMTP id tg13-20020a1709078dcd00b008786b396d2amr26056276ejc.46.1675702851749;
        Mon, 06 Feb 2023 09:00:51 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id v17-20020a17090690d100b007b935641971sm5646806ejw.5.2023.02.06.09.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 09:00:51 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pP4rK-000QVA-2g;
        Mon, 06 Feb 2023 18:00:50 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 3/4] rebase: refuse to switch to a branch already
 checked out elsewhere (test)
Date:   Mon, 06 Feb 2023 17:59:11 +0100
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
 <02a15ebb-b927-1048-db2e-576abef9538b@gmail.com>
 <5b0d5b6e-5055-6323-1b6c-fe98137e81f6@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <5b0d5b6e-5055-6323-1b6c-fe98137e81f6@gmail.com>
Message-ID: <230206.86wn4u6859.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 05 2023, Rub=C3=A9n Justo wrote:

> In b5cabb4a9 (rebase: refuse to switch to branch already checked out
> elsewhere, 2020-02-23) we add a condition to prevent a rebase operation
> involving a switch to a branch that is already checked out in another
> worktree.
>
> A bug has recently been fixed that caused this to not work as expected.

Presumably in 1/4 and 2/4, if so saying "in the preceding commit(s)"
would be better.

> Let's add a test to notice if this changes in the future.

I for one would find this series much easier to follow if you started
with this test, possibly with a test_expect_failure, and as we fix the
relevant code flip them (both this and the subsequent one) to run
successfully, and include them as part of the commit that fixes the
bug).

Maybe there's reasons for why that's tricky to do in this case, so
please ignore this if so.
