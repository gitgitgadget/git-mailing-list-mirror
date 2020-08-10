Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C237C433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 14:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A6A12076B
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 14:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VQJlXw40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHJOPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:15:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:45705 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbgHJOPc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 10:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597068916;
        bh=VnmCnRvDTnTgZ/prU+99x0F98FSJCVTeuUWXADi7d9o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VQJlXw400ljQYlWNG1Nhrm8JAGMMHL94xXpuYuQoTpqjBz1wwgnDZBRU9YJGfHrNp
         lbOK8riaJhszSI2vA5z/ljfzmdPZaElm3O6ZEdW0hktnc8QD0Drjr+NpO0vbtvyQf0
         z85Zlfl9AKG7rjKuwca8fpcwEQ2ZFUYOfcEWvnH8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.90.36] ([213.196.212.215]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sHy-1k1Gh42gd8-0051Jn; Mon, 10
 Aug 2020 16:15:16 +0200
Date:   Mon, 10 Aug 2020 16:15:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
cc:     git <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH v2 2/2] hex: make hash_to_hex_algop() and friends
 thread-safe
In-Reply-To: <CAHd-oW6mvaANTBX5sVEi49s_Ku71-ZXqhyePtkwbCKaTK7tm4Q@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2008101613440.50@tvgsbejvaqbjf.bet>
References: <cover.1593208411.git.matheus.bernardino@usp.br> <b47445fa1cef6d4523dd0ca336f7ee22bce89466.1593208411.git.matheus.bernardino@usp.br> <nycvar.QRO.7.76.6.2007161214270.54@tvgsbejvaqbjf.bet>
 <CAHd-oW6mvaANTBX5sVEi49s_Ku71-ZXqhyePtkwbCKaTK7tm4Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eimD0mSeJQTUiw84xSI5LWJGEtgoYrJPd+QtwYQbYcmnHl1wxx2
 AtcKqa/t2MhjbmE2H9CBE6IFC5yXle1NaIZ3cCDbeAW5xR9jKramnGcbjRyQOXeaaTiibz8
 D56jbvCbmwv3NOWcVRTi1Q+uz+yTu/kk+F9X4eajf1rwZW9iRtXqsBsH9aMzIcC+Z/puXae
 ZTIlOylUA/e9cz6/0CeHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TQH9CiT+ElI=:L/mhD181Q6tYUYhswhaYp0
 jgnul00Gn2vlP1PIe3Sk2OT+uO3aUkhLoVxb+8tGGmE8g0AOBo8lElDe55ZgLBeiVCZE5nIxU
 4cINv1uWPKweIFPVQ7d487D9PH/ANB/cgY+joqAOi4NDX077f5knyDDR5++aIfmxg9y+WyIKt
 PIPcE0l4LtbFaFpJE9wyCC0+BifBrC9mfUyRQRGO8jn9hdCCmF2bM88KwDEzFNm8Tq+wc023/
 8EhDysF/FHTlB3QIY26SttzFzBzPXxBz0OIcG9mOxeAR6WKYodDjWVJdAr83979fZQiw/imu5
 q7kuyufUo8t1QFNGvIEOIc0T2rVzq1xEfnEw9MFi09b+ds36Ad98z6epIDbzc3Su6dYBVIWB+
 LG5ZnNSPyKa14xr3ymCiKm7FLIb1/iEp65ln5ktgbphNN9IIasg1Q0sGhNSAyLndaJHnyKGfU
 47neKx7KClWDFxXbQCWiXRBgNWJEQOCi0jrKVp+P4+zUAB/20Ix0raxdjxsNLk2Cz9qrpv+t9
 DYK64r9x5+0Cc0+KobM2JyBhznh1CAAIV1DIFi+gApbVYRxruZF+m2tgYcRV5F7F5o3q4lcCR
 fsAkH6VWb8vHwiDIgajD4d9A3Hi1YcnUIQVdfgJAX0dWU6MNxpKG2GMbQxzbCwmlPF8xZxOay
 LIwsMiKD0H28MUatUTB2hJufV5XJpCIn2KPhrO8KWGQp3KkRJarpCK9FM4OfDExzhc96smULq
 mPHNz7DOmraYzUuts8UV4f5/MyznafFq/fzoZFe52EjV370tIEm9N9pbiXH17ijb26xEGtw/i
 t+1S5GfzMMrmkfSzTa2zVl+JQ07oHTmEqsgzR9DwuqVhvGpCxfCoxLfOXPRFn+JVschn6+awj
 mbjksI7CGKe4wn4fRL8PxA8qY8DJYYSf5mDY5ZKhPTKn5cFrOhvq93M4jAHsjY3l6CsMLX8T9
 xbvRGpFxd/PHun/BIjbm68cM+TOPNIZ4rdjOex/4bpQwUEmIayUzfTw2z4jAT16R9mhcDtqRl
 lqRPg+nBVG+OJQzVxSapo8yrws9g7LyPyn2GpDs+VVYuWpuuutWulTYaGNS/43A1B9I+Qloyx
 L+suXjQG6kXzrXpSggRlpO02piaEGm4UDfcFjklDnhq20S0yGtNVPsjg6kqd6mG7x2A22C2cI
 B4wa6IVHiT4bPUt3DMZmPsu9al0+L0ko4yUO4iZk4Oam6yjJrFs6Uhz90HERg3wLWo2+/meUb
 Dmvq6Gt0q3DuDD7AvtqAw7HVKtjbGAqwUqwN1Sw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Sat, 18 Jul 2020, Matheus Tavares Bernardino wrote:

> On Thu, Jul 16, 2020 at 9:56 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> Alternatively, if using thread-local storage is still an option, I
> think I might have solved the problems we had in the previous
> iteration with memory leaks on Windows. I changed our
> pthread_key_create() emulation to start using the destructor callback
> on Windows, through the Fiber Local Storage (FLS) API. As the
> documentation says [1] "If no fiber switching occurs, FLS acts exactly
> the same as thread local storage". The advantage over TLS is that
> FLSAlloc() does take a callback parameter.

Okay, but I am still not so enthusiastic. We can fix this in a much
simpler way, I believe, than introducing the first thread-local storage
user. Let's leave TLS until the time we actually need it?

Ciao,
Dscho
