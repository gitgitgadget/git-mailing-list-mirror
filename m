Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD1EC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 21:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjBIV1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 16:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjBIV1G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 16:27:06 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B10A56EE5
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 13:27:05 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id j1so3368384pjd.0
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 13:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSHKPUkUjIholy+qli0imO0kE+4asIOPryXuhtGzA3k=;
        b=VrHCfgjdi3exCLU+TZqHL2nDwmp4fQ0ubzU6HNpmz2WnO/Xpi+mpSoVBAQbccx37x0
         QKn6kh6xpVZbyo12yyYE4Cv6DdZmrNb0l3owoMaFN1kW/mIsModBFKCS5nM7o5LpGkpf
         tRuLjRez1PHzOkwQxx23CASFCbUk+OuwORSWfpc9LdgD5cHZA7s6o31JuUu71tnUIiPE
         jNqBLsD5T6H52aRcC+4HnyjVjIFHzIXQrk0kEWAP4pxvp+T3WN3C9vYTRJzs+jyUnGIA
         PMqK8vzCZ+TD+9hunJAOThIDgzWuGGKY1Wy+XENC5RIxZo4KBNRFlmJJhkJrVnfvmjlm
         jREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VSHKPUkUjIholy+qli0imO0kE+4asIOPryXuhtGzA3k=;
        b=SfJBq8Kbg3nh5Z2XiRtNK7Yw2jWDQ/k38GD2mwlEb6PX9ahryJ/f4pKYSOhTJpq2OG
         11PvMHWXM6ToAmQugTuyC+ogc2PJk6qLkVPbyEk5euVVmKCB9QM8NU2M6yJO2RJWFW5z
         GTrQfX8jt6ttb+EKLM0x3b7lKoOqURN3IPxwC5Q7mGcUmeXrABzoSPSusdOVErUVldNk
         oNEbET3PUoHot8CoamwsIxuhQQ8U6QtBmdjFC9AUpeUnTTwviAZzptOJLOJegCXEsFA+
         A77EmLuW7l2BKKRRcDdVbFRGu1wBS2i9jo5XuyV4YqP4DBgpLsrGj608/e8qDf1kYMDA
         e+DQ==
X-Gm-Message-State: AO0yUKWsXtrxI5/1yg9ByjqI2KYQOx5QMofRs8fgKEScYs5kKbORxIMt
        dl2e7qOmrgdIkGzCycB77A4=
X-Google-Smtp-Source: AK7set8uXcE8E2K/QGUT8ZSwY417M1XSwyBRACMIqSLndoaNIyuVeADrLlxfZVkpjkXYjlXU0c7oRg==
X-Received: by 2002:a17:90a:195e:b0:230:7079:aeb7 with SMTP id 30-20020a17090a195e00b002307079aeb7mr13946945pjh.46.1675978024444;
        Thu, 09 Feb 2023 13:27:04 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id in23-20020a17090b439700b00229f7376247sm1746051pjb.57.2023.02.09.13.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 13:27:03 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Max Gautier <max.gautier@redhat.com>
Subject: Re: [PATCH 0/2] gpg-interface: cleanup + convert low hanging fruit
 to configset API
References: <+TqEM21o+3TGx6D@coredump.intra.peff.net>
        <cover-0.2-00000000000-20230209T142225Z-avarab@gmail.com>
Date:   Thu, 09 Feb 2023 13:27:03 -0800
In-Reply-To: <cover-0.2-00000000000-20230209T142225Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 9 Feb
 2023 15:35:04 +0100")
Message-ID: <xmqqlel6mswo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> On Thu, Feb 09 2023, Jeff King wrote:
>
>> If the gpg code used git_config_get_string(), etc, then they could just
>> access each key on demand (efficiently, from an internal hash table),
>> which reduces the risk of "oops, we forgot to initialize the config
>> here". It does probably mean restructuring the code a little, though
>> (since you'd often have an accessor function to get "foo.bar" rather
>> than assuming "foo.bar" was parsed into an enum already, etc). That may
>> not be worth the effort (and risk of regression) to convert.
>
> I'd already played around with that a bit as part of reviewing Junio's
> change, this goes on top of that.

What's your intention of sending these?  I think we are already in
agreement that the churn may not be worth the risk, so if these are
"and here is the churn would look like, not for application", I
would understand it and appreciate it.  But did you mean that these
patches are for application?  I am not sure...

Thanks.
