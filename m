Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDBAC46467
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 16:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjANQEA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 11:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjANQD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 11:03:59 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DCA9019
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 08:03:58 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id gz9-20020a17090b0ec900b002290bda1b07so3362085pjb.1
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 08:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzEG66rfThPlbXF45FxsFVETOW+clINROKaxEX5/kTs=;
        b=OFHnXXzmrY6fS495cPlKMfzYutNVQISDSVOcIyQSZguHOjhSLQHsvnh41Y0Wd+f883
         39HxgfuwOQSjo8Yzx+Ue8x77ruov+ICUzy5pLNmly8S7Wkv23FIMnzbXjWppo29xatOg
         UShq9zS/H3TBWZXYf0IvBM+pvFAsHymLNtgqRqLXE0PGX++0X61MK1byBhiNbHfwLEH5
         w9cHhnh8OQqjJEJhtDvxLpON2q3CwfyXv/hLZujsO8NwOpHuoYX46csDRBfazqQIH9qy
         QA8DURjScJZ6v03Q1UFuG9/WXrT1XRRfGdFTYKsjJxz7+8E8iAEgzhboMrxDg/Oe9iTV
         Uq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BzEG66rfThPlbXF45FxsFVETOW+clINROKaxEX5/kTs=;
        b=tfbBLYxx7FnVzjuG/DNZ2L22CNk4aRVujUnm6/hbO0ZYuTQoXLzggLCF/c0UCU5DiI
         OgSkcugchDaXjNx9YhzZGMJcxSuJVjDT5GtYRaW22kljfTNPl0ohNPnHIjcuNXtA9XF9
         8+O0kjo5ZTTmUUcGq5gJ0s2R0eDOjGl4LxwCSEvLnkyA1idqNyLYLq1j8F6fQvhXriWT
         2wA1tnRa/6aWcLAkjv1LxRJFKT7LJGjMa/cz0zvDRTLTtclTmcjgeGSNL0W1SeAmx/3d
         Twk+2hrHZRlL+/KnGEM/sxDBdJ/zTg4ZPvnwqYiH/H2yNCqgejVk8WbMSuhI6ZP4KjsA
         r4Nw==
X-Gm-Message-State: AFqh2krQrXP300M5077Fjpho4ATc1eav4+E/q3ffrJJ5nq4Fv8JR/LRf
        si9MdJHv8DwLBWWRRI9SfGs=
X-Google-Smtp-Source: AMrXdXuOm52vB62MmRvaZOXODKtTzkZxVZQSzl3qqBbSi6OktQh+pG9xKbM+1nELqhOTpcwPkxlevw==
X-Received: by 2002:a17:902:8304:b0:194:828d:62b0 with SMTP id bd4-20020a170902830400b00194828d62b0mr1351955plb.48.1673712237708;
        Sat, 14 Jan 2023 08:03:57 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b001911e0af95dsm16067847plh.240.2023.01.14.08.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 08:03:57 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>
Subject: Re: [PATCH v5 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
References: <20230110211452.2568535-1-michael.strawbridge@amd.com>
        <20230110211452.2568535-3-michael.strawbridge@amd.com>
Date:   Sat, 14 Jan 2023 08:03:56 -0800
In-Reply-To: <20230110211452.2568535-3-michael.strawbridge@amd.com> (Michael
        Strawbridge's message of "Tue, 10 Jan 2023 21:16:28 +0000")
Message-ID: <xmqqedrxm7bn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Strawbridge, Michael" <Michael.Strawbridge@amd.com> writes:

> +test_expect_success $PREREQ "--validate hook supports header argument" '
> +	test_when_finished "rm my-hooks.ran" &&
> +	write_script my-hooks/sendemail-validate <<-\EOF &&
> +	filesize=$(stat -c%s "$2")

That "stat -c" is a GNU-ism, I think.  macOS CI jobs at GitHub do
not seem to like it.

> +	if [ "$filesize" != "0" ]; then

Also, please see Documentation/CodingGuidelines to learn the subset
of shell script syntax and style we adopted for this project.

Thanks.
