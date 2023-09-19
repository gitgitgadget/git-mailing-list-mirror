Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74634CD548F
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 07:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjISHmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 03:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjISHmP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 03:42:15 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A36114
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 00:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1695109316; x=1695714116; i=l.s.r@web.de;
 bh=mI9XqmhH105nXLcttwUYxHp1yb1IT/I9cYJ4+2u0xAI=;
 h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:In-Reply-To;
 b=IIblv5LepN3LPDM1qyR4vdQvCUXqOnsYKDdekjsCBAQqGScFE9eWaOyQNYPO531NPy1zYAyMozK
 /aeAeYztBRHUSWCIdJTNFML59Q2zJnqTrQhSYEp2gkyCBVvPUzePPr07DNaq7dtSGkAAItgd/+J2e
 3rFGQnlc/gxw/iLaSEUYbnrB108FsLVkoRu7MRoJNTMUE9fK482E9pJDjMbmoB5H1C1A7znT2wT/G
 dqB2zd4mIZw+SPoEd3ytPp9vmdLJ2/aIgWBNecPLXps807mfvWHdRrYh8MnKf19lDxbDvAMaPs0m5
 5hfI5AZjqYQRQzms3b2oTqMEZ7fy8btTaUdA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.159]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MODmf-1r1x6L1A53-00OcCs; Tue, 19
 Sep 2023 09:41:56 +0200
Message-ID: <fff19abd-263d-48c7-81fd-35a2766b6b16@web.de>
Date:   Tue, 19 Sep 2023 09:41:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 2/2] parse-options: use and require int pointer for
 OPT_CMDMODE
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
 <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de> <ZP2X9roiaeEjzf24@ugly>
 <15530a5f-8d06-24c9-bc2d-e313c895f477@web.de>
 <20230912084029.GD1630538@coredump.intra.peff.net>
 <xmqqa5tmau6e.fsf@gitster.g> <6dc558c6-f78c-4d9c-8444-498de8e4d22a@web.de>
 <ZQgiD0ivfYRpSbnJ@ugly>
Content-Language: en-US
In-Reply-To: <ZQgiD0ivfYRpSbnJ@ugly>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:TK8VSJZGEQ17sQvkzRUbEKWPXq5whN5JJm5274k/yujdd4EqK9k
 uB7EDGRnEff3YezLmmvHbK8riPZ6R3NvWSH8F19Fy9qXuSbHcexG3byH2WZRVCvKyhQACGo
 ETpMIqKwVJETpcZP7Z7PHGG3WcPU0iZ3bk58uWpRF/dLmr/Kd7oGc3+4N8EIo/+44Fs+Pk/
 IDO43tPrb7+IEO8Em7tbw==
UI-OutboundReport: notjunk:1;M01:P0:9aa74GgyWVg=;jus5DJympiHBd1zS8Jg7HGDSNQl
 /77LbuORsHqOMWoeH6kVAtIaQRCuOTah+P/lf+CjyiwVgT64SX5jXlHfhm79ISPCGsT49Zy/Y
 16cED11FSqn3p52ld7ffza6Db0wAEzXKbknflVRuMSCCRtNOaCHxvP70bRJd2HRmWIolXzWy4
 h93TPLRf5Ruwy7lPoVtHRd/leJ++ELCHnDdMBLbjj5u4LISFjTGCuKqp3c2VNTgFw5EzjtrWQ
 p+g2cIOlxlC5ILES/G3wZgCqgQkrl6DfXyxs9ZJrwV/qB/aUQr7+ZCuK5cEm1depajd3E6UuP
 nATVN9mIePDiZS2gZAmqV/QTTF4Kj5d1oSqvWZVHJkvHftNohPrd4Pk+e4nFmy2t6B2lIZw6v
 41OtHTHBt4vergj1BeGXB/qJUxF3VuAyNySdSRPpZ7qW2f2eVohlOd2J5VTuRpxU14F0UIg8T
 zAydi2i3Yh18F63Nf4pGTfcDPQfrlGe9A09OLWoH2qiIAAOf219IDN9Bl1qOuNCYAX7wgbc3i
 4eoXvHpDmG8q0o+4Ks3LNc+TtZT55ZyJCC53DyGj41H72Yr8kkBe3xk3LHqxqKNM+6+isTXIP
 lM9bfCiUi+vVh0Z71a6QPiFR3mKSYh2We8PXKRXu4oOUc/fIloiO5vtd+IW3Vwprbha1GAj3Y
 80QaNUVjq0Bb++EFvThYQBlZlV7n+wvoYYaUwqNYtSWIpW/W5bqCEfqZgpKdkTb1tAEQGxqY7
 1Dch0mPBcRDJg6oN8W+eeL+R0FbADOG7jLfl+q73mMP+2YH23goPhi5HZiVw1Y6MYaWNFeWAL
 0LIWrOLvC4ziiKOoN/v4QjgTvc6erzJkliWfRkSbkgExFxtxlmzzKKATT7rPsnp+m8YH18+Ta
 LM42UDEETV3JjcL25GK72tZvKhGZsmos8hDdwtlxAbDUdJxMSp9sfExsIwzTan9qRrmeGGsQO
 OhUulg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

QW0gMTguMDkuMjMgdW0gMTI6MTAgc2NocmllYiBPc3dhbGQgQnVkZGVuaGFnZW46DQo+IE9uIE1v
biwgU2VwIDE4LCAyMDIzIGF0IDExOjI4OjMxQU0gKzAyMDAsIFJlbsOpIFNjaGFyZmUgd3JvdGU6
DQo+Pg0KPj4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGVycm9yKF8oIm9wdGlvbnMgJyVzPSVzJyBh
bmQgJyVzPSVzJyAiDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAiY2Fubm90IGJlIHVzZWQgdG9nZXRoZXIiKSwNCj4gDQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICItLXNob3ctY3VycmVudC1wYXRjaCIsICItLXNob3ct
Y3VycmVudC1wYXRjaCIsIGFyZywgdmFsaWRfbW9kZXNbcmVzdW1lLT5zdWJfbW9kZV0pOw0KPj4N
Cj4gdG90YWxseSBvbiBhIHRhbmdlbnQ6IHRoZSBhcmd1bWVudCBvcmRlciBpcyBib2d1cyBoZXJl
Lg0KPiBhbmQgdGhlIGxpbmUgd3JhcHBpbmcgaXMgYWxzbyBmdW5ueS4NCg0KSGFoLCBnb29kIGNh
dGNoISAgQ2FyZSB0byBzZW5kIGEgcGF0Y2g/DQoNClJlbsOpDQo=
