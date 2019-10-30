Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57ECD1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 09:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfJ3JNw (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 05:13:52 -0400
Received: from mout.gmx.net ([212.227.15.18]:34817 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfJ3JNw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 05:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572426822;
        bh=cE/T5lPznP2kClwW1yClCPVa7SSrlY/I6KHqZiU4PVM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UeqnzTk+OWfuXzysCYuM2g65HGVKG/S7rQz7fnY/pBIqtWGJdE4PFBLzXONSV2R++
         q5CJwEx3lk+8JsgRHSgHwzHCt95ouGhMKF+UbvE1nn3G2h65ohzGl5TP9FksPmdHeR
         yWHJHJG/HH2o4nJFmkLJZWrcnGOeOfaoKT/9aZCg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeCtZ-1hs3WM3Jx9-00bL0v; Wed, 30
 Oct 2019 10:13:41 +0100
Date:   Wed, 30 Oct 2019 10:13:26 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH v3 1/1] vreportf(): avoid relying on stdio buffering
In-Reply-To: <xmqqo8xz3sa2.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910300957370.46@tvgsbejvaqbjf.bet>
References: <pull.428.v2.git.1572356272.gitgitgadget@gmail.com>        <pull.428.v3.git.1572379280.gitgitgadget@gmail.com>        <fce0894ee46f737322551b51edf5cd2a53413a50.1572379280.git.gitgitgadget@gmail.com> <xmqqo8xz3sa2.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yOSp+y1qccpgo6fVxekn/XCTgSg1L5YP+ji84l1/b+X1KIR+U2U
 c15OEtmjYbVzVmNXrpSwH+kom6Dophkl19/jY7VC3o0fnKtGDRBWaZq/vzu7J0VtgbJgMLs
 ysobENeKD7ijNgFEP0cdrDRlYCo8sMKbyOGwv+T/3NKT/XC8s47SJSufWSTrXbZAgYWHAla
 Kpj041UfQ0ha27toRYM7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BUg3f41DZWM=:0ED4Sam5u1Cu3S13TE3u0G
 t/SM1ldYNlyr3GJ1daOL499w6nFLYZP2eu+IMEh490C02QBpmNM6WCsGsRmF9U5rwyxUMBt2D
 dAD254gk0LLl0l8dw30wKcdhfIX88V/eP0qLDvvztKNcEgPkljpCIhW7RtxjKIo7D5aqzFJga
 HouTY1zY6qCLlCSj64jUg12vS6Acrb7kvhVx3UMPoyei5Ru2z66+DIRg65R9FZYg97YadHkuz
 QSL9L0KriG4EDFuEYMT6dZ9L68SYM99puNKQT/3BA3J/HPAl1NnWBKIwppxdMFWGeMf7HagQX
 uUGaD4QhGQF0oA146Ht+xVFU0GSPNA2PbFWO+r9obURtbwjuzm2+CngsA+pnbOcuC8mBghGhC
 Y7ctTRSZaRYi+yxXNoqfTN2tji3ySenLXfBWNfrD8mxr6Ld9H02DKkW53taLVlAXPs8UKwx3L
 7IiGTJ+vY14T70vdq7Osn8q2UuQDAfPcuavkHWfemVM3juio9VZopP0sDiRjUd32uh3kLOWSy
 ZVH3Sa89EkoDMfxynYrofXinzu5OUSxtB55qIRAugF5z0gyRggS8+aBa/7K5PHoUltYB7ZVL+
 df0Ez7oDj9DF4qyepBe0WwYOP7YohhNIujt03hcBVCzZgnPYrQV8DPLENQXGAs1YvyEU/S7a6
 fcKibpaeiq3kOdj8050iJdVkEdI8S/e3nPnVOCIacQrs6qHmoN6QxgCWX5svl09qLbthxduo+
 tTyW8UIyHI0jx2z7s86BbbEYAPP4dT1Q/URaoNnjTVQQWeuj2XpQAeNlLSDzQt05WmB5Sc4fr
 QfY2smEFcYbmy2zlYi+h2g7LU8ksFG0npvhwq/fFuoKqbOTGJ1cH1/HtSoadIKbafON1FxyWv
 LokditD0LX9fEyawIyzdS2GFq3uamkvP8pSy3zT86Jmpgj+2AnmPpgpSpygLtE4CPwdpXOEW8
 5japo8Le9Nta6lgKok+GLd90/Qfof9P6EBuKcWTBD/LpSPuhRk3QBKCVKZltMWHwl3WRXti8E
 pGSn7w1QCDDU08YPxn9bpugmb59cCflK9qL8b3eYnyT+16/BKagVoFkj8jEipyTwQ7DnBAeBL
 HgjXfwgyHm03ayLSDZhyBZgcd7VKQ1ISP4KbRhoPaGxYWDx1s4pzcxcdyoXkP6+NBRgO5/BKl
 JssPzJd3s1Fe47kDZnZPNpi+qaO+EzNdYVoMimBAgOnVY7SOP69aF7NbgnOROPUnn5nPZU6zk
 xJ3ROiawbmmkeLh+xiSWJ1OUSgwQ4YuolbVw+AzPv37tM3GQLORyEYRme+hU=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 30 Oct 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > Also please note that we `fflush(stderr)` here to help when running in=
 a
> > Git Bash on Windows: in this case, `stderr` is not actually truly
> > unbuffered, and needs the extra help.
>
> I do not think you have to single out Windows in this case; if we
> are writing directly to file descriptor #2, as long as there have
> been something written by the process to the standard error stream
> before our caller called us, we must flush it to make sure what
> we are going to write out will come after, no matter what platform
> we are on.
>
>     The process may have written to the standard error stream and
>     there may be something left in the buffer kept in the stdio
>     layer.  Call fflush(stderr) before writing the message we
>     prepare in this function.
>
> or something along that line would be sufficient.

I replaced the paragraph with a slightly edited version of this. Thanks.

> > diff --git a/usage.c b/usage.c
> > index 2fdb20086b..471efb2de9 100644
> > --- a/usage.c
> > +++ b/usage.c
> > @@ -9,14 +9,21 @@
> >  void vreportf(const char *prefix, const char *err, va_list params)
> >  {
> >  	char msg[4096];
> > -	char *p;
> > +	size_t off =3D strlcpy(msg, prefix, sizeof(msg));
> > +	char *p, *pend =3D msg + sizeof(msg);
> >
> > -	vsnprintf(msg, sizeof(msg), err, params);
> > -	for (p =3D msg; *p; p++) {
> > +	p =3D off < pend - msg ? msg + off : pend - 1;
> > +	if (vsnprintf(p, pend - p, err, params) < 0)
> > +		*p =3D '\0'; /* vsnprintf() failed, clip at prefix */
> > +
> > +	for (; p !=3D pend - 1 && *p; p++) {
>
> It may make the result much simpler to start with something like:
>
> 	size_t prefix_len =3D strlen(prefix);
>
> 	if (sizeof(msg) <=3D prefix_len) {
>  		fprintf(stderr, "BUG!!! too long a prefix '%s'\n", prefix);
> 		abort();
> 	}
> 	memcpy(msg, prefix, prefix_len);
> 	p =3D msg + prefix_len;
>
> as we agreed that we won't have prefix that will fill or overflow
> msg[] based on your earlier reading of the callers like BUG-fl.

Makes sense. I was a bit blinded by my endeavor to keep the diffstat
small.

> That way, we probably may be able to even lose the pend pointer and
> arithmetic around it.

I tried this, and it still looks more obvious to me with `pend`.

> >  		if (iscntrl(*p) && *p !=3D '\t' && *p !=3D '\n')
> >  			*p =3D '?';
> >  	}
>
> Thanks.  With this flow it is crystal clear that the prefix is shown
> as-is, while the payload is sanitized.

Yes ;-)

Thanks,
Dscho

> > -	fprintf(stderr, "%s%s\n", prefix, msg);
> > +
> > +	*(p++) =3D '\n'; /* we no longer need a NUL */
> > +	fflush(stderr);
> > +	write_in_full(2, msg, p - msg);
> >  }
> >
> >  static NORETURN void usage_builtin(const char *err, va_list params)
>
>
