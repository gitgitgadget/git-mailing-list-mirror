Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC63C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 15:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745422068F
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 15:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="B83+cT2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfKYPWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:22:16 -0500
Received: from mout.gmx.net ([212.227.17.21]:54435 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbfKYPWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 10:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574695330;
        bh=UUP3XmhJk/iIZtLNIn88unhZiimTzPqlPH7OKCjQH34=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=B83+cT2zsq81I7DBwQn2bveiDZBDVjeu9i7g7+/otuaBQkTczbO12lKh4ok3sPRVH
         34/2HOvVUyv7v+9IE/SN6aLyESlYapmodHIrC9Ar2NGgLd/p4li/v9a5vf3vQ+fid7
         zaSyBjyas+22jjD6yNwYRmm9ksE5Rhn5TWEg2Hdw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeCtj-1i0Ckn2nFn-00bIzq; Mon, 25
 Nov 2019 16:22:10 +0100
Date:   Mon, 25 Nov 2019 16:21:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/8] built-in add -i: prepare for multi-selection
 commands
In-Reply-To: <xmqqa78p8x6c.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911251621180.31080@tvgsbejvaqbjf.bet>
References: <pull.171.git.1573821382.gitgitgadget@gmail.com> <c324b47592dca2cd4967d62d2520a35bfcf04bae.1573821382.git.gitgitgadget@gmail.com> <xmqqa78p8x6c.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/eOW90oSJqxaNya6ZGJJoRtlXlYDhoZtkITetlubrf/h/Kq1dk6
 kbBO7SyWa+ZSvDxB3PdPGUc8On8PoTvlhXFpCzRlQKUSOk6oeX2q93aEmaa6vWsy5fxKeV2
 JVYpSnwfJYedfc9frdjv6MhG+c+AhOLTq1PHPDnFPyZzbJKVNOwKAUn2hqGjQzDAMqem9BO
 Zp9lLJjlulQYtEY0WHxpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6DStNKd+eDk=:/l//se2D2A4YVS1tLK9vKc
 z/n45qoXF6oPcLsjJdX/c+gk93i5+05MQspUHRCVxTgWUAwC1e8qjO1g3pXCYMAGwkhIOYNCb
 h33utBQQX0pimTiuM7MQER6tBhF6Oa/o8JmVOekoDyrHajp3+d2F/F+QZbY93B9/UtwcAgUFU
 Jc496wy8QFEwDBd7y7oOVndL+Qnu1iUxnlWeZR49gKvKN2Ew3yFXwP+isZBUUWIm7mPDGQeCj
 SvRCL9s8pgighc93Ip0439UCNrMJs2bNiCHSxSU4tJvtoFLkXfx+jQ9+XKXTKFRGf/xV01dy8
 oV3oVAlaV4Gns5BZZMtMvYZGi4NS5oTDvGrpVvLAU6V68TZ0F06z9WQ/cPhutwD774T9lRz3h
 PsSJYUJkN5vi9ftIIIokgYLTA5W+ghjhGrET08skrrw7Y5ophI0oAgcr1VqovcsKpX4iHOzHw
 NajcYI8UsXjpcrW7qfuGfEoPd9OayWrDlE7wF3fMnwhUm6WlSd2KgsHEmQFUPrw0VpcmgJ1zJ
 DZnI8vGR78Oa3Qn4CJrAeL7VXOhfWVrNtMQcr2bCIkboeGYI10SIJU/9kRda83/kUr3O4Xymv
 M7ytoAxaFibl7dt80WHMQ2J3Nxa8UY/w0WjoGLgLXNd+Ejoij4mzryvNmdq52uSt3ZXQ04GHI
 PK/Ryn7XPPLxpgsunuePNr8OqGvL7PaMtHpKDqvnzTCGKf1xUWwqcRTnJN+bb8ORbOpP/6G+V
 wYbWhcF4i4XbI/bSbmxH6RaOubA5WYzxMm+t1OhLGxPnDj2CR/5a6jUTZ86SpA9FJzrN2F3YB
 vwgciUkFU53UVwDOZWRzp5l5lwCJNAK8rKhP4f9RB2Acn5toTWrvyCNSWEhETaPOq2rdOblBs
 HNRuIY3s2B3AouzbA+HOXeOns/fIsKdgyaoZYI5FHNPj0pmvb4GmxgmZ9W4rn9u4YvrOf25O5
 8tFQEZ6IGx2tRvphY77V8XQz1vAboL+IQYxDJGR/vfPMCj3nG1P2oAvYlwlSjuUK7q8JByVSf
 TtDTV7aPosu9jz7ALht++eQEkFBbDUm2dTrS73iwDVSHPfSZb8ialvVlXHZMvLMbTS1evZQlN
 /3aaHog+qtmBZbit+dpT0KncbDP6As4m6iTUqovd44qk9fsXShM95VRxFxbcqiPs+r0eOhDtj
 ZY584zy676D6cTx9P7AmAyh27DYCwSY4Alwrx9m8vl4nKy21GQcbPo1V6yF7/AWxLUaa+tR6d
 69Pb8Ewd1m1WGpZ3OX5anR+q+Z6Zeu2NdY/MSULjNcreOfv6o5WUfTxwIacA=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 21 Nov 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The `upgrade`, `revert` and `add-untracked` commands allow selecting
> > multiple entries. Let's extend the `list_and_choose()` function to
> > accommodate those use cases.
>
> upgrade???

Whoooooops. "update", of course.

> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  add-interactive.c | 114 ++++++++++++++++++++++++++++++++++++---------=
-
> >  1 file changed, 89 insertions(+), 25 deletions(-)
> >
> > diff --git a/add-interactive.c b/add-interactive.c
> > index 8ec930ac15..33a751150a 100644
> > --- a/add-interactive.c
> > +++ b/add-interactive.c
> > @@ -72,15 +72,17 @@ static void init_add_i_state(struct add_i_state *s=
, struct repository *r)
> >  struct prefix_item_list {
> >  	struct string_list items;
> >  	struct string_list sorted;
> > +	int *selected; /* for multi-selections */
> >  	size_t min_length, max_length;
> >  };
>
> OK.  The shape of the data is enough to tell us what you did in this
> patch and I think it makes sense ;-)

:-)

Thanks,
Dscho
