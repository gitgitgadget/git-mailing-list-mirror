Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02AE220281
	for <e@80x24.org>; Sun, 17 Sep 2017 08:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751556AbdIQICm (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 04:02:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55681 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751692AbdIQICj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 04:02:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C59C09C230;
        Sun, 17 Sep 2017 04:02:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VdBhiPPoxVt7CFo6mi6Jx8THQwg=; b=ltD04q
        xrpJ+y9Twwc4lQQXVXnZmoKF0s+ZGmgFpmPLF6xOUkOStKQtg+heYXSJPYU/WWOm
        J0xbCpER6o0ebBTc9iDQK2bcVeu+D5y5qolqROajA80XX2dXqnaOyfM4Wjoamslu
        1tg1yVL9BYrHelCq2s5b2IXGbD8lZqN8M2K68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yKl6FibguDoW1MLAKe3QP+xhauIagxQn
        p7qVUJppfatG9E510EFxB256AKBNzdWuvrm1PY1jQGyU/rgqZDjOGt/eZDy6Vu2i
        /C7pFjIGQWIgpDJj9CptI0S805xHdIy4ljym4a/RLp3g5171+DrigpkfFRxAGsBq
        xAApN7uA33I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD28F9C22F;
        Sun, 17 Sep 2017 04:02:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 19FE29C22E;
        Sun, 17 Sep 2017 04:02:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: Re: [PATCH v6 08/12] fsmonitor: add a test tool to dump the index extension
References: <20170610134026.104552-1-benpeart@microsoft.com>
        <20170915192043.4516-1-benpeart@microsoft.com>
        <20170915192043.4516-9-benpeart@microsoft.com>
Date:   Sun, 17 Sep 2017 17:02:36 +0900
In-Reply-To: <20170915192043.4516-9-benpeart@microsoft.com> (Ben Peart's
        message of "Fri, 15 Sep 2017 15:20:39 -0400")
Message-ID: <xmqqtw01u50j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 925DBC0A-9B7E-11E7-80DD-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <benpeart@microsoft.com> writes:

> diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
> new file mode 100644
> index 0000000000..482d749bb9
> --- /dev/null
> +++ b/t/helper/test-dump-fsmonitor.c
> @@ -0,0 +1,21 @@
> +#include "cache.h"
> +
> +int cmd_main(int ac, const char **av)
> +{
> +	struct index_state *istate = &the_index;
> +	int i;
> +
> +	setup_git_directory();
> +	if (do_read_index(istate, get_index_file(), 0) < 0)
> +		die("unable to read index file");
> +	if (!istate->fsmonitor_last_update) {
> +		printf("no fsmonitor\n");
> +		return 0;
> +	}
> +	printf("fsmonitor last update %"PRIuMAX"\n", istate->fsmonitor_last_update);

After pushing this out and had Travis complain, I queued a squash on
top of this to cast the argument to (uintmax_t), like you did in an
earlier step (I think it was [PATCH 04/12]).

