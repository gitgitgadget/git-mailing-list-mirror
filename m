Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65904C636D3
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 21:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjBHVRn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 16:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBHVRm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 16:17:42 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98057126C5
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 13:17:41 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id pj3so59712pjb.1
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 13:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ancQYkX6sA6kynhJY2G/tDAVbtMALz5muktjwKbN4S4=;
        b=cJxFUv2IUnkFQi0obvSS6FtUxwOUaZ0DtnQ9pc2yRu3TSZpRvb5vH75Y8+XnVyh0F6
         x0zH3Ljmoei+O0H53jNg5W4u4xoW4vymbW8y8o28VoPuNnlaWQQteUm80N+h2Igba94U
         8uP2mnirq/S/kjvl+cqweEXMm5O/vzBCEpwDt6qsh5M1AJJLb00UMPLNpIR60c4xz5c6
         M9LKYAuWFeOxxxPYkI+xDq096USlm1tkZ8uMFbmKqHBkwOBjwZv9n7B1iU4tUKdyJrj5
         wvHhIdYfEiKlgbR4BylcSVqm5AdT4ssM8PgvUE1AUeETseN+aCboKuTwJK6f6ikM72FN
         JOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ancQYkX6sA6kynhJY2G/tDAVbtMALz5muktjwKbN4S4=;
        b=eeSmqazfjxaaw9m4pAKnVWZaGHUgZuzZsp6RPqeyXIk4pNMq64/c03I3VpIbvj88CT
         zmg54a1rwFxsPzGdnSqIXBYDlGhZi/1acx3erAV23EgCpbZfPdCLGckG70nMDkWcZldc
         B/XSOIcFh8SW74sfs9Lku9HDZR0ZtYJvkGqhhTA4OFtB0B+Ow4TQG7HM5dhUYvpN1YJW
         jOxQkNr5zEeECwgFZbrZJhiXinnnXinW46nuul55pJ66/1EzUPOMjq7dhkipu33yZ+6k
         RdnUG0GBErpQqp4M0g+4PPbCZz79ln8pedtlFwDywl/NjZNGqbdoHrG40K8TCF2tZsNE
         sP7g==
X-Gm-Message-State: AO0yUKVpeglZh6Kjz/t9b4jvHD2csZgNqlAoODDx5OF9SNpeTh7o7Np5
        62e42WfVStu6wYBxvb6EaAFhMbacBME=
X-Google-Smtp-Source: AK7set82FOApiHbFgriuQuLiuOlqZgAYzQhLHZJ2iqfDOnEJdhkzI5X6C18W20pAnJIjApdEDwpcbw==
X-Received: by 2002:a17:902:e545:b0:199:f5d:478 with SMTP id n5-20020a170902e54500b001990f5d0478mr10692262plf.63.1675891061010;
        Wed, 08 Feb 2023 13:17:41 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902d70700b00189f69c1aa0sm11337354ply.270.2023.02.08.13.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 13:17:40 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 4/5] sequencer: use the new hook API for the simpler
 "post-rewrite" call
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
        <cover-v2-0.5-00000000000-20230208T191924Z-avarab@gmail.com>
        <patch-v2-4.5-b96522d593f-20230208T191924Z-avarab@gmail.com>
Date:   Wed, 08 Feb 2023 13:17:39 -0800
In-Reply-To: <patch-v2-4.5-b96522d593f-20230208T191924Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 8 Feb
 2023 20:21:14
        +0100")
Message-ID: <xmqqttzvq2ks.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> From: Emily Shaffer <emilyshaffer@google.com>
>
> Change the invocation of the "post-rewrite" hook added in
> 795160457db (sequencer (rebase -i): run the post-rewrite hook, if
> needed, 2017-01-02) to use the new hook API.

Very straight-forward, thanks to the previous step (i.e. addition of
the "path_to_stdin" support).  Nicely done.
