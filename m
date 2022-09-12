Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EFAC6FA83
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 23:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiILXzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 19:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiILXzF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 19:55:05 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C24513F93
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 16:55:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso9686900pjm.5
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 16:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=lzoS7d5effKKq5QcIwKHWovaa9Y7zf7U20zdL55qhDA=;
        b=luXSdSMMajIBvuthnsCdC+Atk8Oj+gbjw8cCyEqFluefGWbujBi5AqSZGfDmswI2P5
         +7Nt/W5NXGkktCPAztfcikqEZQ2w7rD3iS1cRqXkoNaPsnrWOFbB9y+OCKairw3rSF0h
         KTz0r1VRoyfXUoQwk/kh4yuOWDy78B7MqU7EuIwZfCxLrvgcdR07xW18mx//ULaiLO6l
         cg/Qe06jntcgFg7kUT6A73ATV5WBgRRa7QRijUGoydgeI36Br6qVTnQrhGuLRMJ1BvYf
         jKZ0nCOmtlevp4ymj8sw+izMlwWGgHEf/opWF05ionE+5q9oOWT/hrI94vHjyT8LoNdR
         3SOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=lzoS7d5effKKq5QcIwKHWovaa9Y7zf7U20zdL55qhDA=;
        b=Bf2z7/VmSApMUZz0Ey4NRRK7MtJxk3FeBXdQ5nJXCd6ZIhC7XqihUQUhZGbm+mQUYW
         cWzK7H2E0JXNg/yAjLq+IZzXVpAnzQzK4W+Pbuq49svB+7Fpb65kV+ajYSv+9LkGhy9x
         1L9FnDaHziF4rhyA03nUy6eV0KhxMeroTjr8XBAdJ1WNpE2jWN8VL2vkQUoU++O+aXIJ
         HhHuRxI1cFuufEjwuSKaV50aP9QA2w73zyLzzjTgQ6VD34iXUq12jDaHzAbaW2GLe9fh
         GOwA17Y/MnLiFDWKizJnhcd75C3H5M6dHtsKbB7fkvSJpQkOC58rLR4HYClcjZvdRhSU
         YiQQ==
X-Gm-Message-State: ACgBeo2S7lWKCfbwMv3VyPeu9dTUhN22zqhBR8lJ7EgBQBVfwlUxQg5Z
        4o9xINF0dfhW8b5otXzD9zT8ySUbdfI=
X-Google-Smtp-Source: AA6agR6g/9NCXAY0jL53hQeZvXiiAZgKUhmI83KCDQw2Y+tfUIZiRf00DJsWno5wvXgtarHDxEQp8w==
X-Received: by 2002:a17:90a:d585:b0:1f4:f9a5:22a9 with SMTP id v5-20020a17090ad58500b001f4f9a522a9mr951783pju.49.1663026902692;
        Mon, 12 Sep 2022 16:55:02 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b00170d34cf7f3sm6676089plr.257.2022.09.12.16.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 16:55:02 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] chainlint: colorize problem annotations and test
 delimiters
References: <pull.1324.git.git.1663023888412.gitgitgadget@gmail.com>
Date:   Mon, 12 Sep 2022 16:55:01 -0700
In-Reply-To: <pull.1324.git.git.1663023888412.gitgitgadget@gmail.com> (Eric
        Sunshine via GitGitGadget's message of "Mon, 12 Sep 2022 23:04:48
        +0000")
Message-ID: <xmqqsfkwb12i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	$checked =~ s/(\?![^?]+\?!)/$c->{bold}$c->{red}$1$c->{reset}/mg;

It may be just me, but coloring the whole "?!LOOP?!" in red feels a
bit strange.  I would have expected more like

	if ($c->{color_in_use}) {
		$checked =~ s/\?!([^?]+)\?!/$c->{bold}$c->{red}$1$c->{reset}/mg;
	}

IOW, switching between "?!LOOP?!" and "<BOLD><RED>LOOP<RESET>".

But it may be just me.

> +# Restore TERM if test framework set it to "dumb" so 'tput' will work; do this
> +# outside of get_colors() since under 'ithreads' all threads use %ENV of main
> +# thread and ignore %ENV changes in subthreads.
> +$ENV{TERM} = $ENV{USER_TERM} if $ENV{USER_TERM};

Sounds quite sensible.

