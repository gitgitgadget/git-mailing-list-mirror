Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167D6FA3740
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 19:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbiJ0Ths (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 15:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbiJ0Thq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 15:37:46 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631B0635FD
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 12:37:45 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id 4so2669097pli.0
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 12:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EoyybQw7Xo68hHZb5V1oKo+P5E+do4xM5X/6qiv61g=;
        b=MSwG+FMWY8VcTTZ8YEPTFGizCE3EZ2R+7IubuD4CNc4Fa9Nsl9SbVO34T6o+AW9gFZ
         SRoLjx/rKlQAhJNr6YoWs+8dExmQq4VoYkawiNtM+SIVhBDsQH73kGJU+IlrY7ev2AH8
         4dFz6RzUqRA1XjyQD8eS5Goy5qlkulzi7PMm3l61fMs0c0LRcjPapR4jNa9hotsZCYco
         gIK2u4m9fg0yHjapES3mUUXQtCPlx9PIz7Mo7VcsAd8k1Bh0SPrubcg/k6oIzI+SPnvy
         2kaNgZ6Wi43xZ/NGP2z/INV+23MICGJpQ7IjirlcsdfixYJj3J9c2a0xaeZNX8lo8yFj
         WoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7EoyybQw7Xo68hHZb5V1oKo+P5E+do4xM5X/6qiv61g=;
        b=i102OjUtL6LDTLixbN40/JrjT+ddJp1Cy5cf19rZQQXeOKNwJDPAm+ssFVqw3Szg3p
         SiCrSqtiLI67s4g3urDIf/mnC1PF1OH1BWvVlPsxV7RgNywN4HQx79B4wbfWz4axnCa1
         igHfxI7BMWC1T55HkjvpxqUylwk6T/1DAFmpK2tNFSdtqeYSaFnwDvW8T5nXM5uHVpLg
         eVKwUvgEucOg4U5kpmaMpqEFt7Zm+etb8gGdDlArCcaGh3UZR955Ocbtoiqq5meRyn+y
         d7YZLQa+PZsT6T+eBRJTQG9mlbINgLIoWj9YmuI3ePQrSFRqQB59ayUOItmhN7nnlJP4
         Tl1w==
X-Gm-Message-State: ACrzQf3HGHX8eJeaPn4J8thglkE7OCauYbR1Nhp/AgFKQVWn/cEfSNrW
        dvG8+nFskvpqtWESjfIFrU8=
X-Google-Smtp-Source: AMsMyM7YwwlwjQtwkle7ASBsQKU46ZgG5ZxeXodNyHtLxOnALruV582sTNRyfq3q3eIgrWe9Xj2mFA==
X-Received: by 2002:a17:90b:f06:b0:212:cb07:fb82 with SMTP id br6-20020a17090b0f0600b00212cb07fb82mr11619110pjb.221.1666899464754;
        Thu, 27 Oct 2022 12:37:44 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m15-20020a17090a2c0f00b00203ab277966sm3035360pjd.7.2022.10.27.12.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 12:37:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH 06/10] builtin/gc.c: use
 "unsorted_string_list_has_string()" where appropriate
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
        <patch-06.10-9c36f17481b-20221026T151328Z-avarab@gmail.com>
Date:   Thu, 27 Oct 2022 12:37:43 -0700
In-Reply-To: <patch-06.10-9c36f17481b-20221026T151328Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 26 Oct
 2022 17:35:19
        +0200")
Message-ID: <xmqqh6zpkqgo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Refactor a "do I have an element like this?" pattern added in [1] and
> [2] to use unsorted_string_list_has_string() instead of a
> for_each_string_list_item() loop.

In the longer term, I am not sure if we want to keep such code that
uses string-list as a "database to be looked up with the string as
the key".  I am not sure it is worth our review bandwidth to change
a for-each-string-list that terminates early to its shorthand
unsorted_string_list_has_string().  Surely each such conversation
would allow us to lose 4 to 5 lines, but longer term we should be
discuraging the use of unsorted_string_list_has_string() in the
first place.
