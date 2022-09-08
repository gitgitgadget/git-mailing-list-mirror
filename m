Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EE7C38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 16:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiIHQl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 12:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiIHQlU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 12:41:20 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE8AF1F0D
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 09:41:19 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id 9so15232919plj.11
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 09:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=835kdgRacBbJA5/uNJ2+P6Z0tpaE4IUEoxHN03n8IDk=;
        b=PTOZ+eLTRIiIuwuoBTxKiTUZxgH/k4lv25sDq96LlMoTxO4RXnGvuj46WSF5HEMn2N
         +8aq8J787sCde8EeNQ/MJz0X57a2kV5TFUtpM+7IJcpD0aDDryKBpHJ6x4kEKzChFr2K
         SltTXU2LxGxT9oBVGB+lp6/0xNTftmbYaBKvHXs4XS/hmGUMf2zOtId4Mw6zPPTFwtWj
         fWLRxmoVNvqX9XHTHZOuM3HFRwutVvZ/OonzFku3Jcwk28FYcKmXhl5H7+7inYm3AT5/
         anNFkw48kskaQHFdZkdCRtkBW8k2C1+r2YZPVqwCI/QAsPz5be+FAxdCmGz5Afkh585S
         ZF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=835kdgRacBbJA5/uNJ2+P6Z0tpaE4IUEoxHN03n8IDk=;
        b=oIQk4roTX+arLrCdyhqWCqb8W8ZkLMN+LcNq3etrb9W0ZPm/s2yET3fPJYTujN+qL1
         sKEu4HrjA/IE3eGAz15BQUJTlMWrYBFJ7/bDwvfTi3HmzTuKB/I2TexbIt8Uks2d16PZ
         dzfqspa7gQEJh6e1pwxWcDJziV+nsklmYpQNMUMvH5aDLWDqJIgFDy3zLCo41+xz3ewu
         U6JlQl8H0YpJyCEcE/CdacnYwA8DOuD7Z5e4CMK2uOWe6ydw9mNAqhkhhavyD7UPGXcU
         3lAM9AcJ0YwBdBOooRvaY/GYJPghdf6RBakdEX2cu4mCfonr517KEN/UluPJuR+Yt/8f
         HPdg==
X-Gm-Message-State: ACgBeo2SiwajnzUTnvt+Dw12ZbFIM1/QQozseTckfKMEM4I8zVnwuG78
        y1fbQ4TKHei6eOx3dwwZoGc=
X-Google-Smtp-Source: AA6agR7keRH+M73IynEumxnJHwwxcpT4Jai45eRpsCteLU6A8E+mujt18BnRLx/wV+F5CqpOO1Aytw==
X-Received: by 2002:a17:902:dac8:b0:174:cf17:6e93 with SMTP id q8-20020a170902dac800b00174cf176e93mr9995246plx.93.1662655279103;
        Thu, 08 Sep 2022 09:41:19 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902bd4800b00172c7dee22fsm8785789plx.236.2022.09.08.09.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 09:41:18 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 01/34] CodingGuidelines: update and clarify command-line
 conventions
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
        <patch-01.34-b8cbd443987-20220902T092734Z-avarab@gmail.com>
        <xmqqedwnszsz.fsf@gitster.g>
        <220908.865yhyl31c.gmgdl@evledraar.gmail.com>
Date:   Thu, 08 Sep 2022 09:41:18 -0700
In-Reply-To: <220908.865yhyl31c.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 08 Sep 2022 09:46:55 +0200")
Message-ID: <xmqqzgf9rf81.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> "Other than that" as in "let's fix that phrasing" or "let's not have
> that concept as part of these guidelines".

"Other than that" meaning "I do not know what exactly you meant
about the 'inside of', so I do not think I can tell you to get rid
of it altogether or fix it in some way, but other things looked OK".

I think "( -q | --quiet )" -> "(-q | --quiet)" is a good idea.

> I think the phrasing obviously needs to be fixed, here I was just
> attempting to cover a blind spot where the guidelines said nothing, and
> I picked whatever was the most common convention (as the rest of the
> series shows).
