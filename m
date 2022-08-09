Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A95C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 09:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbiHIJgf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 05:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbiHIJgc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 05:36:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC45B22BE6
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 02:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660037778;
        bh=f7kxjVjfkgBiZ+tokbDEQUZqsOW1cg6kfmnavgBNOJ0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RJQ9F0BPtpG7gD6UfnoYIVtuHIS/63mTzG496oDfLSH1Gp1umtQwOiyI+dSXG7LuN
         tnana5Ehx42g9z/6il4vuv8Y1kEVioLDogWcD+iMLutyNhOdMUFNWVDv2bmgN6ZDmy
         YzD/62hjLtq0Nrs5ET9jQ8uHS34jFV40CY7+Z18M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.31.241.252] ([89.1.214.151]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N95eJ-1nIMyb2Eml-0169Zx; Tue, 09
 Aug 2022 11:36:18 +0200
Date:   Tue, 9 Aug 2022 11:36:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Matheus Tavares <matheus.bernardino@usp.br>
cc:     git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        christian.couder@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v2] t/t0021: convert the rot13-filter.pl script to C
In-Reply-To: <CAHd-oW6LZay=MX2FdFjgTh1pjE=g-XTm63mGWuMhHd=-N=tXRA@mail.gmail.com>
Message-ID: <q7o86qo0-9618-p26p-q6q1-8n461qsqpq75@tzk.qr>
References: <cover.1658518769.git.matheus.bernardino@usp.br> <f38f722de7c3323207eda5ea632b5acd3765c285.1658675222.git.matheus.bernardino@usp.br> <4n20476q-6ssr-osp8-q5o3-p8ns726q4pn3@tzk.qr>
 <CAHd-oW6LZay=MX2FdFjgTh1pjE=g-XTm63mGWuMhHd=-N=tXRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3nEJh9v39wu+4GmmAYni35Jyjqr8SfJP3Vp+PL09ntwpQplPtte
 e+iq53lHUh6IKMVGxsg5p5bbl1Q6/b3TQ0fdmg1IktUSJHtrI0ShV9Uix9xNMc7GwbVfI1E
 5fa6T8vVBfkGXraGNNbH6tBFsaj+wvDnd0F/gpizuKZkUMTtBpFqNH88EoQDaGnAogDMB7w
 V9wpkECg6z/SD/N2XLhBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CX6/uO2cLmM=:BWKtQRoVTGY0e4y7ctl3R3
 eMuX7/uzfrnXXSlkfmDxTSN4oFv1Pxg+hwcvLQ10Gd7bF4sunuJqk7t+T7p7cjYcvOEmbFBKV
 f5Kl93M5u80FpClUkYqtqhEPZ07lYZfT8vg6PJ3t7qsE3R19/m4WPFZWpgB0M7X/WEarraAda
 pZfxAPtQHPlZ9vWn7JT0JJ9sr3fNR25jNb0Bv1SDRxfggJ9WWI1SoTl65I7irWY5CEExiQaVH
 uiTY90BzRkF0UdQeYBhQFjJ+EbeYFLujaLt5K+c8MRSDdkru9E+RlluDYI0GuVpyyAVZhNpDn
 kyAws0Cc/Cgg+1QkXBmOaLudHQMnXyYgj6PLgTXE9IdYmL2yi/0z09iyiPaouX2g+5XGn6rwQ
 AdOPCWCaee1ZgF1Agek5tGlEsANZROp7EWQkXBh5eN3uFRNyetL3l5bnOBd0oImkCQPnhuVsR
 mn53Rsbww6AjNS7KcVXWN+l4+O6x+Z/6FM9r3R5bAhoQCgTxlDibeldbuqfxPhqcbYVFplmt3
 PVM1BuH00s9Foqde/lCbeiASrkeBtxDgx2MFla2ocHiEvICeLYWrk8nEhnSp7tg+9mnPyfsiO
 KBDgacHpsJjjE1kQSd7RRVlfgA5kAInchG3wpYLj8LxQ7V3XsbdgiV8tNKnL4zHRy+b6ywfFu
 1kBUxHoXsEeF+nPFo5Np9lprHuS/fRapAqQ5cc2R8+jblTo7xl+iLpU2J2ZK+SSvAjcwRGyRs
 fNgapn6bMpGKZDGNywO2bh2bsocR04/92GDipZRRgZhp7H4s7EDXM29LmpYY2NbRHXm42Mezz
 84WnzxznbecczK8vtr2Sw9hr3iY7Z2MMSHK/k9xehyd0bLD9aQI/ZkQcuAW0B4DlI2pSgwQ2e
 nxWHfALehFDrhy60R+VN1qqBjPkdm7bwtfFGSaxD49PV3UAttKaP/Ida0Oj/8rEX2/CIrT5ac
 dL2karqvsjybKWouUJTYw681zV/XRhU9CtxlO49yRzU/KovJTnkWXs1r2dHoqOx4uLe6bEZgN
 idzlzhN9WRAkvNHPbRiJObnMXxdMJ9kNmu3APnwCX3ERzb17nmtoPSvp8GP2r923immq4cqON
 tjAJFnyKUSxeUlvpgS/qE7rZPl0TeyWbKLRKvzb4YfrBVZtAFegwpab3Q==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Sat, 30 Jul 2022, Matheus Tavares wrote:

