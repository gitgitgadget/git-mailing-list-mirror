Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21DF61F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 18:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754127AbdAZSES (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 13:04:18 -0500
Received: from zm23-mta-out-2.grenet.fr ([130.190.191.53]:52165 "EHLO
        zm23-mta-out-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754084AbdAZSEP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 13:04:15 -0500
Received: from zm23-mta-out.grenet.fr (zm23-mta-out.grenet.fr [130.190.191.35])
        by zm23-mta-out-2.grenet.fr (Postfix) with ESMTP id 5284DC75B;
        Thu, 26 Jan 2017 19:04:12 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (mailhost.u-ga.fr [152.77.1.30])
        by zm23-mta-out.grenet.fr (Postfix) with ESMTP id 4B6641004A4;
        Thu, 26 Jan 2017 19:04:12 +0100 (CET)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 47D80125EA8;
        Thu, 26 Jan 2017 19:04:12 +0100 (CET)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH v2 1/1] status: be prepared for not-yet-started interactive rebase
References: <99f6de4be107044fdf01ee796f42e124ac147891.1453480067.git.johannes.schindelin@gmx.de>
        <cover.1485446899.git.johannes.schindelin@gmx.de>
        <alpine.DEB.2.20.1701261708370.3469@virtualbox>
Date:   Thu, 26 Jan 2017 19:04:13 +0100
In-Reply-To: <alpine.DEB.2.20.1701261708370.3469@virtualbox> (Johannes
        Schindelin's message of "Thu, 26 Jan 2017 17:08:41 +0100 (CET)")
Message-ID: <vpq7f5hpujm.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via submission-587 ACL (112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Some developers might want to call `git status` in a working
> directory where they just started an interactive rebase, but the
> edit script is still opened in the editor.
>
> Let's show a meaningful message in such cases.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t7512-status-help.sh | 19 +++++++++++++++++++
>  wt-status.c            | 14 ++++++++++----
>  2 files changed, 29 insertions(+), 4 deletions(-)

The patch looks good to me.

> @@ -1166,8 +1170,10 @@ static void show_rebase_information(struct wt_status *s,
>  		struct string_list yet_to_do = STRING_LIST_INIT_DUP;
>  
>  		read_rebase_todolist("rebase-merge/done", &have_done);
> -		read_rebase_todolist("rebase-merge/git-rebase-todo", &yet_to_do);
> -
> +		if (read_rebase_todolist("rebase-merge/git-rebase-todo",
> +					 &yet_to_do))
> +			status_printf_ln(s, color,
> +				_("git-rebase-todo is missing."));

I first was surprised not to see this "git-rebase-todo" in the output of
status, but the testcase tests a missing 'done', not a missing todo, so
it's normal.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
