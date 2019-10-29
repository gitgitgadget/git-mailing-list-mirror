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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FCB01F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 20:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfJ2UJi (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 16:09:38 -0400
Received: from mout.gmx.net ([212.227.17.22]:56705 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfJ2UJi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 16:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572379771;
        bh=k72j7SZ3j3FJaHqWJh3x38WV7Wrkx7shl7OZtpcJqqE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SNTdmOWqBPYQPhWDCVpjb3LQhClInrfjjJdTojAUfE1reQUfcgclBngLtkEhT5yWn
         H+KvgMCGNE4nFsMFgENX5YHO9p8HHQ0vECcnMFSxBjjCkbbNCw8oFcbNd1MJVg/SDU
         CGVRcPOqegIdc9BnuZsVMhmeKbwd8uvyzPe9tewo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkYXm-1hgsqb28RK-00m58n; Tue, 29
 Oct 2019 21:09:31 +0100
Date:   Tue, 29 Oct 2019 21:09:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 1/1] vreportf(): avoid buffered write in favor of unbuffered
 one
In-Reply-To: <20191029143246.GA3683@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1910292101300.46@tvgsbejvaqbjf.bet>
References: <pull.428.git.1572274859.gitgitgadget@gmail.com> <455026ce3ef2b2d7cfecfc4b4bf5b588eebddcfe.1572274859.git.gitgitgadget@gmail.com> <xmqqeeyw6xyr.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910291222500.46@tvgsbejvaqbjf.bet>
 <20191029134932.GA2843@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1910291510330.46@tvgsbejvaqbjf.bet> <20191029143246.GA3683@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ha4SXtfi4MZ9pXH9qS/JOn4CR66AZTHXmTadikxEoi1InKP1YMg
 TT1Dz9GdyaHaA3ju9Za2xGxmtFvNnobPKMZQ7AznDZ30gFlELchNxm04J/yY0hV/KioRT41
 HolkO6FDUo4jg0ontO5XuXeBvNlfPexBQVXJR7fmv4ii11frTkufgBbJ5DJkV2aMFBtgojo
 sEERY4oX1+C9CfSXisaoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h5FA2XoLi+E=:+FrbB2T7KAqVnG00Xkvp9U
 GgCzq+yOqWFd4lbVmCB/FCE6S0ZBie8eXFzF8OsylQttxYmjzznNpDUeE/A1AxrpdNmkWcDhO
 7TElzMITp+CxhmeGAVbk5kURSoN8FDdMjIRTEXZUvypFFd0j0dHcLsKhsLrheny/l6KEB02Xy
 r7LWJcIEevOwqxXP9me77ztm+ry1vDm7aPx9rkgihgsF9XQJceanJyGgdhyxrPwB5KTBsTiJu
 n5J1Zwjm0MkKbr7fraAOxux9CXzRA3vnOyHdVmeiY4E54zcV0+KRZwv3mOVExqA594G1Ktg3O
 26HpKxEJrDmtczH3ZgdTsjqpd2p9qwJm4B7JM0sZZMIP9qrp9mVJ2tWaLv+39n0W+kwGL6AEM
 3cuooB9kAKNnKMvRGbtb8NcoUiuM5EPfXz8y3WmUk6azTUt1tCTZ+X8fa/b/O3ei8UPyEdRzm
 si6HBVh7IARGSxHq/uzSkRoJqbE5+QXftvl68DbONaubL3moHkOMLYgMNWQri+V3pQoCl3XYX
 qaJxNuja1ePA3ATsl3jTGpH5DzZlV6OzEl4BNO95HnEjufe25dUqeY/Qc5nT81pA6PTjsPGp+
 0iuodeCOOPDD8Pg8Yv/O/ZGa+v31Hl+fhfPKvS0dPXoZbSyBjQ01Li7CxGCYGSTsg1duwfD9r
 LRUi3L7rJzqS0bf7MSE+/RgaXAbvmWwVrW636xEhFcuu++GcuF+d1xueYcC7b9yDdvsU8CvHT
 7tSnurp2lfZYHPorC8j9DLUiwLyfCcyyGoY1Di0h8CefOTEmPaL0WE20ajCHVL9og8qMNUhJg
 fsMaTuF4K8Z3DQUy4qnEAZ3Xl3wQI1epDMZpry1Wh/8ALim3oQO2jEZEpS0LWCt/mp5nmd12S
 a7l2ZBLKw7pOs/qYP1zj3pQ/xh/sjpAcN+wc0CA7LoyyhMmWH+I30IH55iPCXDJ6vSAlu7hge
 eCP1W07Zate4pcfVSwkds3D9WmeZK8iOJm1zYQmR/Po7ygrgRVQkGpiUPgRL+lYMDLvBMo2IC
 Zn0U4gXsDiWXGRgIVFLAiGst1wdE6bBVGizi9eOu4OIA9wVpuJh3AuaNT9zaACrK0Skr3XvJP
 2UsbTHriAe8daaC9jB4RO2x6sY7VNETvKWNg/cZjt6yn++JxkUWPmuokoRZS3mPOCnOPtgR7v
 IUWwoqgNUBNC5V7FJpNwpter96aq4g4GOe3Aa9PItG8Y8cRwcFxTZp6Efwk0IFT2kDnUhdFjJ
 uUKIqhQGgksIfzaEVDz2+lqcf1ffP7qZXzw9M1Ae8JYYA3uVBQmC0XZusEFE=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 29 Oct 2019, Jeff King wrote:

> On Tue, Oct 29, 2019 at 03:13:39PM +0100, Johannes Schindelin wrote:
> >
> > > I'd disagree here. Any caller sending an arbitrarily-large prefix
> > > is holding it wrong, and we'd probably want to know as soon as
> > > possible (and a BUG() is our best bet there).
> >
> > How about truncating already inside the prefix, then? It would miss
> > the entire error message... but at least it would print
> > _something_...
>
> Yeah, that might be OK. Hopefully missing the whole rest of the error
> message would cause some tests to fail.

I am not really worried about that. So far, we only have prefixes like
`"fatal: "` or `"error: "`. The longest prefix is in `BUG_fl()` itself,
when we have access to the file name and the line number of the
triggering line, in which case it is `"BUG: <file>:<line>: "`. So as
long as nobody builds a custom version of Git that includes a file whose
path is insanely long, they should be fine. I am certain that Junio will
never accept such a file into git.git.

Oh, and even if anybody would introduce insanely long paths into their
fork of git.git, they would _still_ be safe because `BUG_fl()` limits
the prefix to 256 bytes, including `NUL`.

> You could also abort() after having written if we want to be more
> BUG()-like.

As I said, this is really a part of the patch I am not at all concerned
about. The prefixes are well under control, and I only addressed that
potential future breakage (that I believe falls squarely into YAGNI
territory) only because two reviewers seemed to be concerned.

I really believe that the care I put into the patch to safeguard against
overly long prefixes is seriously overkill.

Ciao,
Dscho
