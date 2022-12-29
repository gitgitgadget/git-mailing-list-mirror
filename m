Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8593C4332F
	for <git@archiver.kernel.org>; Thu, 29 Dec 2022 06:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiL2GwD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 01:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiL2GwB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 01:52:01 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2938810B61
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 22:51:59 -0800 (PST)
Date:   Thu, 29 Dec 2022 06:51:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1672296717; x=1672555917;
        bh=CiJy9INMqNkzcMogjF2dd8Di5OC9iIaazxR97MHrXrs=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=0xampXmvmt7GHmEr74+GBwlFnPQtdqy0wW+FY6IEkMhQM/hPzB0T7TAFqa/SxID3a
         8gaEc+mQtXF+fjTQcTx1ZwXYzFsXMVMZ3ORYVL5lOK+SPLJHKtROCbwC2Ki0KuNV78
         7g3WpRe+UDm5zPhQuhMrrkK2LqT+nbJw5OPsQC+SVrTsIlhvBI6iuaODC4q8dNCKqU
         47W7AdfsZA7pT1hPqmwL47k8zG/IWoOw+47PE8zu5V9iEIdq0RS+iuTDMGCqxRhYWZ
         F53F3PcQEi5gYwaEcYv8rvItwxhn2zVNKdr/6VuZJhzVUYhS6Rz96GTgObDPbFOMER
         tBHcnm/VT3mTg==
To:     Junio C Hamano <gitster@pobox.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v6 2/4] worktree add: refactor opt exclusion tests
Message-ID: <20221229065142.fmfviwisjmxsey7b@phi>
In-Reply-To: <xmqq5ydvpu1o.fsf@gitster.g>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev> <20221228061539.13740-1-jacobabel@nullpo.dev> <20221228061539.13740-3-jacobabel@nullpo.dev> <xmqq5ydvpu1o.fsf@gitster.g>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/12/28 09:54PM, Junio C Hamano wrote:
> Jacob Abel <jacobabel@nullpo.dev> writes:
>
> > +# Saves parameter sequence/array as a string so they can be safely sto=
red in a
> > +# variable and restored with `eval "set -- $arr"`. Sourced from
> > +# https://stackoverflow.com/a/27503158/15064705
>
> Please do not copy from source with unknown licensing terms.

Understood. I have removed it.
>
> Isn't it sufficient to stringify "$*" and let it later split at $IFS
> boundary for the particular purpose of this test anyway?

Yes for these particular tests that should be acceptable. I tried putting a=
n
alternative together that still provides an avenue for handling quoted
arguments without the helper [1]. Would this work?

1. https://lore.kernel.org/git/20221229063823.ij3jjuaar2fsayju@phi/

