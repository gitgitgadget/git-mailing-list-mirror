Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3B7C201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 20:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbdBYUwE (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 15:52:04 -0500
Received: from mout.web.de ([217.72.192.78]:63467 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751899AbdBYUwD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 15:52:03 -0500
Received: from [192.168.178.36] ([79.237.49.102]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXYS2-1cnge32PwM-00WYmU; Sat, 25
 Feb 2017 21:51:49 +0100
Subject: Re: [PATCH 1/2] apply: guard against renames of non-existant empty
 files
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20170225101307.24067-1-vegard.nossum@oracle.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Michal Zalewski <lcamtuf@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <baf195cc-ef81-bbad-4e01-4149498efedb@web.de>
Date:   Sat, 25 Feb 2017 21:51:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20170225101307.24067-1-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:7mc7iIofqNdMufnva3Ic5AduNHo+5YTyc9xezNrPKBg/OQ2DSOv
 IPOwG2N/xcTJsURMbJBaNMtXVKlEbzVRxggEfyDpJ2gtdcV77WYkJiIcPOuLpQjP0F05our
 PLBj5Up/eyEKVV/IffeCbBnrLL2dskIZtYTPgRZpX3YsWXYegQzebLCDo1kBPddVFwCRxmy
 NA/iX0HmTl61QHMUvhnzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SoCKITxjKK4=:hhrD678xx+9VRNECX4PuFB
 xHgt51fBIYWz7V0h5iPrOGEyj5K64DBape+J7T7yPWCHOKL9cUfhxELqLg3jKry+6CX0bb8mZ
 o2InCluj/+ymeztgnyxMCUzyqxTr/XPRj9b5tEKARwx/sdkHDISwEO4Cush5rxrjCoosmiTC0
 CpkRNyL+ekC2ziE0551heR7ZYMInKuthguwqZUZjW7810V0++AG+TNVeUzhRQV0sehQZubJRu
 +1L1YxCYA9N5HaHOzS4bEHJg+W692oORWeHuiRt5jNxQa0Z//rg0DGbGeXJz53tT3P/DmOdJ2
 jTCAekAVuzd0oFDH4x+smo91UC/eVYVgaWayrNJupihryhpp6L/VaOxOeSGoAAiBeXHPWXpME
 HIDANTOKTdjmJmiBMwxvP1nX0F5egwLjOhke8zZMwj4m9hFrXld9uFOdoQTFywIso4NoY3XJj
 j3WP2UygQxGB+661su7ORMXWuIdXc3OTKUq0R4roSt3ambC7+lnY8gn7NBqnEtXXCtD4bFO2l
 yCraf1TwZIWq0pCiPimXCZJYiSNlE0t1zvjXpOFOw5vSsqd9W1yLA95qxsILFhYDWDpPf4Hkj
 +uWEnUkwEvkbcCaCq9epGWlFNNIUsLBZ/r45n3LJBoUwo2OYJWInRmbdFiKB4ahYU8yjrgIBD
 3pLwxd1FbfcZe7TdwbqhU3swB00giB+rtWkgfwMrTk2ujBgG3ihPgrb7Ug38BzEMrGxCh5hRp
 Vfz5+XlbBB70BEM7Yd5en0xMiUpd0PXBPE3RyR4jPxJ0YmLUNqjH0EVqe+gPaPRQ4dRxh0X3U
 Cfjkrpt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.02.2017 um 11:13 schrieb Vegard Nossum:
> If we have a patch like the one in the new test-case, then we will
> try to rename a non-existant empty file, i.e. patch->old_name will
> be NULL. In this case, a NULL entry will be added to fn_table, which
> is not allowed (a subsequent binary search will die with a NULL
> pointer dereference).
>
> The patch file is completely bogus as it tries to rename something
> that is known not to exist, so we can throw an error for this.
>
> Found using AFL.
>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  apply.c                     |  3 ++-
>  t/t4154-apply-git-header.sh | 15 +++++++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>  create mode 100755 t/t4154-apply-git-header.sh
>
> diff --git a/apply.c b/apply.c
> index 0e2caeab9..cbf7cc7f2 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -1585,7 +1585,8 @@ static int find_header(struct apply_state *state,
>  				patch->old_name = xstrdup(patch->def_name);
>  				patch->new_name = xstrdup(patch->def_name);
>  			}
> -			if (!patch->is_delete && !patch->new_name) {
> +			if ((!patch->is_delete && !patch->new_name) ||
> +			    (patch->is_rename && !patch->old_name)) {

Would it make sense to mirror the previously existing condition and 
check for is_new instead?  I.e.:

			if ((!patch->is_delete && !patch->new_name) ||
			    (!patch->is_new    && !patch->old_name)) {

or

			if (!(patch->is_delete || patch->new_name) ||
			    !(patch->is_new    || patch->old_name)) {

René
