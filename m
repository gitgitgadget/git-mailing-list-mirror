Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 012C81F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 10:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfJGKRv (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 06:17:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:58923 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727324AbfJGKRv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 06:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570443457;
        bh=SdYDUCE31XCPvRAPLKfp81sQXyIIfxwbDiDeMuiN8nc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hBT3IJYEOQ3/EePb5x2w0IC1R7bs8kGhkr6BDUA/IInU7W8UNUCOD/Ek4tloJyczd
         4gkrBySjuNmEyqKe3NPK0Jo+rjmbViywixHg68B9/Tb2mFGQR1hLcHQFca53t6abDe
         OhiWPZ/cCCUm/A+Cydw7U8M41FWO0556+3EcevqI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8ygO-1iDYjn1ktK-00688N; Mon, 07
 Oct 2019 12:17:37 +0200
Date:   Mon, 7 Oct 2019 12:17:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 1/1] fetch: let --jobs=<n> parallelize --multiple,
 too
In-Reply-To: <nycvar.QRO.7.76.6.1910071212170.46@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1910071215270.46@tvgsbejvaqbjf.bet>
References: <pull.369.git.gitgitgadget@gmail.com> <pull.369.v2.git.gitgitgadget@gmail.com> <93a155a000571df3f3f3a63cd8d886d68fbe8403.1570301198.git.gitgitgadget@gmail.com> <xmqqftk67r6j.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910061151440.46@tvgsbejvaqbjf.bet>
 <xmqqwodh4ann.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910071212170.46@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kpNVArjwmfwAwWQAqllkzrT7lLaEYp8dyZBrYjWNXkcqqttnqLF
 hxBVyGHbloVAAPqYCCIS/pEeJPlrwvHwJvltOeQ2PY+lGpevRw7VPjhESiG6It6K0FtC7sA
 JIh+TWDJPZneRRXVWZKz7+FvoS2+tXeNNhBGbXN+5IHf4fhi46Zpu2Hz6evFCpzAMkYZLs1
 0I0uQgMVfVPPCZHrNGZRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WAsciRL1UIU=:I/o+ZM7DwWeImOcFVfccRb
 ftTqAPqCG9ui/6fryTEi/ogBPCpoKp41fh5P/8O/rrIi1f+i6ScccZYiDdyOnP8wwnqxrlv4D
 fFNBrmEYr1Ue6hgVkjHeHe33n6bbgZnIOzwA0d0eT46cqb5y90TEN9JDcOQnVCmjfx5KxL0be
 TmUhnPhzshxo7Bk2Tg2ZbBMqxqk9lzSqCBaU/6gIVkbURKUM6dDDwXTthhXf0augEa/Sqm/9W
 wzyWYPsr+WPTyWJrcUZGYtyJKGnNfPWBaykg4Y7sB7Ru7ZEPTbDjVf/TYryCBuXR5e635d2Tx
 ysJWZLq4eYtWMrb/uN/zvgCJKoZCcFQKmuHhNr5IQ+2mr0LQ67pvJzL8JpxbRcPLyA4f4fwZW
 y9s6kwBEokClN2F8Ylg+HQiKNtRsW8ALg2oGQwcaa//UGZw6WoEUGTfIEt/eAFyr2P6LbEdn1
 R/vnrac5kpsH+SuNVMkZ5BgqGQm7PC+f5FtSciBNJ6+F9XQw0dJWj5gswu+Ha+RkBOKhGTsEt
 b9FTwDoPyKzC3aKRmKVkV4X2Uq978E+TVlrkGUWH+Y1lVRwwjJ1ginn4KPHZ/nIqsecK55WSL
 qLY3jbTFe3h7oUo5qP7oh+Sd6u+zYvKDoyV33ToilxdXp6Q/IFgAl6lEHk5MTUKfJmO3U25Mv
 i+q5h1yizHSiXRyUzcon6RTzPFiheUxP+eV5LGj4hou6pbvDm8DZFakprh84LfRoOmTAKOCkW
 yzVYXf4EokllW2MOEJ4DcQFatv/kbxO31QlYH/wTZ5xdKIR1mrjeh6L8iLHXhLDAeaUHKdB37
 UJLzgtzP+Fp/OZLVd78uHxmWuzcHparU0QLZ+L421zpZAEWFcpMnxeNoZE+suiZYlNgmAznYQ
 944OVphNzzQSadNpfSmNRXbxtF24YrjO6gu/FobuzNfHTVNGiecqGsfzD/U1DxzDYNw21x24Y
 RqZNEqUN5NdPqvtIWeOBkwTpf2clJyZt+OPaf5lxxQQ4BhpDusw/3/RoACZ2hwNYSWxOCNzIq
 YGq7nvZ0Ay0nSRu3skWKi0nCHOv+ANPrgfrQfOwlCZkOl1F6FyHtlHb7Qvxg4PMZaWQOGaaCa
 cJNBuGWJi5wrlL2S1jY5hOluFCOOKappsCdkxpSklUnOOvvh4Q/81JUIr3R3CLVFqICA7uax/
 x2TYZ1PMjeQsjqKph5AA7/sIRaHo5Z4njL8vFQtM0oPMU3FE/yFiidqiM8liiskIMpFQ9cqny
 S+P1bN4MbxMCpJWxVnYpocFYI3PsMB/xrGgG4rM6Wfmrb5pTyBZBE2N6h2R0=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 7 Oct 2019, Johannes Schindelin wrote:

> On Mon, 7 Oct 2019, Junio C Hamano wrote:
>
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > > Hi Junio,
> > > ...
> > >> Thanks.  I think it is much better to prepare these tests like this
> > >> patch does to be broken when phrasing changes---that would give
> > >> feedback and confidence to the person who is changing the message
> > >> and/or the logic to emit the message.
> > >>
> > >> Where does the constant 128 come from, by the way?  If it is from e=
rrno.h
> > >> then we will soon hear breakage report from NonStop folks, I predic=
t
> > >> ;-)
> > >
> > > It comes from `die()`:
> > > ...
> > > 	exit(128);
> >
> > OK, so hopefully we wouldn't see any platform specific variations.
>
> I am certain of it, as the matched `128` is not printed implicitly, it
> is printed by these two lines that I added in this patch (as part of
> `fetch_finished()`):
>
> +               strbuf_addf(out, _("could not fetch '%s' (exit code: %d)=
\n"),
> +                           remote, result);

Oh, and I forgot to say: the exit code is expected to be `128` because
the added regression test case uses a non-existing path to fetch from,
essentially saying "No, `git fetch`, I expect you to `die()`".

Ciao,
Dscho
