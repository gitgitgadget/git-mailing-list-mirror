Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17AEC77B72
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 18:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjDTSMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 14:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDTSMg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 14:12:36 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC361FC0
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 11:12:35 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1a920d4842bso11379855ad.2
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682014355; x=1684606355;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQZfTLMnyaPJQbDW5OEcJW8yEV3NM+VC6+G6u4dkd4o=;
        b=cDfmeIy+lYgZo2Xea+1C2y1JtsiasaAbpRD8iKzel0csHuIM3FEsPaCyK43s59orac
         U1yhO2o+Bq4BrdImmgVZbgkJJNzDPNYSFm76tlutdbldyGJFyU2/xQfjvhy0J/b5wy7R
         kR0saHAVDYejjcs5mgGn4mnuyUjmkttk8tmtFMFtvWLfEK2rhOMUqntPDn/Q7dTcq675
         YoeMM0nSHAjSm4fgjPe14y5DQ16ZBAL79Nz5erez+4krKEjaqpLNe3/GWji/LvQp6Ywk
         iKrBmXl1KLS+3gFXAlG0RuQSETx9fE+tjTS8VFGleWk4M5dEX2pt51+gTP5eUiLE90X7
         hnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682014355; x=1684606355;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GQZfTLMnyaPJQbDW5OEcJW8yEV3NM+VC6+G6u4dkd4o=;
        b=TGA8oShekiaxX7mepMRHdBU8qKyE3Q0QuSjbUDdT37eDmpjDR9eg6kovKwp+QFpl0e
         q0DuQvkXy3+AWV1TKPHAWj9p2LzsxLDSprSODNW2WoL9a50kDRxvu7HrPfcaWGYujxUl
         BAyVUHbVaLcoZCHFq4N2HuOUt0qR8ucK8pmTHuxk3Skx/mxLib5LlPFUEx1easBZw1dR
         wbuwCbZFRdnwT61cj4etfx/TEADpS6zmA5SIhCJ4AEYK6qMI/ieL7PgIqIpqnWq015XW
         1zwm9eRh1NMdFnZeyK+sNa3u3O/MwvQiTkFC/h5kAxqMiUmxU6vyNWWq1ahNzyqSKXdA
         zUgA==
X-Gm-Message-State: AAQBX9fKz0W890wWr+rulSEVX9PlHry8lJyirfeXGSSn682wZPHTaojY
        +smMr+FNKGQp0yyeye0/3u9gBQh7H0o=
X-Google-Smtp-Source: AKy350bQzqlpvYt45XcvhfvWqd2rqribDh7jKW20MojIwMpIwdgAi05vNlDS+PrZSsxkVp4U7/xvEg==
X-Received: by 2002:a17:903:28e:b0:1a2:9ce6:6483 with SMTP id j14-20020a170903028e00b001a29ce66483mr2590992plr.64.1682014354813;
        Thu, 20 Apr 2023 11:12:34 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id p13-20020a170902a40d00b001a687c505e6sm1418199plq.232.2023.04.20.11.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 11:12:34 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] builtin/pack-objects.c: introduce `pack.extraCruftTips`
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
Date:   Thu, 20 Apr 2023 11:12:34 -0700
In-Reply-To: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
        (Taylor Blau's message of "Thu, 20 Apr 2023 13:27:06 -0400")
Message-ID: <xmqqzg72zalp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> This patch introduces a new configuration, `pack.extraCruftTips` which
> allows the caller to specify a program (or set of programs) whose output
> is treated as a set of objects to treat as "kept", even if they are
> unreachable and have aged out of the retention period.

I can see why this would make the implementation simpler, simply
because no existing codepaths that determines if an object is still
live knows about such a program hence all the codepaths by default
keep considering them expungeable crufts except for a very limited
set of codepaths that will pay attention to the program.  But it
makes me wonder if it would make the life of end-users simpler if we
reserve a special ref hierarchy, say "refs/crufts/*", than having to
write a program for doing something like this.

Thanks.
