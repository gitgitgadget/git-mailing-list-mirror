Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1862CC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 17:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjBFRSO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 12:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjBFRSN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 12:18:13 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398AB17CDD
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 09:18:12 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id q19so12425615edd.2
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 09:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t944XAWXU25lBuU7zB/C6OtKm8HJ7qpaaQwSAJnK2WY=;
        b=UJJzdDemW8T1RAxFPzA4eB98kGXZxKypFqXGkjUsiRwJZPrw66YDRcWUqDrE4FDZYR
         KgxJoO16/7MYitaOautfQ++aEiDHXn2iBcz+2mlrfP6kQJ7U0nSrbbJOxxz84HifT+S6
         +JrsDAPVF0b2yLbs0sTVf6dgOWvKnOZeDeaaMyYEQHgT7DYtC4U3lX7g2fCExRGVe+vz
         FgX9iNnxPVKYkOZdRrSdqtWmQkNZ8opaIh/PecrhloksbHmz6eRAXDAd7U5OYaW4Z9se
         RLNcHH/o06JYXtWAmtE/9wTeV1TgrTQNVeB/RR5hnqtU1aM5R+O7e34/DGNjEshrg47C
         TR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t944XAWXU25lBuU7zB/C6OtKm8HJ7qpaaQwSAJnK2WY=;
        b=5uRAhT8YltlgiFL4dsX34hBOooQ3+eN1J80eOL0f96gNwAUEqbceWzspQKOUo1YF9q
         /BoIK5DG81XIbDvRTVin0uHPEJNS8fO448ajAENSOx+NcjWNjAkJ8ykliMaOdktdGHUG
         SW8GInzQ+wBUESTMFBZMtbnu3ciWQ3wDmAEz0t8bSrpggHJCIYGZkW9P+fZqhsOPV2yz
         qCULk1UJuotjDUuNQP530EUz3uVVYxak0lpfejCZx2HkFlEfyMvVsHTMNLEUGgJVjmxY
         QlugvnwgSUEN8kIBfWxbSGothLC4E7suIva+D++TXVKchlF9EBx2QpDbe8+gCEmzVhnW
         2RkA==
X-Gm-Message-State: AO0yUKVR2EXfSphne/pKa3O6fsPrfO2TmhGiUMg53xkocLBU53HmBjcU
        dCXywG6D4aEJdGweZOpz5Uax6ZupMCeh0CDK
X-Google-Smtp-Source: AK7set/of846QpQAxGHQJ0GJ7rF3catc+aYz/N/6S5Gc83OKf/ys8HSn2dnQfdCHcQQso2EAKkwA2A==
X-Received: by 2002:a50:a6dc:0:b0:4aa:b241:f6e8 with SMTP id f28-20020a50a6dc000000b004aab241f6e8mr278895edc.23.1675703890783;
        Mon, 06 Feb 2023 09:18:10 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id u26-20020aa7d55a000000b004a0b0cd2e45sm5355275edr.75.2023.02.06.09.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 09:18:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pP585-000R4p-1z;
        Mon, 06 Feb 2023 18:18:09 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v6 18/19] push: refactor refspec_append_mapped() for
 subsequent leak-fix
Date:   Mon, 06 Feb 2023 18:16:21 +0100
References: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
 <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
 <patch-v6-18.19-aa33f7e05c8-20230202T094704Z-avarab@gmail.com>
 <xmqqk00zsoqh.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <xmqqk00zsoqh.fsf@gitster.g>
Message-ID: <230206.86sffi67ce.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 02 2023, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> The set_refspecs() caller of refspec_append_mapped() (added in [1])
>> left open the question[2] of whether the "remote" we lazily fetch
>> might be NULL in the "[...]uniquely name our ref?" case, as
>> remote_get() can return NULL.
>>
>> If we got past the "[...]uniquely name our ref?" case we'd have
>> already segfaulted if we tried to dereference it as
>> "remote->push.nr". In these cases the config mechanism & previous
>> remote validation will have bailed out earlier.
>>
>> Let's refactor this code to clarify that, we'll now BUG() out if we
>> can't get a "remote", and will no longer retrieve it for these common
>> cases where we don't need it.
>
> Another thing this does, if I am not mistaken, and the above does
> not mention, is, that the old code called get_local_heads() for each
> and every ref from the command line, and the second and subsequent
> calls to the function and assignment to local_refs would leak the
> entire local_refs linked list.  This step does not release the
> linked list at the end, but at least it stops leaking it in each
> iteration of the loop.

I think you're mistaken, or I'm misunderstanding you. For e.g. the 29th
test in t4301-merge-tree-write-tree.sh where we do:

	git push read-only side1 side2 side3

We'll only invoke "get_local_heads()" once, not once for each of the
refs. That's part of the reason for this refactoring: It *looks* as
though we might do it N times, but in practice we always get hte
"remote", so we only leak it once.

