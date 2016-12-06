Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B07FA1FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 20:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbcLFUgE (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 15:36:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64115 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751613AbcLFUgD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 15:36:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B57BE55BEF;
        Tue,  6 Dec 2016 15:36:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hd5SU4MeJ7SAls8mFZG3dKGDEXA=; b=cCdNA6
        hrjti19HRZZkJqYA1KaeZWszv03LFjZomoU3zxszhUeyL26nYC/4dGqPRNDFDP7G
        RsJhbmU8ixEaTtvFw7hth/5fMIpU51Bfo+Fp/kxs+J01XY2hYp5RLdBX1j7y7+RQ
        M2xLufor49n9UP4jQBtdRU+6LORF6iuIUiwAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o+hRpfx574jMpMIZFH3ydVTB5svLqJEG
        Z2MI87d+SgR6bMNKOnd9MiJh8WA2pGmliCxeFfC7nBxTfx2jG9s1KbvW7wZMgS1f
        ifsWtb6VmoVCJ5qis1JX3fLlKgrYk9Kk8wu+LytSvkU8g2eW+DewvbfAd2yy0PeJ
        0om6vYJD7Wg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ADF4655BEE;
        Tue,  6 Dec 2016 15:36:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0FE7955BEC;
        Tue,  6 Dec 2016 15:36:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Charles Bailey <charles@hashpling.org>,
        Matthew Patey <matthew.patey2167@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] stash: disable renames when calling git-diff
References: <CAFQpxxKbn4vBMzVcLZgBVvuL2fsOGNMHR1WC+aTOG_RAWkZ_Gg@mail.gmail.com>
        <20161206142446.5ba3wc625p5o6nct@sigill.intra.peff.net>
        <CAFQpxx+PJ3FSoH9DFWyEw+ZLagji9Qou+aY9EB8A+=t+QX0o2A@mail.gmail.com>
        <20161206152530.snccf7buiosst3e4@sigill.intra.peff.net>
        <20161206154120.yyuca35ugyuifpq6@sigill.intra.peff.net>
        <xmqqh96g27bh.fsf@gitster.mtv.corp.google.com>
        <20161206193154.vf7cd7lk5gyxrra5@sigill.intra.peff.net>
        <xmqqd1h425vv.fsf@gitster.mtv.corp.google.com>
        <20161206201130.azfmqvtk3iettlx7@sigill.intra.peff.net>
        <20161206202521.zxgxqsetgqejsyl3@sigill.intra.peff.net>
Date:   Tue, 06 Dec 2016 12:36:00 -0800
In-Reply-To: <20161206202521.zxgxqsetgqejsyl3@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 6 Dec 2016 15:25:21 -0500")
Message-ID: <xmqqtwagztfz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A41DE26-BBF3-11E6-8067-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here it is in patch form. Perhaps I am missing some subtle case that
> diff-index would not handle, but it does pass the test suite. And
> looking over the original thread, I don't see any particular reason to
> prefer git-diff.

Ah, our mails crossed ;-)  I am reasonably sure that "diff HEAD" and
"diff-index HEAD" would behave identically.

> @@ -115,7 +115,7 @@ create_stash () {
>  			git read-tree --index-output="$TMPindex" -m $i_tree &&
>  			GIT_INDEX_FILE="$TMPindex" &&
>  			export GIT_INDEX_FILE &&
> -			git diff --name-only -z HEAD -- >"$TMP-stagenames" &&
> +			git diff-index --name-only -z HEAD -- >"$TMP-stagenames" &&
>  			git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
>  			git write-tree &&
>  			rm -f "$TMPindex"

Will queue this one instead.  Thanks.

