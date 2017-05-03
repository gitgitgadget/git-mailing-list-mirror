Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFF3B207F8
	for <e@80x24.org>; Wed,  3 May 2017 20:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbdECU7d (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 16:59:33 -0400
Received: from mout.web.de ([212.227.15.4]:61230 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750716AbdECU7b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 16:59:31 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M7blv-1e27vK0XHr-00xHx8; Wed, 03
 May 2017 22:59:05 +0200
Subject: Re: [PATCH v3 12/25] split_commit_in_progress(): fix memory leak
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
References: <cover.1493387231.git.johannes.schindelin@gmx.de>
 <cover.1493740497.git.johannes.schindelin@gmx.de>
 <8cc59c706934134294e91a99062f7dcc0bda17db.1493740497.git.johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <8a0a2230-239e-b6c8-f7c0-8192e6cec7ec@web.de>
Date:   Wed, 3 May 2017 22:59:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <8cc59c706934134294e91a99062f7dcc0bda17db.1493740497.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:B1QPMDupQeJCphAUvutOXxRkYXoljxAFJ+T2/woO991tS9OfgHK
 ofGual0dcEOMcoLWAcefI3E8A9wD8Cj7uSpclwrbZNJpa0HN/NVwD6F6NNq3CA/1NGD37KC
 I0HMbYVDToovW6aQIdLeYT3atRqMnqHawYqH6yvG22gqD1in14giagaOTrJ+8Jbpgd1XSMG
 7L/o7+Ab199f/2jKKqOAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VBjloT7Yvc0=:Mz+cFDF2eYXPd2QDEt7AR8
 Y95zS8upfxseb1N46tFBxTXulRWqmsnOuKJbRMBI5PzJY6cbEaoqJAOEXpfGaexusUWzAOUZ5
 ChSoExvZNGrgaqmL3bmTOun5p/uLuX6I+jbBfomnHPjHq/EH5Lqsy+pG5uwwFzwn+6ycPzxaO
 btYN7z9P+rXGjdnNgCty/8yFObm3dowF52c6UQOLti0mFV594HGAEfp550VobygtpFTnA2hF0
 a1rRWMycTHY5Ni6fNn8TFMqV3yPKvWd73nSHQI/XUy85tquewggTLegF/Kjmk9XrBAdfcwAcF
 peXkByyRPj1TJRrhrcRJe9WR7kSn+vL7a2QqOTCsuhUZoJNPHTZMJAZ+7lJsf8Ne/TG9DCMG6
 1Yhp4bFjp9MHX0WlyDR96V86aK/K475qA3UW64S3N/2BCz/NZYPweIcaq5McZ4ruLC3iK8Zvn
 fbWD99cYINe4xygLjycI+eHz0389S2oO6FnwRcoTMG1s2EWwyUOuBJIF/VNRNr5Op5KzjXsU9
 Hc4QTBuwH1EDQBJwexbbCTCLgC0KPIdeB/Wl7EegmxJMlBxjIOYKlhWCL3Q4RcjU4fDIhpNif
 da81aOskxN5rhp0OKbMx7qdTWu15RC/sYKhhMHLsgfhK2aXgI8+/DGfu1lSROemaKcwdectCs
 dOBa3cMdTKj/zHHut+pVlobMMVFDxePMTr7e2tSJbswTqawpcpzxM3YYwLAfEc3HyJ0zV4wOk
 ubqc2vEY2yZkk/QxROK94d0hTFzzPcso0/jwmGoy7doKMV5rBr8h/HVIRVeaAZrzX12KGkk0D
 L207cLn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.05.2017 um 18:02 schrieb Johannes Schindelin:
> Reported via Coverity.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   wt-status.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/wt-status.c b/wt-status.c
> index 0a6e16dbe0f..1f3f6bcb980 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1088,8 +1088,13 @@ static int split_commit_in_progress(struct wt_status *s)
>   	char *rebase_orig_head = read_line_from_git_path("rebase-merge/orig-head");
>   
>   	if (!head || !orig_head || !rebase_amend || !rebase_orig_head ||
> -	    !s->branch || strcmp(s->branch, "HEAD"))
> +	    !s->branch || strcmp(s->branch, "HEAD")) {
> +		free(head);
> +		free(orig_head);
> +		free(rebase_amend);
> +		free(rebase_orig_head);
>   		return split_in_progress;
> +	}
>   
>   	if (!strcmp(rebase_amend, rebase_orig_head)) {
>   		if (strcmp(head, rebase_amend))
> 

The return line could be replaced by "; else" to achieve the same
result, without duplicating the free calls.

René
