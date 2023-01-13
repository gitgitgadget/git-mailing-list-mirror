Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC77C6379F
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 19:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjAMTw2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 14:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjAMTwY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 14:52:24 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209807CDEC
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 11:52:24 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id r18so15671916pgr.12
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 11:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4fnUZ64AFTjTV9ZNoMgweKWJeulN4X/k8sxY7BcxmU=;
        b=B7nTPwlupGVH9k9ngyVytUm/RKuorg6MJTil9D3OuazldtJpathuQFWhToNUAu6DXU
         +I5sxbv+X56F1/KxJrxeVwn8C3u5PEYaHrgJNxyYNKAl31xvpmBI5b8/xNrZ50wqCQE4
         6egaDdYn2hnNvRYFNNMw1O0Drrpxra3fl0MCSLY9YbAaczl1rnBCV1lyxJU1HwWgwnD+
         U6P2gBCVXoopfEv5s7XDhripfbDpJlzbSaDhhhFVurW97TQEmqTo1XvcC8N0265GghBs
         dQzQo2eoEJd2YWHss02lvxXtDW6b7CJ0Uqq+rxr1JpkdEJOt5fmCTsqbyWOJYZsfYEo3
         7tcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V4fnUZ64AFTjTV9ZNoMgweKWJeulN4X/k8sxY7BcxmU=;
        b=JJ88qElpg69uHCS8KhCEBCTZ5v7hBN5CPwzMT9IF+zdXSDX3c9vyCQp0jr4/2uk3kQ
         2pNWKPq+k39KjBZIcY2xHnLTlQTWIcx1YUeBLIWHanhbzfXKtPqShZZdetJQY6OZF2aN
         BqTo2jzd8lgBADj0MdpR0yztV3MLfT3W+MbLr5MBJKsHFuA6tf0nUWHQqHrwhg7XbpoP
         3+LHNDmeIBKmnyjHXnPdWsuxfWE+NDp6pIGK+qejnN4i640OWxz9o8d0qUGtEdy8qDuU
         3J4FKqiYUO7q1L0iVmnTHi4PTB4u3M8lMXq9WEYtB85UJuCSJav6eDMX90UT2zpcoSGY
         9r3A==
X-Gm-Message-State: AFqh2kqtNyZmoAua8UQI2FEcq90atjRka184s46Rxk+d5wThuLJv2UNq
        tvoeWGwgNgX261I/xkHf/Ug=
X-Google-Smtp-Source: AMrXdXvpka3QArz4E0ZqTMCR2YtH87qiYObyE8a6Yb8VP2gNplwB1FMZBTHkoLMQ3EEQTgHIS6HAfA==
X-Received: by 2002:a05:6a00:993:b0:581:c2d3:dc5e with SMTP id u19-20020a056a00099300b00581c2d3dc5emr70219597pfg.11.1673639543509;
        Fri, 13 Jan 2023 11:52:23 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id k197-20020a6284ce000000b00574b86040a4sm14039951pfd.3.2023.01.13.11.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:52:23 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v3] scalar: show progress if stderr refer to a terminal
References: <pull.1441.v2.git.1671974986363.gitgitgadget@gmail.com>
        <pull.1441.v3.git.1673442860379.gitgitgadget@gmail.com>
        <9d8e38fd-f001-5aa5-ab78-cc6d314df09a@github.com>
Date:   Fri, 13 Jan 2023 11:52:22 -0800
In-Reply-To: <9d8e38fd-f001-5aa5-ab78-cc6d314df09a@github.com> (Derrick
        Stolee's message of "Wed, 11 Jan 2023 09:55:05 -0500")
Message-ID: <xmqqh6wu2ow9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 1/11/2023 8:14 AM, ZheNing Hu via GitGitGadget wrote:
>> From: ZheNing Hu <adlternative@gmail.com>
>
>> Range-diff vs v2:
>
>>      -+test_expect_success 'progress without tty' '
>>      ++test_expect_success TTY 'progress without tty' '
>
> I think this addition of the TTY prerequisite is not necessary...
>
>> +test_expect_success TTY 'progress without tty' '
>> +	enlistment=progress2 &&
>> +
>> +	test_config -C to-clone uploadpack.allowfilter true &&
>> +	test_config -C to-clone uploadpack.allowanysha1inwant true &&
>> +
>> +	GIT_PROGRESS_DELAY=0 scalar clone "file://$(pwd)/to-clone" "$enlistment" 2>stderr &&
>> +	! grep "Enumerating objects" stderr &&
>> +	! grep "Updating files" stderr &&
>> +	cleanup_clone $enlistment
>> +'
>
> ...because the test doesn't use the environment details for
> mimicing a TTY. The point is that stderr is redirected to a
> file and isatty(2) would report false.

Yup, the prerequisite was uttering misleading.  I may queue it with
local tweaks, but if I forget please send in an update.

Thanks.

> I don't think this is worth a re-roll, though, so I'm happy
> with this version.
>
> Thanks,
> -Stolee
