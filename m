Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB9E4207DF
	for <e@80x24.org>; Fri,  9 Sep 2016 22:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754762AbcIIWkU (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 18:40:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56058 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753554AbcIIWkT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 18:40:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 82BF33C72A;
        Fri,  9 Sep 2016 18:40:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UehXVivC9nRJJ2dYdqzQ/v05ops=; b=uEmUmV
        HZHuCtwYca/21XawDNRZOsm/v1QpJAF68d1eVGh2qJ9xl5ZWSMHEkOYByHeK9A2L
        UCJgTqoiJ6E40IppO43+2kDxW1d2pwzj5y6VaT0Sh4gPhQ8v5ljmalof3j4k8Kji
        rgcQOc8lnPWuTsqDdwpmtC+nCCXVtYSuyj2yg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DDnXq51YPAThahOo0sLZ4G3hRx5aAjh5
        9IAQaC5qgS9TTGBiM+yDEpxoJN+/d/RcEwt4qfolMMaQE8FDwTUe/40Gud9SUTC/
        dKzspBhHT6iq36sTg4dLLbpNcVvbpnSEGXWuOz/vOBKH9KvXsWeVTVvJ+C1+i8gv
        8MPz5bukbzM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7BC6C3C729;
        Fri,  9 Sep 2016 18:40:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A6AE3C726;
        Fri,  9 Sep 2016 18:40:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [RFC/PATCH] ls-files: adding support for submodules
References: <1473458004-41460-1-git-send-email-bmwill@google.com>
        <20160909223513.3rirneqxmrcyi4k4@sigill.intra.peff.net>
Date:   Fri, 09 Sep 2016 15:40:16 -0700
In-Reply-To: <20160909223513.3rirneqxmrcyi4k4@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 9 Sep 2016 18:35:14 -0400")
Message-ID: <xmqqsht88zov.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 620CEB18-76DE-11E6-8CAB-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I suppose another option would be to teach ls-files a "prefix" option
> to add to each filename, and just pass in the submodule path. Then you
> can let the sub-processes write directly to the common stdout, and I
> think it would be safe to blindly pass the parent argv into the child
> processes.

I think that is a sensible way to do this, instead of reading from -z
and showing things depending on various output modes you were told
to use.
