Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8221C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 21:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBFB206C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 21:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Xjske0iX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfLUVYL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 16:24:11 -0500
Received: from mout.gmx.net ([212.227.15.19]:39509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfLUVYL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 16:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576963447;
        bh=47A40sWZQJlW0xSbJiT55/eV1aJKBPP6XnmLsbp5pys=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Xjske0iX+3H50SkSBtvYns/DvUzBpXhIy9drFXbdkBMV+55s33alSIj+JAgFs4tQX
         kRPdWhfM98EgZtMjmdI+P5vjLB13a/Az+S3vOnPQHs/5YaODsyKSGXMnfYsDUJgG8r
         LsbAWL1pRaraId1IV1Y1XkBmhPrShGU4HoNt8fiQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuDc7-1hosBv3zrR-00uYWB; Sat, 21
 Dec 2019 22:24:07 +0100
Date:   Sat, 21 Dec 2019 22:23:48 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/7] built-in add -p: implement the "stash" and "reset"
 patch modes
In-Reply-To: <xmqqy2vag19l.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912212221160.46@tvgsbejvaqbjf.bet>
References: <pull.174.git.1576579264.gitgitgadget@gmail.com>        <846cf16e77f4af39310902129be40fda664ace72.1576579264.git.gitgitgadget@gmail.com> <xmqqy2vag19l.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xFhSEwGUHwqQPclEcsP2A+UgogPAYGERQchUKi+Pv53NTex98RQ
 /6rYWaPmSP+ZUTaPUo/URBW0jsejkrOy6vziagMARX/msOyN2NgZpPSOyrYMQhxGEFsuA4J
 qyNK8jNsswU04JcZsyjysAcojZGyLg8VLc8bV0G1js26WaFU5azAWaiGTlzoJzFtnQ+b+zH
 mEfGVfX5oQkjPhg9WQPkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FbvdeQyKh5c=:WuNSXgcn8iqs+Wkp9vD4A0
 sDDA3wJEuJjUcXVIT/8Wf/IrJ/K7c1CJAcFkfoPmbxtD6/kkWXD6N6OzOdoPQFcBrOSkp+QwE
 k0EHsDIzlxiL9rIv/LZ0GQjLTE30Js+PO1BA3zSaIjKcUH0Cax4bUCiPd2g3daVcrAgL5sNoq
 equmsRiO/PoUisb5j3rovqIwyCrHyGTnPiimkIFWSFpfVe4wJd2DjV6FfqDOvxjDOAdVAOfLR
 n/zwMHpW3DvsoA0EW9fFIATmxeS+5bTuIAmwoAWga9dbx8PoJ++3u9VbhXHJopF9XFSR70H+c
 2PmGfX/s0/PqnjOh1cMszqRvVv0AFfHdJWuLp/RZ6ObuYyDKUjroC4or3EtZ3Wy3ntqqAtxUV
 k/Reev6iGqumyFJ4p77nqKGacByBg/ytm1t9MEtTAegGYUCmEVRaWaCWuOjD1NMGo9WaQTyuV
 t28iON85gbhgxdRB4xRnF5EN0ZidKExAdRhdAR60zqE7nBJLIy+3s/OOYs2cqHCtSBSKU+c56
 xFaL9CwayeyULzLYMMHxO71aj7D5jwotb2LeZlRlcblLuESpETwg9BknLp0nccY5KJkvfnNwj
 wAK1dhjr3uc3ah2FnDuPJ4AV61I5zTEUVrqxKscybCTKq29/oxA5DnBK2iZ49fCsWwk461qx0
 ulznyy3HcB3MsKEz5rUMq4ZY5kVSq7rTjMI0QKokNLb6koCoTidnNolsZf7ywRfVufLROWzCL
 UyxhSaSIfCokdRIHfEtCVI1m14yWb7bCrnY/nzhjj6aSSzz9kvX5ue39eoHrraKuCrYiyMfj/
 rmXBZb4TAGLKJCYJ39+sZJe6ZCP5W8InkJB5M3H2zjZmWW6XN8Hftj/CiJYKuOKh2EIjwc0gw
 9f1FRb6KjyqqZIXytSL9jaH4BIeWV4qj2BTs6nw43SBIH60KS04XrceWVAGXOaXAMBYutCBG6
 J2yeN5pj/S6WWzTr1bOTsV/cKvljUQgZ3/b9AD0ELs+30xLbbwBITRtDFpZSlv3nSPlZUCymr
 OmfsL1J5BXz1bbrfUbh5DTBBhWx7XvYZJSf8Fh/a14jTshD6cyk0fg58vFBbQ/XHh7ho4Ynot
 lRZtMG8kVuHQ3opxS7tihAG/iAn3KK9oyY1WZCd/3hisTMru2QueBUEzSe0+OGYSoQs46U9sL
 AZ37WK5T8iTYombj/IK/7TSNYiMGI0wC0tI9vDOOrZ4XlEkbfoAwVfwuv6dhknQfqBDSYb/Il
 TIzO4zU75dtZ0QHU6IJ8xWDKzKRZ4cjovX8op79eWuo8xKY9yY5Hg/IgK2hQ=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 17 Dec 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > diff --git a/add-interactive.h b/add-interactive.h
