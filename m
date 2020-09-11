Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D054AC433E2
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 10:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D87D2076C
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 10:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="A/G1bvpm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgINKaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 06:30:01 -0400
Received: from mout.gmx.net ([212.227.15.18]:44351 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgINKaA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 06:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600079395;
        bh=VhYJQ9vtkoM8uZeag6u+BBt2YaZnDLlfqe/Ck0sRcAE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=A/G1bvpmBWWKZxnWuYFbjCTHG+b7zmj3chR8bqyPqbLwM/9GQpKe2mQYM2k+ooOxk
         TKAaaLnKeFs+FfsaJFvS9qKCWZc3z3UKNVEDE4oa84fJkP+0lbMePPZa4W4gJXMqKz
         RIdHtuADCDzLZhsjHUJsYC/cJgJ+q/v2AMRrO3s8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.239.213] ([89.1.213.162]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdvmO-1kpRrx0yu6-00b2MW; Mon, 14
 Sep 2020 12:29:55 +0200
Date:   Sat, 12 Sep 2020 00:16:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] push: make `--force-with-lease[=<ref>]` safer
In-Reply-To: <20200910144456.GA25125@mail.clickyotomy.dev>
Message-ID: <nycvar.QRO.7.76.6.2009120013070.56@tvgsbejvaqbjf.bet>
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com> <nycvar.QRO.7.76.6.2009072119350.56@tvgsbejvaqbjf.bet> <xmqqr1rcxdsu.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2009090542430.54@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2009101220400.56@tvgsbejvaqbjf.bet>
 <20200910144456.GA25125@mail.clickyotomy.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:D1kYMT6WUgx0QKvJhjzwiN+iIUVuue0DGJqUnpQhkkItqaCho25
 vBz8WmSW0NznAvBVQ1w0i//gf7JQXTyjsa6954vINV02rv9DdWY5n4iztpvWASlBcJ8QUCc
 6yFboND3blQqSrpr/GGQBJst+oaKSKV8ojZ+nUqTUor5WmfGFH7XylgobTQTBXyk1MJBP+7
 mkCNzYjAHh3F7ggJZdQLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:joUuI7llfvQ=:SL/AZhHWgcktfhOanHGvNE
 g3/kJ5VhHE7vWeS4BaWtGPPLRa3SU8pjdJEo2OXJLYwsxIGOo9XujXG7PFPavEF2HeYi8ACgk
 7NFiM86N/lx8y1X1O+npNvxi1/whipVJANcrmMTKScbz9HRJMIpCMV9Z/BCe/4TGMwgUerO48
 7CdCsp5Syz6XmjRKinTNffyd3BLhvm519GbCb+yyfXBUPM+LM5uGB+Uy9y/vVN/iFrFEY9cYI
 6ypJv+fVwAjCrGVoo1zCkI5IUo89Krb09J3oC99qKAXNHgWOangk0OKoOEcDgspayrgKzTWs8
 XFtXyPJF3rd9/H+xsrpN0N64gLBkRi01lIhd6eqZOPPPtMFGH+1oorkm7ykPhvdMCOoRScN8+
 Rq4oi4t8xWEueEF8Lpyx1K3aPTSGztQgLSTjPRGqJZA5pvOKnBuP9qy5qxJRLRxJl3H1lsj0d
 nAVu2sOQz2/wq1NlpmhrIsD5cYNcA3e3OEcFRkjjqJoYjxe62EKCTjNp2OeE4B03VHxy8m+Vp
 vaXOjeItPoHXuBoJsM9UZ/O306/EMMlCvli6s01BkkJAHkeZgiLNSAeCaM4kryGUzVM858b0a
 EzvNG7Vnat1HArEFgVWDsKHu+qfgkIEF9QnH5r7ibUMHgYEMyQogd3FZ0utfujVxtK/Efjh9p
 f1OS8OQcjwpDFeSQeVQW0DTmN2BkJsx0GdbkEaM3hTd4WbRU/zToqL69flBBwH4EY1VboDPnJ
 3ORDd+xTD9lxZ5zteRioS30+6F/eIQjwA8qNSXqmXP9I8IRX8QcTAwznMPhTanS2h/VNbB5qW
 Ws7jnh1sbgfM5onchFgAZESiMr9UsazgRY1zdqaDPpybYTEU4zGRq3+zrFe6igh5sRoyyhrH3
 p+gEh4Xb7JYXbIs6uYw263vsSGDrQUdS5P609rPFXSD6MUU0mf7tkZ03IgylMq9n0aumjMPb1
 o93a5vvOqUbrIrz+MUvXI6b0vd50/w8xoc5e/2+GMJ+f1N47S9/ziJTd+/3WPKB+gGiyxJBwZ
 Sp5uzYrKpKHGLE/jhmFIs8+TaWgBIw2pxDKUXmpdBAM7FPYCXiCpMjw62QkQrWfTYNWv8iM8o
 iO+D/gAfyN7LyYoxqwR1vBun/lRXJMT4dIQvpWwGLiDpS9VccI3ZflFP79mS+QFAdGJAtAn5n
 Li4ig0t2c4nZIAXqZPPTLVrc0R7mXzuLUzZyhmqNs8Wr/wlSPvXgRC+t32F+RLK5URDTnZedU
 SQ8Mob2ujVNN0nuKIornVlsai4OXX/DVD1WPJSg==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Srinidhi,

On Thu, 10 Sep 2020, Srinidhi Kaushik wrote:

> On 09/10/2020 12:22, Johannes Schindelin wrote:
>
> > BTW I think the patch needs to cover a bit more, still: after I run `g=
it
> > pull --rebase`, the local branch will never have been at the same revi=
sion
> > as the fetched one: `git rebase` moves to an unnamed branch before
> > replaying the patches. So I think we need to see whether the remote ti=
p
> > was _reachable_ from (not necessarily identical to) any of the reflog'=
s
> > revisions.
>
> Good catch. Would adding in_merge_bases() along with checking if OIDs
> are equal for each reflog entry in oid_in_reflog_ent() address the
> problem? That way, we would check if remote ref is reachable from
> one of the entries?
>
> Thanks.
>
> -- >8 --
> + static int oid_in_reflog_ent(struct object_id *ooid, struct object_id =
*noid,
> +			     const char *ident, timestamp_t timestamp, int tz,
> +			     const char *message, void *cb_data)
> + {
> +	struct object_id *remote_oid =3D cb_data;
> +	struct commit *a =3D lookup_commit_reference(the_repository, noid);
> +	struct commit *b =3D lookup_commit_reference(the_repository, remote_oi=
d);
> +	return oideq(noid, remote_oid) || in_merge_bases(b, a);
> + }

Since `in_merge_bases()` is quite a bit more expensive than `oideq()`,
personally, I would actually walk the reflog with the `oideq()` check
first (stopping early in case a match was found), and only fall back to
looking for a merge base in the reflog if the first reflog walk did not
find a match.

Ciao,
Dscho
