Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFEAC74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 20:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjCWUA5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 16:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjCWUA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 16:00:56 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E29328D1F
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 13:00:55 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id o2so15920024plg.4
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 13:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679601654;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fAa/qCJ0Z2C5bNmxgwISjfLV1s9GfHbyve901TmBzFI=;
        b=f7YV6NdyTyhosz7BzE/xxcgOu8V7yQzP9GGBKEkhsQzfGsyFOInwqfNZkqNprPdk9H
         enxAakaUSx92nkZPbRrRhtbl1ZIhpDNmJ9t9r1fiKPDNuACPup3XGMUbSJjG/NM5bLt7
         yTycVi9H5UxbyBkZPyl4my0r+8yvWwaQFXX4nWaj5AlYjxAxeWA7bH0u3ItrnKCngFZf
         UPJk89zrQioNcTI0PGpCVE8FBrxfyXY2TO9GJaV+L/FhmXMcyMMCy2XoBGtK0hHt3MVb
         UCfnyBctgyTt0m0EYIadyoSXkPkgoQMWrWuK/F6LKkz2hgIcgZQq+lnv5ptDgUjFufDT
         Z35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679601654;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fAa/qCJ0Z2C5bNmxgwISjfLV1s9GfHbyve901TmBzFI=;
        b=jXgN6CU/8WdYpTBVzJa5oAL8fegaetb8pttTXwIJpgNJX5PWP6WVoCeigHkfJNBlfW
         S5itacCsmsnXSiWouYWKeuduhLS99O6+XpIcW6ASBYoa9RL57hKSxyst7HrRwXDeeRTA
         JX70LFsrg4DwJsP10bYfn0/C+arkOxXucM8gM1OkLTZUO67kt5NNPUht2uaxR5wbJ9zR
         oX4dhXlTS0a2tEcinIkRRXz4Ta5UFYkTYmpelxsGjRZaxJI6kwKO+k1JO3WXZJiNhOqi
         VOik2XvT/5FIpD9k4Na44Gg94OebXwZpx+NcAc2/17XWNK2xEnYd6o10PWZXPaoJ9SCY
         iImg==
X-Gm-Message-State: AAQBX9cs4+ofRyDgGJdQNP4IxQAwjEWYZW4hknUN7YxccqvFpblIo9FT
        7m0TE9K1op5G+dl6dJkTg54=
X-Google-Smtp-Source: AKy350ZuMqCCvF0GMpesYCS/P3sdwjdWvuYjSdl8FraqVqZw1PilWGf4kk5DOTF6ieZCxC4lWJa28g==
X-Received: by 2002:a17:90b:3502:b0:237:8417:d9e3 with SMTP id ls2-20020a17090b350200b002378417d9e3mr199785pjb.15.1679601654407;
        Thu, 23 Mar 2023 13:00:54 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id p7-20020a1709028a8700b001a1860da968sm12652640plo.178.2023.03.23.13.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 13:00:54 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Subject: Re: [PATCH 1/8] rebase: simplify code related to imply_merge()
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
        <20230323162235.995574-2-oswald.buddenhagen@gmx.de>
        <2b296b75-3f8d-28a9-a3d8-8134450852da@dunelm.org.uk>
Date:   Thu, 23 Mar 2023 13:00:53 -0700
In-Reply-To: <2b296b75-3f8d-28a9-a3d8-8134450852da@dunelm.org.uk> (Phillip
        Wood's message of "Thu, 23 Mar 2023 19:40:17 +0000")
Message-ID: <xmqqiler8cga.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 23/03/2023 16:22, Oswald Buddenhagen wrote:
>> The code's evolution left in some bits surrounding enum rebase_type that
>> don't really make sense any more. In particular, it makes no sense to
>> invoke imply_merge() if the type is already known not to be
>> REBASE_APPLY, and it makes no sense to assign the type after calling
>> imply_merge().
>
> These look sensible, did imply_merges() use to do something more which
> made these calls useful?

Good question.

>>   @@ -1494,9 +1493,6 @@ int cmd_rebase(int argc, const char **argv,
>> const char *prefix)
>>   		}
>>   	}
>>   -	if (options.type == REBASE_MERGE)
>> -		imply_merge(&options, "--merge");

This piece is reasonable, of course.  We already know we are in
merge mode so there is nothing implied.

Before this hunk, there is a bit of code to react to
options.strategy given.  The code complains if we are using the
apply backend, and sets the options.type to REBASE_MERGE, which is
suspiciously similar to what imply_merge() is doing.  I wonder if
the code should be simplified to make a call to imply_merge() while
we are doing similar simplification like this patch does?
