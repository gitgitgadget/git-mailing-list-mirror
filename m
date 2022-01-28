Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF33BC433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 12:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbiA1MBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 07:01:54 -0500
Received: from mout.gmx.net ([212.227.15.19]:60131 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230193AbiA1MBx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 07:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643371309;
        bh=9S3stRU4rerQOAMxLWlwGTmNPMUxpQJmj6cjPR6RaeY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jfCS9QZQJ0lhXP4OlIKwXr8dFO5tay1Em2FJhvTOV+xrveTdWvG2sc2HYcPc82gI6
         dSVbihH1X3yXXnxDpT6/3TdBK4Me7aScXRhGPNMk7JK4x0HCHL6sWnEH7s9fZDl/ss
         9hqRkYx8Y9xCChpmsUmwoUxl9S+m4ErRBotRW8CU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.213.181]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QS2-1n906X2RFI-004Sgv; Fri, 28
 Jan 2022 13:01:49 +0100
Date:   Fri, 28 Jan 2022 13:01:47 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 3/3] diff-filter: be more careful when looking for
 negative bits
In-Reply-To: <xmqq35l8zmkh.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2201281255110.347@tvgsbejvaqbjf.bet>
References: <pull.1127.git.1643149759.gitgitgadget@gmail.com> <pull.1127.v2.git.1643310510.gitgitgadget@gmail.com> <b041d2b7a3bd4433e86438cddbd52857e5f375a6.1643310510.git.gitgitgadget@gmail.com> <xmqq35l8zmkh.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Ur2m5AAiUVi6lAgRjVdCt27Ttl1nn6wUy+Ao61qgncPEd/wo6gL
 w52gFAJqNaKZu9QxmG37DYGy51V/SPG0fv8EH2i+KsX3hvo107oy9BL15VRDd124P9ZP52R
 5IFK1M0vh5Jwdp2D2Xx2ucD5CBiTCk7gp0QGMlcM1IXFsGEEzd8g42GhA1rurDLa5IGioQO
 EPdH+4gi0ZO4NZOCu3feg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zDt9dXlFGKQ=:crO2cCs7/WGnwrsxvzzCeu
 hGdb9v09qfeXQZVvB+1CStawxHFsxm8GoxacfhtRqYqbJzEBFPiNfZgOhymtYrbs//vdBRwhy
 BL/yF5P76JXZPuu4gkgjRjNPQoiu67kovnBvDq62DDwQCnEqwdNwCkYKacXNmwXoTfC6LlGNE
 bp8/TeMjiKi4tjV9FoLcy74ziStGarfUVPBUK1An19scGN0MxcLKEEt/RwfxIEa7k64c68VAR
 y0pZMtFnLV47eSuTbW6f2BUjbIgDB8gtjkFAAuxueyrOD24Ufjs4AlygXxf419/wveahggfmg
 HH1n+SoWNrLd3OlwRTeLgKS5wTIpI+kIVLbjwuX9bewq7iAbJXbBpTS5lxGu71YcJoB5YRBNq
 d2wY0UGTKZlZmwE1gvz2sg1Po/GSAF+BHCdn/k7/ynROmvpMCE0W9voY+26URgnNcZRXrWA8v
 t2qO6ay6FqKE04spNWMMnDEEtlb/+oIneKgFIfKVcexK/siden320jA1O+cby5HKrUBUaXYqd
 CVIJpCMRWvLdBTGIXjRiQPKEB5bH2HW7P3DFVaz+f7IMMeFhBf+rc+eDOA2WAW+rrXIiMIQ6j
 UGYP3HhT+bup/OaFsT3MSE2xyYgRFW56W8hEsvrNJxfNZiITKcBIQfH6P/+UJqS0Knwtv4exD
 EA6veQ22OmkcAj0WTpoZZb7uttvl2ct/s4sN1Z0Bty9/EQLVJSuKhNGn89PDy8sNRWhnI8Ho0
 4eJFKPGs45BhbtufrdFFoKKdqIBwTfSmCBcxuesUHZVPoohSj+G1CtEXh7Cuz379C4Wco8zP9
 LmQ6AsQGxq0aFs6G2q2KpjEL1SWRZHNsrevvjnXvCWXLoVP+J5lR60/QR+HmPKEZipYowo/I0
 k+mTQXpxGtoWt9W7q5AudVB5s18EPl0WQQ14cOdnjxfBONvyjYz+m69fN8d/7NrErLDde8b1s
 Cn5JlYEV847jANHJ+RaoFiKItfvUyz4beH2+267IyLWnOLMaPM6WofZNBP56LtDQSrSx/UrGK
 7t1AXnLdM8/fOh5TyGuO9WrbMyXrk2eplO0iFugnV8klW9EHkm4rnnWebxGfO6hjR95J9bEzH
 TPFU+I1aT06ZCU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 27 Jan 2022, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > diff --git a/diff.c b/diff.c
> > index 5081052c431..4ab4299b817 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -4720,6 +4720,12 @@ void diff_setup_done(struct diff_options *optio=
ns)
> >  	if (!options->use_color || external_diff())
> >  		options->color_moved =3D 0;
> >
> > +	if (options->filter_not) {
> > +		if (!options->filter)
> > +			options->filter =3D ~filter_bit[DIFF_STATUS_FILTER_AON];
>
> Unlike the original, options->filter will have excess higher bit all
> on, in addition to all the filter bits except for the all-or-none
> bit.

Thank you for your thoroughness. Indeed, you are correct that I no longer
do the `(1 << (ARRAY_SIZE(diff_status_letters) - 1)) - 1` dance.

In an uncommitted iteration, I actuall forced that mask in
`diff_setup_done()` via:

	options->filter &=3D (1 << (ARRAY_SIZE(diff_status_letters) - 1)) - 1;

But then I got curious and looked how `options->filter` is accessed, and
we never loop over its bits, we always ask whether a specific bit is set.
So I got rid of that (quite ugly) line.

I made a mental note to write about this in the commit message, but wanted
to quickly look at all the code accessing `options->filter` by using the
very nice refactoring support of VS Code to rename the field so that all
of the accesses would be visible in a diff, and then I wanted to quickly
run the entire test suite first, just in case my analysis missed
something. And by the end of it, my mental note had evaporated.

Thanks to your reminder, I added this to the end of the commit message:

    Note: The code replaced by this commit took pains to avoid setting any
    unused bits of `options->filter`. That was unnecessary, though, as all
    accesses happen via the `filter_bit_tst()` function using specific bit=
s,
    and setting the unused bits has no effect. Therefore, we can simplify
    the code by using `~0` (or in this instance, `~<unwanted-bit>`).

Ciao,
Dscho
