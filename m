Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29F5A1F45F
	for <e@80x24.org>; Tue,  7 May 2019 00:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfEGACc (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 20:02:32 -0400
Received: from forward102j.mail.yandex.net ([5.45.198.243]:34801 "EHLO
        forward102j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbfEGACb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 May 2019 20:02:31 -0400
Received: from mxback5j.mail.yandex.net (mxback5j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10e])
        by forward102j.mail.yandex.net (Yandex) with ESMTP id 057BEF205CF;
        Tue,  7 May 2019 03:02:30 +0300 (MSK)
Received: from smtp4j.mail.yandex.net (smtp4j.mail.yandex.net [2a02:6b8:0:1619::15:6])
        by mxback5j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id AJUetwj31w-2TYue13h;
        Tue, 07 May 2019 03:02:30 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1557187349;
        bh=VHLqr0LA+UvyYrcVcQ0J+kmokRg3DpRHFm1SiG7Ja2A=;
        h=In-Reply-To:Cc:To:Subject:From:References:Date:Message-Id;
        b=ZzXywC/zNpvKtCqXJVzVAU6CHRtTeXmuahYJqssm6McvA/xrzeNR5YjrfEEetWYEi
         VQ2VsvgYqFAThosn2qn9thM2MSxPDSx5f5VP8zlkPCB97H7lCSWtfnao3m16sDUyfZ
         qhFea0uPmQ4uy+jKC8HrjKu18z4JGof/Hw4SaWMc=
Authentication-Results: mxback5j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by smtp4j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id ZrH6KKcGo9-2Tomu59O;
        Tue, 07 May 2019 03:02:29 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Tue, 07 May 2019 03:02:27 +0300
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
Subject: Re: [RFE] Allow for "interactive"-like actions in non-interactive
 rebase
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>
Message-Id: <1557187347.2481.0@yandex.ru>
In-Reply-To: <CAPig+cTC8aGkM3ksG9cEapz33-FcjsvoO9ejeJzjmkyXHjvoJQ@mail.gmail.com>
References: <1556895855.30374.0@yandex.ru>
        <20190506203003.GA85211@google.com>
        <CAPig+cTC8aGkM3ksG9cEapz33-FcjsvoO9ejeJzjmkyXHjvoJQ@mail.gmail.com>
X-Mailer: geary/3.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On =CF=ED, May 6, 2019 at 18:25, Eric Sunshine <sunshine@sunshineco.com>=20
wrote:
> On Mon, May 6, 2019 at 4:30 PM Emily Shaffer=20
> <emilyshaffer@google.com> wrote:
>>  On Fri, May 03, 2019 at 06:04:15PM +0300, Konstantin Kharlamov=20
>> wrote:
>>  > Interactive rebase (i.e. for example "git rebase -i HEAD~10") is=20
>> used most
>>  > often to apply an action to a single commit, e.g. "rename",=20
>> "edit", "fixup",
>>  > etc=85
>>  >
>>  > Instead, it would be nice to have native support in git to start=20
>> "rebase"
>>  > for a given commit, and pass the "interactive action" to use on=20
>> that commit.
>>  >
>>  > $ git rebase -i HEAD~10 --action edit
>>  > $ git rebase -i HEAD~10 --action rename
>>  > $ git rebase -i HEAD~10 --action fixup
>>=20
>>  I would totally use this. The equivalent workflow right now is a=20
>> pretty
>>  large number of steps for, say, fixing a typo.
>=20
> Isn't this pretty much what Phil Hord's RFC patch series[1] was about?
> However, Junio outlined[2] a generalization of that approach providing
> more flexibility and control.
>=20
> [1]:=20
> https://public-inbox.org/git/20190422000712.13584-1-phil.hord@gmail.com/
> [2]:=20
> https://public-inbox.org/git/xmqqk1fm9712.fsf@gitster-ct.c.googlers.com/

Thanks, indeed it is. I replied on the corresponding emails.

=

