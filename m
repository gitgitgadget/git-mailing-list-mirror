Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DAAC388F7
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 15:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1DA92080A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 15:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="n8u6JMzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417027AbgJYPm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 11:42:56 -0400
Received: from mout.web.de ([212.227.15.4]:36051 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1417004AbgJYPm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 11:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1603640570;
        bh=tHVclN/EM/8I2jBcewG2SjxPsRzN6ITz0nkYNdH/oUY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=n8u6JMzjqQIvcboqSY2LvQee5uyj4yGF3kafELpn1r4fzt4H9/O9WXCpSsjKduBzK
         BiXiejNbMBVI6W4PFXdQfex59rl7N1V+vU+stXbtwX3z9+sxw0xi8cJ3RBXB0QXrJw
         DJvusmMrenXvcpJ/X8d4yzqz/UbUyWI1eS3Okl9o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LZvfZ-1k71S30dP3-00loFU; Sun, 25
 Oct 2020 16:42:50 +0100
Subject: Re: [bug] Stashes lost after out-of-memory situation
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Marek Mrva <mrva@eof-studios.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <65a3061a-47ef-9ca6-2468-5449cfc5b37c@eof-studios.com>
 <618d66a8-e2c1-241c-5200-2298bfe24ac0@web.de>
 <5a3db65b-1877-c5be-8077-2926637fba6e@virtuell-zuhause.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <22f34328-1e87-aa4b-3893-564dff1fb893@web.de>
Date:   Sun, 25 Oct 2020 16:42:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <5a3db65b-1877-c5be-8077-2926637fba6e@virtuell-zuhause.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ORXAmeGP3uKZV2hdX/os3Jiirk93QjX/bEj1aWkiq7s86uz0OFc
 Zn4IdpNtDa8A9VuTD8IPE0nwSiKJmZ3pCcnNwJbwHyJF6OecCZv7b2/12+U9wMyG83kGW1f
 PCExO969t2mn97+gpRziqp4PKDywr2STFcDq0BtjrjeM2LCciii95niv+PmKRLa7knLNS5M
 +jDkWCNvqSs9srg28jFew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GFDDXtTCR1k=:9/NxaLSWW/rldboDr36G6f
 8h5mCMwn4P9sVHU2uKXTwHcNsZJJGqe/i/LBdTVwUTL4UCoBx3ebjtxeTZK5og2giWzg78LfL
 WTn+9beUMgU3+uGI4d0Afez1/PyI5E8/eoVCem80+1XQMQ68epTj7dG/cnP+YwZzE4eLxe8PI
 JPqrzhJTrDv/DNoBUq1S4eWM+SqJedQMW0Dz+x2GLr4N74vC+Yq6OmGBv+6386HRklnAju9uk
 FoO8cwVNtXIBfRnzo43d8kpCsB/k7c0bvioojctKPVQiZ9NIAMpqmptaASO6fBPNhEsv++/SV
 UwXJ9+ajzmgPHtMPZLA29+w7polBET/LoIkqC1au7/Yqpk4+B9J2NflFButWeB4LQYXpdwbOU
 whwUn4zYbEpQbYm83sNsMlvfAY58GpU8A6KR8gxVh+sOlDSjP+gK+Y95VaSOSOI+f5H3S0B6p
 EDc6ewnazlf5ErOpmcyRa2htf/jxLrQljUhiOCGc87n7RTlXZngCRVkD4OdF5MxsZSSxeg+4c
 bJgAjnMID2NzOV2RGMdz7TGzuh9gn5ceNPpJ+laxf4rdrbg5JrErV9+Hd6otA94laptdU8orU
 YqBPQ9+O8KTapzTEoL9zggXJmn0vM4E6rsTlv0J0F+KiLwREOA8plLYHxpJQtuvmt8kJRONHc
 uFY8qbTyrjqhBDxjmA5vZncY87D5TVezTteJlb2geAHnyiy62MjNR7qBQT9NWL73wznuDvaOw
 T/tSucbo2OoxESCMGJQtvZbbLbbhJSIkb1afjwikIvIgi54qJQz9iql2jWo+F/HQVMMgeonq+
 ZdoOqgEpp1RLHod9mkJrm6M0ydlW2As8MczklzIhcNMz57shAkkr9HH9px20BzEZ5IINbrCQB
 cxX2j7B9FhVheHUsVTNg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.10.20 um 13:27 schrieb Thomas Braun:
> On 10/24/2020 7:06 PM, Ren=C3=A9 Scharfe wrote:
>
> [...]
>
>> Looks like stash calls rev-parse to see if a
>> stash pop removed the last stash and in that case proceeds to delete th=
e
>> stash ref and its reflog
>
> I was a bit suprised to learn that removing the last stash entry also
> removes it from the reflog.
>
> Wouldn't it be more convenient if it would be kept in the reflog even
> after popping?

The log of the stash ref is separate from the normal reflog.  Popping
a stash doesn't remove anything from the latter.

Ren=C3=A9

