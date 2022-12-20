Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8D3C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 00:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbiLTAUV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 19:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiLTAUT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 19:20:19 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E8515816
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:20:18 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id m4so10656500pls.4
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=occRr38n2LZoGau6favahvH4TdJwygMah4Mo7JpTAhk=;
        b=AVSgjDDDiUbbYIasWTg3JOli7qIDJrL679FMk0uLjoXcNcybHRrPboj4wRupoG9aT8
         vRPwcbBfemgfWadu87KU3+YAKY2NYcGm5OhJiI049C53PJOBcWcVDYO/dFI9FHd5xDxM
         au9oE6fpW/1QTqvjAbqqBSqMUEq3kaUYdNjhyPcHtny+P7fvYORdcREzaKhw7zwCR4LV
         OcFa6tNWFAjjd3uWJMhfN4GCyFvuv8Bq0pY5UZolqStenE2LbnhBSVpCQ6yZwmSNNeSA
         hcBhpefcEMxZud/GZIgCEz5iY6slEd/E/fp803HKnDhJ9DH8DvtFwXoDfx8fKk6S4uXR
         RWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=occRr38n2LZoGau6favahvH4TdJwygMah4Mo7JpTAhk=;
        b=WDPhDEGdTxlQxC5Lrd4xFxfLpNZ2VpoDGCdf290Avac91peswS88uY/HxGTYbbJo0L
         aYx6Dn3Kkh5uLVKvniwuA119YmKco1CagIICbi7/8QT3KqfLxkBpWn8yMA1IVn7ACUJq
         PxJxDQcwXI6/SFY8wSddsO87oBCX75wZpr5tkGVJHl80e09hbhP5jpk7WhAnqddU6mBr
         0vrCUOV5HwYSvxg7KBAZmoEbceHYu5bCiGkT+mPDz7M4dc1EYdeCFGeHnsYo1yAw0x5F
         AVnlGrdnNAHMIdFVjerv4xdg+59INd0C2f7E32QyIwxMYglC7vxj879Zq3uXCg4fdUGF
         uG+Q==
X-Gm-Message-State: ANoB5pmOOwS39QIGgRFsMnEGKUFqGJSqtqiayX+XuOJKIogooej98y/b
        8XboIaNKve4qKUP6UdBrmYEQrQDkqq0APA==
X-Google-Smtp-Source: AA0mqf414cne6ntaByXTM2maAdTOSjVAKkAJ4441/rRS8U+10DApTUiwcAMly2JRh1mtghPGug+Tfg==
X-Received: by 2002:a17:902:7247:b0:189:d780:b98f with SMTP id c7-20020a170902724700b00189d780b98fmr46675903pll.35.1671495617874;
        Mon, 19 Dec 2022 16:20:17 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902ca1300b001896040022asm7812186pld.190.2022.12.19.16.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 16:20:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 3/6] tests: don't lose exit status with "(cd ...;
 test <op> $(git ...))"
References: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
        <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
        <patch-v4-3.6-f5b2489609c-20221219T101240Z-avarab@gmail.com>
Date:   Tue, 20 Dec 2022 09:20:17 +0900
In-Reply-To: <patch-v4-3.6-f5b2489609c-20221219T101240Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 19 Dec
 2022 11:19:26
        +0100")
Message-ID: <xmqqsfhb0vum.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> -	test "a" = "$(cd repo && test-tool path-utils prefix_path prefix "$(pwd)/../repolink/a")"
> +	echo "a" >expect &&
> +	test-tool -C repo path-utils prefix_path prefix "$(cd repo && pwd)/../repolink/a" >actual &&

If we fail to cd to 'repo', "$(cd repo && pwd)/../repolink/a" would
silently expand to nonsense, but presumably "test-tool -C repo"
would fail loudly in such a case, so we should be OK here?

> @@ -28,9 +32,10 @@ test_expect_success 'preparing origin repository' '
>  
>  test_expect_success 'local clone without .git suffix' '
>  	git clone -l -s a b &&
> -	(cd b &&
> -	test "$(git config --bool core.bare)" = false &&
> -	git fetch)
> +	echo false >expect &&
> +	git -C b config --bool core.bare >actual &&
> +	test_cmp expect actual &&
> +	git -C b fetch
>  '

I am not sure if the above with full of "git -C" is strictly an
improvement over

	(
		cd b &&
		echo false >expect &&
		git config --bool core.bare >actual &&
		test_cmp expect actual &&
		git fetch
	)

and even if it were, the reason why it is better would be vastly
different from the reason why it is better that we no longer do
"test $(cmd) = false".  I very much hate the pattern described on
the commit title of this step (which by definition this patch fixes
many instances of).  I.e.

	(cd ...; test <op> $(git ...))

might be something you find that needs improvements, but "don't lose
exit status" ONLY applies to the "test <op> $(git ...)" part, and
the other half, i.e. (cd ...), has nothing to do with "don't lose
exit status" badness.
