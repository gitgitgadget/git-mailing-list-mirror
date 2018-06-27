Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1D9B1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 22:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbeF0W4d (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 18:56:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34115 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751614AbeF0W4c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 18:56:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id l15-v6so19185807wmc.1
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 15:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vc0Ld6Qc6BsPjRNU1Y7WI3pRfT2rxK2QEcnimHv/npA=;
        b=G9ruys0tJSWiOwK6SXjlbe+7r5U6DwYMQ4O/j09YXsFA1DORBgg19aGq1CW68q5OAd
         cm1xHtPAHdFmitsQSoG840hqbK+o0W4OQeY5Y6J+4K2adG5BJO/tgJGaufoDitRlRPI+
         tTV5kgEpHM/LZk9BoiQWAgVyBsGFAlsoG0Brp+y2HCWxZnR/Wyx13j0khljK50MRRg8r
         83VY2AE7ReK00usz38Qw92HVbHFtcp23U8xxEoeBTTUX5Bo5FukBtFeWavtfe7xdrM2a
         DUEaApGsqwrBM1pUzKl7gv97QQHJYh0zeJ0VflUAD/laUw/ivTnZPozMCu/JvVLhCZYf
         l8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vc0Ld6Qc6BsPjRNU1Y7WI3pRfT2rxK2QEcnimHv/npA=;
        b=sK4Khquf8qV6pC3Ru/Wl012TMa3ePKaxkePYmHblBTfDKl37jGlPO8c2vslYUpP4bl
         yQyJWCC2L94SBnK2h2jEaPArGkzMvQo1B76Vso/wd2870pkb8PKQhRpHsvJ16EzR8jo4
         Vpw4uhKkg998P8VBfGSSkpaVGP2vdcsIKGLPH+qjkJqa1BF9IvXrEnEv2YAJ4uqQo/9i
         TiWSNyMOofGkwiE5eBOr8m0B7hIuaLSn9emuU3I3XcGAvb55zgFgwI2qaIbAwHnS5ypl
         Qxo3lJzMfb2XXRDGJ7hFZVTxsT67b6aUUoC87n8T+F6tJHdcfnf2wXdxXAIIGGOh2bYN
         GzHQ==
X-Gm-Message-State: APt69E1+dvSN2/Cq6ZRbkXXwKx2qW65tVo8NGhgpgHsLY4j9S2RdIGb9
        7rzqVVIMTkkTHQ0yu/aEOAaoBem7
X-Google-Smtp-Source: AAOMgpfoSWArtL9C8ISKkPIDscNwP4QzwAAQBnKIg/Vqd0BIn18t/u9OrPMccrHbJj76Mv4LSgm+dQ==
X-Received: by 2002:a1c:8e54:: with SMTP id q81-v6mr243450wmd.135.1530140191109;
        Wed, 27 Jun 2018 15:56:31 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z5-v6sm4509339wrh.10.2018.06.27.15.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 15:56:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch: when deepening, check connectivity fully
References: <xmqqin64dmui.fsf@gitster-ct.c.googlers.com>
        <20180627224033.150025-1-jonathantanmy@google.com>
Date:   Wed, 27 Jun 2018 15:56:30 -0700
In-Reply-To: <20180627224033.150025-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 27 Jun 2018 15:40:33 -0700")
Message-ID: <xmqqwoujdejl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Hmph, remind me how old and/or new shallow cut-off points affect
>> this traversal?  In order to verify that everything above the new
>> cut-off points, opt->shallow_file should be pointing at the new
>> cut-off points, then we do the full sweep (without --not --all) to
>> ensure we won't find missing or broken objects but still stop at the
>> new cut-off points, and then only after check_connected() passes,
>> update the shallow file to make new shallow cut-off points active
>> (and if the traversal fails, then we do nto install the new shallow
>> cut-off points)?
>
> That is the way it should work, but after thinking about it once more, I
> realize that it isn't.
>
> opt->shallow_file is not set to anything. And fetch-pack updates the
> shallow file by itself (at least, that is my understanding of
> update_shallow() in fetch-pack.c) before fetch calls check_connected(),
> meaning that if check_connected() fails, there is still no rollback of
> the shallow file.

Ouch.  We need to fix that; otherwise, a broken server will keep
giving you a corrupt repository even with this fix, no?

