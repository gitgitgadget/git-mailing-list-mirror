Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215BDC636CC
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 16:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjBHQdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 11:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjBHQc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 11:32:58 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835C84C6EA
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 08:32:56 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id on9-20020a17090b1d0900b002300a96b358so2871490pjb.1
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 08:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBbAKdzEs4H8+AI27ClklEHdI5jpH4r9ibk7kI08YjU=;
        b=fVeJES7y1EYqk+PGPlm1xeCUuGMpZuda54u0TUHX46fit7mC3o1wAedMdYIYbMkxgm
         NJm/RLM/9JWXvZP0qHzdLkukald5mTpjxT8wMVY3LIWVWhPl+PgtKE+zQHJbGuBlgviL
         2VY1xeEg5SDCNUTgIxC0Wc4Caxzu/h4sWkIk4r/G/hmQ26xWNSrHf+DZAXRIWq6X3Uao
         QhxO0QOM82IYdX+7E41ZDIdjIBaVZGwz6AY15pDIwJqhZlS1AGZsUb1gnNuEmY6ywXRC
         ghoppQJNyIrlIZVva7W8nZ27/eUys5xA3PQMZgRo1s0X492cJ6BdwX8DW3ZpyYxUrus7
         JNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBbAKdzEs4H8+AI27ClklEHdI5jpH4r9ibk7kI08YjU=;
        b=Dj1zkwgu+wzbKbhs23LDPCBSjrZPsOTVSzk9qEQZ/JYWLK2Qcu9WJTn22KJbnSJ518
         q5WDBc9+TLukb/NgcxMpyUvmqCgD0u7AjumRWUCHTu4+dzQ7iULsgh1Vsc2VSnwO4+Iq
         JOWiX+j+mJ4Ofuj9XGs/4m89FkdNjTJUUy+OB2RhKVFf00BUqp07Bfq0ZCOz67NyHshX
         xXLVBfoFzEYtqE6fZiGC1hHOcO9Pe8zVXkK62KRGL2SlD4L8i5deZ4f7MkELrODFfJjM
         GbD5jDDE/7ahFlo22FrAyO6DHNiphj06VyM++N0CO31EDXK9mUKeyUOMgZydN2ikvW/v
         cZcA==
X-Gm-Message-State: AO0yUKXq2q+Rd/QRfzzgD36yykpVR26UzBGDJ5kVTQVl7wySNmAzFInu
        UCeR8mKXCbWQYjecHI2kqeY=
X-Google-Smtp-Source: AK7set8H16itTpWg62K8IlQkHT/JtJEcKIjhPv/5WuRO2Vngtp+UBgSMkQI8uoZbaktmj6YYwDwgqg==
X-Received: by 2002:a17:902:b718:b0:198:f8e2:2e33 with SMTP id d24-20020a170902b71800b00198f8e22e33mr1644194pls.30.1675873975855;
        Wed, 08 Feb 2023 08:32:55 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709027b8f00b001992521f23esm4950043pll.100.2023.02.08.08.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 08:32:55 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Kir Kolyshkin <kolyshkin@gmail.com>, git@vger.kernel.org,
        Roman Dodin <dodin.roman@gmail.com>
Subject: Re: [PATCH] remote: align columns on -v
References: <20230207235238.1850757-1-kolyshkin@gmail.com>
        <20230208161222.guqqwlceqiy3jq7e@tb-raspi4>
Date:   Wed, 08 Feb 2023 08:32:55 -0800
In-Reply-To: <20230208161222.guqqwlceqiy3jq7e@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Wed, 8 Feb 2023 17:12:22
 +0100")
Message-ID: <xmqq1qn0ungo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> Especially, what happens if a remote is named with a non-ASCII
> character (unicode code point would be a better term) ?
> To determine the width on screen for aligment, strlen()
> does the wrong thing here.

Interesting point.  I am still skeptical about the patch and suspect
that it is better to stick to easy-to-parse output, but if we switch
to align for humans, we should definitely count display columns, not
byte count with strlen().

Thanks.


