Return-Path: <SRS0=YD5J=2F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B349C43603
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 20:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEFD24676
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 20:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KoGXtnor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfLOUbE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Dec 2019 15:31:04 -0500
Received: from mout.gmx.net ([212.227.15.18]:34255 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfLOUbD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Dec 2019 15:31:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576441857;
        bh=xZsnzR6jtO5RZPLXmWDh4BLhdspQu9qZCnzjHr5J3W8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KoGXtnorR10l0eK1VvVjPp7wiUL6s06Da3VKw2jPlqyNGUhMxyO8Fna/D1qD0zONc
         qh+3uvUCgDLUAfrK3OGBbApUlmdaD+vkTkN+WshOeldDCDCRDtOtLTfT/Y3/Hf3bmp
         a34AgYKTGDnV33eyBvlR05rYWCEexIjgBzTKnSrY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZTqW-1iAEWl0PTC-00WVrp; Sun, 15
 Dec 2019 21:30:57 +0100
Date:   Sun, 15 Dec 2019 21:30:40 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Denton Liu <liu.denton@gmail.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH v3 1/4] git-p4: yes/no prompts should sanitize user
 text
In-Reply-To: <xmqqsgloj9fd.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912152125390.46@tvgsbejvaqbjf.bet>
References: <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>        <pull.675.v3.git.git.1576179987.gitgitgadget@gmail.com>        <fff93acf4430e2e7702ae1345f9899244a9867aa.1576179987.git.gitgitgadget@gmail.com>        <20191213014537.GA13064@generichostname>
 <xmqqsgloj9fd.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PTJxFW5jaCdwVnwXeB/aVmfuqnccN1/8UGdCE8ZmSvUi3jjLcyf
 xBx3+/vM+nfvIvcmt/ZZjIUMldmaCVg5UgQBtwMRmIQ7VXGOKRXARGegUPdxoq3sEOTlGIQ
 hvusSgj1fBUnh0V+Ww7ZxMG84/zUTPgU5SOQ3JFuOzTeGXoY3kSsMP/WEGhP6ko9vwQVs9K
 bXVNCuAwQVxnlZNE2nXEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9H5Xs+3f4Nk=:GvTkxVy8lyPfr29rtk+jpu
 x9K861l+JfJHb+UVlVC4fr6bIPhgzFRD1JruTra/TbNhSCCnRUGF2Wcj11CVLqMIrbWwnj6KB
 lYOw3M7oqy2mbS1qf4pXattvMnEZgmOI6zOgVwdpXC1188IfgwESLQGWL6e3x4sXC3PenmP17
 IAIBxXXbtIiieTm8RDRbsoNtyXXYwaOSKI3UNnvBEFPN3Xdn83mkLmm52baQJ8pSh4g8Zo5yA
 AkS8KhkeLyAaA67rLGIbbBH2oAREO8EtS7C+91GA9Fbh1YjZ48eGiROA5eFb3MxiuRBZGQaaE
 V8/7mJ4A4JwakiSIRDBfn9iFuYi32J+cMhk200GRDDXMQqwU2h4DUQkNn/T8D5CsPHkwA6oF9
 wTjCh61ITL0ZeZnA5pDwVCtoILwaw7Wy1ys31tqRWG4HB+JEjXdifRo7Ak5MKCspeUS+5shwO
 CGTtWDWi9SU+zLJgU330AjlobQEbVPgsIrc7KBIifqNzBsy9R+CLirKmFR5OWe/VEikoFIZoI
 arPh39dQT9bOiMEPzxJ9r9+OwKSit1IQ5lcoTrKfDEVsipJ7OSkjU4fZoR0nt5a/00QkWrwgC
 dFB/kEbi6iE5OmW1j6ebn68qWs1VoLukCR6ZeoLzUfYabrcH9m8OlEgJ29pELmo5iZpZ6XGUX
 WKOM4mkvMU+uKKKGxrGAFrrjtVwkZ2ivO0aZZzJvIPube2ph8OR8aAaHxx+aH5yk98UBvJy0H
 wsvLiLGjhD8ckjdfLiZk89svaCWNJJsMQMU7tXgMG6ZlpCyE50dCNg5m4YIk6Ll+z5/VBKVlx
 2dqwHNfzuUFN8L1x51O1LchnXv6IR20nEiEkePOz0HrPkC6oqciWXM9x3E06z+ljztBw0L/K7
 WJviU7TwciS5/mzd1yaYU7m7GNz/OZYbmYqGVqc/tP0cbwvlLvykm+1kHI815bGegVSPX0xPe
 UcVozVOR2P9ROssbjwSJDv/5heqHzN2GPvh1Rdpk4Ci6And8KQEe2F3k7rbBEPiew3S16mRx5
 401RFP6bWeL0rf8HZCXalj4kIw/KQ+r6zerH2lZbeKmPk5ZHy5SPX8yqGfrUGMWt7YS40O3BM
 pKagCBQ+DjZaM9PeJg1iHuY8R4IGTkAF7TmpZO8TpUpxuabH2xffQIg32Uu2qFQeASMRzh+kM
 KYHUub4FUVJrRKghd/HqCqdTBJ8t8W1yhJczW/AGFmR/O8XEYvoRhzCMrzgD+YGyVPmO2vO48
 XeiFI67ScoWWwxEn+scHcUwWIuWv7A/P0pl5pzsCpQDuosupkB7UvnJQSRXI=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 13 Dec 2019, Junio C Hamano wrote:

> Denton Liu <liu.denton@gmail.com> writes:
>
> >> @@ -4170,3 +4175,4 @@ def main():
> >>
> >>  if __name__ =3D=3D '__main__':
> >>      main()
> >> +
> >
> > Spurious trailing line. Perhaps we could make GGG error out on
> > whitespace errors before submissions are allowed?
>
> I think you are asking the tool for too much support.
>
> It may help a lot more if we gave a Makefile target (or two) that
> the contributors can run before going public.  Perhaps
>
>
> 	O=3Dorigin/master
> 	upstream-check::
> 		git log -p --check $(O)..
>
> that can be used like so:
>
> 	$ make upstream-check
> 	$ make O=3Dgitster/next upstream-check
>
> That way, those who use format-patch+email without GGG or those who
> push to a shared repository to be reviewed among the peer developers
> before going public would benefit, not just GGG users.
>
> Hmm?

I'd like that a lot, _and_ I think GitGitGadget could learn the trick of
running that `Makefile` target and report failures back to the PR
_especially_ because GitGitGadget knows the base branch of the PR.

In my opinion, there is a lot of value in having GitGitGadget doing this,
as new contributors are likely to miss such a helpful `Makefile` target.
For example, I vividly remember when I contributed to cURL for the first
time and had totally and completely missed the invocation `make -C src
checksrc` to help me get the code into the preferred shape.

Ciao,
Dscho
