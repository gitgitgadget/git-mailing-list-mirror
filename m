Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F166C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D0F61005
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbhDILtS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 07:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbhDILtR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 07:49:17 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FCDC061760
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 04:49:04 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r12so8202472ejr.5
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 04:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oILW3Zq9x9MXcoiJZKXIWqme1vIwZgr4wGXUp3d3Osg=;
        b=p7dpjyKXopknUpTb9d/EcOshaOru3QsxhN1FgavLmrUF0l3/x6EbuyfA0EdXilgoDE
         OQqT2RmE0P8+UDu947rFUGPhow53yj3Desv5qj+nz4oXZHmSa+BTyb9QEsf2NsFVMKpN
         vuLTi2VjrMOEeMQFwL0bHOVIvMOF2kAY/wModnO//VK8rvzlID7/eJF9COykNDgeoncH
         Jw4q2mc1u4IPw9+5uRK5ZKMS5DD7ETjTuXXg/jyA0tW1PAO6CBKesEO9wAwFf/kKwZWw
         MQD4S1EhS4C2OqmDQ25ZaGUEKFYsGJykCWEDTU59M3borVZrkJZIWLQ2k/pSUFOFVgHi
         celQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=oILW3Zq9x9MXcoiJZKXIWqme1vIwZgr4wGXUp3d3Osg=;
        b=eNjjfUhU8N6bHP1s1WiaJSQeTYSSLDx0gg0M09i8f1fWahhZoCHXnL1cmHVHy7zzFY
         TCWxIBGpRQLJ/p1zJI0ePUtCQZfwrbpRHflzhY+yYKKkl4tX6maIF5wZbNSZPKwmT4zw
         NMlRzB345YjrEmJetQ0vyMeAzQ7iZDSsmbQUUef/0BRWKv7BCgFblsOo49PN5vijC7ed
         FGCkslvfkBbtvIG9rWdUHcOlkX3CtjwEiEx9EiPrVk8Oq/ogIc6YASvIAOv2qznXQdsQ
         mrVFJ3TN9CS7vQOcbhjkuQ64aVTrxHHNh4QNKaHmBV3zU9c/npf9kQaFDygAyv1jaJD2
         NmYw==
X-Gm-Message-State: AOAM530CYTYursygb3bKroVCQtorEm6DtfXWd78SM5fGglEgES3ct6X9
        ZqGJUAxiOxL9KE5g2aIpx4E=
X-Google-Smtp-Source: ABdhPJwohO2jfHw0pkmG1Cre9aOZUovtcuz2R0MRVaR81W7gBRgZa5uKRVdHYMfh+nuCI5m79Fho5Q==
X-Received: by 2002:a17:906:7842:: with SMTP id p2mr16380699ejm.87.1617968943187;
        Fri, 09 Apr 2021 04:49:03 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id nd36sm1108197ejc.21.2021.04.09.04.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 04:49:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] doc lint: lint and fix missing "GIT" end sections
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
 <patch-5.6-d4004b6a7cb-20210326T103454Z-avarab@gmail.com>
 <xmqqr1jzn5j5.fsf@gitster.g> <xmqqk0prmafq.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqk0prmafq.fsf@gitster.g>
Date:   Fri, 09 Apr 2021 13:49:01 +0200
Message-ID: <87lf9rhe4y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 28 2021, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> Lint for and fix the three manual pages that were missing the standard
>>> "Part of the linkgit:git[1] suite" end section.
>>>
>>> We only do this for the man[157] section documents (we don't have
>>> anything outside those sections), not files to be included,
>>> howto *.txt files etc.
>>
>> OK.  Alternatively we could drop the footer from all pages.  IIRC,
>> we used to have another footer section to credit primary authors,
>> which we dropped years ago.  I doubt "git-foo is part of git suite"
>> is something worth repeating over and over.
>>
>> Thanks.
>
> Having said that, making sure all pages consistently have them is
> fine, too.  It is just the repetition, even though my eyes have
> learned to take it as perfectly normal state of affairs, did not
> seem to be adding that much value.

It adds the value of:

 * If you're looking at e.g. git-subtree's manpage it doesn't have it,
   so we're clearly marking things that are part of git itself, also if
   you're doing e.g. "man git-annex" (or other non-git.git tool)
   somewhere.

 * Once you're at the bottom of a manpage in e.g. a web view it's a
   handy link back to the start, see
   e.g. https://git-scm.com/docs/git-add#_git
