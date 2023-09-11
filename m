Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5CFCA0EC1
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349082AbjIKVc1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244371AbjIKUM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 16:12:29 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F6C185
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 13:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1694463117; x=1695067917; i=l.s.r@web.de;
 bh=vYJCU9aqGTGmbilHV/0a96S17Q2IfczYPtfGcny8dvI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=KYJcJ0rhWSvwPkGI9NGHZNTQw27n4c39UWi9Yd48BtSehS1HCiubi6CyOxv4VzOPzjeILJA
 tcj6ScK/TU2ii/M3l5vIEkUNmna1L/WwfvwE7MtayaC0D0ESvgVvNJnYGDqYPjjBs/fRzBO7v
 zF/Cg7ffjMESKE22/JvUK5DcCLtmFddVCMYRvniGNVkIU5qt4/Xw87LJpAzuVq/qnw7b79IeN
 Q7T8FelbLNX1qesc2wVPai0UPBrqRncF7sxFDtTV4Orb93vdg6at2aaPfuGfCb+mkh04pRWlU
 Xqj1umuL6u4qgXsNlKai75V1ycIhquJQEm6F2v5iPGQLPam+ZuUg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.145.34]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgiXO-1pz1KD0bKm-00hIMs; Mon, 11
 Sep 2023 22:11:57 +0200
Message-ID: <15530a5f-8d06-24c9-bc2d-e313c895f477@web.de>
Date:   Mon, 11 Sep 2023 22:11:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] parse-options: use and require int pointer for
 OPT_CMDMODE
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
 <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de> <ZP2X9roiaeEjzf24@ugly>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <ZP2X9roiaeEjzf24@ugly>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W5u/xLTaXTCHvGwzJHlLAYZSAUSBWXJSVBtRSozaTHfbF5aZVRt
 I4CrGmWSuP9yvtAauHvujTy0p99tanco3H+oDkOjvrXlpb/NpughKRo738rZaBtmB9DgxZk
 TYB5r9j/p/yp9xTMK81Y8T7n63PuX3PyCYhyTE3/jl0O6bYQVr83Dn3vzcKsDJAzZxoZmGu
 bOd1I6Hi3qqFRIpPy4yMw==
UI-OutboundReport: notjunk:1;M01:P0:7szLUFFgJwY=;CXroY4Ivncy4wN7yUggb0p52OI1
 eMwdyGnZJdRfesm2s3DqehZGD8nVNRNNsXOflNi2EThJNCu/XTEc5a+fQEE8H5Zl1uv0oTScS
 MuAvnwaGxMXO8pOM5wzj4xH3LYRVgTWTzbSbfsme2WbJTmzdcvd+4rxkeTukAMyWmX8JXn7lx
 /IxB8n+3BadvuHfRWwFRqIsG+XeGLokit7slnIjUNOT2RmJoyyLNQysAKtaJaOdJqZwMb71dX
 6vocntT77a0Fy2eNd2sNfxiiODV2zQTYWVSe5FKlUirnpy9TVFNXIrsjS+sJ6H8tttYw5tWAA
 rgOJ+ivk59RZeUQVeStJzbXzk5xEh9H+1PBzk5D1ucaVVuEFFMeRihlrkFyB2bLOM3zHliH8v
 j8XZrLLxVStZYzokBGxEg8CAVcY7DKBfLLzR0UtAT5ya6iFWmWJUo+L9Puq+7ZC1kPEfqRSUb
 J+rFnRAvl/ApEYE7ykRDgREN58psytn+BfhjvbQqRE2W1FHiq1Mn0Dp7AVnlyrJCix8RnJkye
 j9cBAIYJn567yoebn53KSnF/lF2OZf2DID/Z1ZfyUAuOGwYGkAuCTDJaSny9RUen2sgmsc+PR
 hng4O86P81M+SaNYtsZ3EuixqNzE8YEtY5euVzSxKfi8fGEtbODDBKh3q+4xHj9WfRRA0kK98
 8nAZ2dGzPINpSXQadMPReEFmRAGpwthLJd/CmhdJi0dZDUls1+YcihgO1tOacOCDB/x8ttfNn
 hdn8WsT+uG1ropmqqLUSO96NKmVYkOIp4MrynXqztu+HbKS85V7IS4icuSvbcihgjqbKBKxCq
 9TFPZZ+FLvpjsDK/nWCTKbidfXRPy9TJELRvtN45V1dfmhxD7xUdb55DtmCGaBs4q146mL8Vd
 LyTabMaVqTClbrkknpjOfiyK6f43SIWqZ+a1Kks4Ld4baeXS6QdsuSijghausHM86KcKyIpF1
 cUJTDw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.09.23 um 12:18 schrieb Oswald Buddenhagen:
> On Sat, Sep 09, 2023 at 11:14:20PM +0200, Ren=C3=A9 Scharfe wrote:
>> Convert the offending OPT_CMDMODE users and use the typed value_int
>> point in the macro's definition to enforce that type for future ones.
>>
> that defeats -Wswitch[-enum], though.

True.  Though I don't fully understand these warnings (why not then
also warn about if without else?), but taking them away is a bit rude
to those who care.

> the pedantically correct solution would be using setter callbacks.

Or to use an int to point to and then copy into a companion enum
variable to after parsing, which would be my choice.

Ren=C3=A9
