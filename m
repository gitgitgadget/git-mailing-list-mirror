Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3461FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 23:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755097AbdCaXSv (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 19:18:51 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35493 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755044AbdCaXSu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 19:18:50 -0400
Received: by mail-it0-f65.google.com with SMTP id y18so3411386itc.2
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 16:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=l3OuhhEM/pdJ9WRwvHMeKflJX2wiJuxj/0yL/xHyubA=;
        b=Ztl2uifGCKqHEAq1YREahYKGmcwnCiQhNT4q5DWFiHEplIKB9GvA9TbpZxNBet8O15
         a5mwtkcY7zKq9Rj+f1bIFmjj/Lkz7A5UIG8moGXQr9U7Vg15NIgheAO2IU6fjQNP9+Rs
         dTdGVQSdQZyfmi33JFUBys4pslngPzkJyVTlAtKpqQ8U+1JC3dzN9vkLBXSaGqLipl+A
         jCnkLaap09CmUCnPioZ55BLWxAfLJO+gLeeMEHrS/MTXdRePQ4BSHHe2iacjQi5V27TO
         lcAqd18Y1z2ZOZC3hfy7d+c6ayGBj8bvD9cKIOeb6488b1F7p4ogNRATrsR8ZohMnira
         km5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=l3OuhhEM/pdJ9WRwvHMeKflJX2wiJuxj/0yL/xHyubA=;
        b=nUqY0UA+5LNMCz0e6TFsiATzNtBQVPoGbJM+TjlROAN7ZoN+mLmkfpbWK8umgOU3Oi
         RhJe26Mf0A54AmmaoaGLKJu6iIlzKTiGWzqxICKK26gEtVtgR1D72SUWybk1vInGImcF
         NglYdsuicQCXydgukYaXmTghvgr5P8cB5UJxwWoWsX6P63n0sPbPTsG0pMRlsyt21ek5
         gTTGuu0YG/mO4xJHVcTVrBTBVkhZse/yAxonE1O8YPDljmEze4fJoSeG7KEOFaj8bdnW
         PYIXW/vMwSGFnSykrDl0P+E5/O2JoKKPao08ZAutQaBrUHA9hofgIgi1VGsbRJwbb7ah
         aVJg==
X-Gm-Message-State: AFeK/H1NJS0pUcydb3JOVpgZv+9FbLZaf9NbtDukGsceKkwKMauSZRrDy2+7OZXjQ0UHT/yed6tup3wAKlR0PA==
X-Received: by 10.36.147.71 with SMTP id y68mr314066itd.85.1491002329939; Fri,
 31 Mar 2017 16:18:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.19.75 with HTTP; Fri, 31 Mar 2017 16:18:29 -0700 (PDT)
In-Reply-To: <xmqqy3vlw3f9.fsf@gitster.mtv.corp.google.com>
References: <20170331173214.47514-1-git@jeffhostetler.com> <20170331173214.47514-2-git@jeffhostetler.com>
 <xmqqo9whxmrq.fsf@gitster.mtv.corp.google.com> <xmqqy3vlw3f9.fsf@gitster.mtv.corp.google.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Fri, 31 Mar 2017 16:18:29 -0700
X-Google-Sender-Auth: tMWSXwwA7eBEVuHhhU3RzA2iuRY
Message-ID: <CAPc5daWU5XDVNiYk_pTFk_qziuDr6W2XDHXXH-0oR49_KiCUYA@mail.gmail.com>
Subject: Re: [PATCH] name-hash: fix buffer overrun
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Kevin Willford <kewillf@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2017 at 2:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Will queue with ...
>>
>>>  name-hash.c                             |  4 +++-
>>>  t/t3008-ls-files-lazy-init-name-hash.sh | 19 +++++++++++++++++++
>>>  2 files changed, 22 insertions(+), 1 deletion(-)
>>>  create mode 100644 t/t3008-ls-files-lazy-init-name-hash.sh
>>
>> ... this thing fixed by "chmod +x" (otherwise the tests won't start).
>>
>> Thanks.
>
> Also, https://travis-ci.org/git/git/jobs/217303927 seems to say that
> MacOS is not happy with this change.

Ah, of course. Avoid GNUism to spell HT as "\t" in a sed script.