> > index 3defa2ff3d..c278f3e26f 100644
> > --- a/add-interactive.h
> > +++ b/add-interactive.h
> > @@ -25,6 +25,8 @@ int run_add_i(struct repository *r, const struct pat=
hspec *ps);
> >
> >  enum add_p_mode {
> >  	ADD_P_STAGE,
> > +	ADD_P_STASH,
> > +	ADD_P_RESET,
>
> As I mentioned in my review on the previous step, ADD_P_ADD would be
> more descriptive of what is going on when listed together with STASH
> and RESET here.

I made the suggested change.

> > +static struct patch_mode patch_mode_reset_head =3D {
> > +	.diff =3D { "diff-index", "--cached", NULL },
> > +	.apply =3D { "-R", "--cached", NULL },
> > +	.apply_check =3D { "-R", "--cached", NULL },
> > +	.is_reverse =3D 1,
> > +	.index_only =3D 1,
> > +	.prompt_mode =3D {
> > +		N_("Unstage mode change [y,n,q,a,d%s,?]? "),
> > +		N_("Unstage deletion [y,n,q,a,d%s,?]? "),
> > +		N_("Unstage this hunk [y,n,q,a,d%s,?]? "),
> > +	},
> > +	.edit_hunk_hint =3D N_("If the patch applies cleanly, the edited hun=
k "
> > +			     "will immediately be marked for unstaging."),
> > +	.help_patch_text =3D
> > +		N_("y - unstage this hunk\n"
> > +		   "n - do not unstage this hunk\n"
> > +		   "q - quit; do not unstage this hunk or any of the remaining "
> > +			"ones\n"
> > +		   "a - unstage this hunk and all later hunks in the file\n"
> > +		   "d - do not unstage this hunk or any of the later hunks in "
> > +			"the file\n"),
> > +};
> > +
> > +static struct patch_mode patch_mode_reset_nothead =3D {
> > +	.diff =3D { "diff-index", "-R", "--cached", NULL },
> > +	.apply =3D { "--cached", NULL },
> > +	.apply_check =3D { "--cached", NULL },
> > +	.is_reverse =3D 0,
> > +	.index_only =3D 1,
> > +	.prompt_mode =3D {
> > +		N_("Apply mode change to index [y,n,q,a,d%s,?]? "),
> > +		N_("Apply deletion to index [y,n,q,a,d%s,?]? "),
> > +		N_("Apply this hunk to index [y,n,q,a,d%s,?]? "),
> > +	},
> > +	.edit_hunk_hint =3D N_("If the patch applies cleanly, the edited hun=
k "
> > +			     "will immediately be marked for applying."),
> > +	.help_patch_text =3D
> > +		N_("y - apply this hunk to index\n"
> > +		   "n - do not apply this hunk to index\n"
> > +		   "q - quit; do not apply this hunk or any of the remaining "
> > +			"ones\n"
> > +		   "a - apply this hunk and all later hunks in the file\n"
> > +		   "d - do not apply this hunk or any of the later hunks in "
> > +			"the file\n"),
> > +};
>
> Interesting that "reset to HEAD" and "reset to non-HEAD" would have
> to swap the direction to make it feel more natural to the users.
> This is nothing new---just re-discovering that it is/was interesting.

Indeed. It matches the intuition, but looks incongruent.

Ciao,
Dscho