> On Thu, Jul 28, 2022 at 1:58 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > > On Sun, 24 Jul 2022, Matheus Tavares wrote:
> > >
> > > +static void command_loop(void)
> > > +{
> > > +     while (1) {
> > > +             char *command =3D packet_key_val_read("command");
> > > +             if (!command) {
> > > +                     fprintf(logfile, "STOP\n");
> > > +                     break;
> > > +             }
> > > +             fprintf(logfile, "IN: %s", command);
> >
> > We will also need to `fflush(logfile)` here, to imitate the Perl scrip=
t's
> > behavior more precisely.
>
> I was somewhat intrigued as to why the flushes were needed in the Perl
> script. But reading [1] and [2], now, it seems to have been an
> oversight.
>
> That is, Eric suggested splictily flushing stdout because it is a
> pipe, but the author ended up erroneously disabling autoflush for
> stdout too, so that's why we needed the flushes there. They later
> acknowledged that and said that they would re-enabled it (see [2]),
> but it seems to have been forgotten. So I think we can safely drop the
> flush calls.
>
> [1]: http://public-inbox.org/git/20160723072721.GA20875%40starla/
> [2]: https://lore.kernel.org/git/7F1F1A0E-8FC3-4FBD-81AA-37786DE0EF50@gm=
ail.com/

I am somewhat weary of introducing a change of behavior while
reimplementing a Perl script in C at the same time, but in this instance I
think that the benefit of _not_ touching the `pkt-line.c` code is a
convincing reason to do so.

> > > +
> > > +             if (!strcmp(command, "list_available_blobs")) {
> > > +                     struct hashmap_iter iter;
> > > +                     struct strmap_entry *ent;
> > > +                     struct string_list_item *str_item;
> > > +                     struct string_list paths =3D STRING_LIST_INIT_=
NODUP;
> > > +
> > > +                     /* flush */
> > > +                     if (packet_read_line(0, NULL))
> > > +                             die("bad list_available_blobs end");
> > > +
> > > +                     strmap_for_each_entry(&delay, &iter, ent) {
> > > +                             struct delay_entry *delay_entry =3D en=
t->value;
> > > +                             if (!delay_entry->requested)
> > > +                                     continue;
> > > +                             delay_entry->count--;
> > > +                             if (!strcmp(ent->key, "invalid-delay.a=
")) {
> > > +                                     /* Send Git a pathname that wa=
s not delayed earlier */
> > > +                                     packet_write_fmt(1, "pathname=
=3Dunfiltered");
> > > +                             }
> > > +                             if (!strcmp(ent->key, "missing-delay.a=
")) {
> > > +                                     /* Do not signal Git that this=
 file is available */
> > > +                             } else if (!delay_entry->count) {
> > > +                                     string_list_insert(&paths, ent=
->key);
> > > +                                     packet_write_fmt(1, "pathname=
=3D%s", ent->key);
> > > +                             }
> > > +                     }
> > > +
> > > +                     /* Print paths in sorted order. */
> >
> > The Perl script does not order them specifically. Do we really have to=
 do
> > that here?
>
> It actually prints them in sorted order:
>
>         foreach my $pathname ( sort keys %DELAY )

Whoops, sorry for missing that!

> > > +                             fprintf(logfile, " [OK]\n");
> > > +
> > > +                             packet_flush(1);
> > > +                             strbuf_release(&sb);
> > > +                     }
> > > +                     free(pathname);
> > > +                     strbuf_release(&input);
> > > +             }
> > > +             free(command);
> > > +     }
> > > +}
> > > [...]
> > > +static void packet_initialize(const char *name, int version)
> > > +{
> > > +     struct strbuf sb =3D STRBUF_INIT;
> > > +     int size;
> > > +     char *pkt_buf =3D packet_read_line(0, &size);
> > > +
> > > +     strbuf_addf(&sb, "%s-client", name);
> > > +     if (!pkt_buf || strncmp(pkt_buf, sb.buf, size))
> >
> > We do not need the flexibility of the Perl package, where `name` is a
> > parameter. We can hard-code `git-filter-client` here. I.e. something l=
ike
> > this:
> >
> >         if (!pkt_buf || size !=3D 17 ||
> >             strncmp(pkt_buf, "git-filter-client", 17))
>
> Good idea! Thanks. Perhaps, can't we do:
>
>         if (!pkt_buf || strncmp(pkt_buf, "git-filter-client", size))
>
> to avoid the hard-coded and possibly error-prone 17?

I am afraid that this is not idempotent. If `pkt_buf` is "git" and `size`
is 3, then the suggested `strncmp()` would return 0, but we would want it
to be non-zero.

The best way to avoid the hard-coded 17 would be to introduce a local
constant and use `strlen()` on it (which modern compilers would evaluate
already at compile time).

> > > +             die("bad initialize: '%s'", xstrndup(pkt_buf, size));
> > > +
> > > +     strbuf_reset(&sb);
> > > +     strbuf_addf(&sb, "version=3D%d", version);
>
> Thanks for a very detailed review and great suggestions!

Thank you for your contribution that is very much relevant to my
interests!

Ciao,
Dscho
