Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728E3C761A6
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 17:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjCaRRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 13:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCaRRr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 13:17:47 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DAC1BF75
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 10:17:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54629ed836aso87582637b3.10
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 10:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680283066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s5EEN52gP+cp2bwQBJxkVV/PTe9NfJ9N4tc/pH76/XE=;
        b=PxwIWE/YCMZbDsDjLwDyBlXH7tC5DtI6BaDVuw6BhxkmaV62yunetktzyF5OCx5C5c
         Xoi1P2gaolkWmIXmFM82VSWSM82b3+yoC5p6DGYyxlCR45JMgT9TgjaDztBKWWONwyRD
         Ee6Z39LXnsGY7gUHXOqI7/3t9Vp0gaoLhk4cVADa00d3DQuNiDJCUOs5hknU7EsoPvC3
         GPofbOlL6AzWMyHRk3hmB/daYq2CMp1Lav0zSsnqJ/9j5tk0b7TVqkbH5xs/AyzLIRhu
         8/6x7RQ2S5VhUVJP6gVxLCQDLgLRNGfHmdv04iSnVcu/pEcSoA2kkY/ftb9v/MsALPeb
         n5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680283066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5EEN52gP+cp2bwQBJxkVV/PTe9NfJ9N4tc/pH76/XE=;
        b=w76KLt48BSwDsPoHah07zXoqo9tIshvkoHyhO5y3TLHpEc4PazkeVJxl66vF3sz6bz
         srxItPLHm1aEpfFhOWb6Lwyi0a1+CRWK/p4YKg7VjaR6nH+YR3FsAWFcAJ+C5W9AETIG
         uk5EwkuRyNg8VkM/WUZXtOjFs26KSLaJ0dvgINjC9ExJQPn7wJMclOkLD6sXBn1tv1Jg
         pzGBsGmACdTlrnln7Nw/twarvb+DcD9q9gG7HMdlbvJ6YtaKpXelc/vq/wr79owXDzEl
         vFH09C+hgqtxLgeJYd9f6rcfgSg2DJzJtSCPlovsQBRcMZeH7poSUlLE1TCKmla1G/m8
         zr7A==
X-Gm-Message-State: AAQBX9dzp0uKQ4DnxYtulpQUFtkoy3fezmiolgRkDKC3sGxM+nTQw5/f
        8rOeQEmyWq51XQbhI1gHEznNjok69JFTCQ==
X-Google-Smtp-Source: AKy350bHfSlB1X75dL7hV2T2u6GCwDflZWpiEfOhRaI9W3QjgLSz5AmC75VCQqOigSgYshZELyodopCjHklXsg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:120c:b0:b74:77fa:581d with SMTP
 id s12-20020a056902120c00b00b7477fa581dmr14802481ybu.4.1680283065782; Fri, 31
 Mar 2023 10:17:45 -0700 (PDT)
Date:   Fri, 31 Mar 2023 10:17:44 -0700
In-Reply-To: <xmqqtty2hx30.fsf@gitster.g>
Mime-Version: 1.0
References: <kl6l7cuycd3n.fsf@chooglen-macbookpro.roam.corp.google.com> <xmqqtty2hx30.fsf@gitster.g>
Message-ID: <kl6lzg7sc01z.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: How do we review changes made with coccinelle?
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason" 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> - Is it okay to give Reviewed-By on the basis of _just_ the in-tree
>>   changes and ignore the .cocci patch?
>
> If they were made in separate steps, sure.  If not, not really.  But
> we can still say "I've checked the changes the author made to the
> code and they looked good."  But we haven't reviewed the patch in
> its entirety in such a case to give a Reviewed-by, I would thihk.

I agree, but I wonder what this means in practice when .cocci fluency is
so low. Maybe:

- We increase .cocci fluency, partly by creating our own learning
  materials, partly by being more conscious about spreading knowledge
  from the folks who are relatively fluent in it. We might not have to
  do a lot to get the ball rolling either; just checking in a
  "MyFirstCocci" would help a lot, I think.

- Define some guidelines for what it means for a ".cocci" to be 'good
  enough'. E.g.:

  - Do rules need to target just the right things or is some collateral
    damage okay? Does this change between .cocci and .pending.cocci?

  - Do we allow copy-pasting in .cocci rules when a more 'elegant'
    alternative exists?

>> - What do we do with .cocci after they've been applied?
>
> When we keep .cocci rules in tree, "make coccicheck" would complain
> on any new code that matches the preimage pattern of these rules and
> adjust them.

Orthogonal to the in tree .cocci rules that enforce code style, there
are .cocci meant for large scale refactoring.

IIUC at least one other opinion there is that we keep such refactoring
rules in tree temporarily for the benefit of in-flight or out-of-tree
conflicts [1], but since they are defunct by definition, we remove them
eventually.

[1] https://lore.kernel.org/git/230326.86ileow1fu.gmgdl@evledraar.gmail.com/
