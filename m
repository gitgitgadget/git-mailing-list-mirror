Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCBFC61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 20:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjBBUmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 15:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjBBUmR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 15:42:17 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6619E719B4
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 12:42:16 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso6802359pjj.1
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 12:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrZdX3LlR4p5RfN9iUfy5EHZLaenCe3Xuv03i5gUAAs=;
        b=E9H9jTyAjM8NZPVGunE4LTAvzx/My956ivgrmK8cVEMATyvBhqiwza/Od/YLmWBv2/
         I2Cizzl326d9ZJSFVZo2x8JK/BQ0okqWSMnSpz/vLFlTzWaUBQa+XBAYmfcEI2NB6ZCl
         flx0QOhvra2cXFGvLlXe9UK36p2X6riQRaW3FMcc5OX5xDAXXmvuWyWS5SF4+h4FvxSE
         //ZHnYYAphXzLjKXlI81sMAHkvQ8tq5h+XPGgCBRqao8+sVB0W1CrhxaFe6wXFWbTrL9
         RGwhBrwgF585EZl+F/SS7lPmqMf5JSrA8M+8MpRkwYuWHE1s0jbotP0oqFNKq/HlL/FW
         PdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lrZdX3LlR4p5RfN9iUfy5EHZLaenCe3Xuv03i5gUAAs=;
        b=ZSWFdRErJIMmElzRoOlqufdPxmsuUwGKGPIvyspHb6lx1Rug9GOs+sQiAoXgYwqLkO
         qtf79vqcPKJ6VehXhFTGQ5wLI6qC2vE82FvAa1vKPQsewmFOI8XnEE28h0S5buVMzwC/
         42yy3vrzhWFTqBrGbmpPy9jk8BwoH38tDsE4V1zOvEPPLSmX4Le2QlR4KKC+0I+dpsib
         oNNhoeUnGqDg+sncoGFUvETVb0AiGSw+m0Cc9R2Q/JgnHZXXehi5+ZhjUxA4d4mJzGpa
         LPigTzQdbNtC7ki5OpvmLfahQsU5inC89TZLD3+bUF4vZbJ8fwLW12suRRdH8LOVJRVs
         XJgA==
X-Gm-Message-State: AO0yUKXBHs/7UfaTU4GVnrz9Vmc9SO89eMruta1cFc304Qma7kkr8D9V
        T6TM8YRGS60OXS9WLdoEePk=
X-Google-Smtp-Source: AK7set+Mbr9+OSdMIgnM5VxWROi0en2rH0QGMhSizX9PstT2++8zKn7gHxCKZWNuxjZiAE6musEpmg==
X-Received: by 2002:a05:6a20:7f91:b0:b8:2aab:2309 with SMTP id d17-20020a056a207f9100b000b82aab2309mr9682378pzj.49.1675370535849;
        Thu, 02 Feb 2023 12:42:15 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902d20300b00194c1281ca9sm87863ply.166.2023.02.02.12.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 12:42:15 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/6] imap-send: make --curl no-optional
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
        <patch-v2-4.6-e9cc9bbed1e-20230202T093706Z-avarab@gmail.com>
Date:   Thu, 02 Feb 2023 12:42:15 -0800
In-Reply-To: <patch-v2-4.6-e9cc9bbed1e-20230202T093706Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 2 Feb
 2023 10:44:15
        +0100")
Message-ID: <xmqqfsbnu7dk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> In the preceding commit the old "USE_CURL_FOR_IMAP_SEND" define became
> always true, as we now require libcurl for git-imap-send.
>
> But as we require OpenSSL for the "tunnel" mode we still need to keep
> the OpenSSL codepath around (ee [1] for an attempt to remove it). But

"(ee" -> ???

> we don't need to keep supporting "--no-curl" to bypass the curl
> codepath for the non-tunnel mode.

We do not need to because...?

> @@ -1519,12 +1519,8 @@ int cmd_main(int argc, const char **argv)
>  	if (argc)
>  		usage_with_options(imap_send_usage, imap_send_options);
>  
> -#if defined(NO_OPENSSL)
> -	if (!use_curl) {
> -		warning("--no-curl not supported in this build");
> -		use_curl = 1;
> -	}
> -#endif
> +	if (!use_curl)
> +		die(_("the --no-curl option to imap-send has been deprecated"));

We used to force use of cURL when there is no other way to make the
program work (i.e. there is no direct OpenSSL codepath available),
instead of refusing to work (and forcing user to say --curl or to
stop saying --no-curl, which is one unnecessary roadblock for the
user).  Why do we want to change the error handling strategy that
has been in place?

I think I made the same comment in some other thread, but the
principle is the same.  If there is no other choice the user can
take, do we force users to stop and be explicit to choose that only
available choice, or do we let the program choose the only available
option for the user while clearly telling the user that is what we
did?  Here, changing the behaviour sounds like a disservice to the
users.

