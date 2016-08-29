Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81DE51FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 22:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756157AbcH2WmJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 18:42:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60808 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752043AbcH2WmI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 18:42:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EA0C03A140;
        Mon, 29 Aug 2016 18:42:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dVuHn02KXyoTfyiW0qjk7MtYObY=; b=wx3Wmp
        aG9ycAl94n5NNwe0++rRRVCBwL4Sj4Wz1uyQUsSkqWopVFFaHmKFnd9Dw5KRfEJ7
        Bs1gLtbyV6UQ3KvblfkdLIF4nZQ5DnonATl+ra2mwI6GmLWpLfgPS9ect5u7L49p
        v/kqBwzEq+a7Id3Xi9FAffDEt7K4J6iiv9BNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JZiCX0RV7K7pGvYd42cFCzLPy+rDFHsY
        A4Nuu3LOjseJNbqVIpnzYoJhmRrsIYH8ByUvj/+E9khHUfDN0kIm5/K9GV9eaS+u
        J36ZGRdgqo2GoGUUJs6n0tN+ADLRU1l/dp8Oe7z9rTPGC4kuYXku3lfW4Ny736Dg
        508a5Fy/RvU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E366B3A13F;
        Mon, 29 Aug 2016 18:42:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C8FAE3A13D;
        Mon, 29 Aug 2016 18:42:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/6] pull: drop confusing prefix parameter of die_on_unclean_work_tree()
References: <cover.1472137582.git.johannes.schindelin@gmx.de>
        <8fd43aabe0ee2427276b94928a4d9d8d2ef08613.1472137582.git.johannes.schindelin@gmx.de>
Date:   Mon, 29 Aug 2016 15:41:58 -0700
In-Reply-To: <8fd43aabe0ee2427276b94928a4d9d8d2ef08613.1472137582.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 25 Aug 2016 17:06:44 +0200
        (CEST)")
Message-ID: <xmqqvayj6vux.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CCC71BCA-6E39-11E6-9A4A-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> -static int has_unstaged_changes(const char *prefix)
> +static int has_unstaged_changes(void)
>  {
>  	struct rev_info rev_info;
>  	int result;
>  
> -	init_revisions(&rev_info, prefix);
> +	init_revisions(&rev_info, NULL);
>  	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
>  	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
>  	diff_setup_done(&rev_info.diffopt);
> @@ -344,7 +344,7 @@ static int has_unstaged_changes(const char *prefix)
>  /**
>   * Returns 1 if there are uncommitted changes, 0 otherwise.
>   */
> -static int has_uncommitted_changes(const char *prefix)
> +static int has_uncommitted_changes(void)
>  {
>  	struct rev_info rev_info;
>  	int result;
> @@ -352,7 +352,7 @@ static int has_uncommitted_changes(const char *prefix)
>  	if (is_cache_unborn())
>  		return 0;
>  
> -	init_revisions(&rev_info, prefix);
> +	init_revisions(&rev_info, NULL);

I agree these are good changes.  The prefix being ignored is a mere
accident and a time-bomb waiting to go off.  As you mentioned in the
log message, we do not even want to pass a pathspec to limit the "is
there anything modified" check, which may be affected with prefix,
but we want a full-tree diff no matter where we started in these two
functions.

Good.
