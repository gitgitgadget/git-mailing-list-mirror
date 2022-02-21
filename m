Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2932BC433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 10:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352438AbiBUKIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 05:08:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353942AbiBUKHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 05:07:09 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296732717F
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 01:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645435909;
        bh=BEVatNI/9f5NXiYHJIsubssqtLYRX4oRUbm6wxDNW70=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=e59ygU/f37oWvhEkvXtdFUhkrXWEFCSh8SgLQ3L6yQcGLUE1lTOZTflZzRnNvrKtH
         CqWZxK+AMzIechmAii1pZ2zG2QGXZ/Vk6ChnPxI4tHgAva0uiKzKiRiD8nJFZzMUFD
         bzpbOwLIztODg/TY8X5YaT8ttKEb2jqHj3xlAsjE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6m4-1o7XM91tr2-00lTyQ; Mon, 21
 Feb 2022 10:31:49 +0100
Date:   Mon, 21 Feb 2022 10:31:47 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 09/12] merge-tree: provide a list of which files have
 conflicts
In-Reply-To: <CABPp-BFyaakDSjHULpBRPQqq_jz2keyufHo1MjNS6dHQNR+JLQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202211029220.26495@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <fcbb087fa8865ac05e20473d822cd9795590ee38.1642888562.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2201281755200.347@tvgsbejvaqbjf.bet> <CABPp-BEn=fvmTyYEzjSfvKkYyHj0te=6ck6WF+Jor+L1jKrVkg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202050011350.347@tvgsbejvaqbjf.bet> <CABPp-BFyaakDSjHULpBRPQqq_jz2keyufHo1MjNS6dHQNR+JLQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4XWgmjg7/IPtYRKE/GeM1EEfGmoL6jFmgdh0+cm3fk6skagakp5
 G/eOFCIAtaKAUZG8gLMNgvCBCwlUg+WUShihweZ01hlwvwxbzcbi4Zv5VpY4ydML5c52D+J
 CXlSCLoJ1tdP8kTPFiSMeECk05bElaNLu+qbl9pP/2iEd1v8aRGY+HrCEQh0272LNUAU+Oh
 +rdk40fdxp0Pi3ZRie27A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wgeMOAkgbus=:Y3slXmgb5LKUU1GiF+EpbF
 jIOdSK2AD9fuR1eu1myFhh391Xkc0H+Saktfj9FLCVYLavpHmF8rFNAJWIBQVQ/VyxYqZY/l2
 B+pNPCg4aA7szNOWxprlCWWG3h7T25becvQ854DAMKFTtSjvQEiDAT/A5yQlZnM9OqkcNtIWb
 O2ivwCV59yci122E8JB0+kM6yU4tiUFuL8YaF9khPgjwrhCDoEgyIsvjisdrHUMv4WlRTn7lI
 9MkGSYvvubEveubOUhKIV5YhK6X1iQ7GtvoDjuli5nDuuVOp916psf+ykY/pldIanDepfOFqP
 utJsw1X1uvwDSwUeqJoxpsqFXe9a4Gqy5UeIlt3gmmR8VivMO+XZFxojoo3H5ERKJRKiQjnDL
 2uO/OUMyXP5V2Y+/jn/5HU4+/pNyXuvMaFfobDY4DEeXNWE9/j9DLA3n6AigP4f4gjjbypvZ6
 mh3/zEg0owtRkSfvEhw/prsrf74aP7FcEwaH+BdZIx7+UMyfiahLVm4xkx/PxLpeVxAWGWu8q
 HMG3TXnghIIi5qGBw8Ry3BPiu82fM1Nf22iTCLaoGikldNsySMYsWyjlDqEZozAKCqFuEWsZe
 1ZbUF07gcxH3URksOaPOCJB4i0lQTSLkNnpdi95DBWJRD7z0hTNd/eJsWFHoJQ9ulvCnRMNOn
 yRY8oKXstyG3zSYLagzi4xW9ZagnHWxzOUoboFbr+wX7oTt3qGyb1Ip2rNqioIuI2N5KMEmuD
 tKqTDwuUHTrGbdfBw4kA7QJs2aR+OUlztEiUnwPVAZlQHFMzSTqC9gHrd4hNoaNmj/nV7EKws
 GiwCBs5PT57Pqq7T6Ds+XTON09rt1bqjtSn0W5qx5MZwy/Gkb+EevE7vuSmilCgs/7dmMGDAl
 hQ8tmdzUYadt2D3jcr/aJvFdZx867O95l3JeXDtL7EPksXqcypIJCxvsUt5JDhjrzsrKb33ZD
 kxmAouRULCLoT9SYJGZ20WO0aPhBYFI3LrZcVQgyesdp2NptouybDFVjAR7siMgh2I0qfIG9t
 kXd1Gsf34dM+ChCmWX4vSFKp+QqRejQpXIjz4r2H/f545CqUXNdkKdWa2jVyAK8JpeAqLepeM
 em2OLDXSt8W2ws=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

[reinstating the Cc: list]

On Sat, 12 Feb 2022, Elijah Newren wrote:

> On Fri, Feb 4, 2022 at 3:12 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Fri, 28 Jan 2022, Elijah Newren wrote:
> >
> > > On Fri, Jan 28, 2022 at 8:57 AM Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
> > > >
> > > > Hi Elijah,
> > > >
> > > > On Sat, 22 Jan 2022, Elijah Newren via GitGitGadget wrote:
> > > >
> > > > > From: Elijah Newren <newren@gmail.com>
> > > > >
> > > [...]
> > > > > diff --git a/Documentation/git-merge-tree.txt b/Documentation/gi=
t-merge-tree.txt
> > > > > index fd7a867de60..041a4ac2785 100644
> > > > > --- a/Documentation/git-merge-tree.txt
> > > > > +++ b/Documentation/git-merge-tree.txt
> > > > > @@ -58,6 +58,7 @@ simply one line:
> > > > >  Whereas for a conflicted merge, the output is by default of the=
 form:
> > > > >
> > > > >       <OID of toplevel tree>
> > > > > +     <Conflicted file list>
> > > > >       <Informational messages>
> > > >
> > > > To distinguish between the list of conflicted files and the inform=
ational
> > > > messages, I think it would be good to insert an empty line, as a
> > > > separator, like.
> > >
> > > Yes, I agree; that's why I did so.  :-)
> >
> > My concern was that I did not see this empty line reflected in the quo=
ted
> > diff. I would have expected an empty line between the `<Conflicted [..=
.]>`
> > and the `<Informational [...]>` line.
>
> As stated later in the same email, the newline is only printed if the
> <Informational messages> section is printed.  As such, it's part of
> the <Informational messages> section and listing it between the
> sections could be misleading.

Thank you for the clarification. I still think that it might cause
confusion in the documentation not to see the explicit newline, quite
possible when _I_ re-read this in six months from now. But then, if `-z`
is in effect, it won't be an explicit newline, it will be a NUL instead.

In short: I am fine with leaving this as-is, it might actually reduce even
_my_ confusion to the minimum possible.

Thanks,
Dscho
