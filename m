Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58521C7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 08:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbjDFINs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 04:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbjDFINp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 04:13:45 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C93983C1
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 01:13:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id er13so106328959edb.9
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 01:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680768821;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IRQ1+t/6+6RuS+Dc7fu1zpiqEYbVVGUFM054vxX8FHo=;
        b=ljJk36YiuVop8+vH+ZxNGooD7ctqAZVXU4Tp5EUqPvM+YgUZlvtPmUE6+CLJIWPxdT
         R8ws0JE4Q3BCuxL3kCVh61mNUJgtyc1PqifO2ZgymkjxyqGPZ/+F6TdkqG3FKdLuBOI7
         DQT0F/y/mim+1B5xqka98bmVcvrqNqkMM6ZQC+llIxUGLzKPNEVjHpU2zMuY1+vg75Wg
         pCa5T6ICIdV6wUUibWRQO7eMYrocqh2wo1EvYUrIcXbwyzs9NB38iYMKxNOG3f1ALE82
         nw+rWRYBgzaH95q5BbxxMh9oPVohGiJbiXXJw1TbjPXh+z8RLaMEf5N7mf04qTWZL0EF
         2MtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680768821;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRQ1+t/6+6RuS+Dc7fu1zpiqEYbVVGUFM054vxX8FHo=;
        b=wiPx+InfDbL0rab3n0ciTjUQoE5pNkRl0GUqr+m1HE9+LOvTT/WMtOKl/cQ+dHGg7n
         pWlriDERaBqHXWp+TiuMolJa4MNCN7wr0VR0DfML2bBzKRr7qRkGXbu5wQzNx6UJF5Hb
         q1fJJKw+tYLVqhETlhgXm0Q5/WwVb/ZrJZkLsG485c7DZ4se2wV1OvQvaX4my4USwLl9
         BZGD9pvG92tMKIV48PKHgJmFz6BMpenzBOQvcEPDbAqTTzsCvk9r+nEISw+UVJeWEL25
         lhPQBBPLZ5Wo9PAwVVaiJNUBOPne5YVMvrM4mw24c3vPWYipQdLFt9xEkhczDEP+2XG0
         /iEg==
X-Gm-Message-State: AAQBX9crbIO0UcDEmNY1nYrgbZ7tbQQf+l/S08hal8c5d9IU59oAZPPE
        eLuhW/aon2SyHndWJH2nBVA=
X-Google-Smtp-Source: AKy350YWC4vO3CbKcxERDvEeOEPc0jmRs+XdGMBuq/W+rPldv8jun+Vo+kvrawsUiz27U/iUv79sZg==
X-Received: by 2002:a17:907:da7:b0:933:422b:5f5d with SMTP id go39-20020a1709070da700b00933422b5f5dmr7578642ejc.18.1680768820784;
        Thu, 06 Apr 2023 01:13:40 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906500400b0093e817ee3f9sm469576ejj.191.2023.04.06.01.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 01:13:40 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pkKkW-005O3E-09;
        Thu, 06 Apr 2023 10:13:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] global: resolve Perl executable via PATH
Date:   Thu, 06 Apr 2023 10:05:46 +0200
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
 <20230405213020.M231170@dcvr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230405213020.M231170@dcvr>
Message-ID: <230406.86355dv363.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 05 2023, Eric Wong wrote:

> Patrick Steinhardt <ps@pks.im> wrote:
>> diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
>> index 755a110bc4..3fe43b8968 100755
>> --- a/Documentation/cmd-list.perl
>> +++ b/Documentation/cmd-list.perl
>> @@ -1,5 +1,6 @@
>> -#!/usr/bin/perl -w
>> +#!/usr/bin/env perl
>>  
>> +use warnings;
>
> Fwiw, adding `use warnings' only affects the current scope
> (package main), whereas `-w' affects the entire Perl process.
>
> I prefer `-w' since adding `use warnings' everywhere is
> annoyingly verbose and I only use 3rd-party code that's
> warning-clean.

I much prefer "use warnings", and it's what we should be using. Note
that "-w" isn't just "global warnings", but for anything non-trivial
you'll likely be tripped up by "-w" being dynamically scoped, and "use
warnings" being lexically scoped. See "What's wrong with -w and $^W" in
"perldoc warnings".

In any case, I think it's fine to change these to "use warnings", and
the behavior won't change, as the scripts are trivial, and the either
don't use any modules, or use perl core modules that are (presumably)
warning-free.

But I think that change really should be split up from any proposed
shebang change, as it's just being made here because by usin g"env" in
particular we can't pass the "-w" argument...
