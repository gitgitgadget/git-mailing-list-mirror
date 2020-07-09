Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0FDC433E2
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 00:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01BB206DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 00:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="WPesNkyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgGIAkC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 20:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgGIAkB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 20:40:01 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF539C061A0B
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 17:40:00 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 1so222982pfn.9
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 17:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=SNHCzpBJ2ktCdv/ewCEG2d6hQB62ImY+6xOjbVSpeNw=;
        b=WPesNkyjPM6qOZNyckZKyIVxNV77IvEmSfh8Vzbh/JSToFbf113H00hO1ua9UHmc1G
         AXbZJrZlI7E6tb3w5JL27II8NMGRxYAzRS5rK39e3rQtqRKOO2X/yjys2HPn93OqaVGR
         E7pLWv5mGQHSYARJypjCbsJYnjAJapn6TASUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=SNHCzpBJ2ktCdv/ewCEG2d6hQB62ImY+6xOjbVSpeNw=;
        b=VVdGWADUIT/3rm0AMvOgFf/9gC8GELHs3xVAdZsHKy+MXTEC9e46Inp2um3ozjqD4Z
         OQgORD/0Q6o+hWF30hmM4Olg8hp7dV4XFVKg5lgLHDoEIC3tKIxd0dMTqhT2L+R/39IK
         ara5+4B+5jzv/RHJwxj9v+nxYSN8T2hq9jvEXEmprVrZ51gKMeS9xChGq0/NcxAF02SZ
         U8tSwzEgnYfG9lNyrooF27rykyobUoah/w0XwDfVAilBk1VSg0oO8NWxQzdN/S1mv6os
         O0JSSbm5HWXkNvj+TB3J6WmoT0D97vmSBSmWKz823VIHPnZo9aOEnBm73tDuiFkfQrND
         bB0g==
X-Gm-Message-State: AOAM530zZvo4qp1t/cfpyh+uffdnUsdBgondRdXIEsqM8euO+qegJLbY
        1hGabn2z58T3VJDtY/4IQb5Lis5FCDo=
X-Google-Smtp-Source: ABdhPJxpcJ+SnCS9iIVpb0dh2P4zPZ6c2OjbZSKjzpBu2UDyjKlk07lMqI15Xa3teAEJmiuOFxyCtw==
X-Received: by 2002:a62:75c8:: with SMTP id q191mr46435914pfc.321.1594255200324;
        Wed, 08 Jul 2020 17:40:00 -0700 (PDT)
Received: from DESKTOPLINSUN ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id 2sm827293pfa.110.2020.07.08.17.39.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 17:39:59 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>,
        =?utf-8?B?J8SQb8OgbiBUcuG6p24gQ8O0bmcgRGFuaCc=?= 
        <congdanhqx@gmail.com>
Cc:     "'sunlin'" <sunlin7@yahoo.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
References: <pull.781.v12.git.git.1594178716840.gitgitgadget@gmail.com> <pull.781.v13.git.git.1594254906647.gitgitgadget@gmail.com>
In-Reply-To: <pull.781.v13.git.git.1594254906647.gitgitgadget@gmail.com>
Subject: [PATCH v13] Support auto-merge for meld to follow the vim-diff behavior
Date:   Thu, 9 Jul 2020 08:39:53 +0800
Message-ID: <1f0901d65589$7858bbd0$690a3370$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGL+c9r+Sj3YnB8Xlh5VXkiFBL/EQG/MxNQqYUk99A=
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Danh,

The [PATCH v13] add the missing "*" back at the back of *'[OPTION...]'.
     -+			*"--auto-merge"*|*'[OPTION...]')
     ++			*"--auto-merge"*|*'[OPTION...]'*)

https://lore.kernel.org/git/pull.781.v13.git.git.1594254906647.gitgitgadg=
et@gmail.com
Thanks

Regards
Lin

