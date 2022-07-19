Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8370AC433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 10:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbiGSK5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 06:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbiGSK5u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 06:57:50 -0400
Received: from mail-108-mta106.mxroute.com (mail-108-mta106.mxroute.com [136.175.108.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3E2402E8
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 03:57:45 -0700 (PDT)
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta106.mxroute.com (ZoneMTA) with ESMTPSA id 182161b4b0e0000261.003
 for <git@vger.kernel.org>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Tue, 19 Jul 2022 10:57:43 +0000
X-Zone-Loop: 7f56bc616c9f907b310a3cab880e4006ec5285570217
X-Originating-IP: [140.82.40.27]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=that.guru;
        s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7aEpwk2P8lStQHuOtJFZAj08vhcu9XFlJxzAOZsOVFQ=; b=APXffpYRdADUMV8EeLP6HSonoH
        W8djC2JwSgv27EFzxFpipOe3nP8xx0HCzO+URl/0QR5bSzDWoG8BF17S24zDu4r05cOEA0Br5Oc46
        Tk6DbUP/zECRHUM7G/ITmn3g1rUOA2RptW/zBvA1XSyqqEJge00jtXyIytPgsgaMSw194bEIMfbc6
        KLBzoQeStDFq8HuNQD7PhX+GQ7sNDtWVRbb/fv9yqF5Y/z4kfFNK+aE90ugXjW0OJNPJneI/pEdX3
        Ap0+JpM37Yhx+hmG7AUKzZjEgRPk/uhfOCTD18ypVG9G105hIjrc1LplbY158CchAh6NxRQqkQrXM
        PXORPrsg==;
Message-ID: <e2d73c87ae798de6d1dd21fe14371b8cdc65228f.camel@that.guru>
Subject: Re: Feature request: provide a persistent IDs on a commit
From:   Stephen Finucane <stephen@that.guru>
To:     Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Date:   Tue, 19 Jul 2022 11:57:39 +0100
In-Reply-To: <20220718190403.GT17705@kitsune.suse.cz>
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
         <20220718173511.rje43peodwdprsid@meerkat.local>
         <20220718190403.GT17705@kitsune.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-AuthUser: stephen@that.guru
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2022-07-18 at 21:04 +0200, Michal Such=C3=A1nek wrote:
> On Mon, Jul 18, 2022 at 01:35:11PM -0400, Konstantin Ryabitsev wrote:
> > On Mon, Jul 18, 2022 at 06:18:11PM +0100, Stephen Finucane wrote:
> > > ...to track evolution of a patch through time.
> > >=20
> > > tl;dr: How hard would it be to retrofit an 'ChangeID' concept =C3=A0 =
la the 'Change-
> > > ID' trailer used by Gerrit into git core?
> >=20
> > I just started working on this for b4, with the notable difference that=
 the
> > change-id trailer is used in the cover letter instead of in individual
> > commits, which moves the concept of "change" from a single commit to a =
series
> > of commits. IMO, it's much more useful in that scope, because as series=
 are
> > reviewed and iterated, individual patches can get squashed, split up or
> > otherwise transformed.
>=20
> You can turn that around and say that IDs of individual commits are more
> powerful because they are preserved as series are reviewed, split,
> merged, and commits cherry-picked.

There's also the fact that many communities insist on small, atomic commits=
:
they're much easier to review. It stands to reason that reviewing a series =
on a
patch-by-patch basis is also much easier, as is reviewing a series _revisio=
n_ on
a patch-by-patch basis. To be able to do this though, you need to be able t=
o map
patch revisions to their predecessors/successors and well as the series
revisions. I don't see how you realistically rely on a series-only identifi=
er.

There's no reason 'git-format-patch' couldn't allow you to set an
AuthorID/ChangeID/<whatever we want to call this field> value for a cover
letter, though it obviously would need to be done manually since cover lett=
ers
aren't git objects.

  git send-email \
    --reroll-count 2 \
    --series-id 300628e5-8b27-45fe-be71-95417f7ccd6f
    main

Stephen

>=20
> Thanks
>=20
> Michal

