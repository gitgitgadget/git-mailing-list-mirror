Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77B64202A0
	for <e@80x24.org>; Tue, 31 Oct 2017 07:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbdJaHDu (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 03:03:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61904 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751539AbdJaHDt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 03:03:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BD17A9E6F;
        Tue, 31 Oct 2017 03:03:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nt7cA2Psbe2JoUt2KpE3Nmp435I=; b=Pj8S8f
        pZSH8j+LY2u5WYUPxUh2IwPjEQaICaK2EorO6YMakD3hKYXjNRCJuurhQkqr3fiS
        SMwKNiuWAH5pe/VWUzkWGxxr93MM+UtVT0G7iP399uGyJsnU96S0TNCbcUVdQ5Ii
        Lx8PeMmRMb5pWjHJw+lOOY0/2Bn1SaaBKVPNY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HwOdu5vy/IIJPNu6Ko0X+NipLHJhWlT/
        1B+ZuqkLtItebnzRkNYIUVIg1mrPZopUay8B/tpttl3nulDhs1qes/oPcGU74q9g
        9xmXc8FlnKoKTfpB0tLy1JMHStR9mfXtTlxnUGYaDZ/baSi05qxurypMbIv5Gqjs
        chalVR1PbtQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2336AA9E6D;
        Tue, 31 Oct 2017 03:03:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 93ACEA9E6C;
        Tue, 31 Oct 2017 03:03:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, me@ikke.info, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 4/7] builtin/describe.c: print debug statements earlier
References: <20171028004419.10139-1-sbeller@google.com>
        <20171031003351.22341-1-sbeller@google.com>
        <20171031003351.22341-5-sbeller@google.com>
Date:   Tue, 31 Oct 2017 16:03:47 +0900
In-Reply-To: <20171031003351.22341-5-sbeller@google.com> (Stefan Beller's
        message of "Mon, 30 Oct 2017 17:33:48 -0700")
Message-ID: <xmqq60avztm4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4C149F4-BE09-11E7-A07A-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> For debuggers aid we'd want to print debug statements early, so
> introduce a new line in the debug output that describes the whole
> function, and the change the next debug output to describe why we need
> to search. Conveniently drop the arg from the second line; which will
> be useful in a follow up commit, that refactors the describe function.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Adding an eary "entry" log may indeed be a good idea.  This is not a
new issue, but I do not think it is a good trade-off to burden i18n
teams to translate debug-only messages, though.

>  builtin/describe.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/describe.c b/builtin/describe.c
> index fd61f463cf..3136efde31 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -293,6 +293,9 @@ static void describe(const char *arg, int last_one)
>  	unsigned long seen_commits = 0;
>  	unsigned int unannotated_cnt = 0;
>  
> +	if (debug)
> +		fprintf(stderr, _("describe %s\n"), arg);
> +
>  	if (get_oid(arg, &oid))
>  		die(_("Not a valid object name %s"), arg);
>  	cmit = lookup_commit_reference(&oid);
> @@ -316,7 +319,7 @@ static void describe(const char *arg, int last_one)
>  	if (!max_candidates)
>  		die(_("no tag exactly matches '%s'"), oid_to_hex(&cmit->object.oid));
>  	if (debug)
> -		fprintf(stderr, _("searching to describe %s\n"), arg);
> +		fprintf(stderr, _("No exact match on refs or tags, searching to describe\n"));
>  
>  	if (!have_util) {
>  		struct hashmap_iter iter;
