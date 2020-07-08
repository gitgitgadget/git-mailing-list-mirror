Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C58C433DF
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 03:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C20C7206BE
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 03:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="PiMMbi+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgGHDcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 23:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgGHDcB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 23:32:01 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE16C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 20:32:00 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k5so1732339plk.13
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 20:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:references:in-reply-to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=rWeHjNPGlu+grYHGhdEidY267ajtgrPTXZh6iK9u70M=;
        b=PiMMbi+HwJ4vnKEblWtrAgjRVuPN3eho8FFFUoe5v20ZzsD7CFkyrH3/gJHvUVWDpc
         SarnyeLn+41CV0fBUW47d2gW43M6YaXA2NKMVDzbRbMpoTOcE+a3IPlv8MueJcFBSR+R
         Eqt874hydx77u5MPmqTPsgxk34jqE01adpaT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=rWeHjNPGlu+grYHGhdEidY267ajtgrPTXZh6iK9u70M=;
        b=iwZGImXvzVbaP9DYTbOzdevFIigC4HsVfpWDo32br2xquWR6Td+XMowZRbVFJ+bJtd
         WsR8ZlbSqQUD4t1lNh/KbVKbook9XfFCrKpooWl65dZ5piJByjNJXZUrZlhJW+JyfF+L
         shK+oatUV/v786pJ0G28ZV710IM90k6we/z/vn4qXlAHtECotO1B26+UUfyUTWQf0AF2
         g/NyVJ5HeLOy62SZwu4nie/1ubsgdq5GJMTMriej8JAYgbOJpvjZ7Y5J14bZUe0SFFkJ
         QmKgUGAZ8ms3QvlL6aIAWXPsg8UFOv9zzqvTsva/Y9mTRyJcxqTX7ab62H6qYHebHFbl
         Xz6g==
X-Gm-Message-State: AOAM532piVvdnoCy9Bd6lqxeI2vo8QCvuKiq1I5nowRGp3kB9ZcGkEDl
        w/jL+ToUaqrtqkXKINH4rBh7XQ==
X-Google-Smtp-Source: ABdhPJwDMD/gP+LuPFgKeYXp+ygobVM+AaApvZun3qUqmvlfBRauu3sj3WBxFIMivngTqTpj9u7xDQ==
X-Received: by 2002:a17:902:6181:: with SMTP id u1mr47746163plj.205.1594179119678;
        Tue, 07 Jul 2020 20:31:59 -0700 (PDT)
Received: from DESKTOPLINSUN ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id m1sm3792893pjy.0.2020.07.07.20.31.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 20:31:58 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>, "'Junio C Hamano'" <gitster@pobox.com>,
        =?utf-8?B?J8SQb8OgbiBUcuG6p24gQ8O0bmcgRGFuaCc=?= 
        <congdanhqx@gmail.com>
References: <pull.781.v11.git.git.1594106024078.gitgitgadget@gmail.com> <pull.781.v12.git.git.1594178716840.gitgitgadget@gmail.com>
In-Reply-To: <pull.781.v12.git.git.1594178716840.gitgitgadget@gmail.com>
Subject: RE: [PATCH v12] Support auto-merge for meld to follow the vim-diff behavior
Date:   Wed, 8 Jul 2020 11:31:53 +0800
Message-ID: <089101d654d8$55503fc0$fff0bf40$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHCWhx1ftaZsotRV+SB1Gp08SI0dwGL+c9rqRia22A=
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio, Doah,

The [PATCH v12] Is uploaded, in which,
1. "$meld_path" is quoted.
2. the logical for deal true/false/auto is flow Junio's comment
3. error message will emit for invalid configuration value
$ git config mergetool.meld.useAutoMerge invalid_boolean_value
$ git mergetool --tool=3Dmeld
...
fatal: bad numeric config value 'hello' for =
'mergetool.meld.useautomerge' in .git/config: invalid unit

Please review again, thank you.
https://lore.kernel.org/git/pull.781.v12.git.git.1594178716840.gitgitgadg=
et@gmail.com/

Regards
Lin

