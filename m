Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11513C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 14:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEAA260F9C
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 14:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbhKPOLg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 09:11:36 -0500
Received: from mout.gmx.net ([212.227.17.22]:49639 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237079AbhKPOLe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 09:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637071711;
        bh=U7Xf1C9xFe5em6TfJV8yHyua0DSK1MPJDzspiwYDF7A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=e5S0Jr4qHnceE2hL+6Z33SN5ILKnQr8WoTxIEScFgaSnmlBGiP3cySpboFO6K0yyl
         /Sjky5Q2SeiF//kiFTJOWMqZNN/3I99XzKFNR9MaRrZr9P10kA6YcTF1xvPVvoXiJd
         gGhQNjUQj5EYay+BE/5rg0RBDNRNgaSCwNC0nf6s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.213.220]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6bjy-1mcPR23nos-0182k0; Tue, 16
 Nov 2021 15:08:31 +0100
Date:   Tue, 16 Nov 2021 15:08:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergesort: avoid left shift overflow
In-Reply-To: <5eabbe1c-4c0f-559a-da21-423afec89e7e@web.de>
Message-ID: <nycvar.QRO.7.76.6.2111161505500.21127@tvgsbejvaqbjf.bet>
References: <5eabbe1c-4c0f-559a-da21-423afec89e7e@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-230432021-1637071711=:21127"
X-Provags-ID: V03:K1:kV9DkHFdvIZSPGtgUrR8hfGvj7cL6y35q4MtdgnO18tP2H7nmfc
 qquKDiOeL2k0T1twHXcnkOpQbWt5sROoAbhgDKPJI0nyPuuJQbJCa2G/saIhuiWF2NsuNu3
 jOZ/5sO9TocuW4iEgYP5fCheSQ2/Gf+tMRZthQvc6isGQDeq1LK2Q8lYfiFd/nw3fNnIj/c
 dyOqFWN3TPKgBXKAnBojQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ip6v+gGSSV8=:njyA0kFq2iFueH9DNohVy/
 OkQZ3EjZtmV8fv9iTowTzztaVt3MPq7J8Vky8zlBVLkPHavDJnwOmrWJWn9HvEu9z0a2YAvSO
 pPtGaTYXPmYXM9hEn3aUCNjXLreMCXpwsYcJ7DML72gylY0jDeRPlqcnIVKv/l959NWnEvdvD
 17upLv1CCrbBe7CRFgXAlKXC7tFpuu/CScHSTYXGEQPX2BHunXT9Kh3+xpunymm8kq8g1WzLP
 nNNugd7rVI1rm54IfYqrb9gRS2ZzmtxAe9Ogi5unRuK2P6CSUby55B/m1ohfb+b+/uLIITSyI
 2yYDYo4I/qvlaN3cmzvZSJd2s5EnpF2rJdchrd0cBgHv5ygeoa51bEMAPf9qbD3d/qQecP5s8
 0YnwDlmMWa3AdwH4ivNkb7m5EjYmTmyN5NVwmH9tSddFTBgYn59b8VkZZgvn8NuB9DA2SJJP7
 P1DD/MZdEsbNOLMdzQrq7waO553QAHsNCm9ueaN4mhiwVidZrzKMj4Bm4V63M795Jf8wUkLrs
 U3BTW0ZHQvrPVWU5SNOpMwOyOA8UTnwBrJi1EJP0+vwPISfF5W1ZDHKGOGVv52Jlpmyguzttl
 4UbUytHotWcpBpBqOm1Yp2aNbKT1Jf2B8Ei+1UHzpjdjC+x/AJyH5BRWlHVrnhS0GSn2DkXpL
 ylZlbBBpoyKVdxrUiwdbh3mv98GV6BEtjlJ4CLWm0PXwo5PDTsDPU/r2aNgk5yiVlOd7c1vY8
 D9LzzNX48wYy2g+OOC/XYB3BjvXzpgEM/cdfa63+/WnWHS7XvJaKzVOd70FvM53QUqtQeg140
 zE/Se3b6r4mkeTaKAdM/OEg935O2oTveJJyaWFOVPYo4unY0bB+hBrKYVyW9yONKz4pYjphZO
 vhfCKTqPsrPub0cj85UJ2ftztdMtUU/7NL2UpPOfwtGSzs1xxfff6zc3i/70BO8Wbl122p7lT
 k4Q+QXcvDXx0BG/So2npwK/2u7ut2K1ZocRzHTaiGL/AKq1nqtPDP8GAO6JSGnZV80E49HvV+
 3Li2vUiS3cjlf92IFeOtvxt1p8sfrschcktb0Cm5jXVcJ6whAfdDmuNbnSyIbIRpS8rqpf43F
 6Ig0iCy8r2PP7c=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-230432021-1637071711=:21127
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Tue, 16 Nov 2021, Ren=C3=A9 Scharfe wrote:

> Use size_t to match n when building the bitmask for checking whether a
> rank is occupied, instead of the default signed int.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Ugh, sorry. :(
>
>  mergesort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mergesort.c b/mergesort.c
> index 6216835566..bd9c6ef8ee 100644
> --- a/mergesort.c
> +++ b/mergesort.c
> @@ -63,7 +63,7 @@ void *llist_mergesort(void *list,
>  		void *next =3D get_next_fn(list);
>  		if (next)
>  			set_next_fn(list, NULL);
> -		for (i =3D 0; n & (1 << i); i++)
> +		for (i =3D 0; n & ((size_t)1 << i); i++)

I was a bit concerned about the operator precedence (some of which I
remember by heart, some not), but according to
https://en.cppreference.com/w/c/language/operator_precedence the cast has
a higher precedence than the shift operator.

I would have preferred an extra pair of parentheses around `(size_t)1` so
that I (and other readers) do not have to remember or look up the operator
precedence, but it _is_ correct.

Ciao,
Dscho

>  			list =3D llist_merge(ranks[i], list, get_next_fn,
>  					   set_next_fn, compare_fn);
>  		n++;
> --
> 2.33.1
>

--8323328-230432021-1637071711=:21127--
