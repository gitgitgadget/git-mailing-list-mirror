Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5984B20954
	for <e@80x24.org>; Mon,  4 Dec 2017 14:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753994AbdLDOnT (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 09:43:19 -0500
Received: from mout.gmx.net ([212.227.15.18]:64085 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752732AbdLDOnR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 09:43:17 -0500
Received: from virtualbox ([95.208.59.29]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVui8-1ebCwP19ce-00X5ck; Mon, 04
 Dec 2017 15:43:01 +0100
Date:   Mon, 4 Dec 2017 15:42:11 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v2 4/9] rebase -i: refactor transform_todo_ids
In-Reply-To: <20171203221721.16462-5-liambeguin@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1712041541000.98586@virtualbox>
References: <20171127045514.25647-1-liambeguin@gmail.com> <20171203221721.16462-1-liambeguin@gmail.com> <20171203221721.16462-5-liambeguin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gkvf3blc6eJ41b6cEUcipKm2JynfqImsMbKl87gHCMDW87M3M9X
 G2VTBDhsZkmpV8BM+W5IeXxkHBZXzm/Z8j8xvbA0enhnlx3om2BOhh80+/k7RsRWanQHefT
 DtaiKDdn3tVPTdGykX/o0QtFBbyWnAOwkx+gbpNYvrvrp4wzBHPTcApZFIdbiojOGKEvOhs
 8VSHEzK2zzD57trsWP6DA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DEr/nT5tTDQ=:/Z1oqaUeG52uuz0NmxN5Ve
 vebAmYLCEl0Qskyy9iz8d0qwghFkB6j71zJm/byQ5cQ8Py2BB6F00l4O5LFqTlZleHXPhuUeY
 +rQNe/jTyKsHNS6CCcJNuEdb3f/F2Xe3MMTYl6fY7DrOlM+VSTXRLc8mOktCLYxs1qMX4V54U
 bnwKNysj0je9hjuXAyA/1JAyiEIILOSj0KYopZvV1v3PKAzbjK0u5W7LpcxL9CBzH37N4rPrZ
 s4Odcc9c18KzcGPthafrecdIRdkFQFCS4OZaYxSw9UJ0zkyJ19FBPs1Oq49iXgkdAThkBhE1C
 FCszJaQrDakh3zkHDL9aY0EK2nmy0jsja3A2NwBByN6pd+8WW77L1gsv4oPRtw91ClFrzO+kz
 KldJmCRI4h4JC2medQquNGoryjv67gv4sbErnYFGbZGBF9PVXMEZGbuWdnkAl3FWX2QqbQfUg
 iT8/YjFNGo4EvWnePdTizgzrMTGfEQUbs9ymosUnoMsvPTNYuVxqfNCUbyK8kh0kCi8np5MMN
 DBUffI/Rfj9XGFI9K7vD9xqVVvuYVKlHy4DmFIV9p8VYOAD1+65LDljCoDK4vfqC6Al447bPP
 c88Qm5fU91VTNtE7ArgODnyj/l+FwpSXwQ2VcH/ipcLChhxQUUfavTe6zj5hsFSHjEL1ytxBA
 esBfy/eEocIurFid9RP7uvg8PKU35Eywe4l9aEJXOXJTgs3KQGvZF37IbvtQHCNKQGQm6qib+
 cfC5ETRIYnGMscInhlS6Z23K/WH/FO9vmu85khpK8de4UgRkalM8ONaZZ0uD+bUFEkKHauuta
 Xy+auoBMwDuJRCcaGv/j2v4yUa+zIRA9iDz4b8avraY5OF27jaYHtoGawc1aCvqpFrb5ML8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,

On Sun, 3 Dec 2017, Liam Beguin wrote:

> The transform_todo_ids function is a little hard to read. Lets try
> to make it easier by using more of the strbuf API. Also, since we'll
> soon be adding command abbreviations, let's rename the function so
> it's name reflects that change.

I am not really a fan of the new name, and would prefer the old one, but
that's only a nit, not a reason to reject the patch.

The rest of it makes the code reads a lot nicer than before. Thank you,
Johannes
