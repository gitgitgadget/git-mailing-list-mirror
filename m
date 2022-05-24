Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D637C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 10:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbiEXK5n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 06:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiEXK5j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 06:57:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7216FD13
        for <git@vger.kernel.org>; Tue, 24 May 2022 03:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653389841;
        bh=M7hz44TuvPwN2nbaPy2Ztrc8KHqvG4hsQ7N4Ja3PgE0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZrY0B1t/ihkFkvmtTGn7Dh4nJCCDD+SCMRTh4e1pESx+pvp9Qdo722+KBLU8EsJ+X
         QZ+FEZwChEREy83K8HLwp5fOP/X6Wj7/ok8p+ug5aYnTp2Ufr52h7pwvZpDW3dD9ge
         ezfJW+BaRg8dswLu7u+mHr1zQeDxv+dP/U0lirdo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MORAa-1oCkSl2ylS-00PrHf; Tue, 24
 May 2022 12:57:21 +0200
Date:   Tue, 24 May 2022 12:57:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Daniel Stenberg <daniel@haxx.se>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH] http.c: clear the 'finished' member once we are done
 with it
In-Reply-To: <q274s3nn-pp38-4sn-53ro-o2q63447r341@unkk.fr>
Message-ID: <nycvar.QRO.7.76.6.2205241253270.352@tvgsbejvaqbjf.bet>
References: <cover.1651859773.git.git@grubix.eu>        <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>        <xmqqtua2jtr0.fsf@gitster.g> <xmqqczgqjr8y.fsf_-_@gitster.g>        <nycvar.QRO.7.76.6.2205232248360.352@tvgsbejvaqbjf.bet>
        <xmqqr14jluu4.fsf@gitster.g>        <nycvar.QRO.7.76.6.2205240124280.352@tvgsbejvaqbjf.bet> <xmqqa6b7lrw6.fsf@gitster.g> <q274s3nn-pp38-4sn-53ro-o2q63447r341@unkk.fr>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HF+9xstSmAVn22+iIkQdfb5WM5xYEDqY40p6B9zkI6L6bq5O1KE
 SN7i59nEEBBuSedeycozvspD47USb+FlFbY33cQanaa9SyLgIBJAl3VnbJi6yCKHc2V4vJw
 IJVCfDAe8gtbZr6WqjdwD+bgbbQp9/FXqw67dW7S5Ru0zmcmbHypVTn6A4c2NWhTX6BopWV
 EDnrN8s7RX4xzgBRaV6tQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VRI7WKXDBoA=:uclxsVcvW9k+YATU880xFb
 kQxbO339VnHwfZqeMyv+Kq4xOgqM0QIhC/jWzTPYrxRxMU3z0pSYmibQQHdE9exOvKaKZu+pU
 L7szYVDz3YqQdHqk4VY346qSwFmG/+ns18XA1t+2BOCcEVkBXHY8job3aTV5q8ss7RAKZifAE
 9tVpQXgnmU1ep+GxNt7xJjVP6SCm2h/s8zJnlKBoF4BBWhWl3hfzCOrc13WTkAF2PTDcoyTml
 VhMA2xfR7H0ICXTC+y70I4CRWmudlB7AXjM9MR4s4LKT6t55sb9W1JzpVDqy90W1yU3FlRAee
 ozttVuAFQn3D1PaYrY4EaY3yE5WLXNATiqzkYAgAFEq5rzVFem7+z4R5OMqRJTj834kbJ7tFK
 qApZKsWicwCnYhh8t/2Naa2+9jFBEYtyZPnsh1S+q/SL9OhQWKoifvQr7xnhT2zc6MzL6yS0c
 y+Su+Yrkr6sOEB9vvzUP1Rth6iyuuYv169e1rbHGDcZ/x95xo3lnpeK0hTmOgBQuAQYRtT277
 tt9aHNcx27YJa5MpceZU03t/AWCpeNHwM/ff24AgFN7MsJdy3vvOSdSvupg2ikL68nrx8v1+y
 GlkqCFoRbkvtyLE1qHAY7LqMfIC12QE5sIi6vS/okAV2dJvkjcJ0VAQRqKGx+ZiWWaoFUinkX
 9eETyvxzXmxM9YKnlI7BTWOa3AL6QUHaq11uSUkMSwlY9aMEkhc0SXBUx9Rx6e9H+ts1VKr5d
 UKrW9LaTVYfyE6oABJ0cKO1hxIleD1aSQPq0onrX6doC5QY67ASCRqJQ+10rB3YFtvyu+9NjK
 yGbJiBEShKC9If/5rCq6yhqLT0MgOQzAASZEfyQmjFQsqLSnDF0TSct2RPllkfn43w+uaxag8
 wL31/duvACvXwwjz8fTYB1Y5/5EEdTZwNniNjuCENB3JvDRw8wJpohpEQBUls9p7jhEOckAMq
 YBdK2bCcuJJYwpb6adp7za90HA2EIZsY4BwztSLK7/JTBf4/NsSzGrar+oSreINTquQpVIpDk
 bRULa1QmtbMs9xhe3vSX6EHGVlfMJQvgLQM8eBIDfW0emzlfnZvgTFcAMa59XSJO7lNMoRAHD
 Gz+Gth1g9+tGtnaQIWxd1v5XGjB1wsXgp74Rf/InFwjo0OXXPeiKPvJlA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Daniel,

On Tue, 24 May 2022, Daniel Stenberg wrote:

> On Mon, 23 May 2022, Junio C Hamano wrote:
>
> > > It calls into cURL, which I suspect has a multi-threaded mode of
> > > operation,
> >
> > https://curl.se/libcurl/c/threadsafe.html ;-)
> >
> > My understanding is that what we have is pretty much select() driven
> > single-threaded multi-fd transfer.
>
> Confirmed. libcurl *can* use threads (if built that way), but the only u=
se it
> has for such subthreads is for resolving host names. libcurl, its API an=
d its
> callbacks etc always operate in the same single thread.

Great, thanks for clarifying!

Ciao,
Dscho

P.S.: I'm enjoying your book, Uncurled. It feels great to see validation
in some experiences (I'm a youngster compared to you, maintaining Open
Source software only since 2001 or so, but still), and to get a fresh and
inspiring perspective on others.
